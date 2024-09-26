# Alpaca

Inicialize the docker service
```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Build the image
```bash
docker build -t bitcoin_engine .
```

Create network
```bash
docker network create alpaca_network
```

Run container
```bash
docker stop alpaca_engine
docker rm alpaca_engine 
docker run --name alpaca_engine -e POSTGRES_PASSWORD=admin -d -p 5432:5432 bitcoin_engine
```

Run de script
```bash
docker exec -it alpaca_engine /bin/bash -c "source /usr/src/app/venv/bin/activate && python3 /usr/src/app/scripts/extract_file.py"
```

Debug logs
```bash
docker logs alpaca_engine
```

Open postgres terminal in interactivate mode
```bash
docker exec -it alpaca_engine psql -U postgres -d bitcoin_engine
```

Activate venv
```bash
docker exec -it alpaca_engine bash
source /usr/src/app/venv/bin/activate
```

Insert bitcoin data
```bash
docker exec -it alpaca_engine psql -U postgres -d bitcoin_engine -f /usr/src/app/queries/load_bitcoin_data.sql
```