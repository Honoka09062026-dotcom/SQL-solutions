# SQL-solutions
Explaining my solutions for interview questions

# SQL Challenge: Active User Retention (Facebook Interview Question)

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
