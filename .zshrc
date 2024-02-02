# get VCS info (which branch are we on?)
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst
zstyle ':vcs_info:git:*' formats 'on %b'

# custom prompt, default was '%n@%m %1~ %# '
PS1='▲ | %1~ %F{210}>%f '
RPROMPT='%F{247}${vcs_info_msg_0_}%f'

