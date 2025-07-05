
clc; close all;

% === CONFIGURAÇÕES ===
%filename = 'captura3.dat';
%filename = 'captura2.dat'; %3.5
%filename = 'captura_C_15M_3500_1s.dat';
filename = 'captura_B_15M_3495_3s_float.dat';
%filename = 'captura_B_15M_3495_3s.dat';
%filename = 'captura_A_15M_3500_3s.dat';
%filename = 'captura_D_15M_3500_5s.dat';
fs = 15.36e6;                  % Taxa de amostragem usada na captura
nfft = 2048;                   % Tamanho da FFT
subcarrierSpacing = 30e3;     % Espacamento entre subportadoras para n78
Tsym = 1 / subcarrierSpacing; % Tempo de símbolo
Ns = round(Tsym * fs);        % Amostras por símbolo

% === LEITURA DO ARQUIVO ===
sinal_complexo = lerArquivo(filename);
mostraEspectro(sinal_complexo, nfft, fs);

% === DETECÇÃO PSS ===
corrs = correlacaoPSS(sinal_complexo);
mostraCorrelacao(corrs);
mostraCorrelacaoZoom(corrs);

%Múltiplos PSS
qtd_picos = 5;
dist_minima_ms = 0.5;
[posicoes_pss, valores_pss, nid2_usado] = localizarMultiplosPSS(sinal_complexo, fs, qtd_picos, dist_minima_ms);

for i = 1:length(posicoes_pss)
    pos_pss = posicoes_pss(i);
    nid2 = nid2_usado(i);

    [nid1, nidcell] = detectarSSS_individual(sinal_complexo, pos_pss, nid2);
    fprintf('[%d] PSS: %d | NID2: %d | NID1: %d | NIDcell = %d\n', ...
        i, pos_pss, nid2, nid1, nidcell);

    ssbGrid = extrairSSBGrid(sinal_complexo, pos_pss, fs, nfft, subcarrierSpacing);        
    [csi_ls, k_ls, h_dmrs, x_dmrs] = estimarCSI_replica_artigo(ssbGrid, nidcell);

    csis(i).nid1 = nid1;
    csis(i).nid2 = nid2;
    csis(i).nidcell = nidcell;
    csis(i).pos_pss = pos_pss;   
    csis(i).csi_ls = csi_ls;   
    csis(i).ssbGrid = ssbGrid;   
    csis(i).k_ls = k_ls;
    csis(i).h_dmrs = h_dmrs;
    csis(i).x_dmrs = x_dmrs;
end
%[nid1, nid2, pos_pss, nidcell] = detectarSSS(sinal_complexo, fs);

mostrarGrid(csis(1).ssbGrid)
mostraCSI(csis(1).csi_ls);
