#!/usr/bin/env bash

#───────────────────────────────────────────────────────────────#
# 📦 Auto Install Essential CLI Tools (Arch Linux)
#───────────────────────────────────────────────────────────────#

set -e  # Exit immediately on error

echo "
            ███╗   ███╗ █████╗ ██╗  ██╗██╗███╗   ██╗    ███████╗                
            ████╗ ████║██╔══██╗██║  ██║██║████╗  ██║    ██╔════╝                
            ██╔████╔██║███████║███████║██║██╔██╗ ██║    ███████╗                
            ██║╚██╔╝██║██╔══██║██╔══██║██║██║╚██╗██║    ╚════██║                
            ██║ ╚═╝ ██║██║  ██║██║  ██║██║██║ ╚████║    ███████║                
            ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝    ╚══════╝                
                                                                                
██████╗  █████╗ ███████╗██╗  ██╗      ███████╗███████╗████████╗██╗   ██╗██████╗ 
██╔══██╗██╔══██╗██╔════╝██║  ██║      ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
██████╔╝███████║███████╗███████║█████╗███████╗█████╗     ██║   ██║   ██║██████╔╝
██╔══██╗██╔══██║╚════██║██╔══██║╚════╝╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██████╔╝██║  ██║███████║██║  ██║      ███████║███████╗   ██║   ╚██████╔╝██║     
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝      ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝
"

#───────────────🔄 Update system
# sudo pacman -Syu --noconfirm

#───────────────📥 Install CLI packages
ESSENTIAL_PACKAGES=(
  duf             # Disk Space
  bat             # Better 'cat'
  gvfs            # Virtual filesystem support
  helix           # Modal text editor
  fastfetch       # System info fetch
  yazi            # TUI file manager
  tree            # Directory tree viewer
  fd              # Simpler 'find'
  ripgrep         # Fast search
  zoxide          # Smart 'cd'
  eza             # Modern 'ls'
  fzf             # Fuzzy finder
  bash-completion # Bash tab completion
  sl              # Steam locomotive (fun)
  ttf-jetbrains-mono-nerd  # 🧠 Nerd font for terminal glyphs
)

echo "📦 Installing: ${ESSENTIAL_PACKAGES[*]}"
sudo pacman -S --noconfirm --needed "${ESSENTIAL_PACKAGES[@]}"

#───────────────🖥️ Ask for GUI editor
echo -n "🖋️  Do you want to install a GUI text editor (gedit)? [y/N]: "
read -r INSTALL_GUI

if [[ "$INSTALL_GUI" =~ ^([yY][eE][sS]|[yY])$ ]]; then
  echo "🖥️ Installing gedit..."
  sudo pacman -S --noconfirm gedit
else
  echo "❌ Skipping GUI editor install."
fi
#───────────────🔁 Reload .bashrc
if [[ -f "$HOME/.bashrc" ]]; then
  echo "🔄 Reloading your .bashrc..."
  source "$HOME/.bashrc"
  echo "✅ .bashrc reloaded!"
fi

echo "
  
██████╗  ██████╗ ███╗   ██╗███████╗
██╔══██╗██╔═══██╗████╗  ██║██╔════╝
██║  ██║██║   ██║██╔██╗ ██║█████╗  
██║  ██║██║   ██║██║╚██╗██║██╔══╝  
██████╔╝╚██████╔╝██║ ╚████║███████╗
╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚══════╝
bash-setup is done please reload your terminal
"
