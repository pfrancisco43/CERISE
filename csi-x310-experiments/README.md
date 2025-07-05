## Experimentos para extração do CSI com a SDR X310 em redes 5G

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
```

Nota: Ao iniciar um novo terminal, lembre-se de ativar o ambiente gr48 antes de executar qualquer script.

```bash
conda activate gr48
```
### 3. Instalação e Configuração da X310

Esta etapa garante que o computador esteja pronto para comunicar com a USRP X310 e fazer capturas confiáveis em tempo real.

#### 3.1. Verificar conexão de rede com a USRP

Configure o IP da interface Ethernet para comunicar com a X310 (por padrão: `192.168.10.1`):

```bash
sudo ip addr add 192.168.10.1/24 dev <nome_da_interface>
sudo ip link set <nome_da_interface> up
```

Substitua `<nome_da_interface>` por `enp1s0`, `eth0`, ou outro, conforme seu sistema.

#### 3.2. Verificar comunicação com a placa

Use os comandos abaixo para checar a detecção da USRP:

```bash
uhd_find_devices
uhd_usrp_probe
```

Ambos devem identificar corretamente a X310. Se der erro, verifique cabo, IP e permissões.

#### 3.3. Atualizar imagens do FPGA (compatível com UHD 4.8)

Baixe e instale as imagens recomendadas:

```bash
sudo /usr/lib/uhd/utils/uhd_images_downloader.py
```

Após o download, atualize o FPGA com:

```bash
sudo /usr/bin/uhd_image_loader --args="type=x300,addr=192.168.10.2"
```

> **Importante:** a versão do FPGA precisa estar compatível com o UHD instalado. O erro "FPGA compatibility number mismatch" indica necessidade de atualização.

#### 3.4. Testar recepção com `uhd_fft`

Este comando gráfico permite verificar espectro em tempo real:

```bash
uhd_fft --freq 3500e6 --samp-rate 15.36e6 --gain 40
```

> Observação: é necessário estar com o ambiente `gr48` ativado.

