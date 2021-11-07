usage() { echo "Usage: $0 [-t <TOKEN_SIZE>] [-l <LINE_AMOUNT>]" 1>&2; exit 1; }

while getopts t:l:e flag; do
    case "${flag}" in
        t) token_size=${OPTARG};;
        l) line_amount=${OPTARG};;
        e) english_poems="TRUE";;
        *) usage;;
    esac
done

shift $((OPTIND-1))

if [ -z "${token_size}" ] || [ -z "${line_amount}" ]; then
    usage
fi

today_poem=""
generate_poem(){
    if [ ! -z $english_poems ]
    then
        folder_index=$(($RANDOM % 2))
    else
        folder_index=0
    fi
    if [[ -d "${memory_enhancer_default_folder}/poemas" && -d "${memory_enhancer_default_folder}/poems" ]]
    then
        poems_folders=("poemas" "poems")
        selected_folder=${poems_folders[$(($folder_index))]}
        
        poems=("$memory_enhancer_default_folder/$selected_folder"/*)
        poem_index=$(($RANDOM % ${#poems[@]}))
        poem_file="${poems[$poem_index]}"
        get_random_poem "$poem_file"
    else
        echo "A poems folder doesn't seems to exists"
    fi
}

get_random_poem(){
    poem_path=$1
    readarray -t all_lines < "${poem_path}"
    line_index=$(($RANDOM % (${#all_lines[@]} - $line_amount)))
    get_poem_name "$poem_path"
    for counter in $( eval echo {0..$(($line_amount-1))} )
    do
        random_line_index=$(($line_index+$counter))
        today_poem="$today_poem${all_lines[$random_line_index]}"$'\n'
    done
    today_poem=${today_poem::-1}
    get_poem_author "$poem_path"
}

today_poem_author=""
get_poem_author(){
    poem_path=$1
    poem_file_name=$(echo $poem_path | rev | cut -d"/" -f 1 | rev)
    poem_author=$(echo $poem_file_name | cut -d"-" -f 2)
    poem_author=${poem_author:1}
    today_poem_author="$poem_author"
}

today_poem_title=""
get_poem_name(){
    poem_path=$1
    poem_file_name=$(echo $poem_path | rev | cut -d"/" -f 1 | rev)
    poem_name=$(echo $poem_file_name | cut -d"-" -f 1)
    today_poem_title="$poem_name"
}

today_token=""
generate_token(){
    full_token=$(apg -a 1 -n 1 -m 128 -M SNCL)
    today_token=$(echo "$full_token" | cut -c 1-$token_size)
}

run_memory_enhancer(){
    memory_enhancer_default_folder="$HOME/.memory-enhancer"
    history_path="$memory_enhancer_default_folder/history"
    current_date=$(date '+%Y-%m-%d')
    if [[ -z "$history_path" || -s "$history_path" ]]
    then
        readarray -t history_lines < "${history_path}"
        for i in $(seq $((${#history_lines[@]})) -1 0)
        do
            if [[ "${history_lines[$i]}" == *"Date"* ]]
            then
                line_date=$(echo "${history_lines[$i]}" | cut -d":" -f 2)
                if [[ "$line_date" < "$current_date" ]]
                then
                    init_token_poem
                    show_today_token_poem "$today_token" "$today_poem" "$today_poem_title" "$today_poem_author"
                    break
                fi
                if [[ "$line_date" == "$current_date" ]]
                then
                    break
                fi
            fi
        done
    else
        init_token_poem
        show_today_token_poem "$today_token" "$today_poem" "$today_poem_title" "$today_poem_author"
    fi
}

init_token_poem(){
    generate_token
    generate_poem
}

show_today_token_poem(){
    token="$1"
    poem="$2"
    title="$3"
    author="$4"
    
    echo "Hi, todays token is:$token"
    echo "Have fun memorizing this part of the poem!"
    echo "$title"
    echo "$poem"
    echo "$author"
    
    save_poem "$token" "$poem" "$title" "$author"
}

save_poem(){
    token="$1"
    poem="$2"
    title="$3"
    author="$4"
    
    echo "Date:$current_date" >> $history_path
    echo "Token:$token" >> $history_path
    echo "Poem:" >> $history_path
    echo "$title" >> $history_path
    echo "$poem" >> $history_path
    echo "$author" >> $history_path
    echo "" >> $history_path
}

run_memory_enhancer