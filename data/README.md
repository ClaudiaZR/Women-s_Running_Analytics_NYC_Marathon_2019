# Data — Women's Running Analytics

## Overview

This folder contains the cleaned dataset used for the Women's Running Analytics — NYC Marathon 2019 project.

## Dataset File

**File:** `nyc_marathon_2019_clean.csv`

The CSV was exported from the cleaned SQLite table `nyc_marathon_2019_clean` and imported into Tableau for analysis.

## Data Preparation

The dataset was prepared using SQLite. The preparation workflow included:

- Exploring the raw marathon results.
- Checking record counts and key fields.
- Investigating missing or blank values in relevant fields.
- Testing the finish-time format.
- Converting marathon finish times from `H:MM:SS` into total seconds in the `time_full_in_seconds` field.
- Validating the cleaned table before exporting it to CSV.

The original fields were retained, and `time_full_in_seconds` was added to support numerical analysis in Tableau.

## Dataset Summary

- **Total records:** 53,520
- **Female runners:** 22,719
- **Male runners:** 30,801
- **Race year:** 2019

## Intended Use

This dataset supports the Tableau dashboard **Running Through the Ages**, which explores women's participation and finish-time performance across age groups.

## Source

The original dataset was obtained from the public GitHub repository:

[AndrewMillerOnline — Marathon Results](https://github.com/AndrewMillerOnline/marathon-results)

The source file used was `results-2019.csv`.
