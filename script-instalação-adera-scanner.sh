#!/bin/bash

# Atualiza a lista de pacotes e atualiza o sistema
sudo apt update && sudo apt upgrade

# Verifica a versão do Java
java -version

# Verifica se o Java não está instalado e, se não estiver, solicita a instalação
if [$? -eq 0]
    then
        echo "Java instalado"
    else
        echo "Java não está instalado. Deseja instalar? (Y/n)"
        read resposta
        if [ "$resposta" = "Y" ] 
        then
          sudo apt install openjdk-17-jre -y
        fi
fi

# Baixa o arquivo .jar do meu grupo de PI
curl -O -L "https://github.com/Adera-SPTech/adera-scanner/raw/dev/out/artifacts/adera_scanner_jar/adera-scanner.jar"

# Executa o arquivo .jar do meu grupo de PI
java -jar adera-scanner.jar


chmod +x scriptProjeto.sh