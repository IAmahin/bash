#───────────────────────────────────────────────────────────────#
#    ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗            #
#    ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔════╝            #
#    ██████╔╝███████║███████╗███████║██████╔╝██║                 #
#    ██╔══██╗██╔══██║╚════██║██╔══██║██╔══██╗██║                 #
# ██╗██████╔╝██║  ██║███████║██║  ██║██║  ██║╚██████╗            #
# ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝            #

#────────────────────────🛠️ SYSTEM ALIAS ⚙️───────────────────────#

alias c='clear'
alias off='shutdown now'
alias sleep='systemctl suspend'
alias cat='bat'
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'

alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'

alias ins='sudo pacman -S'
alias uins='sudo pacman -Rns'
alias updt='sudo pacman -Syu'

alias cbash='helix ~/.bashrc'
alias qq='source ~/.bashrc && fastfetch'

#───────────────✍️ TEXT EDITING ALIAS 📝──────────────────────#

alias h='helix'
alias hi='sudo helix'
alias g='gedit'
alias gi='sudo gedit'

#────────────────────🧱 DWM ALIAS 🧱─────────────────────────#

alias s='clear && startx'
alias cst='cd ~/.config/slstatus && helix config.def.h'
alias rest='cd ~/.config/slstatus && rm config.h && sudo make clean install'

alias cdwm='cd ~/.config/dwm && helix config.def.h'
alias redwm='cd ~/.config/dwm && sudo rm config.h && sudo make clean install && cd ~'

alias ii='sudo make clean install'
alias iii='sudo rm config.h && sudo make clean install'

#───────────────✨ EXTRA ALIAS ⚡─────────────────────────────#

alias info='fastfetch'
alias go='yazi'
alias gc='git clone'
alias n='helix $HOME/.config/note/note.txt'
alias linutil='curl -fsSL https://christitus.com/linux | sh'
alias f='fd --exec rg --color=always'  
alias tree='tree -CAhF --dirsfirst'

#────────────────────🚀 ZOXIDE 🚀────────────────────────────#

eval "$(zoxide init --cmd cd bash)"

#─────────────────────🗃️ EZA 🗃️──────────────────────────────#

alias ls="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

#───────────────🧠 BASH COMPLETION 🧩─────────────────────────#

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'

#───────────────🎨 TAB COLOR COMPLETION 🌈────────────────────#

bind "set colored-completion-prefix on"
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"

export LS_COLORS=$LS_COLORS:'di=1;34:'
eval "$(dircolors -b)"

#──────────────────────💻 PS1 PROMPT 💻────────────────────────#

PS1='\[\e[1;32m\]\u\[\e[38;5;208m\]@\[\e[1;32m\]\h\[\e[0m\] \[\e[38;5;139m\])\[\e[0m\] \[\e[0;34m\]󰥔 \@\[\e[0m\] \[\e[38;5;139m\])\[\e[0m\] \[\e[38;5;178m\]\w\[\e[38;5;178m\] \[\e[0m\] \[\e[38;5;139m\] )\[\e[0m\] \n\[\e[38;5;208m\]\[\e[0m\] '

# ──────────────🔥 FZF History Picker on Ctrl+Up Arrow ────────────── #

__fzf_history__() {
  local entry
  entry=$(
    history | tac | awk '{
      $1=""; sub(/^ +/, "");
      split($0, a, " ");
      time=a[1] " " a[2];
      $1=$2=""; sub(/^ +/, "");
      printf "%s   %s\n", time, $0
    }' | fzf --prompt='📜 History> ' --preview='echo {}' --preview-window=up:1
  ) || return

  READLINE_LINE="${entry#*   }"
  READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\e[1;5A":__fzf_history__'


#───────────────📂 YAZI CD SUPPORT 🔄─────────────────────────#

y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  cwd=$(<"$tmp")
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
  rm -f "$tmp"
}

#───────────────🎨 DEFAULT EDITOR ─────────────────────────────#

export EDITOR=helix

#───────────────────📦 EXTRACT 🗃️──────────────────────────────#

uzp() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case $archive in
        *.tar.bz2) tar xvjf "$archive" ;;
        *.tar.gz)  tar xvzf "$archive" ;;
        *.bz2)     bunzip2 "$archive" ;;
        *.rar)     rar x "$archive" ;;
        *.gz)      gunzip "$archive" ;;
        *.tar)     tar xvf "$archive" ;;
        *.tbz2)    tar xvjf "$archive" ;;
        *.tgz)     tar xvzf "$archive" ;;
        *.zip)     unzip "$archive" ;;
        *.Z)       uncompress "$archive" ;;
        *.7z)      7z x "$archive" ;;
        *)         echo "🛑 Don't know how to extract '$archive'..." ;;
      esac
    else
      echo "⚠️ '$archive' is not a valid file!"
    fi
  done
}
# ──────────────🔥 FZF History Picker on Ctrl+Up Arrow ────────────── #

HISTTIMEFORMAT="%F %T   "
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export FZF_DEFAULT_OPTS='
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f
  --color=fg+:#ffffff,bg+:#3c3836,hl+:#fe8019
  --color=info:#83a598,prompt:#b8bb26,pointer:#d3869b
  --color=marker:#fb4934,spinner:#8ec07c,header:#d65d0e
'

#──────────────────────────────────────────────────────────────────────#


source /home/i/.config/broot/launcher/bash/br
