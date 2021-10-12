export OSCOUT_RG_PREFIX='rg --color=always --column --with-filename'
export OSCOUT_PATH=''
export OSCOUT_TMP=$(mktemp -d)
export ARGS=$@

export OSCOUT_EDITCMD='bat {1}  --pager="less +{2}"'
#export OSCOUT_EDITCMD='subl {1}:{2}:{3} '
