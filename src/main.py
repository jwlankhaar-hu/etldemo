"""Main module for the Fast F1 data loading."""

import avgspeed
import driverdata
import racecalendar
from settings import settings

NUM_OF_YEARS = settings.num_of_years


def main(num_of_years):
    print('Loading average speeds...')
    avgspeed.main(num_of_years)
    print('Loading driver data...')
    driverdata.main(num_of_years)
    print('Loading race calendar...')
    racecalendar.main(num_of_years)


if __name__ == '__main__':
    main(NUM_OF_YEARS)