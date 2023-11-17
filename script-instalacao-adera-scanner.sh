#!/bin/bash

sudo apt update

if command docker  &> /dev/null
then
    echo "Docker já está instalado."
else
    # Ask the user if they want to install java
    read -p "Ambiente não está instalado, deseja instalar o ambiente? (s/n): " res
    if [ "$res" == "s" ]||[ "$res" == "S" ]||[ "$res" == "SIM" ]||[ "$res" == "sim" ]||[ "$res" == "Sim" ]; then
        # Install Java
        sudo apt install docker.io -y
        echo "Ambiente instalado com sucesso."
    else
        echo "Ambiente não instalado. Saindo..."
        exit 1
    fi
fi

sudo docker run -d -p 3306:3306 aderatech/db:latest

sleep 5
clear
sudo docker run -it aderatech/jar:latest
