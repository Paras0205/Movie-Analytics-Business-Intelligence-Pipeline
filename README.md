# 🎬 Movie Analytics & Business Intelligence Pipeline

An end-to-end data analytics and business intelligence project that extracts movie data from the **TMDB API**, processes and validates it using **Python & Pandas**, stores it in **MySQL**, performs analytical queries using **SQL**, and presents insights through an interactive **Power BI dashboard**.

> **API Extraction → Data Transformation → Data Validation → SQL Storage → SQL Analysis → Power BI Visualization**

---

## 📌 Project Overview

Raw movie data pulled from an API isn't directly useful for business analysis — it needs to be cleaned, validated, structured, and interpreted before it can answer real questions. This project builds a complete, reusable analytics pipeline that turns raw TMDB movie data into meaningful insights about:

- Movie ratings and audience reception
- Popularity and engagement trends
- Release volume over time
- Language distribution across the movie industry
- The relationship between popularity and audience rating

---

## 🎯 Business Problem

A movie dataset can contain thousands of records — titles, languages, release dates, popularity scores, ratings, and vote counts — but simply collecting this data doesn't create business value on its own.

This project answers questions such as:

- Which movies receive the highest audience ratings?
- Which movies attract the most attention?
- How has movie production changed over time?
- Which languages dominate the dataset?
- Which movies combine high popularity with strong audience ratings?
- How engaged are audiences with different movies?

---

## 🎯 Objectives

1. Extract movie data from TMDB via its API
2. Handle API pagination across multiple pages of results
3. Transform raw JSON/API data using Pandas
4. Clean and validate the dataset
5. Handle missing and duplicate records appropriately
6. Convert complex/nested fields into SQL-compatible formats
7. Store processed data in MySQL
8. Perform analytical queries using SQL
9. Build an interactive Power BI dashboard
10. Surface movie performance, audience, industry, and language trends

---

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| **TMDB API** | Movie data source |
| **Python** | ETL and data processing |
| **Requests** | API communication |
| **Pandas** | Data transformation and cleaning |
| **MySQL** | Data storage |
| **SQL** | Data analysis |
| **Power BI** | Dashboard and visualization |
| **Git/GitHub** | Version control and project sharing |

---

## 🏗️ End-to-End Architecture

```
                  TMDB API
                     │
                     ▼
              API Data Extraction
                     │
                  Python
                     │
                     ▼
                Raw JSON
                     │
                     ▼
            Pandas Transformation
                     │
          ┌──────────┴──────────┐
          │                     │
       Cleaning             Validation
          │                     │
          └──────────┬──────────┘
                     │
                     ▼
                  MySQL
                     │
                     ▼
               SQL Analysis
                     │
                     ▼
                 Power BI
                     │
                     ▼
        Interactive BI Dashboard
```

---

## 📥 Data Extraction

Movie data is retrieved using the **TMDB Discover Movie API**. Python's `requests` library handles:

- API authentication
- Request parameters
- Pagination across multiple pages
- HTTP status code handling
- JSON response parsing

```
Page 1 → Movies
Page 2 → Movies
Page 3 → Movies
   ...
Page 500 → Movies
      ↓
Combined Dataset
```

This mirrors a real-world analytics workflow — working with a live API rather than a static CSV file.

---

## 🔄 Data Transformation

Once extracted, JSON responses are converted into a structured Pandas DataFrame:

- **Date conversion** — `release_date` converted into proper datetime format
- **Missing-value handling** — missing dates preserved as null rather than replaced with placeholder values
- **Genre field transformation** — TMDB's `genre_ids` list (e.g. `[28, 12, 878]`) converted into a JSON string for relational storage
- **Column pruning** — non-essential fields (poster/backdrop paths, overview text) excluded from the analytical dataset

---

## ✅ Data Validation

Before loading into MySQL, the dataset is validated to catch bad or unexpected records:

| Check | Rule |
|---|---|
| Duplicate movie IDs | `df["id"].duplicated().sum()` — `id` treated as unique identifier |
| Rating range | `0 ≤ vote_average ≤ 10` |
| Vote count | No negative values |
| Popularity | No negative values |
| Movie title | No null/blank titles |
| Release date | Invalid/missing dates flagged |

---

## 🗄️ MySQL Database

**Database:** `movie_analytics`
**Table:** `movies`

| Field |
|---|
| `id` (Primary Key) |
| `title` |
| `original_language` |
| `original_title` |
| `popularity` |
| `release_date` |
| `vote_average` |
| `vote_count` |
| `release_date_status` |
| `genre_ids` |

Pandas data types are converted to native Python types before insertion to avoid database parameter/type errors.

---

## 📊 SQL Analysis

### Movie Performance
- Highest-rated movies
- Movies with the highest audience vote counts
- Highly rated movies with sufficient audience engagement
- Most popular movies
- Movies combining high popularity and high ratings

> *Example:* Which movies have the highest ratings among movies with at least 1,000 votes? (Prevents low-vote outliers from skewing the ranking.)

### Industry Trends
- Movies released per year
- Changes in production volume over time
- Years with the highest number of releases
- Years with the highest average ratings
- Audience engagement across release years

### Language Analysis
- Most common movie languages
- Number of movies per language
- Average rating by language
- Average vote count by language
- A minimum movie-count threshold applied so languages with very few titles don't produce misleading averages

---

## 📈 Power BI Dashboard

### KPI Cards
| KPI | Description |
|---|---|
| **Movies Analyzed** | Number of movies in the current filtered dataset |
| **Average Audience Rating** | Average movie rating |
| **Average TMDB Popularity** | Average popularity score |
| **Audience Votes** | Total number of votes |
| **Languages Covered** | Number of unique original languages |

### Visualizations

**1. Movies Released by Year**
Line chart tracking release volume over time.
*Business question: How has movie release volume changed over time?*

**2. Top Rated Movies**
Horizontal bar chart of highest-rated movies, filtered to a 1,000+ vote threshold for meaningful rankings.
*Business question: Which movies are most highly rated among those with real audience participation?*

**3. Most Popular Movies**
Horizontal bar chart of movies with the highest TMDB popularity scores.
*Business question: Which movies are attracting the most attention on TMDB?*

**4. Top 10 Movie Languages**
Horizontal bar chart of the ten most represented original languages.
*Business question: Which original languages dominate the dataset?*

**5. Popularity vs Audience Rating**
Scatter plot — X: audience rating, Y: TMDB popularity, bubble size: vote count.
*Business question: Do highly popular movies also receive strong audience ratings?*

This reveals patterns such as:
- **High popularity + high rating** → well-received, high-visibility movies
- **High popularity + low rating** → attention-grabbing but weakly received
- **Low popularity + high rating** → well-received movies with limited visibility

### Interactive Filters
- **Original Language** — filter analysis to a specific language
- **Release Date** — filter to a specific date range

Both filters dynamically update all visuals and KPIs.

---

## 💡 Key Insights the Dashboard Provides

- Overall dataset size and composition
- Average audience rating and popularity levels
- Total audience voting activity
- Number of languages represented
- Growth or decline in movie releases over time
- Highest-rated and most popular movies
- Dominant languages in the dataset
- Relationship between popularity and audience reception

---

## 💼 Business Value

This project demonstrates how raw API data can be transformed into a decision-support system for:

- Content analysts
- Entertainment businesses
- Streaming/content teams
- Marketing teams
- Business analysts

Use cases include evaluating content performance, audience reception, market/language distribution, popularity patterns, historical trends, and potential content opportunities.

> The dashboard does not make business decisions — it provides structured evidence to support them.

---

## 🧩 Challenges Addressed

- **API Pagination** — retrieving data across multiple API pages
- **Dynamic API Data** — handling record counts/duplicates that vary between extraction runs
- **Duplicate Records** — identifying and resolving duplicate movie IDs
- **Missing Values** — preserving nulls instead of introducing artificial placeholders
- **Nested/Complex Data** — transforming `genre_ids` lists for relational storage
- **Data Type Compatibility** — converting Pandas types to native Python types for MySQL insertion
- **Large Dataset Visualization** — filtering thousands of records for an interpretable scatter plot

---

## 🔁 Project Workflow

1. Connect to TMDB API
2. Authenticate API requests
3. Extract movie data
4. Handle pagination
5. Combine API responses
6. Clean and transform data using Pandas
7. Validate data quality
8. Convert data for database loading
9. Load data into MySQL
10. Perform SQL analysis
11. Connect MySQL to Power BI
12. Build interactive dashboard
13. Generate business insights

---

## 🧠 Skills Demonstrated

**Data Analytics**
Exploratory analysis · KPI development · Business question framing · Trend analysis · Performance analysis

**Python**
API requests · JSON handling · Pandas · Data cleaning · Data validation · ETL scripting

**SQL**
Aggregations · GROUP BY · HAVING · ORDER BY · Filtering · Date analysis · Analytical queries · KPI calculations

**Database**
MySQL · Table design · Primary keys · Data loading · Relational storage

**Power BI**
Data modeling · DAX measures · KPI cards · Interactive slicers · Bar charts · Line charts · Scatter plots · Dashboard design

---

## 🚀 Future Improvements

- Normalize genre data into a separate related table instead of storing `genre_ids` as a JSON string
- Add scheduled/automated data refresh (e.g. cron job or Airflow)
- Add unit tests for transformation and validation functions
- Expand SQL analysis with window functions and multi-table joins
- Add a data-freshness indicator to the dashboard

---

## 📄 License

This project is open for educational and portfolio purposes. Attribution appreciated if reused.
