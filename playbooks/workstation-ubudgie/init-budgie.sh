sudo apt install -y \
  curl \
  xz-utils \
  debian-keyring \
  debian-archive-keyring \
  apt-transport-https \
  ca-certificates \
  gnupg \
  lsb-release \
  software-properties-common \
  exa \
  neofetch \
  flatpak \
  gnome-software-plugin-flatpak \
  stow

sh <(curl -L https://nixos.org/nix/install) --no-daemon
. $HOME/.nix-profile/etc/profile.d/nix.sh

nix-env -i \
  curl \
  unzip \
  vim \
  fish \
  tldr \
  duf \
  bat \
  git \
  diff-so-fancy \
  just \
  tmux \
  xsel \
  wmctrl \
  neovim \
  ripgrep \
  fd \
  lazygit \
  glances

tldr -u

echo "source ~/.nix-profile/etc/profile.d/nix.sh" >> $HOME/.bashrc # todo: how to configure for fish?
source $HOME/.bashrc

# install git LFS
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
nix-env -i git-lfs

git clone --local $HOME/dev/linux-auto git@github.com:tim-codes/linux-auto.git 2&> /dev/null

# setup fish shell
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source -
fisher install jorgebucaran/fisher

if [[ ! -d $HOME/.local/share/omf ]]; then
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

omf update
if ! omf list | grep eden > /dev/null
  # omf install eden
  omf install https://github.com/catppuccin/fish
end

# add catppuccin theme (not working with tpm??)
git clone git@github.com:catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin

# get catppuccin bat themes
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

# install nodejs
curl -fsSL https://fnm.vercel.app/install | bash
source $HOME/.bashrc
fnm install 18
fnm install 20
fnm default 20

# install pnpm
corepack enable
corepack prepare pnpm@latest --activate
pnpm setup

# install gcloud cli
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
  | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
  | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
  && sudo apt-get update \
  && sudo apt-get install google-cloud-cli

# install microsoft devtunnel
curl -sL https://aka.ms/DevTunnelCliInstall | bash

# install ngrok
curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok

# install hydrapaper
flatpak install flathub org.gabmus.hydrapaper

# setup alacritty
mkdir -p $HOME/.config/alacritty
git clone https://github.com/alacritty/alacritty-theme $HOME/.config/alacritty/themes

# https://github.com/tmux-plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm


