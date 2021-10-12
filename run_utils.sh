#!/bin/sh
reload_command () {
    echo "$(get_header)";
    echo "${OSCOUT_RG_PREFIX} $(get_type_filter) \"$(get_prefix_regex)${1}\" ${OSCOUT_PATHS} ${ARGS} || true";
    eval "${OSCOUT_RG_PREFIX} $(get_type_filter) \"$(get_prefix_regex)${1}\" ${OSCOUT_PATHS} ${ARGS} || true";
};

store () {
    echo ${1} > "$OSCOUT_TMP/$2"
};

retrieve () {
    path="${OSCOUT_TMP}/${1}"
    if [[ -f $path ]]
    then
        echo $(<$path)
    fi
};

toggle () {
    new_ls=()
    removed=0
    OSCOUT_SEARCH_TYPES=($(retrieve "$2"))
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
    store "$new_ls" "$2"
};

get_type_filter () {
    OSCOUT_SEARCH_TYPES=($(retrieve "type"))
    s=""
    for st in $OSCOUT_SEARCH_TYPES
    do
        s+="-t$st "
    done
    echo $s
};

get_prefix_regex () {
    SEARCH_PREFIX=($(retrieve "prefix"))
    if [[ ${#SEARCH_PREFIX[@]} -eq 0 ]]
    then
        exit
    fi
    s="($(prefix_list))\s*=?\s*('|\\\")?"
    echo $s
};

prefix_list () {
    s=""
    sep=""
    for st in $SEARCH_PREFIX
    do
        s+="$sep$st"
        sep="|"
    done
    echo $s
};

get_header () {
    OSCOUT_SEARCH_TYPES=($(retrieve "type"))
    SEARCH_PREFIX=($(retrieve "prefix"))
    echo "Matching : $(prefix_list)"
    echo "Looking for files : $OSCOUT_SEARCH_TYPES"
};

if [[ -f ~/.config/oscout/run_utils.sh ]]
then
    source ~/.config/oscout/run_utils.sh
fi
