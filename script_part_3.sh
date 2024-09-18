#!/bin/bash

# Script Parte 1: Instalação de Pacotes do Sistema e Dependências

# Diretório de logs
install_log_dir="$HOME/zsh_install_logs_$(date +'%Y%m%d%H%M')"
mkdir -p "$install_log_dir"

# Log file
log_file="$install_log_dir/system_dependencies_install_log_$(date +'%Y%m%d%H%M').log"

# Função para registrar logs
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

log "Iniciando a instalação dos pacotes do sistema e dependências..."

# Verificar permissões de sudo
if [ "$EUID" -ne 0 ]; then
    log "Erro: Por favor, execute como root ou usando sudo."
    exit 1
fi

# 1. Instalação de Docker e Docker Compose
log "Verificando a instalação de Docker e Docker Compose..."

# Instalar Docker se não estiver instalado
if ! command -v docker &> /dev/null; then
    log "Docker não encontrado. Instalando Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker "$USER"
    log "Docker instalado e configurado."
else
    log "Docker já está instalado. Verificando atualizações..."
    sudo apt-get install --only-upgrade docker.io
    log "Docker atualizado."
fi

# Instalar Docker Compose se não estiver instalado
if ! command -v docker-compose &> /dev/null; then
    log "Docker Compose não encontrado. Instalando Docker Compose..."
    sudo apt-get install -y docker-compose
    log "Docker Compose instalado."
else
    log "Docker Compose já está instalado. Verificando atualizações..."
    sudo apt-get install --only-upgrade docker-compose
    log "Docker Compose atualizado."
fi

# 2. Instalação de Virtualenv e Virtualenvwrapper
log "Verificando a instalação de Virtualenv e Virtualenvwrapper..."

if ! command -v virtualenv &> /dev/null; then
    log "virtualenv não encontrado. Instalando virtualenv..."
    sudo apt-get install -y virtualenv
    log "virtualenv instalado."
else
    log "virtualenv já está instalado."
fi

if ! command -v virtualenvwrapper.sh &> /dev/null; then
    log "virtualenvwrapper não encontrado. Instalando virtualenvwrapper..."
    sudo apt-get install -y virtualenvwrapper
    log "virtualenvwrapper instalado."
else
    log "virtualenvwrapper já está instalado."
fi

# Verificar se o virtualenvwrapper está configurado no .zshrc
if ! grep -q "source /usr/local/bin/virtualenvwrapper.sh" "$HOME/.zshrc"; then
    log "virtualenvwrapper não está configurado no .zshrc. Adicionando..."
    echo "source /usr/local/bin/virtualenvwrapper.sh" >> "$HOME/.zshrc"
    log "virtualenvwrapper configurado no .zshrc."
else
    log "virtualenvwrapper já configurado no .zshrc."
fi

# 3. Instalação de Git, Git-Flow e Git-LFS
log "Verificando a instalação de Git, Git-Flow e Git-LFS..."

# Instalar Git se não estiver instalado
if ! command -v git &> /dev/null; then
    log "Git não encontrado. Instalando Git..."
    sudo apt-get install -y git
    log "Git instalado."
else
    log "Git já está instalado."
fi

# Instalar Git-Flow se não estiver instalado
if ! command -v git-flow &> /dev/null; then
    log "git-flow não encontrado. Instalando git-flow..."
    sudo apt-get install -y git-flow
    log "git-flow instalado."
else
    log "git-flow já está instalado."
fi

# Instalar Git-LFS se não estiver instalado
if ! command -v git-lfs &> /dev/null; then
    log "git-lfs não encontrado. Instalando git-lfs..."
    sudo apt-get install -y git-lfs
    log "git-lfs instalado."
else
    log "git-lfs já está instalado."
fi

# Verificar se o nome de usuário e email do Git estão configurados
if ! git config --global user.name &> /dev/null; then
    log "Configuração de nome de usuário do Git não encontrada. Solicitar ao usuário..."
    read -p "Digite o nome de usuário para o Git: " git_user_name
    git config --global user.name "$git_user_name"
    log "Nome de usuário do Git configurado como: $git_user_name"
fi

if ! git config --global user.email &> /dev/null; then
    log "Configuração de email do Git não encontrada. Solicitar ao usuário..."
    read -p "Digite o email para o Git: " git_user_email
    git config --global user.email "$git_user_email"
    log "Email do Git configurado como: $git_user_email"
fi

# 4. Instalação de Command-Not-Found (somente em sistemas baseados no Ubuntu)
if [ -f /etc/lsb-release ]; then
    log "Sistema baseado no Ubuntu detectado. Verificando a instalação de Command-Not-Found..."
    if ! command -v command-not-found &> /dev/null; then
        log "command-not-found não encontrado. Instalando command-not-found..."
        sudo apt-get install -y command-not-found
        log "command-not-found instalado."
        log "Atualizando banco de dados de pacotes com update-command-not-found..."
        sudo update-command-not-found
        log "Banco de dados de pacotes atualizado."
    else
        log "command-not-found já está instalado."
    fi
else
    log "Sistema não é baseado no Ubuntu. Pulando a instalação do command-not-found."
fi

# 5. Verificações pós-instalação e configurações finais
log "Verificando as permissões do Docker..."
if groups "$USER" | grep &>/dev/null 'docker'; then
    log "Usuário já faz parte do grupo docker."
else
    log "Adicionando o usuário ao grupo docker..."
    sudo usermod -aG docker "$USER"
    log "Usuário adicionado ao grupo docker. É necessário reiniciar a sessão."
fi

log "Verificação concluída. Todos os pacotes do sistema e dependências foram instalados e configurados."

log "Parte 1 concluída com sucesso. Consulte os logs em: $log_file"
echo "Instalação da Parte 1 concluída. Reinicie o terminal ou a sessão para aplicar as permissões do Docker."
