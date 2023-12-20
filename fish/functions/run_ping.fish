function run_ping
    cl

    echo -e "Ping at Google:\n----------------------------------------"
    ping -vc $argv www.google.com

    echo -e "\nPing at Unicamp:\n----------------------------------------"
    ping -vc $argv www.unicamp.br

    echo -e "\nPing at Uol:\n----------------------------------------"
    ping -vc $argv www.uol.com.br

    echo -en "\nCurrent Network: "
    iwgetid -r
    echo -e "----------------------------------------\n"

end
