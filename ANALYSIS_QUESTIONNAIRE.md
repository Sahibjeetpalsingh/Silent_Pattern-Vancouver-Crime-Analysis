# Analysis Questionnaire

This questionnaire frames the project the way a senior data analyst would: start with the business decision, define the metrics clearly, then test whether the dataset is strong enough to answer the question.

## 1. Business Context

1. What decision is this analysis supposed to support?
2. Is the audience interested in resource allocation, public safety reporting, neighbourhood comparison, or long-term trend monitoring?
3. Should the analysis focus on all crime, violent crime, or one specific offence category?

## 2. Problem Definition

Use this project statement:

> Analyze how `Offence Against a Person` incidents are distributed across Vancouver neighbourhoods and how those incident counts have changed over time.

## 3. Core Analytical Questions

1. Which neighbourhoods report the highest incident counts?
2. How concentrated are incidents in the top neighbourhoods?
3. What does the citywide trend look like over time?
4. Which neighbourhoods show the strongest increase or decrease in the recent period?
5. Are the latest values structurally meaningful, or could they be driven by incomplete-year reporting?

## 4. KPI Definitions

- **Total incidents**: Sum of `incident_count` across all available years for a neighbourhood.
- **Annual incidents**: `incident_count` for a single neighbourhood-year record.
- **Neighbourhood share**: A neighbourhood's total incidents divided by the dataset-wide total.
- **Recent-period change**: Difference between the latest year and the chosen baseline year, such as 2020.
- **Top concentration**: Share of total incidents held by the highest-volume neighbourhoods.

## 5. Scope Checks

A senior analyst would state these before presenting results:

- The file measures **incident counts**, not true **crime rates**.
- A real rate analysis needs population data by neighbourhood and year.
- The dataset covers only **`Offence Against a Person`**, not all Vancouver crime.
- Annual data is useful for trend reporting, but it cannot explain monthly seasonality.
- The latest year should be validated as a complete year before drawing strong conclusions.

## 6. Data Validation Questions

1. Does every neighbourhood have a record for every year from 2003 to 2025?
2. Are any years partial due to extraction timing?
3. Were any neighbourhood boundaries or naming rules changed over time?
4. Was the `level` field generated from `incident_count`, or is it sourced directly from the original system?
5. Are incident definitions consistent across the full time window?

## 7. Recommended Storyline For Presentation

1. Define the scope precisely: Vancouver `Offence Against a Person` incidents by neighbourhood.
2. Show the long-term concentration of incidents by neighbourhood.
3. Show the recent-year trend to identify movement since 2020.
4. Explain what the dataset can answer well.
5. Explain what cannot yet be claimed, especially around population-adjusted rates.

## 8. Example Insights From This Dataset

Based on the current file:

- The Central Business District has the largest cumulative incident count.
- A small group of neighbourhoods accounts for a large share of the total incidents.
- The recent trend rises into 2023, then softens afterward.
- The 2025 decline should be treated as provisional until the reporting completeness is confirmed.

## 9. Next Questions To Ask If This Becomes A Larger Project

1. Can population data be added to calculate incident rates per 1,000 residents?
2. Can other offence categories be included for a fuller citywide crime view?
3. Can monthly or daily grain be added to identify seasonality?
4. Should socioeconomic, land-use, or mobility context be added for explanatory analysis?
