# Layoffs 2022 SQL Analysis

This project analyzes the [Layoffs 2022 Dataset](https://www.kaggle.com/datasets/swaptr/layoffs-2022) using SQL. The analysis focuses on understanding trends and patterns in layoffs using advanced SQL concepts such as Common Table Expressions (CTEs), window functions, and standard SQL queries.

## DML SQL Techniques Used in the Project 

### Data Manipulation Language (DML)
- **Normal Queries:** Standard SQL queries for data extraction, filtering, and summarization. DML is the important chunk of the data cleaning and exploratory data analysis processes.

### Group Functions
- **GROUP BY:** The `GROUP BY` clause was used to aggregate data based on one or more columns. This technique was essential for summarizing data, such as counting the number of layoffs per company or per month or calculating the total layoffs in a year.

### Advanced SQL Techniques
- **Common Table Expressions (CTEs):** Utilized to simplify complex queries and break them down into manageable parts.
- **Window Functions:** Utilized to perform operations like running totals, ranking, moving averages over a set of row, and using this function to find duplicates in the data set


## Key Findings

1. **High Layoffs During 2022:** Over the span of four years, the company experienced significant layoffs, particularly in 2022, where the number of employees laid off reached six figures. This spike in layoffs could be attributed to the delayed economic impact of the COVID-19 pandemic, leading companies to reduce their workforce.

2. **Total Layoffs Over Four Years:** In total, companies laid off 383,659 employees over the four-year period analyzed. This figure highlights the widespread impact across various industries.

3. **Geographic Concentration in the USA:** The United States experienced the most layoffs, with a total of approximately 256,559 employees affected, accounting for 66.87% of the total layoffs. This trend suggests that U.S.-based companies were particularly hard-hit, likely due to economic challenges such as the recession, prompting these companies to reduce their workforce as a countermeasure.

4. **Complete Layoffs in 116 Companies:** A total of 116 companies completely laid off all their employees during this period. Upon further research, many of these companies were identified as startups that went bankrupt, unable to sustain operations during economically challenging times.

