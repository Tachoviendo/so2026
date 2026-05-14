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




