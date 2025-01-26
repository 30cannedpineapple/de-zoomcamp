import argparse
from time import time
import pandas as pd
from sqlalchemy import create_engine

zone = pd.read_csv("taxi_zone_lookup.csv")
engine = create_engine('postgresql://root:root@localhost:5432/ny_taxi')
engine.connect()
zone.to_sql(name='zones', con=engine, if_exists='replace')