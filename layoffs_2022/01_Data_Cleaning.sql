SELECT * FROM world_layoffs.layoffs;
SELECT * FROM world_layoffs.layoffs_staging2;

-- Steps in Data Cleaning (cleaning data preps us to do exploratory Data Analysis)
-- 1. Remove Duplicates
-- 2. Standardize the data 
-- 3. check null values / empty values (populate or not)
-- 4. Remove unecessary Rows and Columns

-- create a staging place to hold data for data cleaning
-- we are using this staging place to modify our data alot and incase of errors,
-- we can have the original data available
DROP TABLE IF EXISTS world_layoffs.layoffs_staging;
CREATE TABLE layoffs_staging (
	SELECT * FROM world_layoffs.layoffs
);




#---------------------------1 Removing duplicates---------------------------
-- 1a identify Duplicates
WITH duplicates_cte AS (
	SELECT
		*,
		ROW_NUMBER() OVER(
			PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
		) AS row_id
	FROM world_layoffs.layoffs_staging
)
SELECT *
FROM duplicates_cte
WHERE row_id > 1;

-- stage table for duplicate deletion
-- create table for deletion
DROP TABLE IF EXISTS world_layoffs.layoffs_staging2;
CREATE TABLE layoffs_staging2 (
	SELECT
		*,
		ROW_NUMBER() OVER(
			PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions
		) AS row_id
	FROM world_layoffs.layoffs_staging
);
-- delete duplicates for the newly created table
DELETE FROM world_layoffs.layoffs_staging2 WHERE row_id > 1;




#---------------------------2 Standardizing data---------------------------
-- standardizing industry column
SELECT * FROM world_layoffs.layoffs_staging2
ORDER BY industry;

-- convert empty strings to NULL value 
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- Make the Crypto industry name more uniform 
UPDATE world_layoffs.layoffs_staging2 
SET industry = 'Cryptocurrency'
WHERE industry IN ("Crypto","Crypto Currency");

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry LIKE "Cryptocurrency";

-- fixing the format of date and data type
UPDATE world_layoffs.layoffs_staging2
SET `date` = STR_TO_DATE(`date`, "%Y-%m-%d");

ALTER TABLE world_layoffs.layoffs_staging2 
MODIFY COLUMN `date` date;

-- country
-- countries where their names end with a period
-- using trim to remove the period
SELECT country
FROM world_layoffs.layoffs_staging2
WHERE country LIKE "%.";

UPDATE world_layoffs.layoffs_staging2
	SET country = trim("." FROM country)
WHERE country LIKE "%.";




#---------------------------3 Updating/Deleting our data's null values---------------------------
SELECT * FROM world_layoffs.layoffs_staging2
ORDER BY industry;

-- we have 4 companies that have NULLs lets find their respective companies
-- populate to their respective industries

-- Juul
SELECT * FROM world_layoffs.layoffs_staging2
WHERE company LIKE "Juul";

-- Airbnb	
SELECT * FROM world_layoffs.layoffs_staging2
WHERE company LIKE "Airbnb";

-- Carvana
SELECT * FROM world_layoffs.layoffs_staging2
WHERE company LIKE "Carvana"; 

-- since the companies above have their own respectiv industires but som rows are null we will
-- update 3 companies that have NULL industries and populate with their respective industries
UPDATE world_layoffs.layoffs_staging2 t1
JOIN world_layoffs.layoffs_staging2 t2 
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE 
	t2.industry IS NOT NULL
    AND t1.industry IS NULL;
    
-- Bally's Interactive
SELECT * FROM world_layoffs.layoffs_staging2
WHERE company LIKE "Bally's Interactive";

-- since Bally's is still null given that we updated our company's industry
-- lets populate company's industry that do not have declared their industry to Other
UPDATE world_layoffs.layoffs_staging2
SET industry = "Other"
WHERE industry  IS NULL;

-- Find null values in stage
SELECT *
FROM world_layoffs.layoffs_staging2
ORDER BY stage;

-- Update the null stage values into unknown
-- I will assume that they do not know what stage they are in
UPDATE world_layoffs.layoffs_staging2
SET stage = 'Unknown'
WHERE stage IS NULL;


-- select all total_laid_off and percentage_laid_off where both are null
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE 
	total_laid_off IS NULL
    AND percentage_laid_off IS NULL;
    
-- DELETE all rows where both columns  total_laid_off and percentage_laid_off
DELETE FROM world_layoffs.layoffs_staging2
WHERE 
	total_laid_off IS NULL
    AND percentage_laid_off IS NULL;
    
#---------------------------4 Dropping Columns
-- DROP row_id as it will not be useful in exploratory data analysis
ALTER TABLE world_layoffs.layoffs_staging2
DROP COLUMN row_id;

-- making sure the column was dropped
SELECT * FROM world_layoffs.layoffs_staging2;
    
