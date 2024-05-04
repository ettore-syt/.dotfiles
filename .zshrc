# get VCS info (which branch are we on?)
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats 'on %b'


# custom prompt, default was '%n@%m %1~ %# '
# variant 1, pastel red directory bg
#symbol=$'\uE0B0'
#PS1='${accapo}%K{#313243} %F{#CED6F1}▲ %f%k%K{210}  %F{#181824}%1~%f  %k%F{210}${symbol}%f '
# variant 2, catpuccin white bg
#PS1='${accapo}%K{#313243} %F{#CED6F1}▲ %f%k%K{#CFD6F1}  %F{#181824}%1~%f  %k%F{#CFD6F1}${symbol}%f '
# variant 3: simplicity wins + I love pizza
prompt_margin_top=$'\n'
#PS1='${prompt_margin_top} ▲ | %1~  🍕  '
PS1='${prompt_margin_top} ▲ | %1~  %F{210}>%f  '
RPROMPT='%F{247}${vcs_info_msg_0_}%f'

export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# alias to interact with my dotfiles
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

# pnpm
export PNPM_HOME="/Users/ettore/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
