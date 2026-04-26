# Medical Insurance Cost Analysis

## Project Overview
Analyzed 1,338 medical insurance records to identify key cost drivers 
and high-risk customer segments using SQL and Power BI.

## Business Problem
Insurance charges vary from $1,122 to $63,770 — a 57x difference. 
What drives this gap and which patient segments are highest risk?

## Tools Used
- SQL (SQLite) — Data analysis and segmentation
- Power BI — Interactive dashboard
- Excel — Data profiling and validation

## Key Findings
- Smokers pay 3.8x more than non-smokers ($32,050 vs $8,441)
- Obese patients pay 48% more than normal weight patients
- Insurance charges double from youngest to oldest age group
- Southeast region is 20% more expensive than Southwest
- Smoker + Obese segment pays 5.2x more than lowest risk group

## Business Recommendation
Smokers with obesity represent just 11% of customers but generate 
average claims of $41,558 — 5.2x more than the lowest risk segment. 
Insurance companies should introduce targeted wellness programs and 
premium adjustments for this high-risk segment.

## Files
- `insurance.csv` — Raw dataset (Kaggle)
- `insurance_queries.sql` — 7 SQL queries with business insights
- `Medical_Insurance_Cost_Analysis_Dashboard.pdf` — Power BI dashboard
