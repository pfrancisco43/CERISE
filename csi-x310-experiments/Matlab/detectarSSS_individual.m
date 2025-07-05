function [nid1, nidcell] = detectarSSS_individual(sinal, pos_pss, nid2)
% DETECTARSSS_INDIVIDUAL - Detecta o NID1 e NIDcell para uma única posição de PSS e seu NID2.
%
% [nid1, nidcell] = detectarSSS_individual(sinal, pos_pss, nid2)
%
% - sinal: vetor de amostras complexas
% - pos_pss: posição do pico de PSS
% - nid2: valor do NID2 correspondente
%
% Retorna:
% - nid1: valor do NID1 detectado
% - nidcell: valor do NIDcell calculado (3 * NID1 + NID2)

    deslocamento_sss = 240;
    sss_start = pos_pss - deslocamento_sss - floor(127/2);
    sss_end = sss_start + 127 - 1;

    if sss_start < 1 || sss_end > length(sinal)
        nid1 = -1;
        nidcell = -1;
        return;
    end

    janela = sinal(sss_start:sss_end);

    max_corr = 0;
    nid1 = -1;

    for nid1_cand = 0:335
        sss_seq = generate_sss(nid1_cand, nid2);
        corr = abs(sum(janela .* conj(sss_seq.')));
        if corr > max_corr
            max_corr = corr;
            nid1 = nid1_cand;
        end
    end

    nidcell = 3 * nid1 + nid2;
end
