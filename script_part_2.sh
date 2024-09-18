#!/bin/bash

# 2. Instalação do Zsh (Parte 2):
# Aqui, focaremos em reinstalar o Zsh e garantir que tudo esteja funcionando corretamente antes de seguir para as próximas etapas. Este script garantirá que o Zsh esteja disponível com todas as dependências básicas.

# Script Parte 2: Instalação do Zsh e configuração inicial

# Diretório de logs
install_log_dir="$HOME/zsh_install_logs_$(date +'%Y%m%d%H%M')"
mkdir -p "$install_log_dir"

# Log file
log_file="$install_log_dir/install_log_$(date +'%Y%m%d%H%M').log"

# Função para registrar logs
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

log "Iniciando a instalação do Zsh..."

# 1. Verificar se o Zsh já está instalado
if ! command -v zsh &> /dev/null; then
    log "Zsh não está instalado. Instalando Zsh..."
    sudo apt update
    sudo apt install -y zsh
    log "Zsh instalado com sucesso."
else
    log "Zsh já está instalado."
fi

# 2. Definir Zsh como shell padrão
log "Definindo Zsh como shell padrão..."
chsh -s $(which zsh)
log "Zsh definido como shell padrão."

# 3. Verificar versão do Zsh instalada
zsh_version=$(zsh --version)
log "Versão do Zsh instalada: $zsh_version"

# 4. Criar um .zshrc básico caso não exista
if [ ! -f "$HOME/.zshrc" ]; then
    log "Criando arquivo .zshrc básico..."
    cat <<EOF > ~/.zshrc
# Arquivo de configuração básico do Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"  # Este tema será temporário até o Powerlevel10k ser instalado
plugins=(git)
source \$ZSH/oh-my-zsh.sh
EOF
    log "Arquivo .zshrc criado."
else
    log ".zshrc já existente. Nenhuma ação necessária."
fi

# 5. Finalização
log "Instalação do Zsh concluída com sucesso."
log "Reinicie o terminal ou execute 'source ~/.zshrc' para aplicar as mudanças."

echo "Instalação do Zsh concluída. Consulte os logs em: $log_file"