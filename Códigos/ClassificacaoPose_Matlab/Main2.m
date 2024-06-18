%Antes de executar esse código é preciso construir as bases de treinamento e teste
clc;clear;close all
load('train_data.mat'); % Isso deve carregar as variáveis train_data e train_labels
load('test_data.mat'); % Isso deve carregar as variáveis test_data e test_labels


% Dividir os dados de treinamento e teste
X_train = train_data; % Dados de treinamento (N x 30)
y_train = train_labels; % Labels de treinamento (N x 1)
X_test = test_data; % Dados de teste (M x 30)
y_test = test_labels; % Labels de teste (M x 1)

% Normalização dos dados
X_trainS = normalize(train_data);
y_trainS = train_labels;
X_testS = normalize(test_data);
y_testS = test_labels;


%% Treinamento do classificador SVM
%SVMModel = fitcsvm(X_train, y_train); %SVM: 54.75%
SVMModel = fitcsvm(X_trainS, y_trainS, 'KernelFunction', 'rbf', 'BoxConstraint', 1, 'KernelScale', 'auto');

% Testar o classificador SVM
svm_predictions = predict(SVMModel, X_testS);

% Avaliação do classificador SVM
svm_accuracy = sum(svm_predictions == y_testS) / length(y_test);
disp(['Acurácia do classificador SVM: ', num2str(svm_accuracy * 100), '%']);
confusion_matrix_svm = confusionmat(y_test, svm_predictions);
disp('Matriz de Confusão para SVM:');
disp(confusion_matrix_svm);
% Plotar a matriz de confusão para KNN
figure;
svm_confusion_chart = confusionchart(y_test, svm_predictions);
title('Matriz de Confusão para SVM');
% svm_confusion_chart.RowSummary = 'row-normalized';
% svm_confusion_chart.ColumnSummary = 'column-normalized';


%% % Treinamento do classificador KNN com ajuste de hiperparâmetros
KNNModel = fitcknn(X_train, y_train, 'NumNeighbors', 1, 'Standardize', 1);

% Testar o classificador KNN
knn_predictions = predict(KNNModel, X_test);

% Avaliação do classificador KNN
knn_accuracy = sum(knn_predictions == y_test) / length(y_test);
disp(['Acurácia do classificador KNN: ', num2str(knn_accuracy * 100), '%']);
confusion_matrix_knn = confusionmat(y_test, knn_predictions);
disp('Matriz de Confusão para KNN:');
disp(confusion_matrix_knn);
% Plotar a matriz de confusão para KNN
figure;
knn_confusion_chart = confusionchart(y_test, knn_predictions);
title('Matriz de Confusão para KNN');
% knn_confusion_chart.RowSummary = 'row-normalized';
% knn_confusion_chart.ColumnSummary = 'column-normalized';
