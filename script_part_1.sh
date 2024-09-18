#!/bin/bash

# 1. Script de Desinstalação Completa (Parte 1):
# Este será o primeiro script, que cuidará da desinstalação total do Zsh, Oh-My-Zsh, Powerlevel10k, fontes e plugins instalados anteriormente, além de realizar backups completos.

# Script Parte 1: Desinstalação Completa do Zsh, Oh-My-Zsh, Powerlevel10k e Plugins

# Criar diretório para backup
backup_dir="$HOME/zsh_cleanup_backup_$(date +'%Y%m%d%H%M')"
mkdir -p "$backup_dir"

# Log file
log_file="$backup_dir/cleanup_log_$(date +'%Y%m%d%H%M').log"

# Função para registrar logs
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$log_file"
}

# 1. Backup de arquivos de configuração
log "Iniciando backup dos arquivos de configuração."
cp "$HOME/.zshrc" "$backup_dir/.zshrc"
cp "$HOME/.p10k.zsh" "$backup_dir/.p10k.zsh"
cp "$HOME/.fzf.zsh" "$backup_dir/.fzf.zsh"
cp "$HOME/.oh-my-zsh" "$backup_dir/.oh-my-zsh" -r
log "Arquivos de configuração salvos no diretório de backup: $backup_dir."

# 2. Remover Zsh, Oh-My-Zsh e Powerlevel10k
log "Removendo Powerlevel10k..."
rm -rf "$HOME/powerlevel10k"
log "Powerlevel10k removido."

log "Removendo Oh-My-Zsh..."
rm -rf "$HOME/.oh-my-zsh"
rm "$HOME/.zshrc"
log "Oh-My-Zsh removido."

log "Desinstalando o Zsh..."
sudo apt-get remove --purge zsh -y
log "Zsh removido."

# 3. Limpar pacotes de plugins e Nerd Fonts
log "Limpando plugins adicionais e Nerd Fonts."
rm -rf "$HOME/.local/share/fonts"
rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/*"
log "Fontes e plugins removidos."

# 4. Limpeza final
log "Desinstalação e limpeza concluída."