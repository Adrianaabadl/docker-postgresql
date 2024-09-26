import os
import subprocess
import zipfile

def download_dataset():
    current_path = '/usr/src/app'
    slug = 'tzelal/binance-bitcoin-dataset-1s-timeframe-p2'
    try:
        subprocess.run(['/usr/src/app/venv/bin/kaggle', 'datasets', 'download', '-d', slug, '-p', current_path], check=True)
        print(f'Dataset downloaded in: {current_path}')
    except subprocess.CalledProcessError as e:
        print(f"Error in download: {e}")


if __name__ == "__main__":
    download_dataset()