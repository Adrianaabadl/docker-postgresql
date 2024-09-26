import os
import subprocess
import zipfile

def extract_file():
    current_path = '/usr/src/app'
    dataset = 'binance-bitcoin-dataset-1s-timeframe-p2'
    dataset_zip_path = os.path.join(current_path, f'{dataset}.zip')

    if os.path.exists(dataset_zip_path):
        with zipfile.ZipFile(dataset_zip_path, 'r') as zip_ref:
            zip_ref.extractall(current_path)
            os.remove(dataset_zip_path)
        print(f"File decompressed in: {current_path}")
    else:
        print("File does not exist.")

if __name__ == "__main__":
    extract_file()