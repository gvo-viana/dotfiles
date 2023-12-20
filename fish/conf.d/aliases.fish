# Force the remove command to be always interactive.
alias rm="rm -i"
# Customize the Glances monitoring system.
alias glances="glances  --percpu \
                        --disable-plugin irq,diskio \
                        --enable-plugin sensors \
                        --strftime '[%d/%b/%Y - %H:%M]'"
# Customize the bat document viewer.
alias bat="bat --theme=base16"
# Customize the ipython3 invokation.
alias ipython="ipython3 --classic"
# Shortcut to quit the terminal.
alias x='exit'
# put the screen in standby mode.
alias pause_screen='xset -display $DISPLAY dpms force standby'
