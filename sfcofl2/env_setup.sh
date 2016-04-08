server1 service apache2 start
sf1 ./iptables_tproxy.sh &
sf2 ./iptables_tproxy_sf2.sh &
client1 firefox &
