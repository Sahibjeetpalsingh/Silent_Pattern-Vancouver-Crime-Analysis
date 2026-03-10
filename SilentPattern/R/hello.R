library(DBI)
library(RSQLite)
library(readr)
library(dplyr)
library(ggplot2)

# raw data
crime_data <- read_csv("crimedata.csv")

con <- dbConnect(SQLite(), "silent_patterns.db")
dbWriteTable(con, "crime_data", crime_data, overwrite = TRUE)

Harassment_Pattern <- dbGetQuery(con, "
  SELECT NEIGHBOURHOOD, YEAR, COUNT(*) AS COUNT
  FROM crime_data
  WHERE TRIM(TYPE) = 'Offence Against a Person'
    AND YEAR BETWEEN 2020 AND 2026
    AND NEIGHBOURHOOD IS NOT NULL
  GROUP BY NEIGHBOURHOOD, YEAR
  ORDER BY NEIGHBOURHOOD, YEAR
")

dbDisconnect(con)

Harassment_Pattern
Harrasment_Pattern <- Harassment_Pattern %>%
  mutate(year2020 = YEAR)
ggplot(Harassment_Pattern, aes(x = YEAR, y = COUNT, color = NEIGHBOURHOOD)) +
  geom_line() +
  geom_point() +
  labs(title = "Offence Against a Person by Neighbourhood (2020–2023)",
       x = "Year", y = "Count") +
  theme_minimal() + facet_wrap(~ NEIGHBOURHOOD)
# save the plot
ggsave("harassment_pattern.png", width = 10, height = 6)



