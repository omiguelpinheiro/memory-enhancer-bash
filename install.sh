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

setup_zshrc(){
    echo "# memory-enhancer configuration, delete this if uninstalling" >> "$HOME/.zshrc"
    echo "bash $HOME/.memory-enhancer/run.sh -t 6 -l 4 -e" >> "$HOME/.zshrc"
}

install_memory_enhancer(){
    setup_repo
    setup_script_folder
    echo "Installed memory enhancer"
}

install_memory_enhancer