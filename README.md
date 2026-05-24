# SQL-solutions
Explaining my solutions for interview questions

# SQL Challenge1: Active User Retention (Facebook Interview Question)

## 📌 Problem Overview
This repository contains a solution to the "Active User Retention" problem from DataLemur.

### Scenario
As a data analyst at Facebook, I need to identify **Monthly Active Users (MAUs)** for July 2022. 
A "retained user" is defined as a user who was active in **both** the current month (July 2022) and the previous month (June 2022).

### Goal
- Calculate the total number of retained users for July 2022.
- Output the month and the count of monthly active users.

---

## 🛠️ Technical Approach

To solve this problem efficiently, I focused on data modularity and readability using **Common Table Expressions (CTEs)**.

1.  **Data Isolation (CTEs)**: 
    - Created two separate CTEs (`june` and `july`) to isolate user activity for each respective month.
    - Used `TO_CHAR` and `EXTRACT` functions to filter records specifically for June 2022 and July 2022.
2.  **Identifying Retained Users**: 
    - Performed an **INNER JOIN** between the two CTEs on `user_id`. 
    - This approach ensures that only users present in both datasets are included in the final count, perfectly matching the business definition of a "retained user."
3.  **Aggregation**: 
    - Counted unique `user_id`s to produce the final MAU metric.

---

## 🚀 Key Learning Points
- **CTE vs Subqueries**: Used CTEs to make the query more readable and maintainable, which is a best practice in professional data environments.
- **Join Logic**: Leveraged an Inner Join as a filtering mechanism to identify overlapping user segments across different time periods.
- **Date Manipulation**: Practiced extracting specific time intervals from `datetime` objects to align with monthly reporting requirements.

---

## 🔗 Original Problem
[DataLemur - Active User Retention](https://datalemur.com/questions/user-retention)

---

# SQL Challenge2: Sending vs. Opening Snaps (Snapchat Interview Question)

## 📌 Problem Overview
This repository contains a solution to the "Sending vs. Opening Snaps" problem from DataLemur.

### Scenario
As a data analyst at Snapchat, I need to analyze how users in different age groups spend their time on the platform. Specifically, I need to break down the proportion of time spent sending snaps compared to opening snaps.

### Goal
- Calculate the percentage of time spent sending snaps and opening snaps for each `age_bucket`.
- Output the age bucket, send percentage, and open percentage, rounded to two decimal places.

---

## 🛠️ Technical Approach

To solve this problem efficiently, I focused on data modularity and conditional aggregation using **Common Table Expressions (CTEs)** and **Window Functions**.

1.  **Data Isolation & Aggregation (CTEs)**: 
    - Created a CTE to join the `activities` and `age_breakdown` tables.
    - Filtered out irrelevant data early by selecting only 'send' and 'open' activities.
    - Used **Window Functions** (`SUM(...) OVER(PARTITION BY ...)`) to simultaneously calculate the total time spent per activity type and the total time spent per age bucket without relying on complex nested subqueries.
2.  **Conditional Aggregation (Pivoting)**: 
    - Utilized the `MAX(CASE WHEN ... THEN ... END)` pattern combined with a `GROUP BY` clause. 
    - This approach cleanly pivots the row-level activity data into readable, separate columns (`send_percentage` and `open_percentage`).
3.  **Percentage Calculation**: 
    - Divided the activity-specific time by the total age bucket time, multiplied by 100.0 to ensure accurate floating-point division, and applied the `ROUND(..., 2)` function to format the final output.

---

## 🚀 Key Learning Points
- **Window Functions**: Leveraged `PARTITION BY` to calculate multiple levels of aggregation (by age bucket and by activity type) simultaneously within a single dataset.
- **Data Pivoting**: Mastered the `MAX(CASE WHEN ...)` technique to effectively transform normalized row data into a structured, columnar report format.
- **Query Optimization**: Improved query processing efficiency by filtering out unnecessary data (like 'chat' activities) at the CTE level before performing heavy aggregations.

---

## 🔗 Original Problem
[DataLemur - Sending vs. Opening Snaps](https://datalemur.com/questions/time-spent-snaps)
