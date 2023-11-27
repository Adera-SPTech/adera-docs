#!/bin/bash

sudo apt update
if command docker  &> /dev/null
then
    echo "Docker já está instalado."
else
    read -p "Ambiente não está instalado, deseja instalar o ambiente? (s/n): " res
    if [ "$res" == "s" ]||[ "$res" == "S" ]||[ "$res" == "SIM" ]||[ "$res" == "sim" ]||[ "$res" == "Sim" ]; then
        sudo apt install docker.io -y
        echo "Ambiente instalado com sucesso."
    else
        echo "Ambiente não instalado. Saindo..."
        exit 1
    fi
fi
sudo docker run  -d --name db -p 3306:3306 aderatech/db:latest
sleep 5
clear
sudo docker run -it --privileged --name jar --cap-add=ALL -v /bin/systemctl:/bin/systemctl -v /run/systemd/system:/run/systemd/system -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket -v /sys/fs/cgroup:/sys/fs/cgroup aderatech/jar:latest;

