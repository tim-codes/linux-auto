source ~/.config/fish/common.fish
source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

set GO_VERSION "1.22.10"
set -x GOPRIVATE "github.com/coreeng/*"

set -x PNPM_HOME "$HOME/Library/pnpm"
set -x GOROOT "$HOME/sdk/go/go$GO_VERSION"
set -x GOPATH "$HOME/go/go$GO_VERSION"
set -x NVM_DIR "$HOME/.nvm"
set -x KUBE_CONFIG_PATH "$HOME/.kube/config"
set -x GOOGLE_APPLICATION_CREDENTIALS "$HOME/.config/gcloud/application_default_credentials.json"
# enable IAP ssh tunnel to use numpy on system to increase performance
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1

set -x PATH /opt/homebrew/bin:/opt/homebrew/sbin $PATH
set -x PATH $HOME/bin:/usr/local/bin $PATH
set -x PATH /Applications/Sublime Text.app/Contents/SharedSupport/bin $PATH
set -x PATH $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin $PATH
set -x PATH $GOROOT/bin $PATH
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/Library/Application Support/Jetbrains/Toolbox/scripts $PATH
set -x PATH $HOME/Library/pnpm $PATH

set -x GPG_TTY $(tty)

# function dns:flush
#   sudo dscacheutil -flushcache
#   sudo killall -HUP mDNSResponder
# end

# fish aliases to mimic bash `which`
alias which="type -p"
alias where="type -a"

# set OpenAI API Key to opencommit config
# NOTE: can't call this in common.fish because opencommit is not in scope until PNPM_HOME is set
if type -q opencommit
  opencommit config set OCO_OPENAI_API_KEY=$(cat ~/keys/openai.key) 1&> /dev/null
end

