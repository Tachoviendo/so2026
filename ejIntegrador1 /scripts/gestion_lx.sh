#!/bin/bash

#parte a 
# para que todas las partes debe ejecutarse como root 

base="/academia"
logs="$base/reportes/log_linux.txt"

echo "Creando grupos..."

# prog
if getnet gruop programacion > /dev/null 2>&1; then 
    echo "el grupo programacion ya existe."
else
    groupadd programacion 
    echo "Grupo programacion creado!"
fi 

# redes
if getnet gruop redes > /dev/null 2>&1; then 
    echo "el grupo redes ya existe."
else
    groupadd redes 
    echo "Grupo redes creado!"
fi

# bases de datos 
if getnet gruop  bd > /dev/null 2>&1; then 
    echo "el grupo bd ya existe."
else
    groupadd bd 
    echo "Grupo bd creado!"
fi

# parte b
 
echo "Creando usuarios!"

if id "Estudiante1" > /dev/null 2>&1; then 
    echo "Estudiante1 ya existe "
else
    useradd -g programacion estudiante1
    mkdir /home/estudiante1 
    chown estudiante1 /home/estudiante1 
    echo "Estudiante1 creado"
fi 


if id "Estudiante2" > /dev/null 2>&1; then 
    echo "Estudiante2 ya existe "
else
    useradd -g programacion estudiante2
    mkdir /home/estudiante2 
    chown estudiante2 /home/estudiante2 
    echo "Estudiante2 creado"
fi 


if id "Estudiante3" > /dev/null 2>&1; then 
    echo "Estudiante3 ya existe "
else
    useradd -g programacion estudiante3
    mkdir /home/estudiante2 
    chown estudiante3 /home/estudiante3 
    echo "Estudiante3 creado"

fi




