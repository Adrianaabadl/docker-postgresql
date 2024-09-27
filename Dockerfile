# Usa la imagen base de PostgreSQL
FROM postgres:latest

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv file unzip git

# Crear el directorio para los scripts
RUN mkdir -p /usr/src/app/scripts

# Copiar archivos de tu proyecto
COPY ./profile/profiles.yml /profiles.yml
COPY ./sql/init.sql /docker-entrypoint-initdb.d/
COPY ./sql/load_bitcoin_data.sql /usr/src/app/queries/
COPY ./dbt/biggest_return.sql /usr/src/app/queries/biggest_return.sql
COPY ./dbt/maximun_losses.sql /usr/src/app/queries/maximun_losses.sql
COPY ./src/ /usr/src/app/scripts/
COPY ./kaggle.json /root/.kaggle/kaggle.json
COPY ./requirements.txt /usr/src/app/requirements.txt
COPY ./start.sh /usr/src/app/start.sh

# Cambiar permisos para el archivo kaggle.json
RUN chmod 600 /root/.kaggle/kaggle.json

# Crear un entorno virtual y activar
RUN python3 -m venv /usr/src/app/venv

# Instalar dependencias en el entorno virtual
RUN /usr/src/app/venv/bin/pip install --no-cache-dir -r /usr/src/app/requirements.txt

# Dar permisos de ejecución al script de inicio
RUN chmod +x /usr/src/app/start.sh

# Cambiar el punto de entrada
ENTRYPOINT ["/usr/src/app/start.sh"]

# Exponer el puerto de PostgreSQL
EXPOSE 5432