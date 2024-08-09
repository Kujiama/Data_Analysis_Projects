# EXPLORATOY DATA ANALYSIS

SELECT  * FROM world_layoffs.layoffs_staging2;

-- using the layoffs data that we have cleaned we try to explore the data at hand focusing on layoffs
# main questions
-- 1. highest and lowest layoff by number of employees of
-- 2. Highest and lowest layoff by percentage of company
-- 3. highest total of employees laid off in one day




-- highest and lowest total employees laid off
SELECT max(total_laid_off),  min(total_laid_off)
FROM world_layoffs.layoffs_staging2;


-- Highest and lowest total percentage laid off
SELECT max(percentage_laid_off) , min(percentage_laid_off)
FROM world_layoffs.layoffs_staging2;

-- overall total of employees laid off
SELECT
	sum(total_laid_off)
FROM world_layoffs.layoffs_staging2;


-- highest total of employees laid off in 1 day
SELECT `date`, max(total_laid_off) as total_employees_laid_off
FROM world_layoffs.layoffs_staging2
WHERE 
	total_laid_off IS NOT NULL
    AND `date` IS NOT NULL
GROUP BY `date`
ORDER BY total_employees_laid_off DESC;


-- companies that have complete layoffs
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1; 
/* 116 companies have completely laid off their employees
I have researched for thier company names most of these companies
were startups that went bankrupt */



-- what country in the world have the most layoffs?
SELECT country, sum(total_laid_off) as total_employees_laid_off
FROM world_layoffs.layoffs_staging2
WHERE 
	total_laid_off IS NOT NULL
GROUP BY country
ORDER BY total_employees_laid_off DESC;
/* USA have the most layoffs totaling around 256,559. I can assume that most
of these companies were affected economically by the recession resulting in them
laying off employeees to counter the economic downturn*/



-- how many employees got laid off each year?
SELECT 
    YEAR(`date`) AS layoff_year,
    SUM(total_laid_off) AS year_total_laid_off
FROM world_layoffs.layoffs_staging2
WHERE
    YEAR(`date`) IS NOT NULL
GROUP BY layoff_year;
/* Out of the 4 years the company has laid off upto the 6 figures
especially during 2022 having the highest ammount of employeess layed off during that year.
I assume that the pandemic had a delayed impact resulting in companies laying off employees */
   
   
   
-- percentage of each country for the layoff
WITH country_layoff AS (
	SELECT
		country,
		sum(total_laid_off) employees_laidoff
	FROM world_layoffs.layoffs_staging2 
	WHERE 
		total_laid_off IS NOT NULL
	GROUP BY country
), global_layoff_percentage AS (
	SELECT
		*,
		sum(employees_laidoff) over() as global_layoff_count
	FROM country_layoff
)
SELECT
	country,
    (employees_laidoff / global_layoff_count) * 100 as layoff_perecentage
FROM global_layoff_percentage;
/* Half of the world's lay off comes from the USA coming around to 66.87 */


--  how much each month in each year contributes to the over all total of global layoff count
WITH month_year AS(
	SELECT 
		substring(`date`,1,7) AS dates,
		sum(total_laid_off) as total_laid_off
	FROM world_layoffs.layoffs_staging2
	GROUP BY dates
)
SELECT 
    dates,
    sum(total_laid_off) over(ORDER BY dates) as month_total_laid_off
FROM month_year;
    
    
-- top 3 companies with highest total number off layoffs by year starting from 2020?
WITH company_year AS (
	SELECT 
		company,
		year(`date`) `year`,
		sum(total_laid_off) as total_employees_laid_off
	FROM world_layoffs.layoffs_staging2
	WHERE 
		total_laid_off IS NOT NULL
        AND year(`date`) IS NOT NULL
	GROUP BY 
		year(`date`),company
), company_ranking AS (
	SELECT
		*,
		dense_rank() over(partition by `year` order by total_employees_laid_off DESC) company_layoff_ranking
	FROM company_year
)	
SELECT
	*
FROM company_ranking
HAVING company_layoff_ranking <= 3;

