function [nid1_detectado, nid2_detectado, posicao_pss, nidcell] = detectarSSS(sinal, fs)
    N_ZC = 127;
    posicoes_picos = zeros(1,3);
    valores_picos = zeros(1,3);

    % Localizar os 3 picos de correlação (um para cada NID2)
    for nid2 = 0:2
        pss = generate_pss(nid2);
        corr = abs(conv(sinal, fliplr(conj(pss)), 'same'));
        [val, idx] = max(corr);
        posicoes_picos(nid2+1) = idx;
        valores_picos(nid2+1) = val;
    end

    % Escolhe o NID2 e posição com maior correlação
    [~, melhor_nid2] = max(valores_picos);
    nid2_detectado = melhor_nid2 - 1;
    posicao_pss = posicoes_picos(melhor_nid2);

    % PSS ocupa 127 amostras, mas o SSS está antes dele no tempo
    % Normalmente o SSS vem 127 + um espaço (ajustável, usaremos ~240)
    deslocamento_sss = 240;
    %janela = sinal(posicao_pss - deslocamento_sss - 126 : posicao_pss - deslocamento_sss + 126);
    sss_start = posicao_pss - deslocamento_sss - floor(127/2);
    sss_end = sss_start + 127 - 1;
    janela = sinal(sss_start:sss_end);

    max_corr = 0;
    nid1_detectado = -1;
    for nid1 = 0:335
        sss_seq = generate_sss(nid1, nid2_detectado);
        corr = abs(sum(janela .* conj(sss_seq.')));
        if corr > max_corr
            max_corr = corr;
            nid1_detectado = nid1;
        end
    end

    nidcell = 3 * nid1_detectado + nid2_detectado;
end