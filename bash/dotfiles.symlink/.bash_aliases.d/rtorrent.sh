
# For Rutorrent
if [ "$HOST_NAME" = 'mainpc' ]; then
    alias rt='screen -rd rtorrent'
    alias startrt='screen -t rtorrent rtorrent'
fi

if [ "$HOST_NAME" = 'iScrit' ]; then
    alias remotert='ssh -t eboney@mainpc screen -m -d -t rtorrent rtorrent'
fi