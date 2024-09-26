#!/bin/bash

# Iniciar PostgreSQL en segundo plano
docker-entrypoint.sh postgres &

# Esperar un momento para asegurarnos de que PostgreSQL esté listo para aceptar conexiones
sleep 10

# Ejecutar el script de Python y redirigir los logs a stdout y stderr
/usr/src/app/venv/bin/python /usr/src/app/script.py > /proc/1/fd/1 2>/proc/1/fd/2

# Esperar a que el proceso de PostgreSQL termine
wait
