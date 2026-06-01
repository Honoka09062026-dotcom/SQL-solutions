--Problem: Consecutive Filing Years
--URL: https://datalemur.com/questions/consecutive-filing-years

WITH turbotax_years
     AS (SELECT user_id,
                Extract(year FROM filing_date) AS filing_year
         FROM   filed_taxes
         WHERE  product LIKE '%TurboTax%'),
     consecutive_check
     AS (SELECT user_id,
                filing_year,
                Lag(filing_year, 2)
                  OVER (
                    partition BY user_id
                    ORDER BY filing_year) AS year_2steps_back
         FROM   turbotax_years)
SELECT DISTINCT user_id
FROM   consecutive_check
WHERE  filing_year - year_2steps_back = 2 
