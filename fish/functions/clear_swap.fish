function clear_swap
    echo ""
    echo "Current Memory State:"
    echo "---------------------"
    free -h
    echo ""

    sudo swapoff -a
    echo ""
    echo "Cleaning the Swap..."
    sleep 30

    echo ""
    echo "Memory State After the Cleaning:"
    echo "--------------------------------"
    free -h
    echo ""

    sudo swapon -a
    echo "Done!"
end
