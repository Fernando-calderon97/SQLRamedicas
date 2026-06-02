import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL  # <-- ADD THIS IMPORT

# --- CONFIGURATION ---
FILE_PATH = r'G:\Mi unidad\CODIGOS\AUTOMATIZACIONES\EXCELABD\BaseparatablerocontrolCapitaFamisanar2026.xlsx'  # Path to your Excel file
DB_CONFIG = {
    'driver': 'ODBC Driver 17 for SQL Server',
    'server': '192.168.0.11\\rame2022',
    'database': 'RamedicasLAB',
    'user': 'rmdbi03',
    'pass': 'Fer97nando12*'
}

def initial_load():
    # 1. Load the Excel file
    print("Reading Excel...")
    df = pd.read_excel(FILE_PATH)

    # 2. Clean and Rename columns to match your SQL Table exactly
    # This mapping fixes the spaces and naming differences we discussed
    rename_map = {
        'CODIGO RAMEDICAS': 'artcod',
        'CUR': 'cur',
        'DCI': 'dcicod',
        'DESCRIPCION': 'descripcion',
        'CUM': 'cum',
        'OPCION': 'opcion'
    }
    df = df.rename(columns=rename_map)
    # Drop any phantom rows or "Total" rows from the bottom of the Excel file
    df = df.dropna(subset=['artcod'])

    # 3. Data Type Correction (Crucial for SQL)
    # Ensure NITs are strings to prevent .0 or scientific notation
    df['artcod'] = df['artcod'].astype(str).str.replace('.0', '', regex=False)
    
    # Fill NaN values for numeric columns to avoid SQL insertion errors
    # (SQL doesn't like Pandas 'NaN' in INT columns)
    numeric_cols = df.select_dtypes(include=['number']).columns
    df[numeric_cols] = df[numeric_cols].fillna(0)

    int_columns = ['opcion']
    for col in int_columns:
        if col in df.columns:
            df[col] = df[col].astype(int)

    # 4. Create SQL Connection
    connection_url = URL.create(
        "mssql+pyodbc",
        username=DB_CONFIG['user'],
        password=DB_CONFIG['pass'],
        host=DB_CONFIG['server'],
        database=DB_CONFIG['database'],
        query={
            "driver": DB_CONFIG['driver'],
            "TrustServerCertificate": "yes"
        }
    )
    engine = create_engine(connection_url)

    # 5. Push to SQL
    print(f"Connecting to {DB_CONFIG['server']} via VPN...")
    try:
        # We use if_exists='append' because the table already exists
        # index=False prevents pandas from adding an extra 'index' column
        df.to_sql(
            name='rmd_objcoddciyrmd_tecnica', 
            con=engine, 
            if_exists='append', 
            index=False,
            schema='dbo',
            chunksize=50 # Upload in batches to stay stable over the VPN
        )
        print("🚀 Initial load successful!")
    except Exception as e:
        print(f"❌ Error during upload: {e}")

if __name__ == "__main__":
    initial_load()