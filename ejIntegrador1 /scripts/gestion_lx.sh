#!/bin/bash

#variables que me van a servir mas adelante: 

base="/academia"
logs="$base/reportes/log_linux.txt"


#parte a 
# para que todas las partes debe ejecutarse como root 


echo "Creando grupos..."

# prog
if getent group programacion > /dev/null 2>&1; then 
    echo "el grupo programacion ya existe."
else
    groupadd programacion 
    echo "Grupo programacion creado!"
fi 

# redes
if getent group redes > /dev/null 2>&1; then 
    echo "el grupo redes ya existe."
else
    groupadd redes 
    echo "Grupo redes creado!"
fi

# bases de datos 
if getent group  bd > /dev/null 2>&1; then 
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
    useradd -g redes estudiante2
    mkdir /home/estudiante2 
    chown estudiante2 /home/estudiante2 
    echo "Estudiante2 creado"
fi 


if id "Estudiante3" > /dev/null 2>&1; then 
    echo "Estudiante3 ya existe "
else
    useradd -g bd estudiante3
    mkdir /home/estudiante3 
    chown estudiante3 /home/estudiante3 
    echo "Estudiante3 creado"

fi


#parte c

echo "creando dirs" 
mkdir -p $base/programacion
mkdir -p $base/redes  
mkdir -p $base/bd  
mkdir -p $base/reportes
echo "dirs creados!"

#parte d 
echo "archivos con info"
#estudiante 1 
echo "Nombre de usuario: estudiante1 "> $base/programacion/info_estudiante1.txt 
echo "Grupo: programación " >> $base/programacion/info_estudiante1.txt 
echo "Fecha de creación $(date '+%Y-%m-%d') ">> $base/programacion/info_estudiante1.txt 

#estudiante 2
echo "Nombre de usuario: estudiante2 "> $base/redes/info_estudiante2.txt 
echo "Grupo: redes" >> $base/redes/info_estudiante2.txt 
echo "Fecha de creación $(date '+%Y-%m-%d') ">> $base/redes/info_estudiante2.txt 
#estudiante 3
echo "Nombre de usuario: estudiante3 "> $base/bd/info_estudiante3.txt 
echo "Grupo: bd">> $base/bd/info_estudiante3.txt 
echo "Fecha de creación $(date '+%Y-%m-%d') ">> $base/bd/info_estudiante3.txt 

#parte e 

echo "asignando permisos"

chmod 770 $base/programacion 
chmod 770 $base/redes
chmod 770 $base/bd 
chmod 770 $base/reportes

echo "permisos aplicados!"

#parte f 

echo "hola" > $base/reportes/log_logins.txt
#Se adjunta la captura en el .md de lso usuarios generados!







