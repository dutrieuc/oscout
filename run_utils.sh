#!/bin/sh
reload_command () {
    echo ${OSCOUT_HEADER};
    echo "${OSCOUT_RG_PREFIX} ${OSCOUT_RG_TYPE_FILTER} \"${OSCOUT_REGEX}${1}\" ${OSCOUT_PATHS} ${ARGS} || true";
    eval "${OSCOUT_RG_PREFIX} ${OSCOUT_RG_TYPE_FILTER} \"${OSCOUT_REGEX}${1}\" ${OSCOUT_PATHS} ${ARGS} || true";
};

toggle_type () {
    new_ls=()
    removed=0
    for st in $OSCOUT_SEARCH_TYPES
    do
        if [ "$st" = "$1" ]
        then
            removed=1
        else
            new_ls+=("$st")
        fi
    done
    if [[ $removed -eq 0 ]]
    then
        new_ls+=("$1")
    fi
    export OSCOUT_SEARCH_TYPES=("$new_ls[@]")
    export OSCOUT_RG_TYPE_FILTER=$(generate_type_filter)
};

generate_type_filter () {
    s=""
    for st in $OSCOUT_SEARCH_TYPES
    do
        s+="-t$st "
    done
    echo $s
};

if [[ -f ~/.config/oscout/run_utils.sh ]]
then
    source ~/.config/oscout/run_utils.sh
fi
