function [csi_ls, k_dmrs, h_dmrs, x_dmrs] = estimarCSI_replica_artigo(ssbGrid, nidcell)
    % === Geração do DMRS padrão (X) ===
    u = mod(nidcell, 30);  % raiz Zadoff-Chu
    N_zc = 139;
    n = 0:N_zc-1;
    x_zc = exp(-1j * pi * u * n .* (n+1) / N_zc);  % sequência base

    % === Posição dos REs de DMRS no PBCH ===
    v = 0:3;                         % offsets {0,1,2,3}
    k_dmrs = 0:3:239;               % subcarriers com DMRS
    simbolo_dmrs = ssbGrid(:,2);    % símbolo 2 é o PBCH-DMRS

    % === Repetição e mapeamento da sequência ZC para os REs usados ===
    % Total de REs = 240/3 = 80 → deve-se repetir a ZC se necessário
    if length(k_dmrs) > length(x_zc)
        x_dmrs = repmat(x_zc, 1, ceil(length(k_dmrs)/length(x_zc)));
    else
        x_dmrs = x_zc;
    end
    x_dmrs = x_dmrs(1:length(k_dmrs)).';  % vetor coluna

    % === Sinais recebidos nos REs de DMRS (Y) ===
    h_dmrs = simbolo_dmrs(k_dmrs + 1);  % +1 pois MATLAB começa em 1

    % === Estimativa de canal por Least Squares ===
    csi_ls = h_dmrs ./ x_dmrs;
end