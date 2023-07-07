source ~/.config/fish/common.fish

set -x PNPM_HOME $HOME/.local/share/pnpm
set -x PATH $PATH $PNPM_HOME

# set OpenAI API Key to opencommit config
opencommit config set OCO_OPENAI_API_KEY=$(cat ~/keys/openai.key)
