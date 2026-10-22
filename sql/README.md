# SQL Analysis — Women's Running Analytics

## Overview

This folder contains the SQL script used to explore, prepare, clean, and validate the NYC Marathon 2019 results dataset for the Women's Running Analytics project.

SQLite was used to inspect the raw data, investigate participant demographics and finish-time formats, convert marathon finish times into numeric seconds, and create a clean analytical table for use in Tableau.

## SQL Script

**File:** `nyc_marathon_2019_analysis.sql`

The script includes the following steps:

### 1. Initial Data Exploration
- Inspected the raw table structure and sample records.
- Checked the total number of records and distinct bib numbers.
- Explored race year, race category, gender, and nationality.
- Examined overall and women's age ranges.
- Checked women's records for missing ages and missing or blank finish times.

### 2. Finish-Time Conversion Tests
- Inspected the original `time_full` format.
- Tested how hours, minutes, and seconds could be extracted.
- Converted finish times from `H:MM:SS` into total seconds.
- Tested the formatted time output to confirm the conversion approach.

These exploratory queries document the process used to understand and transform the source data.

### 3. Clean Table Creation
Created `nyc_marathon_2019_clean` from the raw table, retaining the original fields and adding:

- `time_full_in_seconds` — finish time converted into total seconds for numerical analysis in Tableau.

### 4. Validation
- Inspected the clean table's schema and sample records.
- Checked the clean table's record count.
- Checked for missing converted finish times.

## Tools

- **SQLite** — data exploration, transformation, and validation
- **DB Browser for SQLite** — database interface and SQL execution

## Output

The cleaned dataset was exported to CSV and imported into Tableau for visualization and performance analysis across women's age groups.

The analytical focus and findings are documented in the main project README and Tableau dashboard.

