USE telecom_churn_project;
SELECT * FROM churn_data;

-- 1. Description of Table Structure
DESCRIBE Churn_data; 
SELECT * FROM churn_data LIMIT 10;

-- 2. Basic Dataset Understanding
-- Total number of customers
SELECT COUNT(*) AS Total_Customers FROM churn_data;
-- Churn distribution
SELECT Churn, COUNT(*) AS Total_Customers FROM churn_data 
GROUP BY Churn;
  
-- 3. Calculate Churn Rate
SELECT 
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS churn_rate
FROM churn_data;

-- 4. Customer Demographics Analysis
-- Churn by Gender 
SELECT gender, COUNT(*) AS Tatol_Customers 
FROM Churn_Data
GROUP BY gender;
-- Churn by Sineor citizen
SELECT SeniorCitizen, COUNT(*) AS Tatol_Customers
FROM Churn_Data
GROUP BY SeniorCitizen;

-- 5. Contract Type Analysis
SELECT Contract, COUNT(*) AS Total_Customer,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)AS Churned_Customers,
ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2) AS Churned_Percentage 
FROM Churn_data
GROUP BY Contract;

-- 6. Payment Method Aalysis
SELECT PaymentMethod, COUNT(*)AS Total_Customers
FROM Churn_data
GROUP BY PaymentMethod;

SELECT PaymentMethod,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)AS Churned_Customers
FROM Churn_data
GROUP BY PaymentMethod;
 
-- 7. Revenue Analysis
-- Monthly Average Revenue
SELECT ROUND(AVG(MonthlyCharges), 2) AS Avg_Monthly_Charges
FROM Churn_data;
-- Total Company Revenue
SELECT ROUND(SUM(TotalCharges), 2) AS Total_Revenue
FROM  Churn_data;

-- 8 Tenure Analysis
SELECT AVG(Tenure)AS Tenure_Avg
FROM Churn_data;

SELECT 
CASE 
WHEN tenure < 12 THEN 'New'
WHEN tenure BETWEEN 12 AND 36 THEN 'Mid-term'
ELSE 'Loyal'
END AS tenure_group,
COUNT(*) AS customers
FROM churn_data
GROUP BY tenure_group;

-- 9 Services Analysis
SELECT 
    TechSupport,
	COUNT(*) AS Total_customers,
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)AS Churned_Customers,
	ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END)*100/COUNT(*),2)AS Churned_Percentage
FROM churn_data
GROUP BY TechSupport;

SELECT 
    OnlineSecurity,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Churn_Percentage
FROM churn_data
GROUP BY OnlineSecurity;

SELECT 
    OnlineBackup,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Churn_Percentage
FROM churn_data
GROUP BY OnlineBackup;

SELECT 
    StreamingTV,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Churn_Percentage
FROM churn_data
GROUP BY StreamingTV;

SELECT 
    StreamingMovies,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Churn_Percentage
FROM churn_data
GROUP BY StreamingMovies;

SELECT 
    InternetService,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
    ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Churn_Percentage
FROM churn_data
GROUP BY InternetService;

-- 10. High-Value Customers Who Churned
SELECT 
    customerID,
    Contract,
    InternetService,
    MonthlyCharges,
    TotalCharges
FROM churn_data
WHERE Churn = 'Yes'
ORDER BY TotalCharges DESC
LIMIT 10;

-- 11. Multi-Service Churn Percentage Table
SELECT
ROUND(SUM(CASE WHEN OnlineSecurity='Yes' AND Churn='Yes' THEN 1 ELSE 0 END)*100.0 /
SUM(CASE WHEN OnlineSecurity='Yes' THEN 1 ELSE 0 END),2) AS OnlineSecurity_Churn,

ROUND(SUM(CASE WHEN TechSupport='Yes' AND Churn='Yes' THEN 1 ELSE 0 END)*100.0 /
SUM(CASE WHEN TechSupport='Yes' THEN 1 ELSE 0 END),2) AS TechSupport_Churn,

ROUND(SUM(CASE WHEN StreamingTV='Yes' AND Churn='Yes' THEN 1 ELSE 0 END)*100.0 /
SUM(CASE WHEN StreamingTV='Yes' THEN 1 ELSE 0 END),2) AS StreamingTV_Churn,

ROUND(SUM(CASE WHEN StreamingMovies='Yes' AND Churn='Yes' THEN 1 ELSE 0 END)*100.0 /
SUM(CASE WHEN StreamingMovies='Yes' THEN 1 ELSE 0 END),2) AS StreamingMovies_Churn

FROM churn_data;
