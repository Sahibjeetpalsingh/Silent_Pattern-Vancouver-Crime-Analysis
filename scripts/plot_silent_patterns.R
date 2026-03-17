data_path <- file.path("data", "silent_patterns_person.csv")
output_dir <- "output"
output_path <- file.path(output_dir, "vancouver_offence_against_person_trends.png")

required_packages <- c("DBI", "RSQLite", "readr", "ggplot2")
missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing_packages) > 0) {
  stop(
    sprintf(
      "Missing packages: %s. Install them with install.packages(c(%s)).",
      paste(missing_packages, collapse = ", "),
      paste(sprintf('"%s"', missing_packages), collapse = ", ")
    ),
    call. = FALSE
  )
}

invisible(lapply(required_packages, library, character.only = TRUE))

if (!file.exists(data_path)) {
  stop(sprintf("Data file not found: %s", data_path), call. = FALSE)
}

raw_summary <- read_csv(data_path, show_col_types = FALSE)

con <- dbConnect(SQLite(), ":memory:")
on.exit(dbDisconnect(con), add = TRUE)

dbWriteTable(con, "silent_patterns_person", raw_summary, overwrite = TRUE)

# SQL step used to structure the analytical dataset for reporting.
crime_summary_sql <- "
  SELECT
    neighbourhood,
    CAST(year AS INTEGER) AS year,
    CAST(incident_count AS INTEGER) AS incident_count,
    level
  FROM silent_patterns_person
  WHERE CAST(year AS INTEGER) >= 2020
  ORDER BY neighbourhood, year
"

crime_summary <- dbGetQuery(con, crime_summary_sql)

if (nrow(crime_summary) == 0) {
  stop("SQL query returned no rows. Check the dataset and year filter.", call. = FALSE)
}

year_range <- range(crime_summary$year)

plot <- ggplot(
  crime_summary,
  aes(x = year, y = incident_count, group = neighbourhood, color = neighbourhood)
) +
  geom_line(linewidth = 0.7, show.legend = FALSE) +
  geom_point(size = 1.6, show.legend = FALSE) +
  facet_wrap(~ neighbourhood) +
  labs(
    title = sprintf(
      "Vancouver Offence Against a Person Incidents by Neighbourhood (%s-%s)",
      year_range[1],
      year_range[2]
    ),
    subtitle = "Annual incident counts from the project dataset",
    x = "Year",
    y = "Incident Count",
    caption = "This chart uses incident counts, not population-adjusted crime rates."
  ) +
  theme_minimal()

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
ggsave(output_path, plot = plot, width = 14, height = 10, dpi = 300)

message(sprintf("Saved plot to %s", output_path))
print(plot)
