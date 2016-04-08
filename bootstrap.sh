#!/usr/bin/env bash

#If proxy is needed, export the http_proxy env variable


#Installation of all the sw required
sudo apt-get update
sudo apt-get install -y libcap2 libcap2-dev g++ apache2 uml-utilities vlan xubuntu-desktop openjdk-7-jre autoconf automake
sudo apt-get -f install
sudo apt-get remove -y xscreensaver

OVS_DIR='/usr/share/openvswitch'
if [ ! -d "$OVS_DIR" ]; then
	sudo dpkg -i /vagrant/openvswitch/openvswitch-datapath-source_2.3.1-1_all.deb
	module-assistant auto-install openvswitch-datapath
	sudo dpkg -i /vagrant/openvswitch/openvswitch-common_2.3.1-1_amd64.deb
	sudo dpkg -i /vagrant/openvswitch/openvswitch-switch_2.3.1-1_amd64.deb
	sudo modprobe 8021q
	sudo cp /vagrant/ovs-controller /usr/bin
	sudo chmod 755 /usr/bin/ovs-controller
fi
sudo apt-get -y -f install
sudo apt-get install -y mininet
#Squid compilation and installation
sudo modprobe ip_tables
sudo modprobe nf_conntrack_ipv4
sudo modprobe xt_tcpudp
#sudo modprobe nf_tproxy_core
#sudo modprobe xt_MARK
sudo modprobe xt_TPROXY
sudo modprobe xt_socket 

cp /vagrant/Xfce\ Terminal.desktop /home/vagrant/Desktop/
sudo chown vagrant:vagrant /home/vagrant/Desktop/Xfce\ Terminal.desktop
sudo chmod 755 /home/vagrant/Desktop/Xfce\ Terminal.desktop

#cd /vagrant/squid-3.5.3
SQUID_DIR='/usr/local/squid'
if [ ! -d "$SQUID_DIR" ]; then
	cp -R /vagrant/squid /usr/local
	sudo chown -R vagrant:vagrant /usr/local/squid
	sudo chmod -R 755 /usr/local/squid

fi

#Apache conf and webpages
sudo /etc/init.d/apache2 stop
sudo a2enmod rewrite

WEBDIR='/var/www/html/assets'
if [ ! -d "$WEBDIR" ]; then
	cp /vagrant/apache2.conf /etc/apache2/
	cp /vagrant/chain* /var/www/html/
	cp -R /vagrant/assets /var/www/html/
	sudo chmod -R 755 /var/www/html/
fi

#OpenDaylight SFC

ODL_DIR='/home/vagrant/sfc-karaf-0.1.0-Lithium'
if [ ! -d "$ODL_DIR" ]; then
	export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
	cp -R /vagrant/sfc-karaf-0.1.0-Lithium /home/vagrant
	cd /home/vagrant
	sudo chmod -R 755 sfc-karaf-0.1.0-Lithium/
	sudo chown -R vagrant:vagrant sfc-karaf-0.1.0-Lithium/
fi
export DISPLAY=:0.0
screen -dmS karaf '/home/vagrant/sfc-karaf-0.1.0-Lithium/bin/karaf'
sleep 400

#Start mininet environment
SFC_DIR='/home/vagrant/sfcofl2'
if [ ! -d "$SFC_DIR" ]; then
	cp -R /vagrant/sfcofl2 /home/vagrant/
	sudo chmod -R 755 /home/vagrant/sfcofl2
	sudo chown -R vagrant:vagrant /home/vagrant/sfcofl2
fi

cd /home/vagrant/sfcofl2
export DISPLAY=:0.0
screen -dmS mininet ./launch_mininet.sh

# Avoid X server permission problems when root opens terimanals/browsers
xhost_present=`grep xhost /home/vagrant/.bashrc`
if [ -z "$xhost_present" ] ; then
	echo "xhost +" >> /home/vagrant/.bashrc
fi
