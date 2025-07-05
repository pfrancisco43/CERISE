function [posicoes, valores, nid2_detectados] = localizarMultiplosPSS(sinal, fs, qtd_picos, distancia_minima_ms)
% LOCALIZARMULTIPLOS_PSSCOMNID2 - Localiza múltiplos picos de PSS no sinal, considerando todos os NID2 possíveis.
%
% [posicoes, valores, nid2_detectados] = localizarMultiplosPSSComNID2(sinal, fs, qtd_picos, distancia_minima_ms)
%
% - sinal: vetor de amostras complexas
% - fs: taxa de amostragem (ex: 15.36e6 Hz)
% - qtd_picos: número desejado de picos (opcional, default = 10)
% - distancia_minima_ms: distância mínima entre picos (em ms, opcional, default = 0.5)
%
% Retorna:
% - posicoes: posições dos picos
% - valores: valores das correlações nesses picos
% - nid2_detectados: NID2 correspondente a cada pico

    if nargin < 3
        qtd_picos = 10;
    end
    if nargin < 4
        distancia_minima_ms = 0.5;
    end

    % Geração das correlações com os 3 possíveis NID2
    corrs = zeros(3, length(sinal));
    for nid2 = 0:2
        pss = generate_pss(nid2);  % Gera sequência PSS para o NID2
        corrs(nid2+1, :) = abs(conv(sinal, fliplr(conj(pss)), 'same'));
    end

    % Determina qual NID2 teve maior correlação em cada ponto
    [valores_maximos, indices_maximos] = max(corrs, [], 1);

    % Converte a distância mínima em amostras
    min_dist_samples = round((distancia_minima_ms / 1000) * fs);

    % Encontra picos na correlação máxima global no caso de 1 só
    if qtd_picos == 1
        [val, pos] = max(valores_maximos);
        posicoes = pos;
        valores = val;
        nid2_detectados = indices_maximos(pos) - 1;
        return;
    end
    %Encontra picos na correlação máxima global no caso de mais de 1
    % [picos_val, picos_pos] = findpeaks(valores_maximos, ...
    %     'MinPeakDistance', min_dist_samples, ...
    %     'NPeaks', qtd_picos, ...
    %     'SortStr', 'descend');
    [picos_val, picos_pos, nid2_detectados] = my_findpeaks(valores_maximos, indices_maximos, qtd_picos, min_dist_samples);


    % Organiza saídas
    posicoes = picos_pos;
    valores = picos_val;
    %nid2_detectados = indices_maximos(posicoes) - 1;  % Ajusta para índice correto de NID2
end
