FROM postgres:latest

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv

# Copiar tus archivos
COPY ./init.sql /docker-entrypoint-initdb.d/
COPY ./start.sh /usr/src/app/start.sh
COPY ./script.py /usr/src/app/script.py
COPY ./requirements.txt /usr/src/app/requirements.txt

RUN mkdir -p /root/.kaggle
COPY ./kaggle.json /root/.kaggle/kaggle.json
RUN chmod 600 /root/.kaggle/kaggle.json

# Crear un entorno virtual y activar
RUN python3 -m venv /usr/src/app/venv

# Instalar psycopg2 en el entorno virtual
RUN /usr/src/app/venv/bin/pip install -r /usr/src/app/requirements.txt

# Dar permisos de ejecución al script
RUN chmod +x /usr/src/app/start.sh

# Cambiar el punto de entrada
ENTRYPOINT ["/usr/src/app/start.sh"]

EXPOSE 5432
