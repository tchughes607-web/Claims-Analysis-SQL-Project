-- Claimsdata queries

CREATE TABLE claims (
    claim_id VARCHAR(10) PRIMARY KEY,
    policy_id VARCHAR(10) NOT NULL,
    incident_date DATE NOT NULL,
    report_date DATE NOT NULL,
    settlement_date DATE NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    fault ENUM('Yes','No') NOT NULL,
    claim_status ENUM('Open','Investigating','Settled') NOT NULL,
    region VARCHAR(20) NOT NULL,
    estimated_loss DECIMAL(10,2) NOT NULL,
    settlement_amount DECIMAL(10,2) NULL,
    INDEX idx_region (region),
    INDEX idx_vehicle_type (vehicle_type),
    INDEX idx_claim_status (claim_status),
    INDEX idx_incident_date (incident_date)
);

DROP TABLE claimsdata;

-- Basic Data Checks 

-- Row Count 

SELECT COUNT(*) AS total_claims
FROM claims;

-- Distinct Customers

SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM claims;

-- Date Range 

SELECT MIN(claim_date) AS first_claim,
		MAX(claim_date) AS last_claim
	FROM claims;

-- Claim Frequency Analysis 

-- Claims by Age Group 

SELECT `Age Group`,
	COUNT(*) AS total_claims
FROM claims
GROUP BY `Age Group`
ORDER BY total_claims DESC;

-- Claims by Gender

SELECT gender,
       COUNT(*) AS total_claims
FROM claims
GROUP BY gender;

-- Claims by City 

SELECT city,
       COUNT(*) AS total_claims
FROM claims
GROUP BY city
ORDER BY total_claims DESC;

-- Claims by Claim Type

SELECT claim_type,
       COUNT(*) AS total_claims
FROM claims
GROUP BY claim_type
ORDER BY total_claims DESC;

-- Financial Analysis 

-- Average claim amount by claim type

SELECT claim_type,
       ROUND(AVG(claim_amount), 2) AS avg_claim_amount
FROM claims
GROUP BY claim_type
ORDER BY avg_claim_amount DESC;

-- Average claim amount by city

SELECT city,
       ROUND(AVG(claim_amount), 2) AS avg_claim_amount
FROM claims
GROUP BY city
ORDER BY avg_claim_amount DESC;

--  Total claim value by month

SELECT DATE_FORMAT(claim_date, '%Y-%m') AS claim_month,
       SUM(claim_amount) AS total_claim_value
FROM claims
GROUP BY claim_month
ORDER BY claim_month;

-- Status & Operational Analysis

-- Claims by status

SELECT status,
       COUNT(*) AS total_claims
FROM claims
GROUP BY status;

-- Status by claim type

SELECT claim_type,
       status,
       COUNT(*) AS total_claims
FROM claims
GROUP BY claim_type, status
ORDER BY claim_type, status;

-- fix blank value 

UPDATE claims
SET status = 'Approved'
WHERE claim_type = 'Auto'
  AND (status = '' OR status IS NULL);

-- Status by city

SELECT city,
       status,
       COUNT(*) AS total_claims
FROM claims
GROUP BY city, status
ORDER BY city, status;

-- Customer Behaviour Analysis

-- Top customers by total claim amount

SELECT customer_id,
       customer_name,
       SUM(claim_amount) AS total_claim_value,
       COUNT(*) AS claim_count
FROM claims
GROUP BY customer_id, customer_name
ORDER BY total_claim_value DESC
LIMIT 10;

-- Customers with multiple claims

SELECT customer_id,
       customer_name,
       COUNT(*) AS claim_count
FROM claims
GROUP BY customer_id, customer_name
HAVING COUNT(*) > 1
ORDER BY claim_count DESC;

-- Time Series Analysis

-- Claims per month

SELECT DATE_FORMAT(claim_date, '%Y-%m') AS claim_month,
       COUNT(*) AS total_claims
FROM claims
GROUP BY claim_month
ORDER BY claim_month;

-- Claims per weekday

SELECT DAYNAME(claim_date) AS weekday,
       COUNT(*) AS total_claims
FROM claims
GROUP BY weekday
ORDER BY total_claims DESC;




