if shell_is_elliot; then
    # For Rutorrent
    if [ "$HOST_NAME" == 'mainpc' ]; then
        alias rt='screen -rd rtorrent'
        alias startrt='screen -t rtorrent rtorrent'
    else 
        alias remotert='ssh -t eboney@mainpc screen -m -d -t rtorrent rtorrent'
    fi
fi