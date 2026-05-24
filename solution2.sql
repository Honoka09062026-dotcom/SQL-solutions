--Problem: Sending vs. Opening Snaps
--URL: https://datalemur.com/questions/time-spent-snaps

WITH sum_of_time_spend
     AS (SELECT b.age_bucket,
                a.activity_type,
                Sum(a.time_spent)
                  OVER (
                    partition BY b.age_bucket, a.activity_type) AS
                activity_time_spend,
                Sum(a.time_spent)
                  OVER (
                    partition BY b.age_bucket)                  AS
                age_time_spend
         FROM   activities a
                JOIN age_breakdown b
                  ON a.user_id = b.user_id
         WHERE  activity_type IN ( 'send', 'open' ))
SELECT age_bucket,
       Max(CASE
             WHEN activity_type = 'send' THEN Round(
             activity_time_spend / age_time_spend *
             100.0, 2)
           END) AS send_percentage,
       Max(CASE
             WHEN activity_type = 'open' THEN Round(
             activity_time_spend / age_time_spend *
             100.0, 2)
           END) AS open_percentage
FROM   sum_of_time_spend
GROUP  BY age_bucket 
