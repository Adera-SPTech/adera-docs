#!/bin/bash

# Atualiza a lista de pacotes e atualiza o sistema
sudo apt update && sudo apt upgrade -y

# Check if java is installed
if command -v java &> /dev/null
then
    echo "Java já está instalado."
else
    # Ask the user if they want to install java
    read -p "Java não está instalado, desejá instalar o java? (s/n): " install_java
    if [ "$install_java" == "s" ]; then
        # Install Java
        sudo apt install openjdk-17-jre
        echo "Java instalado com sucesso."
    else
        echo "Java não está instalado. Saindo..."
        exit 1
    fi
fi

# Baixa o arquivo .jar do meu grupo de PI
curl -O -L "https://github.com/Adera-SPTech/adera-scanner/raw/dev/out/artifacts/adera_scanner_jar/adera-scanner.jar"

chmod +x script-instalacao-adera-scanner.sh