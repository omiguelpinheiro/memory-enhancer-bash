# THIS PROJECT HAS BEEN DISCONTINUED
[I moved to go](https://github.com/omiguelpinheiro/memory-enhancer-go).
# memory-enhancer
Helps exercise your memory by giving you random passwords and poems to memorize.

## Using
Every day you, when you first open your terminal, you will receive a password and a part of a poem. You need to remember them till the end of the day. You can play with this and use the history located at `$HOME/.memory-enhancer/history` to try to remember passwords and poems from past days and see if you're getting it right.

## Install
To install use the following command which will use the repository `install.sh` script
```bash
curl https://raw.githubusercontent.com/omiguelpinheiro/memory-enhancer/main/install.sh | bash
```
Then configure the zshrc using
```bash
echo "bash $HOME/.memory-enhancer/run.sh -t 4 -l 2 -e" >> "$HOME/.zshrc"
```
And enjoy exercising your memory.
## Uninstall
To uninstall just delete the .memory-enhancer folder from your home and remember to remove our entries from your zshrc. There should be a comment above the lines you need to delete.

## Options
The script also comes with 3 parameters that you can play with and can be changed in the script call in your `zshrc` file. Change the following options to modify:
```
-t -> size of the password (default -6)
-l -> lines in cutted poem (default -4)
-e -> if poems in english can be used (default setted)
```
