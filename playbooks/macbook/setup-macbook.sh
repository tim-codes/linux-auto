#!/bin/zsh

# create default zshrc file
touch ~/.zshrc

if [[ -z "$(which brew)" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'PATH="/opt/homebrew/bin:$PATH"' >> ~/.zshrc
  source ~/.zshrc
fi

# https://switowski.com/blog/favorite-cli-tools

brewDeps=(
  ansible
  asciinema
  bat
  colordiff
  ctop
  devtunnel
  diff-so-fancy
  duf
  exa
  fd
  fish
  fzf
  git
  glances
  htop
  httpie
  just
  jq
  k9s
  #kdash
  lazydocker
  lazygit
  ncdu
  nvm
  ripgrep
  sloth
  telnet
  terraform
  tldr
  thefuck
  tree
  webp
  websocat
  yq
)
brew install $brewDeps

# make sure fish config directory exists so we can install gcloud completion
mkdir -p ~/.config/fish

brew install --cask google-cloud-sdk
cd ~ \
  && rm -rf gcloud-completion \
  && git clone https://github.com/aliz-ai/google-cloud-sdk-fish-completion gcloud-completion \
  && cd gcloud-completion \
  && ./install.sh \
  && cd ~ \
  && rm -rf gcloud-completion

if [[ ! -d /Users/tim/.local/share/omf ]]; then
  curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

sudo chsh -s $(which fish)

# fish script...
cat <<EOF | fish

# omf theme
omf update
if ! omf list | grep eden > /dev/null
  omf install eden
end

# install powerline fonts
cd ~ \
  && git clone https://github.com/powerline/fonts.git powerline-fonts \
  && cd powerline-fonts \
  && ./install.sh \
  && cd ~ \
  && rm -rf powerline-fonts

# https://github.com/jorgebucaran/fisher#quickstart
# https://github.com/PatrickF1/fzf.fish
if ! type -q fisher
    curl -sL https://git.io/fisher | source
end

fisher install jorgebucaran/fisher \
  && fisher install jorgebucaran/nvm.fish \
  && fisher install PatrickF1/fzf.fish

# setup nodejs
nvm install 16
brew install npm pnpm

set npm_globals \
  "@xata.io/cli" \
  "cdktf-cli" \
  "opencommit" \
  "ts-node" \
  "typescript" \
  "vercel"

pnpm i -g $npm_globals

EOF
