# Vancouver Crime Analysis

This project analyzes **Offence Against a Person** incidents across Vancouver neighbourhoods using R, SQL, and data visualization. The goal is to identify where incidents are most concentrated, how the pattern has changed over time, and which neighbourhoods should be monitored more closely.

## Executive Summary

This dataset covers **24 Vancouver neighbourhoods** across **2003 to 2025** with **552 annual observations**. The analysis shows that incident counts are heavily concentrated in a small number of neighbourhoods, especially the **Central Business District**, **Strathcona**, and the **West End**. In the post-2020 view used for the chart, total incidents rose through **2023** before easing in **2024** and **2025**. The 2025 value should be treated carefully until the source is confirmed as a full-year extract.

A senior analyst framing is important here: this repository analyzes **incident counts**, not a true citywide **crime rate**. A rate calculation would require neighbourhood population data so incidents can be normalized per resident.

## Business Question

How have `Offence Against a Person` incidents changed across Vancouver neighbourhoods over time, and which areas show the highest concentration of incidents in the most recent years?

## Analytical Questions

1. Which neighbourhoods contribute the largest share of reported incidents?
2. How has the city-level trend changed from 2003 to 2025?
3. Which neighbourhoods remain consistently high-volume over time?
4. Which neighbourhoods increased or decreased the most since 2020?
5. Does the latest year indicate a real decline, or could it reflect incomplete reporting?

A more interview-ready version of these questions is included in [ANALYSIS_QUESTIONNAIRE.md](ANALYSIS_QUESTIONNAIRE.md).

## Dataset

The working dataset is [`data/silent_patterns_person.csv`](data/silent_patterns_person.csv).

Columns:

- `neighbourhood`: Vancouver neighbourhood name
- `year`: reporting year
- `incident_count`: annual count of incidents
- `level`: count band used in the source extract

Current scope:

- 24 neighbourhoods
- 2003 to 2025
- 552 rows
- One crime category: `Offence Against a Person`

## Methodology

The analysis follows a standard analyst workflow:

1. Load the cleaned CSV into R.
2. Push the dataset into an in-memory SQLite table.
3. Use SQL to cast fields and filter the reporting window to 2020 onward for the chart.
4. Visualize annual incident counts by neighbourhood using faceted line charts.
5. Interpret the output using concentration, trend, and change-over-time logic.

The analysis script is [`scripts/plot_silent_patterns.R`](scripts/plot_silent_patterns.R).

## Key Findings

- The **Central Business District** has the highest cumulative incident count in the dataset with **25,589 incidents**, representing about **30.3%** of all recorded incidents in this file.
- **Strathcona** and the **West End** are the next largest contributors, with **11,072** and **9,264** incidents respectively.
- At the city level, the highest annual total in the full dataset appears in **2007** with **4,406 incidents**.
- In the recent period used for the plot, **2023** is the post-2020 high point with **4,074 incidents**.
- The **2025** total is lower than the preceding years, but that should not be over-interpreted without confirming whether the extract represents a complete reporting year.

## Limitations

- This is **not** a true crime-rate model because no population denominator is included.
- The project currently covers only one offence category rather than total Vancouver crime.
- Annual aggregation hides monthly or seasonal patterns.
- The latest year may be incomplete depending on the source export date.

## Repository Structure

- `README.md`: project summary and methodology
- `ANALYSIS_QUESTIONNAIRE.md`: stakeholder and analytical question set
- `data/silent_patterns_person.csv`: input dataset
- `scripts/plot_silent_patterns.R`: SQL + visualization workflow
- `output/`: generated charts, ignored by git

## Tools Used

- **R** for scripting and visualization
- **SQLite / SQL** for lightweight analytical querying
- **ggplot2** for faceted trend charts
- **readr** for CSV ingestion

## How To Run

Install the required packages in R:

```r
install.packages(c("DBI", "RSQLite", "readr", "ggplot2"))
```

Run the script from the project root:

```r
source("scripts/plot_silent_patterns.R")
```

Or from a terminal with `Rscript` available:

```bash
Rscript scripts/plot_silent_patterns.R
```

The chart is saved to `output/vancouver_offence_against_person_trends.png`.

## Next Steps

To take this project to a stronger analyst or portfolio level, the next improvements would be:

- add neighbourhood population data to calculate rates per capita
- expand the analysis to multiple crime categories
- include monthly data to detect seasonality and volatility
- build a dashboard layer for interactive filtering and comparison
