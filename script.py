import os
import subprocess
import zipfile
import pandas as pd
import psycopg2

os.environ['KAGGLE_CONFIG_DIR'] = os.path.expanduser("/root/.kaggle")
kaggle_json_path = os.path.expanduser("/root/.kaggle/kaggle.json")
current_path = os.getcwd()

slug = 'tzelal/binance-bitcoin-dataset-1s-timeframe-p2'
dataset = 'binance-bitcoin-dataset-1s-timeframe-p2'

try:
    subprocess.run(['/usr/src/app/venv/bin/kaggle', 'datasets', 'download', '-d', slug, '-p', current_path], check=True)
    print(f'Dataset download in: {current_path}')
except subprocess.CalledProcessError as e:
    print(f"Error in download: {e}")

dataset_zip_path = os.path.join(current_path, f'{dataset}.zip')

if os.path.exists(dataset_zip_path):
    with zipfile.ZipFile(dataset_zip_path, 'r') as zip_ref:
        zip_ref.extractall(current_path)
        os.remove(dataset_zip_path)
    print(f"File decompressed in: {current_path}")
else:
    print("File does not exist.")