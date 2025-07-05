function ssbGrid = extrairSSBGrid(sinal, posicao_pss, fs, nfft, subcarrierSpacing)
    % === Parâmetros da SSB ===
    Nsymb = 4; % número de símbolos OFDM na SSB (PBCH + PSS + SSS)
    Nsc = 240; % subportadoras no bloco (20 RB × 12 SC)

    % Cálculo de tempo de símbolo (assume CP normal)
    Tsym = 1 / subcarrierSpacing;
    Ns = round(Tsym * fs); % amostras por símbolo OFDM

    % Posição inicial da SSB (começando alguns símbolos antes do PSS)
    inicio = posicao_pss - 2 * Ns;

    % Matriz de saída: [subportadoras × símbolos]
    ssbGrid = zeros(Nsc, Nsymb);

    for i = 0:Nsymb-1
        ini = inicio + i * Ns;
        fim = ini + nfft - 1;

        if fim > length(sinal)
            warning('Limite do sinal atingido. Truncando.');
            break;
        end

        simb_ofdm = sinal(ini:fim);
        simb_freq = fftshift(fft(simb_ofdm, nfft));

        % Extrai apenas as 240 subportadoras centrais (posição centralizada)
        meio = floor(nfft/2) + 1;
        ssbGrid(:, i+1) = simb_freq(meio - 119 : meio + 120);
    end
end