
# TODO temporary, to be removed
echo ""
echo "SFF1-node flows"
sudo ovs-ofctl -O Openflow13 dump-flows sff1-node 

# TODO temporary, to be removed
echo ""
echo "SFF2-node flows"
sudo ovs-ofctl -O Openflow13 dump-flows sff2-node

# TODO temporary, to be removed
#echo ""
#echo "SFF3-node flows"
#sudo ovs-ofctl -O OpenFlow13 dump-flows sff3-node

echo ""
echo "SFF1 flows"
sudo ovs-ofctl -O OpenFlow13 dump-flows sff1 | awk '{print $3, $4,$6,$7,$8}'

echo ""
echo "SFF2 flows"
sudo ovs-ofctl -O OpenFlow13 dump-flows sff2  | awk '{print $3, $4,$6,$7,$8}'

#echo ""
#echo "SFF3 flows"
#sudo ovs-ofctl -O OpenFlow13 dump-flows sff3

echo ""
echo "GW1 flows"
sudo ovs-ofctl -O OpenFlow13 dump-flows gw1

echo ""
echo "GW2 flows"
sudo ovs-ofctl -O Openflow13 dump-flows gw2

echo ""
echo "Tor1 flows"
sudo ovs-ofctl -O OpenFlow13 dump-flows tor1

