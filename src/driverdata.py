"""Module that loads the driver data from the Ergast API."""

import json
from http import HTTPStatus
from time import sleep

import pandas as pd
import requests

from settings import settings
from utils import year_range

NUM_OF_YEARS = settings.num_of_years
DEST_FILE = settings.driver_data_file
BASE_URL = settings.ergast_base_url
RETRIES = settings.ergast_num_of_retries


def get_drivers_in_year(year):
    """Get driver info for a given year from the Ergast API.
    
    In case of bad response, retry using exponential back-off (i.e. 
    increase waiting time for next retry exponentially).
    """
    url = f"{BASE_URL}{year}/drivers.json"
    for k in range(RETRIES):
        resp = requests.get(url)
        if resp.status_code == HTTPStatus.OK:
            return json.loads(resp.content)
        print(f"No proper response after request {url}.")
        if k < RETRIES - 1:
            print("Re-trying shortly...")
        pass
        wait = 100 * (1.05) ** k  # Use exponential back-off.
        sleep(wait / 1000)
        
        
def get_driver_table(driver_data):
    """Return a tuple with the season and the driver table from 
    the `driver_data` (nested) structure.
    """
    driver_table = driver_data["MRData"]["DriverTable"]
    season = driver_table["season"]
    return (season, driver_table)


def main(num_of_years):
    """Load driver data for the given number of years and write the
    results to a CSV file.
    """
    driver_tables = {}
    for year in year_range(num_of_years):
        driver_data = get_drivers_in_year(year)
        season, driver_table = get_driver_table(driver_data)
        driver_tables[season] = driver_table["Drivers"]
    df = pd.concat({k: pd.DataFrame(v) for k, v in driver_tables.items()}, axis=0)
    df.to_csv(DEST_FILE, index=True, index_label=['season', 'drivernumber'])


if __name__ == "__main__":
    main(NUM_OF_YEARS)
