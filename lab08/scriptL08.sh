#!/bin/bash

# Parte 1
#
mkdir -p ~/laboratorio_linux/{documentos,respaldos,logs,sistema}
echo "Inicio de ejecucion: $(date '+%Y-%m-%d %H:%M:%S')" > ~/laboratorio_linux/logs/ejecucion.log

echo "PARTE 1. Estructura de directorios creada."


#Parte 2: Archivos y navegación 
cd ~/laboratorio_linux/documentos

echo "Este es el informe del laboratorio 08." > informe.txt
echo "Notas del laboratorio: comandos de Linux basicos." > notas.txt
echo "Comandos usados: mkdir, cd, echo, ls, chmod, chown, cp." > comandos.txt

echo "PARTE 2. Archivos creados."
echo "Ruta actual: $(pwd)"
ls -l


# Parte 3: Usuarios, grupos y permisos 
if getent group estudiantes_linux > /dev/null 2>&1; then
    echo "PARTE 3. Grupo 'estudiantes_linux' ya existe."
else
    sudo groupadd estudiantes_linux
    echo "PARTE 3. Grupo 'estudiantes_linux' creado."
fi

sudo chgrp estudiantes_linux ~/laboratorio_linux/documentos/informe.txt
chmod 640 ~/laboratorio_linux/documentos/informe.txt
echo "PARTE 3. Grupo y permisos 640 asignados a informe.txt."


#Parte 4: Manipulación de consultas 
cp /proc/cpuinfo ~/laboratorio_linux/sistema/cpuinfo.txt
cp /proc/meminfo ~/laboratorio_linux/sistema/meminfo.txt

echo "Mensaje de prueba enviado a /dev/null" > /dev/null

echo "PARTE 4. /proc/cpuinfo copiado a sistema/cpuinfo.txt." >> ~/laboratorio_linux/logs/ejecucion.log
echo "PARTE 4. /proc/meminfo copiado a sistema/meminfo.txt." >> ~/laboratorio_linux/logs/ejecucion.log
echo "PARTE 4. Mensaje enviado a /dev/null." >> ~/laboratorio_linux/logs/ejecucion.log
echo "PARTE 4. Consultas completadas."


#arte 5: Respaldo y reporte final
cp ~/laboratorio_linux/documentos/*.txt ~/laboratorio_linux/respaldos/

REPORTE=~/laboratorio_linux/reporte_final.txt

{
    echo "      REPORTE FINAL"
    echo "Usuario        : $(whoami)"
    echo "Ruta           : $(pwd)"
    echo "Fecha          : $(date '+%Y-%m-%d %H:%M:%S')"
    echo ""
    echo "    Archivos creados"
    ls -l ~/laboratorio_linux/documentos/
    echo ""
    echo "    Permisos de informe.txt "
    ls -l ~/laboratorio_linux/documentos/informe.txt
    echo ""
    echo "     Acceso a /proc "
    if [ -r /proc/cpuinfo ] && [ -r /proc/meminfo ]; then
        echo "OK: /proc/cpuinfo y /proc/meminfo accesibles."
    else
        echo "ERROR: no se pudo acceder a /proc."
    fi
    echo ""
    echo "   Acceso a /dev/null"
    if [ -w /dev/null ]; then
        echo "OK: /dev/null accesible para escritura."
    else
        echo "ERROR: no se pudo acceder a /dev/null."
    fi
    echo " "
} > "$REPORTE"

echo "PARTE 5. Respaldo y reporte final completados."
echo "Fin de ejecucion: $(date '+%Y-%m-%d %H:%M:%S')" >> ~/laboratorio_linux/logs/ejecucion.log

