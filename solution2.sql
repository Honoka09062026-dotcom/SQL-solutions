WITH sum_of_time_spend AS (
SELECT b.age_bucket, a.activity_type, SUM(a.time_spent) OVER (PARTITION BY b.age_bucket, a.activity_type) as activity_time_spend, SUM(a.time_spent) OVER (PARTITION BY b.age_bucket) as age_time_spend
FROM activities a JOIN age_breakdown b ON a.user_id = b.user_id
WHERE activity_type IN ('send', 'open')
)
SELECT age_bucket, MAX(CASE WHEN activity_type = 'send' THEN ROUND(activity_time_spend/age_time_spend*100.0, 2) END) as send_percentage,
MAX(CASE WHEN activity_type = 'open' THEN ROUND(activity_time_spend/age_time_spend*100.0, 2) END) as open_percentage
FROM sum_of_time_spend
GROUP BY age_bucket
