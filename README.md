# Claims-Analysis-SQL-Project
A complete SQL exploration of an insurance claims dataset, including data cleaning, table creation, indexing, analytical queries, and dashboard‑ready views

Project Overview
This project analyses a dataset of 101 insurance claims across multiple product lines (Auto, Travel, Pet, Health, Life).
The goal is to demonstrate real‑world SQL skills:

Data cleaning & preparation

Table design

Query writing

Aggregation & grouping

Time‑series analysis

Customer behaviour insights

The dataset includes fields such as claim type, customer demographics, claim amount, city, and status.

Data Cleaning

The original CSV required extensive cleaning before import:

Standardised dates → YYYY-MM-DD

Normalised numeric fields → 1234.00

Fixed inconsistent city names (dublin, DUBLIN → Dublin)

Cleaned customer names (removed double spaces)

Removed broken final row

Dropped unused columns (Min Age, Band)

Ensured all rows had exactly 11 fields

The cleaned dataset imported successfully into MySQL with 101 valid records.

Database Schema 

The final table structure 

| Column        | Type        | Description |
| --- |         | --- |
| claim_id      | VARCHAR   | Unique claim reference |
| customer_id   | INT       | Customer identifier |
| customer_name | VARCHAR   | Full name |
| Age Group     | VARCHAR   | Age band (e.g., 25-34) |
| age           | DECIMAL   | Exact age |
| gender        | CHAR(1)   | M/F |
| claim_date    | DATE      | Date of claim |
| claim_type    | VARCHAR   | Auto, Travel, Pet, Health, Life |
| claim_amount  | DECIMAL   | Monetary value |
| city          | VARCHAR   | Claim location |
| status        | VARCHAR   | Approved, Pending, Closed, Under Review, Cancelled |

Table Creation SQL

CREATE TABLE claims (
    claim_id VARCHAR(10),
    customer_id INT,
    customer_name VARCHAR(100),
    `Age Group` VARCHAR(10),
    age DECIMAL(4,2),
    gender CHAR(1),
    claim_date DATE,
    claim_type VARCHAR(20),
    claim_amount DECIMAL(10,2),
    city VARCHAR(50),
    status VARCHAR(20)
);

📈 Analysis Queries
1️⃣ Basic Checks

SELECT COUNT(*) FROM claims;
SELECT COUNT(DISTINCT customer_id) FROM claims;
SELECT MIN(claim_date), MAX(claim_date) FROM claims;

2️⃣ Claim Frequency
By Age Group

SELECT `Age Group`, COUNT(*) 
FROM claims
GROUP BY `Age Group`
ORDER BY COUNT(*) DESC;

By City

SELECT city, COUNT(*) 
FROM claims
GROUP BY city
ORDER BY COUNT(*) DESC;

By Claim Type

SELECT claim_type, COUNT(*) 
FROM claims
GROUP BY claim_type;

3️⃣ Financial Analysis
Average Claim Amount by Type

SELECT claim_type, ROUND(AVG(claim_amount), 2)
FROM claims
GROUP BY claim_type;

Total Claim Value per Month

SELECT DATE_FORMAT(claim_date, '%Y-%m') AS month,
       SUM(claim_amount)
FROM claims
GROUP BY month
ORDER BY month;

4️⃣ Status Analysis

SELECT claim_type, status, COUNT(*)
FROM claims
GROUP BY claim_type, status
ORDER BY claim_type, status;

5️⃣ Customer Behaviour
Top Customers by Claim Value

SELECT customer_id, customer_name,
       SUM(claim_amount) AS total_value,
       COUNT(*) AS claim_count
FROM claims
GROUP BY customer_id, customer_name
ORDER BY total_value DESC
LIMIT 10;

Customers with Multiple Claims

SELECT customer_id, customer_name, COUNT(*) AS claim_count
FROM claims
GROUP BY customer_id, customer_name
HAVING COUNT(*) > 1;

6️⃣ Time‑Series Analysis
Claims per Month

SELECT DATE_FORMAT(claim_date, '%Y-%m') AS month,
       COUNT(*)
FROM claims
GROUP BY month;

Claims per Weekday

SELECT DAYNAME(claim_date) AS weekday,
       COUNT(*)
FROM claims
GROUP BY weekday
ORDER BY COUNT(*) DESC;

------

🎯 Key Insights
Auto claims are overwhelmingly Approved

Travel claims are consistently Pending

Pet claims are always Closed

Health claims are always Under Review

Life claims are always Cancelled

Claim amounts vary significantly by product line

Customer behaviour shows repeat claimants across several categories

🧠 Skills Demonstrated
SQL data cleaning

Table creation & schema design

Aggregation & grouping

Time‑series analysis

Index optimisation

Creating reusable views

Real‑world insurance domain logic


