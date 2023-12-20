# Loading the settings of the TokyoNight theme:
source ~/.config/fish/aux_files/tokyonight.fish
# Loading the settings of the BobTheFish theme:
source ~/.config/fish/aux_files/bobthefish.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/gviana/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
# starship init fish | source
