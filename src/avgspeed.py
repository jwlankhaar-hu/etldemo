"""Module for loading average lap speeds from the Fast F1 API."""

import csv
from statistics import mean

import fastf1
import pandas as pd

from settings import settings
from utils import date_range

NUM_OF_YEARS = settings.num_of_years
CLEAR_CACHE = settings.fastf1_clear_cache
LAP_DATA_FILE = settings.lap_data_file

LAP_DATA_TO_EXPORT = [
    "LapTime",
    "Driver",
    "DriverNumber",
    "LapNumber",
    "Stint",
    "TyreLife",
    "Team",
    "Position",
]
LAP_DATA_FILE_HEADER = [
    'RaceName',
    'RaceDate',
    'RaceAvgSpeedKmh',
    *LAP_DATA_TO_EXPORT,
    'LapAvgSpeedKmh'
]


if CLEAR_CACHE:
    fastf1.Cache.clear_cache(deep=True)


def get_race_events(start_date, end_date):
    """Return events from the event schedules that were organized
    in the period between `start_date` and `end_date`.
    """
    years = list(range(start_date.year, end_date.year + 1))
    events_raw = pd.concat(
        (fastf1.get_event_schedule(y, include_testing=False) for y in years),
        ignore_index=True,
    )
    events = events_raw[
        (events_raw["EventDate"] >= start_date) & (events_raw["EventDate"] <= end_date)
    ]
    return events


def load_race_session(event):
    """Load the race session of `event`."""
    year = event["EventDate"].year
    gp_name = event["OfficialEventName"]
    session = fastf1.get_session(year=year, gp=gp_name, identifier="Race")
    # Do not use `get_race` on the event directly because this seems
    # to return the wrong session.
    session.load()
    return session


def finished_drivers(race_session):
    """Return a list of the drivers' ids who finished the race."""
    return [
        r["DriverNumber"]
        for _, r in race_session.results.iterrows()
        if r["Status"] == "Finished"
    ]


def laps_of_interest(race_session, drivers):
    """Return the laps of the given `drivers`."""
    return race_session.laps[race_session.laps["DriverNumber"].isin(drivers)].copy()


def avg_lap_speeds(laps):
    """Get average speed of all laps."""
    avg_speeds = []
    for _, lap in laps.iterrows():
        car_data = lap.get_car_data()
        lap_speed = car_data["Speed"]
        avg_speeds.append(mean(lap_speed))  # TODO: exclude pitstops
    return avg_speeds


def prep_for_export(laps, avg_lap_speeds, race_name, race_date, race_avg_speed):
    """Return a list of tuples. Each tuple contains lap data together
    with the average lap speed and some general race data.
    """
    columns = LAP_DATA_TO_EXPORT
    laps.LapTime = laps.LapTime.dt.total_seconds()
    return [
        (race_name, race_date, race_avg_speed, *lp, sp)
        for sp, (_, lp) in zip(avg_lap_speeds, laps[columns].iterrows())
    ]


def laps_to_csv(lap_data):
    """Export `lap_data` to CSV."""
    with open(LAP_DATA_FILE, 'wt', encoding='utf8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(LAP_DATA_FILE_HEADER)
        writer.writerows(lap_data)
    print(f'Lap data written to {LAP_DATA_FILE}')
        

def main(num_of_years):
    """Get race data for the given number of years and export the 
    lap data of all drivers who finished the race to a CSV file.
    """
    start_date, end_date = date_range(num_of_years)
    race_events = get_race_events(start_date, end_date)

    avg_speeds_races = {}
    laps_for_export = []
    for _, race in race_events.iterrows():
        name = race["OfficialEventName"]
        date = race["EventDate"]
        session = load_race_session(race)
        laps = laps_of_interest(session, finished_drivers(session))
        laps_avg = avg_lap_speeds(laps)
        race_avg = mean(laps_avg)
        laps_for_export.extend(
            prep_for_export(laps, laps_avg, name, date, race_avg)
        )
        print(f"{name}: {race_avg} km/h")
        avg_speeds_races[name] = race_avg
        
    laps_to_csv(laps_for_export)

    print(avg_speeds_races.values())
    fastest_race = max(avg_speeds_races, key=avg_speeds_races.get)  # type: ignore
    print(
        f"The fastest race was: {fastest_race} with an average speed of {avg_speeds_races[fastest_race]}"
    )


if __name__ == "__main__":
    main(NUM_OF_YEARS)
