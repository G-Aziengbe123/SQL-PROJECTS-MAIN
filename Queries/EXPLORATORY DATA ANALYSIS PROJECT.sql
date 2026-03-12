-- EXPLORATORY DATA ANALYSIS
select*
from layoffs_staging3;

select max(total_laid_off), max(percentage_laid_off), count(percentage_laid_off)
from layoffs_staging3;

select*
from layoffs_staging3
where percentage_laid_off = 1
order by funds_raised_millions desc;

select count(company)
from layoffs_staging3
where percentage_laid_off = 1;

select company, sum(total_laid_off)
from layoffs_staging3
group by company
order by sum(total_laid_off) desc ;

select min(`date`), max(`date`)
from layoffs_staging3;

select country ,sum(total_laid_off)
from layoffs_staging3
group by country
order by sum(total_laid_off) desc ;

select*
from layoffs_staging3;

select year(`date`) ,sum(total_laid_off)
from layoffs_staging3
group by year(`date`)
order by year(`date`) desc ;

select stage ,sum(total_laid_off)
from layoffs_staging3
group by stage
order by sum(total_laid_off) desc ;

select company ,sum(percentage_laid_off)
from layoffs_staging3
group by company
order by sum(percentage_laid_off) desc ;

select substring(`date`, 1, 7) `Month`, sum(total_laid_off)
from layoffs_staging3
where substring(`date`, 1, 7) is not null
group by `Month` 
order by 1 asc;

with rolling_total as
(
select substring(`date`, 1, 7) `Month`, sum(total_laid_off) as total_lf
from layoffs_staging3
where substring(`date`, 1, 7) is not null
group by `Month` 
order by 1 asc
)
select `Month`,total_lf
,sum(total_lf) over(order by `Month` ) roling_t
from rolling_total;

select company, sum(total_laid_off)
from layoffs_staging3
group by company
order by sum(total_laid_off) desc ;

select company,year(`Date`), sum(total_laid_off)
from layoffs_staging3
group by company,year( `Date`)
order by 3 desc;

with Company_year (company, years, total_laid_off)as
(
select company,year(`Date`), sum(total_laid_off)
from layoffs_staging3
group by company,year( `Date`)
), Company_Year_rank as 
(select*, dense_rank() over(partition by years order by total_laid_off desc) Y_TLO
from Company_year
WHERE years is not null
)
select*
from Company_Year_Rank
where Y_TLO <=5;

