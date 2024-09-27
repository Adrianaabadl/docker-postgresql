#!/bin/bash

# Iniciar el servicio de PostgreSQL
/usr/local/bin/docker-entrypoint.sh postgres &

sleep 5

# Activar el entorno virtual
source /usr/src/app/venv/bin/activate

dbt init alpaca_bi

# Ejecutar el script de descarga
python3 /usr/src/app/scripts/download_script.py
if [ $? -ne 0 ]; then
    echo "Error en download_script.py"
    exit 1
fi

# Ejecutar el script de extracción
python3 /usr/src/app/scripts/extract_file.py
if [ $? -ne 0 ]; then
    echo "Error en extract_file.py"
    exit 1
fi

# Mantener el contenedor en ejecución
tail -f /dev/null
