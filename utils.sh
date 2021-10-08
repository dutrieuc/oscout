#!/bin/sh
get_bindings () {
    input=$1;
    bound_actions=""
    sep=''
    while read -r line
    do
        if [[ "${line}" != \#* ]]
        then
            bound_actions+="$sep$line"
            sep=','
        fi
    done < "$input"
    echo "${bound_actions}"
};

get_first_file () {
    for arg
    do
        if [[ -f "$arg" ]]; then
           echo "$arg"
           return
        fi
    done
};

