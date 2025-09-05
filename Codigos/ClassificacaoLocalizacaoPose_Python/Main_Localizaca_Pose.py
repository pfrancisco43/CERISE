import time

import scipy.io as sio
from sklearn.svm import SVC
import numpy as np
import pickle
from sklearn.metrics import accuracy_score
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns


def treinamento_svm():
    train = sio.loadmat('data/train.mat')
    data_train = train['train_data']
    label_train = train['train_label']

    x = data_train[:, 0:29]

    pose_labels = label_train[:, 0]  # Primeira coluna
    location_labels = label_train[:, 1]  # Segunda coluna
    combined_labels = [f"{pose} - {location}" for pose, location in zip(pose_labels, location_labels)]
    y_combined = np.array(combined_labels)

    y = y_combined[:]

    # Inicializar o classificador SVM
    modelo_svm = SVC(kernel='linear')
    # # Treinar o modelo
    modelo_svm.fit(x, y)
    # Salvar o modelo treinado em um arquivo
    with open('modelo_svm.pkl', 'wb') as arquivo:
        pickle.dump(modelo_svm, arquivo)


def treinamento_knn():
    train = sio.loadmat('data/train.mat')
    data_train = train['train_data']
    label_train = train['train_label']

    x = data_train[:, 0:29]

    pose_labels = label_train[:, 0]  # Primeira coluna
    location_labels = label_train[:, 1]  # Segunda coluna
    combined_labels = [f"{pose} - {location}" for pose, location in zip(pose_labels, location_labels)]
    y_combined = np.array(combined_labels)

    y = y_combined[:]

    # Inicializar o classificador KNN
    modelo_knn = KNeighborsClassifier(n_neighbors=5)  # Vamos usar 3 vizinhos mais próximos
    # Treinar o modelo
    modelo_knn.fit(x, y)
    # Salvar o modelo treinado em um arquivo
    with open('modelo_knn.pkl', 'wb') as arquivo:
        pickle.dump(modelo_knn, arquivo)


def treinamento_tree():
    train = sio.loadmat('data/train.mat')
    data_train = train['train_data']
    label_train = train['train_label']

    x = data_train[:, 0:29]

    pose_labels = label_train[:, 0]  # Primeira coluna
    location_labels = label_train[:, 1]  # Segunda coluna
    combined_labels = [f"{pose} - {location}" for pose, location in zip(pose_labels, location_labels)]
    y_combined = np.array(combined_labels)

    y = y_combined[:]

    # Inicializar o classificador arvore de decisão
    modelo_tree = DecisionTreeClassifier()
    # Treinar o modelo
    modelo_tree.fit(x, y)
    # Salvar o modelo treinado em um arquivo
    with open('modelo_tree.pkl', 'wb') as arquivo:
        pickle.dump(modelo_tree, arquivo)


def treinamento_rf():
    train = sio.loadmat('data/train.mat')
    data_train = train['train_data']
    label_train = train['train_label']

    x = data_train[:, 0:29]

    pose_labels = label_train[:, 0]  # Primeira coluna
    location_labels = label_train[:, 1]  # Segunda coluna
    combined_labels = [f"{pose} - {location}" for pose, location in zip(pose_labels, location_labels)]
    y_combined = np.array(combined_labels)

    y = y_combined[:]

    # Inicializar o classificador arvore de decisão
    modelo_rf = RandomForestClassifier()
    # Treinar o modelo
    modelo_rf.fit(x, y)
    # Salvar o modelo treinado em um arquivo
    with open('modelo_rf.pkl', 'wb') as arquivo:
        pickle.dump(modelo_rf, arquivo)


def carrega_svm():
    # Carregar o modelo treinado a partir do arquivo
    with open('modelo_svm.pkl', 'rb') as arquivo:
        modelo_svm = pickle.load(arquivo)
        return modelo_svm


def carrega_knn():
    # Carregar o modelo treinado a partir do arquivo
    with open('modelo_knn.pkl', 'rb') as arquivo:
        modelo_knn = pickle.load(arquivo)
        return modelo_knn


def carrega_tree():
    # Carregar o modelo treinado a partir do arquivo
    with open('modelo_tree.pkl', 'rb') as arquivo:
        modelo_tree = pickle.load(arquivo)
        return modelo_tree


def carrega_rf():
    # Carregar o modelo treinado a partir do arquivo
    with open('modelo_rf.pkl', 'rb') as arquivo:
        modelo_rf = pickle.load(arquivo)
        return modelo_rf


def classifica(x,modelo):
    x = x.reshape(1, -1)
    previsao = modelo.predict(x)
    return previsao

def showMatriz(y_true,y_pred):
    conf_matrix = confusion_matrix(y_true, y_pred)  # cria
    conf_matrix_norm = conf_matrix.astype('float') / conf_matrix.sum(axis=1)[:, np.newaxis]  # normaliza
    # Criando o gráfico da matriz de confusão normalizada
    plt.figure(figsize=(10, 8))
    sns.heatmap(conf_matrix_norm, annot=True, cmap='Blues')
    # Adicionando colorbar para representar a acurácia
    plt.colorbar(label='Acurácia')
    # Definindo rótulos dos eixos
    plt.xlabel('Classe Prevista')
    plt.ylabel('Classe Real')
    # Exibindo o gráfico
    plt.title('Matriz de Confusão Normalizada')
    plt.show()


#####################################INICIO##########################
#treinamento_knn() #treina o modelo
modelo_knn = carrega_knn() #carrega um modelo treinado

#treinamento_tree() #treina o modelo
modelo_tree = carrega_tree() #carrega um modelo treinado

#treinamento_rf() #treina o modelo
modelo_rf = carrega_rf() #carrega um modelo treinado

#treinamento_svm() #treina o modelo
modelo_svm = carrega_svm() #carrega um modelo treinado

test = sio.loadmat('data/test.mat')
data_test = test['test_data']
label_test = test['test_label']

pose_labels = label_test[:, 0]  # Primeira coluna
location_labels = label_test[:, 1]  # Segunda coluna
combined_labels = [f"{pose} - {location}" for pose, location in zip(pose_labels, location_labels)]
y_true = np.array(combined_labels)

qnt=np.size(y_true)

predictions_svm=[]
predictions_knn=[]
predictions_tree=[]
predictions_rf=[]


start_time = time.time()
for i in range(qnt):
    x = data_test[i, 0:29]

    p2 = classifica(x, modelo_knn)
    predictions_knn.append(p2)

    p3 = classifica(x, modelo_tree)
    predictions_tree.append(p3)

    p4 = classifica(x, modelo_rf)
    predictions_rf.append(p4)

    p1 = classifica(x, modelo_svm)
    predictions_svm.append(p1)


end_time = time.time()
execution_time = end_time - start_time
print("Tempo de execução:", execution_time, "segundos")

y_pred_svm = np.array(predictions_svm)
y_pred_knn = np.array(predictions_knn)
y_pred_tree = np.array(predictions_tree)
y_pred_rf = np.array(predictions_rf)

accuracy_svm = accuracy_score(y_true, y_pred_svm)
accuracy_knn = accuracy_score(y_true, y_pred_knn)
accuracy_tree = accuracy_score(y_true, y_pred_tree)
accuracy_rf = accuracy_score(y_true, y_pred_rf)

print("Acurácia svm:", accuracy_svm)
print("Acurácia knn:", accuracy_knn)
print("Acurácia tree:", accuracy_tree)
print("Acurácia rf:", accuracy_rf)

