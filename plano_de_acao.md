# Plano de Ação Atualizado para Criação dos Scripts

## Objetivo Geral:
Executar a desinstalação completa e, em seguida, instalar e configurar o Zsh, Oh-My-Zsh, Powerlevel10k e seus respectivos plugins, pacotes e configurações. A instalação será realizada em etapas, com cada script executando uma fase distinta do processo, todos integrados e em continuidade. A instalação será feita com logs gerados para cada etapa e backups automáticos de arquivos.

---

## Fases de Execução dos Scripts:

### 1. **Fase 1: Desinstalação Completa e Backup dos Arquivos de Configuração**
- **Nome sugerido:** `cleanup_and_backup_zsh.sh`
- **Função:** Realiza a desinstalação completa do Zsh, Oh-My-Zsh, Powerlevel10k, plugins e fontes Nerd Fonts, além de realizar o backup de todos os arquivos de configuração que serão removidos ou modificados.

#### Principais Tarefas:
- Backup dos arquivos de configuração (.zshrc, .p10k.zsh, .fzf.zsh).
- Remoção completa do Zsh, Oh-My-Zsh, Powerlevel10k e seus plugins.
- Limpeza de fontes e outros pacotes associados.
- Geração de logs detalhados para auditoria.

---

### 2. **Fase 2: Instalação do Zsh e Definição como Shell Padrão**
- **Nome sugerido:** `install_zsh.sh`
- **Função:** Instala o Zsh, define-o como o shell padrão e cria um arquivo `.zshrc` básico para garantir que o ambiente esteja pronto para as próximas fases.

#### Principais Tarefas:
- Instalação do Zsh, caso ainda não esteja instalado.
- Definir o Zsh como shell padrão do sistema.
- Criação de um `.zshrc` básico com um tema temporário e o plugin Git.
- Geração de logs detalhados sobre o status da instalação.

---

### 3. **Fase 3: Instalação de Dependências do Sistema e Pacotes Necessários**
- **Nome sugerido:** `install_system_dependencies.sh`
- **Função:** Instala pacotes do sistema necessários para o correto funcionamento dos plugins e ferramentas do Zsh. Isso inclui Docker, Virtualenv, Git, entre outros.

#### Principais Tarefas:
- Instalação de Docker, Docker Compose, Virtualenv e Virtualenvwrapper.
- Instalação de Git, Git-Flow, Git-LFS e `command-not-found`.
- Verificações pós-instalação para garantir que as permissões e integrações estejam corretas.
- Geração de logs detalhados da instalação de cada componente.

---

### 4. **Fase 4: Instalação do Oh-My-Zsh e Plugins**
- **Nome sugerido:** `install_oh_my_zsh_and_plugins.sh`
- **Função:** Instala o Oh-My-Zsh e os plugins selecionados, garantindo que todos estejam integrados corretamente no arquivo `.zshrc`.

#### Principais Tarefas:
- Instalação do Oh-My-Zsh.
- Instalação de plugins como `autojump`, `zsh-autosuggestions`, `zsh-syntax-highlighting`, `git`, entre outros.
- Atualização do arquivo `.zshrc` para refletir os plugins instalados e as variáveis de ambiente necessárias.
- Geração de logs detalhados sobre cada plugin instalado e suas configurações.

---

### 5. **Fase 5: Instalação de Ferramentas Essenciais e Customizações Finais**
- **Nome sugerido:** `install_tools_and_customizations.sh`
- **Função:** Instala fontes Nerd Fonts, pacotes como `bat`, `eza`, `nnn`, e realiza ajustes finais no `.zshrc` para melhorar a experiência do terminal.

#### Principais Tarefas:
- Instalação de Nerd Fonts (FiraCode, Hack, JetBrains Mono).
- Instalação de ferramentas como `bat`, `eza`, `nnn`, `fzf`.
- Adição de aliases úteis e configuração de cores avançadas no terminal.
- Atualização do `.zshrc` com configurações customizadas e funções de navegação.
- Geração de logs sobre as configurações e pacotes instalados.

---

### 6. **Fase 6: Instalação do Powerlevel10k**
- **Nome sugerido:** `install_powerlevel10k.sh`
- **Função:** Instala o Powerlevel10k e prepara o ambiente para que o usuário realize a configuração manual do tema.

#### Principais Tarefas:
- Instalação do Powerlevel10k.
- Configuração mínima necessária no arquivo `.zshrc` para integrar o Powerlevel10k.
- Instrução para o usuário rodar o comando `p10k configure` para fazer as configurações manuais do tema.
- Geração de logs sobre o status da instalação e orientação ao usuário.

---

## **Geração de Logs e Backups**
- **Logs Detalhados:** Todos os scripts gerarão logs detalhados de cada comando executado, armazenando as saídas em arquivos de log para facilitar o diagnóstico.
- **Backups Automáticos:** Qualquer arquivo de configuração alterado será previamente salvo em um backup automático para recuperação em caso de falha.

---

## **Ordem de Execução dos Scripts**
1. **`cleanup_and_backup_zsh.sh`** - Desinstalação completa e backup.
2. **`install_zsh.sh`** - Instalação do Zsh e configuração básica.
3. **`install_system_dependencies.sh`** - Instalação de pacotes e dependências do sistema.
4. **`install_oh_my_zsh_and_plugins.sh`** - Instalação do Oh-My-Zsh e dos plugins.
5. **`install_tools_and_customizations.sh`** - Instalação de ferramentas essenciais e customizações finais.
6. **`install_powerlevel10k.sh`** - Instalação do Powerlevel10k e instruções para configuração manual.

---

### **Resumo:**
Este Plano de Ação organiza todos os scripts em fases lógicas e sequenciais, permitindo um fluxo contínuo de instalação e configuração do Zsh, Oh-My-Zsh, Powerlevel10k e plugins associados. Cada fase realiza um conjunto de tarefas específicas, facilitando o diagnóstico e recuperação de erros através dos logs gerados e backups automáticos.
