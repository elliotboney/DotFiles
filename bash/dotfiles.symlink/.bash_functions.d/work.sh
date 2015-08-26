function hubot() {
    case "$1" in
      start)
        ssh -t elliotboney.com 'screen -S hubot -rd "/home/eboney/hubot/bin/hubot" || screen -S hubot "/home/eboney/hubot/bin/hubot"'
      ;;

      stop)
        ssh -t elliotboney.com 'kill $(cat /home/eboney/hubot/hubot.pid) && rm /home/eboney/hubot/hubot.pid'
      ;;

      restart)
        ssh -t elliotboney.com 'kill $(cat /home/eboney/hubot/hubot.pid) && rm /home/eboney/hubot/hubot.pid'
        ssh -t elliotboney.com 'screen -S hubot -rd "/home/eboney/hubot/bin/hubot" || screen -S hubot "/home/eboney/hubot/bin/hubot"'
      ;;

      *)
        ssh -t elliotboney.com 'screen -S hubot -rd'
      ;;

    esac
}