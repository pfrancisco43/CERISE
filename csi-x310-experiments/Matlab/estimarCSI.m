function [csi_interp, k_dmrs, h_dmrs] = estimarCSI(ssbGrid, nfft)
    % === Extração do símbolo com DMRS ===
    simboloDMRS = ssbGrid(:, 2);  % símbolo 2 da SSB (índice 2)

    % === Posições de subportadoras com DMRS ===
    k_dmrs = 0:3:239;
    h_dmrs = simboloDMRS(k_dmrs + 1);  % +1 pois MATLAB indexa de 1

    % === Interpolação linear para estimar o CSI completo ===
    k_full = 0:239;
    csi_interp = interp1(k_dmrs, h_dmrs, k_full, 'linear', 'extrap');
end