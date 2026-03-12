-- DATA CLEANING

SELECT*
FROM layoffs;

-- step 1  CREATE A NEW TABLE  remove duplicates
-- step 2 standardize the data
-- 3 null values or blank values
-- 4 remove unneccsaary columns and rows



CREATE TABLE layoffs_staging
LIKE layoffs;

select*
from layoffs_staging;

INSERT layoffs_staging
SELECT*
FROM layoffs;

SELECT*,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)  AS ROW_NUM
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT*,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)  AS ROW_NUM
FROM layoffs_staging
)
SELECT*
FROM duplicate_cte
WHERE ROW_NUM > 1;

SELECT*
FROM layoffs_staging
WHERE company='Casper';








CREATE TABLE `layoffs_staging3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `ROW_NUM`  int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT*
FROM layoffs_staging3;

INSERT INTO layoffs_staging3
SELECT*,
ROW_NUMBER () OVER (
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, country, funds_raised_millions)  AS ROW_NUM
FROM layoffs_staging;

SELECT*
FROM layoffs_staging3
WHERE ROW_NUM >1;

DELETE 
FROM layoffs_staging3
WHERE ROW_NUM >1;

SELECT* 
FROM layoffs_staging3;


-- STANDARDIZING DATA
SELECT company, trim(company)
FROM layoffs_staging3;

update layoffs_staging3
set company = trim(company);

select distinct  industry
from layoffs_staging3;


update layoffs_staging3
set industry ='crypto'
where industry like 'crypto%';

select distinct  industry
from layoffs_staging3
order by industry;

select*
from layoffs_staging3
where country like 'United States%';

select distinct country, trim(trailing '.' from country)
from layoffs_staging3
order by country;

update layoffs_staging3
set country = trim(trailing '.' from country)
where country like 'United States%';

select date
from layoffs_staging3;

alter table layoffs_staging3
MODIFY `date` DATE;

update layoffs_staging3
set `date` = str_to_date(`date`, '%m/%d/%Y');

select*
from layoffs_staging3
where industry is null
or industry = '';

-- null and blank values
select *
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;


 -- remove unneccary columns and rows
 select *
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

 select *
from layoffs_staging3;


delete
from layoffs_staging3
where total_laid_off is null
and percentage_laid_off is null;

alter table layoffs_staging3
DROP COLUMN ROW_NUM;



SELECT company, trim(company)
FROM layoffs_staging3;

update layoffs_staging3
set company = trim(company);
