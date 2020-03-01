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

DIRCOLORS=`command -v gdircolors dircolors | head -1`
eval $($DIRCOLORS -b $HOME/.dircolors)

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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

export EDITOR=vim
# use nvim by default when neovim is installed
if (( $+commands[nvim] )) ; then
  alias vim=nvim
  alias vi=nvim
  export EDITOR=nvim
  export TMUX_VIM_VIM_BIN=nvim
fi

# tmux-vim integration
export TMUX_VIM_LAYOUT='mode:shell,vim-pos:right,size:80'
alias tmux-vim='~/.bin/tmux-vim/tmux-vim'
sp() { tmux-vim sp $* }
vsp() { tmux-vim vsp $* }
e() { tmux-vim e $* }
tabnew() { tmux-vim tabnew $* }
ta() { tmux-vim ta $* }

# aliases
LS_BIN=`command -v gls ls | head -1`
alias ls='$LS_BIN -G -F --color=auto'
alias grep='grep --color=auto'
alias less='less -R'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias man='nocorrect man'
alias git='nocorrect git'
alias hg='nocorrect hg'
alias rg='nocorrect rg'

export GREP_COLOR='1;31'
export GREP_COLORS='fn=38;5;8:ln=38;5;8:bn=38;5;8:se=38;5;8'

export hist_ignore_all_dups
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

setopt correctall

if [ "$SSH_AUTH_SOCK" != "/tmp/ssh-agent-$USER-screen" ]; then
  ln -sf $SSH_AUTH_SOCK /tmp/ssh-agent-$USER-screen
  export SSH_AUTH_SOCK="/tmp/ssh-agent-$USER-screen"
fi

initssh() { ssh $1 echo -n }

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

# fzf file select
__fsel() {
  set -o nonomatch
  find * -path '*/\.*' -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | fzf-tmux -x -m -d "20%" | while read item; do
    printf '%q ' "$item"
  done
  echo
}
fzf-file-select() {
  # see https://github.com/wellle/dotfiles/blob/master/fzf.zsh
  # TODO: this could probably be cleaner
  LBUFFER="${LBUFFER%% #}$(__fsel)"
  zle redisplay
}
zle     -N   fzf-file-select
bindkey '^t' fzf-file-select

# vim tags
function _get_tags {
  [ -f ./tags ] || return
  local cur
  read -l cur
  echo $(echo $(awk -v ORS=" "  "/^${cur}/ { print \$1 }" tags))
}
compctl -x 'C[-1,-t]' -K _get_tags -- vim

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

# homebrew settings
export HOMEBREW_NO_ANALYTICS=1

function man {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

set_terminal_tab_title() {
  print -Pn "\e]1;$1:q\a"
}

precmd() {
  set_terminal_tab_title "$USER@$HOST"
}

if (( !$+commands[pbcopy] )) ; then
  alias pbcopy='clipsync'
fi

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  USER_ID=$(id -u $USER)
  mkdir -p /run/user/$USER_ID/gnupg/
  ln -snf $HOME/.gnupg/S.gpg-agent /run/user/$USER_ID/gnupg/S.gpg-agent
fi

# load local settings
if [ -f ~/.zshrc.local ]; then
  source ~/.zshrc.local
fi
