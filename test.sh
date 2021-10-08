#/bin/sh
input="./bindings"
bound_actions=""
sep=''
while read -r line
do
    if [[ "${line}" == \#* ]]
    then
        bound_actions+="${sep}${line}"
        sep=','
    fi
done < "$input"

echo $bound_actions
