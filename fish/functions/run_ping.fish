function run_ping
    cl

    echo -e "Ping at GOOGLE:\n----------------------------------------"
    ping -vc $argv www.google.com

    # echo -e "\nPing at UNICAMP:\n----------------------------------------"
    # ping -vc $argv www.unicamp.br

    # echo -e "\nPing at USP:\n----------------------------------------"
    # ping -vc $argv www.usp.br

    echo -e "\nPing at UOL:\n----------------------------------------"
    ping -vc $argv www.uol.com.br

    echo -en "\nCurrent Network: "
    iwgetid -r
    echo -e "----------------------------------------\n"

end
