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

alias go='yazi'
alias gc='git clone'
alias n='helix $HOME/.config/note/note.txt'
alias linutil='curl -fsSL https://christitus.com/linux | sh'
alias f='fd --exec rg --color=always'  
alias fzf='fzf --preview "bat --style=numbers --color=always {}" --bind "enter:execute(helix {})"'


#────────────────────🚀 ZOXIDE 🚀────────────────────────────#

eval "$(zoxide init --cmd cd bash)"

#─────────────────────🗃️ EZA 🗃️──────────────────────────────#

alias ls='eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions'
alias lst='eza --tree --level=2 --icons=always --color=always '
alias tree='eza --tree --all --icons=always --color=always '

#───────────────🧠 BASH COMPLETION 🧩─────────────────────────#

if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

#───────────────🎨 TAB COMPLETION AND COLOR 🌈────────────────────#

# TAB COMPLEATION AND SCROLING
bind 'set show-all-if-ambiguous on'
bind '"\t":menu-complete'

#COLORS
export CLICOLOR=1
export LS_COLORS=$LS_COLORS:'di=1;34:'
bind 'set colored-completion-prefix on'
eval "$(dircolors -b)"
bind 'set colored-stats on'

#──────────────────────💻 PS1 PROMPT 💻────────────────────────#

get_dir_icon() {
    # If no write permission (likely root/system dir)
    if [ ! -w "$PWD" ]; then
        echo ""
        return
    fi

    case "$PWD" in
        "$HOME") echo "" ;;
        "$HOME/.config") echo "" ;;
        "$HOME/Documents") echo "" ;;
        "$HOME/Desktop") echo "" ;;
        "$HOME/Downloads") echo "" ;;
        *) echo "" ;;
    esac
}

PS1='\[\e[1;32m\]\u\[\e[38;5;208m\]@\[\e[1;32m\]\h\[\e[0m\] \
\[\e[38;5;139m\]⏽\[\e[0m\] \
\[\e[0;34m\]󰥔 \@\[\e[0m\] \
\[\e[38;5;139m\]⏽\[\e[0m\] \
\[\e[38;5;178m\]\w $(get_dir_icon)\[\e[0m\] \
\[\e[38;5;139m\] ⏽\[\e[0m\] \
\n\[\e[38;5;208m\]\[\e[0m\] '


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

#───────────────────🕓 Copy With Status 📦──────────────────────────────#
cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
  awk '{
    count += $NF
    if (count % 10 == 0) {
      percent = count / total_size * 100
      printf "%3d%% [", percent
      for (i=0; i<=percent; i++) printf "="
      printf ">"
      for (i=percent; i<100; i++) printf " "
      printf "]\r"
    }
  }
  END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# ──────────────🔥 FZF History Picker on Ctrl+Up Arrow ────────────── #

HISTTIMEFORMAT="%F %T   "
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export FZF_DEFAULT_OPTS='
  --exact --border=bold --border=rounded
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f
  --color=fg+:#ffffff,bg+:#3c3836,hl+:#fe8019
  --color=info:#83a598,prompt:#b8bb26,pointer:#d3869b
  --color=marker:#fb4934,spinner:#8ec07c,header:#d65d0e
'

#──────────────────────────────────────────────────────────────────────#


