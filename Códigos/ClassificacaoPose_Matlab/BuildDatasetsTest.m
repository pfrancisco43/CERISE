clc;clear;close all

pks=1:2900;%Pacotes a serem usados
Q=57; %Quantidade de subportadoras usadas

%% Em pé
opencsi('captura_em_pe_2.csi')
captura=captura_em_pe_2;
[mg1_emPe,mg2_emPe,ph1_emPe,ph2_emPe]=getData(pks,Q, captura);
emPe=ones(size(pks,2),1);

%% Sentado
opencsi('captura_sentado_2.csi')
captura=captura_sentado_2;
[mg1_sentado,mg2_sentado,ph1_sentado,ph2_sentado]=getData(pks,Q, captura);
sentado=ones(size(pks,2),1)*2;

test_data=[mg1_emPe,mg2_emPe, ph1_emPe, ph2_emPe;
            mg1_sentado,mg2_sentado,ph1_sentado,ph2_sentado];

% test_data=[mg1_emPe,mg2_emPe;
%             mg1_sentado,mg2_sentado];

test_labels=[emPe;sentado];

save("test_data.mat","test_data","test_labels");

function [mg1,mg2,ph1,ph2]=getData(pks,Q,captura)
    phase_matrix=captura{1,1}.CSI.Phase(pks,[1:Q,58:(58+Q-1)]);
    mag_matrix=captura{1,1}.CSI.Mag(pks,[1:Q,58:(58+Q-1)]);

    %Removendo subportadoras com problemas
    problematic_subcarriers = [8, 22, 36, 50];

    %Coletando a phase
    ph1=phase_matrix(:,1:Q);
    ph2=phase_matrix(:,Q+1:end);
    ph1(:, problematic_subcarriers) = [];
    ph2(:, problematic_subcarriers) = [];
    %mostraPhaseUmPacote(ph1,ph2, 1);
    %Calibrando a phase
    ph1=CalibrationPhase(ph1);
    ph2=CalibrationPhase(ph2);
    % mostraPhaseUmPacote(ph1,ph2, 30);

    %Coletando a magnitude
    mg1=mag_matrix(:,1:Q);
    mg2=mag_matrix(:,Q+1:end);
    mg1(:, problematic_subcarriers) = [];
    mg2(:, problematic_subcarriers) = [];

    % mostraAmplitudeTempo(mg2)
    % mostraAmplitudeSubportadoras(mg2)
end

