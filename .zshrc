# key bindings
bindkey -v # vim mode
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word

# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line

# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# undo
bindkey '^u' undo
bindkey '^o' clear-screen

# edit command line in vim
autoload edit-command-line && zle -N edit-command-line
bindkey '\ee' edit-command-line

# quick help through <esc-h>
autoload run-help
bindkey "\eh" run-help

autoload -U compinit
compinit -i

eval $(dircolors -b $HOME/.dircolors)

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# cycle history with C-p/C-n
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

autoload -U promptinit
promptinit
PROMPT=$'[%n@%m %1~]$ '

# allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

# history
setopt hist_ignore_all_dups

# disable flow control (ctrl+s freezes terminal)
stty -ixon

# aliases
alias ls='ls -G -F --color=auto'
alias grep='grep --color=always'
alias less='less -R'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias man='nocorrect man'
sp() { tmux-vim sp $* }
vsp() { tmux-vim vsp $* }
e() { tmux-vim e $* }
tabnew() { tmux-vim tabnew $* }
ta() { tmux-vim ta $* }
send() { echo $* | nc localhost 52698 }
alias pbcopy='sed 1i"copy" | nc localhost 52698'
alias notify='send notify done'

export GREP_COLOR='1;31'

export hist_ignore_all_dups
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
export PATH="$HOME/.bin:$PATH"

setopt correctall

export EDITOR=vim
alias back='cd "$OLDPWD"'

if [ "$SSH_AUTH_SOCK" != "/tmp/ssh-agent-$USER-screen" ]; then
  ln -sf $SSH_AUTH_SOCK /tmp/ssh-agent-$USER-screen
  export SSH_AUTH_SOCK="/tmp/ssh-agent-$USER-screen"
fi

#
# Gentoo-like prompt
#
prompt_gentoo_setup () {
  local blue=${1:-'blue'}
  local green=${2:-'green'}
  local red=${3:-'red'}

  if [ "$USER" = 'root' ]
  then
    base_prompt="%B%F{$red}%m%k "
  else
    base_prompt="%B%F{$green}%n@%m%k "
  fi
  post_prompt="%b%f%k"

  path_prompt="%B%F{$blue}%1~"
  PS1="$base_prompt$path_prompt %# $post_prompt"
  PS2="%B%F{$blue}%_> $post_prompt"
  PS3="%B%F{$blue}?# $post_prompt"
}

prompt_gentoo_setup "$@"

# vim tags
function _get_tags {
  [ -f ./tags ] || return
  local cur
  read -l cur
  echo $(echo $(awk -v ORS=" "  "/^${cur}/ { print \$1 }" tags))
}
compctl -x 'C[-1,-t]' -K _get_tags -- vim

# misc aliases
alias stripc='sed -r "s/\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias lasturl='tmux capture-pane \; show-buffer -b0 \; delete-buffer -b0 | grep -P -o "(?:https?://|ftp://|news://|mailto:|file://|\bwww\.)[a-zA-Z0-9\-\@;\/?:&=%\$_.+!*\x27,~#]*(\([a-zA-Z0-9\-\@;\/?:&=%\$_.+!*\x27,~#]*\)|[a-zA-Z0-9\-\@;\/?:&=%\$_+*~])+" | tail -1 | stripc'

# change cursor shape depending on insert mode
function zle-keymap-select zle-line-init
{
  # change cursor shape in iTerm2
  case $KEYMAP in
    vicmd)      print -n -- "\E]50;CursorShape=0\C-G";;  # block cursor
    viins|main) print -n -- "\E]50;CursorShape=1\C-G";;  # line cursor
  esac

  zle reset-prompt
  zle -R
}

function zle-line-finish
{
  print -n -- "\E]50;CursorShape=0\C-G"  # block cursor
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# load local settings
if [ -f ~/.zsh/local ]; then
  source ~/.zsh/local
fi
