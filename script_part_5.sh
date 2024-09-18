#!/bin/bash
# Script Parte 3: Configurações Adicionais e Finalização

# Diretório de logs
install_log_dir="$HOME/zsh_install_logs_$(date +'%Y%m%d%H%M')"
mkdir -p "$install_log_dir"

# Log file
log_file="$install_log_dir/zsh_final_config_log_$(date +'%Y%m%d%H%M').log"

# Função para registrar logs
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

log "Iniciando configurações adicionais e finalização..."

# 1. Backup do arquivo .zshrc
log "Criando backup do arquivo .zshrc..."
cp ~/.zshrc ~/.zshrc.bak-$(date +'%Y%m%d%H%M')
log "Backup criado em ~/.zshrc.bak-$(date +'%Y%m%d%H%M')."

# 2. Verificação e instalação de Nerd Fonts (FiraCode, Hack, JetBrains Mono)
log "Verificando a instalação de Nerd Fonts..."
nerd_fonts_dir="$HOME/.local/share/fonts"

# Função para instalar uma Nerd Font
install_nerd_font() {
    local font_name="$1"
    local font_url="$2"
    
    if ! fc-list | grep -i "$font_name" >/dev/null; then
        log "$font_name Nerd Font não encontrada. Instalando..."
        curl -fLo "$nerd_fonts_dir/${font_name}.zip" "$font_url"
        unzip -o "$nerd_fonts_dir/${font_name}.zip" -d "$nerd_fonts_dir"
        fc-cache -fv
        log "$font_name Nerd Font instalada."
        # Remover o arquivo zip após a instalação
        rm "$nerd_fonts_dir/${font_name}.zip"
        log "$font_name .zip removido."
    else
        log "$font_name Nerd Font já está instalada."
    fi
}

# Instalar FiraCode, Hack e JetBrains Mono
mkdir -p "$nerd_fonts_dir"
install_nerd_font "FiraCode" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"
install_nerd_font "Hack" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip"
install_nerd_font "JetBrainsMono" "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/JetBrainsMono.zip"

# 3. Verificação e instalação de pacotes essenciais (bat, eza, nnn, fzf)
log "Verificando pacotes essenciais: bat, eza, nnn, fzf..."

# Função para instalação de pacotes
install_package() {
    local pkg_name="$1"
    local install_cmd="$2"

    if ! command -v "$pkg_name" &> /dev/null; then
        log "$pkg_name não encontrado. Instalando $pkg_name..."
        $install_cmd
        log "$pkg_name instalado."
    else
        log "$pkg_name já está instalado."
    fi
}

# Instalar pacotes essenciais
install_package "bat" "sudo apt-get install -y bat"
install_package "eza" "sudo apt-get install -y exa"
install_package "nnn" "sudo apt-get install -y nnn"
install_package "fzf" "sudo apt-get install -y fzf"

# 4. Adicionar aliases úteis no .zshrc
log "Adicionando aliases úteis ao .zshrc..."
if ! grep -q "alias ll=" "$HOME/.zshrc"; then
    cat <<EOF >> ~/.zshrc
# Aliases úteis
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'

# Alias para nnn como gerenciador de arquivos
alias open='nnn'

# Função para abrir arquivos e diretórios de forma inteligente (smartopen)
smartopen() {
  if [ -d "\$1" ]; then
    # Se for um diretório, usar eza com árvore
    eza --tree --level=2 --icons "\$1"
  elif [ -f "\$1" ]; then
    case "\$1" in
      *.txt|*.md|*.sh|*.json|*.csv|*.py|*.js|*.html)
        # Se for um arquivo de texto ou código, usar bat para syntax highlighting
        bat "\$1"
        ;;
      *)
        # Para outros tipos de arquivos, usar see ou bat
        if command -v see &> /dev/null; then
          see "\$1"
        else
          bat "\$1"
        fi
        ;;
    esac
  else
    echo "'\$1' não é um arquivo ou diretório válido."
  fi
}

alias smartopen='smartopen'

# Função de navegação interativa com fzf
z_fzf() {
  local dir
  dir=\$(z -l 2>&1 | fzf --height 40% --border --ansi) && cd "\$dir"
}
bindkey '^g' z_fzf
EOF
    log "Aliases adicionados ao .zshrc."
else
    log "Aliases já presentes no .zshrc."
fi

# 5. Configurar terminal para suportar cores avançadas
log "Configurando suporte a cores avançadas no terminal..."
if ! grep -q "export TERM=xterm-256color" "$HOME/.zshrc"; then
    cat <<EOF >> ~/.zshrc
# Ativar suporte a cores avançadas
export TERM=xterm-256color
EOF
    log "Configuração de cores adicionada ao .zshrc."
else
    log "Configuração de cores já presente no .zshrc."
fi

# 6. Finalização e reinicialização
log "Configuração adicional e finalização concluídas."
log "Reinicie o terminal ou execute 'source ~/.zshrc' para aplicar as mudanças."

echo "Configurações adicionais concluídas. Consulte os logs em: $log_file"
