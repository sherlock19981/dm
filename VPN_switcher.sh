#!/bin/bash

test=$(nmcli con show --active | grep -c vpn)

# 0 - No VPN connected. Start one
# 1 - VPN connected.

case $test in

   "0")

      nmcli con up `nmcli --mode tabular --fields name,type,timestamp con | grep -E "\s+vpn\s+" | sort -k3 | head -n1 | awk '{ print $1}'`      

      notify-send "Ебашим ВПН" "Соединяемся с `nmcli con show --active | grep vpn | awk '{print $1}'`" --icon=network-vpn-symbolic

   ;;

   "1")

      nmcli con down id `nmcli con show --active | grep vpn | awk '{print $1}'`

#      nmcli con up `nmcli --mode tabular --fields name,type,timestamp con | grep -E "\s+vpn\s+" | sort -k3 | head -n1 | awk '{ print $1}'`

      notify-send "Привильно - харе" "А то посадить могут. Вырубаю `nmcli con show --active | grep vpn | awk '{print $1}'`" --icon=network-vpn-symbolic

   ;;

esac

exit

done
