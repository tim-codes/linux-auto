set -U fish_greeting ""

source $HOME/.local/share/omf/pkg/omf/functions/omf.fish
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# Fish Config
set fish_theme eden
set -x fish_conf "$HOME/.config/fish/config.fish"

# set shell title to pwd
function fish_title
    set -q argv[1]; or set argv fish
    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
end

# Make the blue color for directories more readable
set -x LSCOLORS Exfxcxdxbxegedabagacad

# edit fish config
set FISH_CONFIG_SOURCE "~/dev/workstation/config.fish"
alias cf="code $FISH_CONFIG_SOURCE"
alias ff="fleet $FISH_CONFIG_SOURCE"
alias vf="vim $FISH_CONFIG_SOURCE"

# reload fish config
function rf
  rm $fish_conf
  touch $fish_conf
  echo "# ~~~~ WARNING: DO NOT EDIT THIS FILE ~~~~ #" >> $fish_conf
  cat ~/dev/workstation/config.fish >> $fish_conf
  source $fish_conf
end

set -x PATH "$HOME/bin:/usr/local/bin:$PATH"
set -x PATH "/opt/homebrew/bin:$PATH"
set -x PATH "/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
set -x PATH "$PNPM_HOME:$PATH"PATH="$PNPM_HOME:$PATH"
set -x PATH "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
set -x PATH "$HOME/sdk/go1.20.5/bin:$PATH"
set -x PATH "$HOME/go/bin:$PATH"
set -x PATH "$HOME/Library/Application Support/Jetbrains/Toolbox/scripts:$PATH"
set -x PATH "$HOME/dev/workstation/bin:$PATH"
set -x PATH "$HOME/Library/pnpm:$PATH"

set -x PNPM_HOME "/Users/tim/Library/pnpm"
set -x GOROOT "$HOME/sdk/go1.20.5"
set -x GOPATH "$HOME/go"
set -x NVM_DIR "$HOME/.nvm"
set -x KUBE_CONFIG_PATH "$HOME/.kube/config"

# enable IAP ssh tunnel to use numpy on system to increase performance
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1

# nodejs configuration
set -x nvm_default_version 18
nvm use $nvm_default_version &> /dev/null # override as the var is not being ignored by nvm

# set OpenAI API Key to opencommit config
opencommit config set OCO_OPENAI_API_KEY=$(cat ~/keys/openai.key)

# fish aliases to mimic bash `which`
alias which="type -p"
alias where="type -a"

# use exa for dir commands
alias l="ll"
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"

alias mp="mkdir -p"

alias python="python3"
alias py="python"
alias tf="terraform"
alias pm="podman"
alias p="pnpm"
alias gcp="gcloud"
alias oc="opencommit"

# Git aliases
alias g="git"
alias gs='git status -sb'
alias gcl='git clone'
alias gf='git fetch'
alias gm='git merge'
alias gp='git pull'

alias ga='git add'
alias gap='ga --patch'

function gd
  git diff --color $argv[1] | diff-so-fancy | bat
end
alias gds="git diff --staged --color | diff-so-fancy | bat"

alias gb='git branch'
alias gbl='gb -l | cat'
alias gblr='gb -lr | cat'

alias gc='git commit -m'
alias gcn='git commit --no-verify -m'
alias gca='git commit -a -m'
alias gcan='git commit -a --no-verify -m'

alias gr='git reset'
alias grev='git revert'
alias greb='git rebase'
alias grebi='greb --interactive'
alias gundo='gr HEAD^'
alias gunstage='gr HEAD --'

alias gpu='git push'
alias gpun='gpu --no-verify'
alias gpuf='gpu --force-with-lease'
alias gpunf='gpu --no-verify --force-with-lease'
alias gpufn='gpunf'
alias godel='gpu --no-verify --delete origin'

alias gch='git checkout'
function gchh
  set resetting (echo $argv | grep -E 'package.json|pnpm-lock.yaml')
  if $resetting
    echo "manifests changed, running install hook"
    git checkout HEAD -- $argv
  else
    echo "manifests unchanged, skipping install hook"
    git -c core.hooksPath=/dev/null checkout HEAD -- $argv
  end
end

# Default git pull strategy
git config --global pull.rebase true

# Terraform aliases
alias tfi="tf init"
alias tfpx="tf plan" # base plan
alias tfp="tfpx -lock=false" # plan (no-lock)
alias tfpr="tfpx -lock=false -refresh-only" # refresh
alias tfpl="tfpx -lock=true" # plan (lock)
alias tfpc="tfpx -lock=true -input=false -out=plan.cache" # plan to file
alias tfa="tf apply" # apply
alias tfac="tfa -input=false plan.cache" # apply from file

# bat aliases
alias byaml="bat -l yaml"
alias bjson="bat -l json"

function ip-local
  ifconfig | grep 'broadcast' | awk '{print $2}'
end

function ip-public
  curl -s ipinfo.io | jq '.ip' -r
end

function ip-public-detailed
  curl -s ipinfo.io | jq
end

# Clear docker container logs <container>
function docker-clear
  echo "" > $(docker inspect --format='{{.LogPath}}' $1)
end

# Remove all stopped containers
function docker-prune-stopped
  docker rm $(docker ps -a -q)
end

function dns:flush
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
end
