#!/bin/bash

# Función Ctrl+C

function ctrl_c(){

clear

        echo -e " \e[31m[!] Saliendo...\e[0m"

tput cnorm; exit 1
}

# Ctrl+C

trap ctrl_c INT


# Función de ayuda

function ayuda {
clear
    echo -e "\e[31mUso: ./Tbash.sh -t <token> -i <id> -m <mensaje> -n <numero>\n"
    echo -e "Opciones:\n"
    echo -e "  -t <token>    Indica el token del bot"
    echo -e "  -i <id>       Establece el ID del chat."
    echo -e "  -m <mensaje>  Establece el mensaje a enviar."
    echo -e "  -n <numero>   Establece el número de veces que se enviará el mensaje.\n"
    echo -e "Ejemplo:"
    echo -e '  ./Tbash.sh -t 1234567890:ABCDe1fGhI2JKlmno_abcdEFgHijKlMNO -i 1234567890 -m "Hola, mundo" -n 5\e[0m\n'
}

# Función para verificar el estado del mensaje

function verify (){
clear
tput civis
        if [ $? == 0 ]; then
        echo
  echo -e "\e[32m|-------------------------------------|"
        echo -e "| [!] Mensaje enviado correctamente   |"
        echo -e "|-------------------------------------|\e[0m"
        tput cnorm;exit
else
        echo
  echo -e "\e[31m|-----------------------------------|"
        echo -e "| [!] El Mensaje no fué enviado"
        echo -e "|-----------------------------------|\e[0m"
        tput cnorm;menu
fi
}

# Inicializa las variables
TOKEN=""
MENSAJE=""
NUMERO=1

# Procesa las opciones de línea de comandos
while getopts t:i:m:n: option
do
case "${option}"
in
t) BOT_TOKEN=${OPTARG};;
i) CHAT_ID=${OPTARG};;
m) MENSAJE=${OPTARG};;
n) NUMERO=${OPTARG};;
*) ayuda; exit 1;;
esac
done

# Si no se introdujeron parámetros, muestra la ayuda
if [ -z "$BOT_TOKEN" ] || [ -z "$CHAT_ID" ] || [ -z "$MENSAJE" ]; then
    ayuda
    exit 1
fi

# Envía el mensaje a través de la API de Telegram el número de veces especificado
for ((i=1;i<=NUMERO;i++)); do
    curl -s -X POST https://api.telegram.org/bot$BOT_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$MENSAJE" &>/dev/null
done

verify
