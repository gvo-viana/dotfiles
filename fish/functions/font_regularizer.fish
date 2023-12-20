function font_regularizer
    sudo chown root:root $argv
    sudo chmod 644 $argv/* -R
    sudo chmod 755 $argv
    sudo fc-cache -fv
end
