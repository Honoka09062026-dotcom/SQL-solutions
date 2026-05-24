--Problem: Active User Retention
--URL: https://datalemur.com/questions/user-retention

WITH june
     AS (SELECT user_id,
                Extract(month FROM event_date) AS month
         FROM   user_actions
         WHERE  To_char(event_date, 'MM/YYYY') = '06/2022'),
     july
     AS (SELECT user_id,
                Extract(month FROM event_date) AS month
         FROM   user_actions
         WHERE  To_char(event_date, 'MM/YYYY') = '07/2022'),
     combine
     AS (SELECT DISTINCT july.user_id,
                         july.month
         FROM   june
                JOIN july
                  ON june.user_id = july.user_id)
SELECT month,
       Count(*) AS monthly_active_users
FROM   combine
GROUP  BY month 
