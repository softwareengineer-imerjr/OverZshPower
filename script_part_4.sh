#!/bin/bash
# Script Parte 2: Instalação e Configuração do Oh-My-Zsh e Plugins

# Diretório de logs
install_log_dir="$HOME/zsh_install_logs_$(date +'%Y%m%d%H%M')"
mkdir -p "$install_log_dir"

# Log file
log_file="$install_log_dir/ohmyzsh_plugins_install_log_$(date +'%Y%m%d%H%M').log"

# Função para registrar logs
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

log "Iniciando a instalação do Oh-My-Zsh e plugins..."

# 1. Instalação do Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Oh-My-Zsh não encontrado. Instalando..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    log "Oh-My-Zsh instalado com sucesso."
else
    log "Oh-My-Zsh já está instalado."
fi

# 2. Instalação dos plugins do Oh-My-Zsh
log "Instalando plugins adicionais do Oh-My-Zsh..."

declare -A plugins
plugins=(
  ["autojump"]="https://github.com/wting/autojump.git"
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
  ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
  ["command-not-found"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found"
  ["alias-finder"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/alias-finder"
  ["autoenv"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/autoenv"
  ["docker"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker"
  ["docker-compose"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose"
  ["extract"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/extract"
  ["git"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git"
  ["thefuck"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/thefuck"
  ["virtualenv"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/virtualenv"
  ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
  ["zsh-history-substring-search"]="https://github.com/zsh-users/zsh-history-substring-search"
  ["zsh-interactive-cd"]="https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zsh-interactive-cd"
  ["zsh-navigation-tools"]="https://github.com/psprint/zsh-navigation-tools"
)

# Diretório customizado de plugins do Oh-My-Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

for plugin in "${!plugins[@]}"; do
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]; then
    git clone "${plugins[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
    log "Plugin $plugin instalado."
  else
    log "Plugin $plugin já está instalado."
  fi
done

# 3. Atualizar o arquivo .zshrc com os plugins instalados
log "Atualizando o arquivo .zshrc com os novos plugins e variáveis de ambiente..."

# Atualizar o fpath para suportar autocompletar do zsh-completions
if ! grep -q "fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src" "$HOME/.zshrc"; then
    echo "fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src" >> "$HOME/.zshrc"
    log "fpath atualizado com suporte ao zsh-completions."
else
    log "fpath para zsh-completions já presente no .zshrc."
fi

# Plugins do Oh-My-Zsh no .zshrc
if ! grep -q "plugins=(" "$HOME/.zshrc"; then
    cat <<EOF >> ~/.zshrc
# Plugins do Oh-My-Zsh
plugins=(
  alias-finder
  autoenv
  autojump
  command-not-found
  docker
  docker-compose
  extract
  git
  thefuck
  virtualenv
  zsh-autosuggestions
  zsh-completions
  zsh-history-substring-search
  zsh-interactive-cd
  zsh-navigation-tools
)
EOF
    log "Plugins do Oh-My-Zsh adicionados ao .zshrc."
else
    log "Plugins já configurados no .zshrc."
fi

# Configuração de variáveis de ambiente para Python e Virtualenv
if ! grep -q "export WORKON_HOME=" "$HOME/.zshrc"; then
    cat <<EOF >> ~/.zshrc
# Variáveis de ambiente para Python e Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh
EOF
    log "Variáveis de ambiente para Python e Virtualenv adicionadas ao .zshrc."
else
    log "Variáveis de ambiente já configuradas no .zshrc."
fi

# Configurar zsh-syntax-highlighting e F-Sy-H por último no .zshrc
if ! grep -q "source \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$HOME/.zshrc"; then
    cat <<EOF >> ~/.zshrc
# zsh-syntax-highlighting e Fast Syntax Highlighting
source \$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source \$ZSH_CUSTOM/plugins/F-Sy-H/F-Sy-H.plugin.zsh
EOF
    log "zsh-syntax-highlighting e F-Sy-H configurados no .zshrc."
else
    log "zsh-syntax-highlighting e F-Sy-H já configurados no .zshrc."
fi

# 4. Finalização
log "Instalação do Oh-My-Zsh e plugins concluída com sucesso."
log "Reinicie o terminal ou execute 'source ~/.zshrc' para aplicar as mudanças."

echo "Instalação da Parte 2 concluída. Consulte os logs em: $log_file"
