#!/bin/bash

# Start the PostgreSQL service
/usr/local/bin/docker-entrypoint.sh postgres &

sleep 5

# Activate the virtual environment
source /usr/src/app/venv/bin/activate

# Initialize the DBT project
dbt init alpaca_bi

# Create the models directory if it doesn't exist
mkdir -p /alpaca_bi/models/trading

# Copy the query files to the models directory
cp /usr/src/app/queries/biggest_return.sql /alpaca_bi/models/trading/biggest_return.sql
cp /usr/src/app/queries/maximun_losses.sql /alpaca_bi/models/trading/maximun_losses.sql

# Run the download script
python3 /usr/src/app/scripts/download_script.py
if [ $? -ne 0 ]; then
    echo "Error in download_script.py"
    exit 1
fi

# Run the extraction script
python3 /usr/src/app/scripts/extract_file.py
if [ $? -ne 0 ]; then
    echo "Error in extract_file.py"
    exit 1
fi

# Keep the container running
tail -f /dev/null
