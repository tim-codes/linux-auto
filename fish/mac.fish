source ~/.config/fish/common.fish

set -U fish_greeting ""

# # set shell title to pwd
function fish_title
    set -q argv[1]; or set argv fish
    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
end

# fish aliases to mimic bash `which`
alias which="type -p"
alias where="type -a"

source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

set -x PNPM_HOME "$HOME/Library/pnpm"
set -x GOROOT "$HOME/sdk/go1.20.5"
set -x GOPATH "$HOME/go"
set -x NVM_DIR "$HOME/.nvm"
set -x KUBE_CONFIG_PATH "$HOME/.kube/config"

set -x PATH $PATH $HOME/bin:/usr/local/bin
set -x PATH $PATH /opt/homebrew/bin
set -x PATH $PATH /Applications/Sublime Text.app/Contents/SharedSupport/bin
set -x PATH $PATH $PNPM_HOME:$PATH"PATH="$PNPM_HOME
set -x PATH $PATH $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
set -x PATH $PATH $HOME/sdk/go1.20.5/bin
set -x PATH $PATH $HOME/go/bin
set -x PATH $PATH $HOME/Library/Application Support/Jetbrains/Toolbox/scripts
set -x PATH $PATH $HOME/Library/pnpm
