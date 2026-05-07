#!/bin/bash

# Parte 1
#
mkdir -p ~/laboratorio_linux/{documentos,respaldos,logs,sistema}
echo "Inicio de ejecucion: $(date '+%Y-%m-%d %H:%M:%S')" > ~/laboratorio_linux/logs/ejecucion.log

echo "PARTE 1. Estructura de directorios creada."


# ── Parte 2: Archivos y navegación ──────────────────────────
cd ~/laboratorio_linux/documentos

echo "Este es el informe del laboratorio 08." > informe.txt
echo "Notas del laboratorio: comandos de Linux basicos." > notas.txt
echo "Comandos usados: mkdir, cd, echo, ls, chmod, chown, cp." > comandos.txt

echo "PARTE 2. Archivos creados."
echo "Ruta actual: $(pwd)"
ls -l

