default_folder="$HOME/.memory-enhancer"

setup_repo(){
    if [ ! -d ${default_folder} ]
    then
        repo="https://github.com/omiguelpinheiro/memory-enhancer.git"
        git clone $repo $default_folder
    else
        echo "Script folder exists, doing nothing"
    fi
}

setup_script_folder(){
    if [ ! -f "${default_folder}/history" ]
    then
        touch "${default_folder}/history"
    else
        echo "History file exists, doing nothing"
    fi
}

install_memory_enhancer(){
    setup_repo
    setup_script_folder
}

install_memory_enhancer