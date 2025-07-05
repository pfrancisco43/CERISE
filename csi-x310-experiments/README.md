## 🧪 Experimentos para extração do CSI com a SDR X310 em redes 5G

### 1. Introdução

Este documento descreve o processo técnico e os experimentos realizados para capturar a Informação do Estado do Canal (CSI) em redes 5G usando a USRP X310. A iniciativa faz parte dos estudos conduzidos dentro do eixo 1 do CERISE, com foco em sensoriamento sem fio e localização.

Inicialmente, investigamos a possibilidade de configurar a X310 como um equipamento de usuário (UE) usando o `srsRAN`, mas após testes e tentativas frustradas, optamos por trabalhar em modo de escuta passiva (passive sniffing). Este repositório documenta todas as etapas, configurações de software e hardware, além dos scripts utilizados para captura e análise dos dados.

### 2. Requisitos

A seguir estão listados os equipamentos utilizados, sistemas operacionais, drivers e ferramentas de software necessárias para replicar os experimentos.

#### 2.1. Equipamentos

- **USRP X310**
- **Antenas** conectadas aos canais RX
- **Computador host** com Linux Ubuntu 20.04 ou superior

#### 2.2. Softwares e versões

- **UHD (USRP Hardware Driver)** versão `4.8.0.0`
- **GNU Radio** versão compatível com UHD 4.8 (usamos Python 3.9 via Conda)
- **Conda** para gerenciamento de ambientes (`Miniconda` recomendado)
- **Git** para versionamento e clonagem de repositórios
- **MATLAB** (para processamento offline dos arquivos capturados)

#### 2.3. Instalação de dependências

Os comandos e ambientes utilizados foram organizados no ambiente `gr48`. A criação do ambiente pode ser feita assim:

```bash
conda create -n gr48 python=3.9
conda activate gr48

