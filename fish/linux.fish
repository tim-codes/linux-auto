source ~/.config/fish/common.fish

set -x PNPM_HOME $HOME/.local/share/pnpm
set -x PATH $PATH $PNPM_HOME

alias bat="batcat"
alias python="python3"

# set OpenAI API Key to opencommit config
# NOTE: can't call this in common.fish because opencommit is not in scope until PNPM_HOME is set
opencommit config set OCO_OPENAI_API_KEY=$(cat ~/keys/openai.key) 1&> /dev/null
