"""Modules with various utility functions for the project."""

import datetime as dt

import pandas as pd


def date_range(num_of_years):
    """Return start date and end date which are taken exactly
    `num_of_years` before today's date.
    """
    end_date = pd.Timestamp(dt.datetime.now())
    start_date = end_date - pd.DateOffset(years=num_of_years)
    return start_date, end_date


def year_range(num_of_years):
    """Return a list of years starting at the `num_of_years` back
    from today.
    """
    cur_year = dt.date.today().year
    start_year = cur_year - num_of_years
    return list(range(start_year, cur_year + 1))


