#!/bin/bash



# Función Ctrl+C

function ctrl_c (){
tput civis
clear
echo -e "\e[31m\n\n|--------------------|"
          echo -e "| [!] Saliendo...    |"
          echo -e "|--------------------|\n\n\e[0m"

sleep 0.7
tput cnorm; exit 1
}

# Ctrl+C

trap ctrl_c INT



# Enviar mensaje al id previamente especificado

function msg_to (){

curl -s -X POST https://api.telegram.org/bot$BOT_TOKEN/sendMessage -d chat_id=$id_chat -d text="$msg" &>/dev/null  | verify

}




# Función para la info del target

function text_msg_to (){
tput civis
clear

echo -e "\e[31m\n|-------------------------------------------|"
        echo -e "| [!] Inserta el token del bot              |"
        echo -e "|-------------------------------------------|"
        read -p "|---> " BOT_TOKEN
        clear

echo -e "\e[31m\n|-------------------------------------------|"
        echo -e "| [!] Inserta el id del chat o grupo        |"
        echo -e "|-------------------------------------------|"
        read -p "|---> " id_chat
        clear

echo -e "\e[31m\n|---------------------------|"
        echo -e "| [!] Inserta el mensaje    |"
        echo -e "|---------------------------|"
        read -p "|---> " msg
        clear

echo -e "\e[31m\n|------------------------------|"
        echo -e "| [!] Inserta el nº de veces   |"
        echo -e "|------------------------------|"
        read -p "---> " num
        clear

        for ((i=1;i<=num;i++))
do
   msg_to

done
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



# Función Menú

function menu (){
tput civis
clear


  echo -e "\e[31m|-----------------------------------------|"
        echo -e "|---------- \e[36mTBash by S0ulx3\e[31m --------------|"
        echo -e "|-----------------------------------------|"
        echo -e "| [+] 1. Iniciar script                   |"
        echo -e "|-----------------------------------------|"
        read -p "|------> " option

                if [ $option == 1 ]; then

                text_msg_to

                else

                tput civis
                clear
        echo -e "\e[31m\n|-------------------------------------------|"
                echo -e "| [!] Opción inválida, intentalo de nuevo.  |"
                echo -e "|-------------------------------------------|\e[0m"
                sleep 1.5
                menu
                tput cnorm

                fi
}
  menu