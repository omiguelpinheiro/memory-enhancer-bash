default_folder="$HOME/.memory-enhancer"

setup_repo(){
    if [ ! -d ${default_folder} ]
    then
        repo="https://github.com/omiguelpinheiro/memory-enhancer.git"
        git clone $repo $default_folder
        echo "Script folder don't exist, cloning repository"
    else
        echo "Script folder exists, doing nothing"
    fi
}

setup_script_folder(){
    if [ ! -f "${default_folder}/history" ]
    then
        echo "History file don't exist, creating it"
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