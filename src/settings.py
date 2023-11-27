"""Module with all settings for the project."""

from dataclasses import dataclass
from pathlib import Path


@dataclass
class Settings:
    data_dir: Path = Path(__file__).parent / '..' / 'data'
        
    num_of_years: int = 2
    
    race_calendar_file: Path = data_dir / 'racecalendar.csv'
    lap_data_file: Path = data_dir / 'lapspeeds.csv'
    driver_data_file: Path = data_dir / 'driverinfo.csv'
    
    fastf1_clear_cache: bool = False
    
    ergast_base_url: str = 'https://ergast.com/api/f1/'
    ergast_num_of_retries: int = 10
    
settings = Settings()
    