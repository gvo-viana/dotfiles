function copy_dirpath
    pwd | tr -d '\n' | xclip -selection clipboard
    echo 'directory path copied to the clipboard!'
end
