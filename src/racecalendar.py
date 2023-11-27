"""Module that loads the race calendar(s) from the Fast F1 API."""

import fastf1
import pandas as pd

from settings import settings
from utils import year_range

NUM_OF_YEARS = settings.num_of_years
DEST_FILE = settings.race_calendar_file


def main(num_of_years):
    """Load the race calendars of the given number of years and
    write the results to a CSV file.
    """
    events = pd.concat(
        (
            fastf1.get_event_schedule(y, include_testing=False)
            for y in year_range(num_of_years)
        ), ignore_index=True
    )
    events.to_csv(DEST_FILE, index=True, index_label='index')
    print(f'Race calendars exported to {DEST_FILE}')


if __name__ == "__main__":
    main(NUM_OF_YEARS)
