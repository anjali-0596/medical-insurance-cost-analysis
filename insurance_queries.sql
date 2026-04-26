-- ============================================================
-- PROJECT: Medical Insurance Cost Analysis
-- Author: Anjali Yadav
-- Date: April 2026
-- Tool: SQL (SQLite)
-- Dataset: Kaggle Medical Insurance Dataset (1,338 records)
-- Goal: Identify key drivers of insurance charges and 
--       high risk customer segments
-- ============================================================


-- Query 1: Total Record Count
-- Purpose: Validate data loaded correctly
SELECT COUNT(*) FROM insurance;


-- Query 2: Charge Range and Average
-- Finding: Charges range from $1,122 to $63,770
-- Average customer pays $13,279
SELECT 
MIN(charges), 
MAX(charges), 
ROUND(AVG(charges), 2) 
FROM insurance;


-- Query 3: Smoker vs Non-Smoker Charges
-- Finding: Smokers pay 3.8x more ($32,050 vs $8,441)
-- BIGGEST cost driver in the dataset
SELECT smoker, ROUND(AVG(charges), 2) 
FROM insurance 
GROUP BY smoker;


-- Query 4: BMI Impact on Charges
-- Finding: Obese patients pay 48% more than normal weight
-- Second biggest cost driver after smoking
SELECT 
CASE 
WHEN CAST(bmi AS REAL) < 18.5 THEN 'Underweight' 
WHEN CAST(bmi AS REAL) BETWEEN 18.5 AND 24.9 THEN 'Normal' 
WHEN CAST(bmi AS REAL) BETWEEN 25 AND 29.9 THEN 'Overweight' 
WHEN CAST(bmi AS REAL) >= 30 THEN 'Obese' 
ELSE 'Unknown' 
END AS bmi_category, 
ROUND(AVG(CAST(charges AS REAL)), 2) AS avg_charge, 
COUNT(*) AS total_customers 
FROM insurance 
GROUP BY bmi_category;


-- Query 5: Age Group Impact on Charges
-- Finding: Charges double from youngest to oldest age group
-- 18-25 pays $9,111 vs 56+ pays $18,796
SELECT 
CASE 
WHEN CAST(age AS INT) BETWEEN 18 AND 25 THEN '18-25' 
WHEN CAST(age AS INT) BETWEEN 26 AND 35 THEN '26-35' 
WHEN CAST(age AS INT) BETWEEN 36 AND 45 THEN '36-45' 
WHEN CAST(age AS INT) BETWEEN 46 AND 55 THEN '46-55' 
ELSE '56+' 
END AS age_group, 
ROUND(AVG(charges), 2) AS avg_charge, 
COUNT(*) AS total_customers 
FROM insurance 
GROUP BY age_group;


-- Query 6: Regional Analysis
-- Finding: Southeast is most expensive region at $14,745
-- Southwest is cheapest at $12,347 -- 20% difference
SELECT 
region, 
ROUND(AVG(charges), 2) AS avg_charge, 
COUNT(*) AS total_customers,
ROUND(MIN(charges), 2) AS min_charge,
ROUND(MAX(charges), 2) AS max_charge
FROM insurance 
GROUP BY region;


-- Query 7: Combined Risk Segmentation (STAR QUERY)
-- Finding: Smoker + Obese segment pays 5.2x more than lowest risk
-- Just 11% of customers but highest cost impact
SELECT 
CASE 
WHEN smoker = 'yes' AND CAST(bmi AS REAL) >= 30 THEN 'Smoker + Obese'
WHEN smoker = 'yes' AND CAST(bmi AS REAL) < 30 THEN 'Smoker + Normal BMI'
WHEN smoker = 'no' AND CAST(bmi AS REAL) >= 30 THEN 'Non-Smoker + Obese'
ELSE 'Non-Smoker + Normal BMI'
END AS risk_segment,
ROUND(AVG(charges), 2) AS avg_charge,
COUNT(*) AS total_customers
FROM insurance
GROUP BY risk_segment
ORDER BY avg_charge DESC;