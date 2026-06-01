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

---

# SQL Challenge 3: Consecutive Filing Years (Intuit Interview Question)

## 📌 Problem Overview
This repository contains a solution to the "Consecutive Filing Years" problem from DataLemur.

### Scenario
As a data analyst, I need to identify individuals who have filed their taxes using any version of TurboTax for three or more consecutive years. Each user is allowed to file taxes once a year using a specific product.

### Goal
- Identify the user IDs of individuals with 3 or more consecutive years of TurboTax filings.
- Display the output in ascending order of user IDs.

---

## 🛠️ Technical Approach

To solve this problem efficiently, I focused on window functions and mathematical logic using **Common Table Expressions (CTEs)**.

1. **Data Isolation (CTE)**:
   - Created a CTE (`turbotax_years`) to filter for 'TurboTax' products using the `LIKE` operator.
   - Used the `EXTRACT` function to retrieve the filing year as an integer.
2. **Identifying Historical Filings**:
   - Leveraged the **`LAG()` window function** with an offset of 2 (`LAG(filing_year, 2)`).
   - Partitioned by `user_id` and ordered by `filing_year` to directly retrieve the year from two records prior.
3. **Mathematical Filtering**:
   - Calculated the difference between the current `filing_year` and the `year_2steps_back`.
   - A difference of exactly `2` mathematically confirms 3 consecutive years of filing activity.

---

## 🚀 Key Learning Points
- **Advanced Window Functions (`LAG` Offset)**: Discovered that `LAG(column, offset)` accepts a second argument. By using `LAG(filing_year, 2)`, I could cleanly look two rows back in a single step, making the query smarter and eliminating the need for nested CTEs.
- **`EXTRACT` vs `TO_CHAR`**: Initially used `TO_CHAR` to extract the year, which caused a type error during the final filtering stage because it converts the output into a string. Switching to `EXTRACT(YEAR FROM filing_date)` kept the value as an integer, allowing the arithmetic operation (`filing_year - year_2steps_back = 2`) to work flawlessly.
- **SQL Naming Conventions**: Encountered a syntax error when trying to use an alias starting with a number (`as 2steps_back_year`). Learned the strict rule that SQL aliases must begin with a letter (e.g., `year_2steps_back`).
- **Regex in PostgreSQL**: While trying to match the string "TurboTax", I learned that PostgreSQL 14 does not support the standard `REGEXP` keyword. Instead, it relies on specific operators like `~` (case-sensitive) or `~*` (case-insensitive). For this problem, using the standard `LIKE` operator was the most straightforward approach.

---

## 🔗 Original Problem
[DataLemur - Consecutive Filing Years](https://datalemur.com/questions/consecutive-filing-years)
