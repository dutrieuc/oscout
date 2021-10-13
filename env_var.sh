export OSCOUT_RG_OPTS='--color=always --smart-case'
export OSCOUT_TMP=$(mktemp -d)
export ARGS=$@


if [[ -f $HOME/.config/oscout/env_var.sh ]]
then
    source $HOME/.config/oscout/env_var.sh
fi
