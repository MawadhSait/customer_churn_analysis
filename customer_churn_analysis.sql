-- =========================================================
-- CUSTOMER CHURN ANALYSIS
-- Database: SQLite
-- Table: customer_churn
-- =========================================================

-- Project Workflow:
-- 1. Overall Churn
-- 2. Customer Segments
-- 3. Customer Behavior
-- 4. Customer Value
-- 5. Advanced SQL
-- 6. High-Risk Customer Analysis


-- =========================================================
-- 1. OVERALL CHURN
-- =========================================================

-- 1.1 Overall Churn Rate

SELECT
    COUNT(CASE WHEN Churn = 1 THEN CustomerID END)
        * 100.0 / COUNT(CustomerID) AS Churn_Rate
FROM customer_churn;


-- 1.2 Churned vs. Active Customers

SELECT
    CASE
        WHEN Churn = 1 THEN 'Churned'
        ELSE 'Active'
    END AS Status,
    COUNT(CustomerID) AS Customers
FROM customer_churn
GROUP BY Status
ORDER BY Customers DESC;


-- =========================================================
-- 2. CUSTOMER SEGMENTS
-- =========================================================

-- 2.1 Churn Rate by Subscription Type

SELECT
    `Subscription Type`,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY `Subscription Type`
ORDER BY Churn_Rate DESC;


-- 2.2 Churn Rate by Contract Length

SELECT
    `Contract Length`,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY `Contract Length`
ORDER BY Churn_Rate DESC;


-- 2.3 Churn Rate by Gender

SELECT
    Gender,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY Gender
ORDER BY Churn_Rate DESC;


-- 2.4 Churn Rate by Age Group

SELECT
    CASE
        WHEN Age < 30 THEN '18-29'
        WHEN Age BETWEEN 30 AND 39 THEN '30-39'
        WHEN Age BETWEEN 40 AND 49 THEN '40-49'
        WHEN Age BETWEEN 50 AND 59 THEN '50-59'
        WHEN Age BETWEEN 60 AND 65 THEN '60-65'
    END AS Age_Range,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY Age_Range
ORDER BY Age_Range;


-- =========================================================
-- 3. CUSTOMER BEHAVIOR
-- =========================================================

-- 3.1 Churn Rate by Support Calls

SELECT
    `Support Calls`,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY `Support Calls`
ORDER BY Churn_Rate DESC;


-- 3.2 Churn Rate by Payment Delay

SELECT
    `Payment Delay`,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY `Payment Delay`
ORDER BY Churn_Rate DESC
LIMIT 10;


-- 3.3 Churn Rate by Usage Frequency

SELECT
    `Usage Frequency`,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY `Usage Frequency`
ORDER BY Churn_Rate DESC
LIMIT 10;


-- 3.4 Churn Rate by Tenure

SELECT
    Tenure,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY Tenure
ORDER BY Churn_Rate DESC
LIMIT 10;


-- 3.5 Churn Rate by Last Interaction

SELECT
    `Last Interaction`,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
GROUP BY `Last Interaction`
ORDER BY `Last Interaction` DESC
LIMIT 10;


-- =========================================================
-- 4. CUSTOMER VALUE
-- =========================================================

-- 4.1 Average Total Spend by Churn Status
-- Churn = 0: Active
-- Churn = 1: Churned

SELECT
    Churn,
    AVG(`Total Spend`) AS Avg_Total_Spend
FROM customer_churn
GROUP BY Churn
ORDER BY Avg_Total_Spend DESC;


-- 4.2 Average Total Spend by Subscription Type and Churn

SELECT
    Churn,
    `Subscription Type`,
    AVG(`Total Spend`) AS Avg_Total_Spend
FROM customer_churn
GROUP BY `Subscription Type`, Churn
ORDER BY `Subscription Type`, Churn;


-- =========================================================
-- 5. ADVANCED SQL
-- =========================================================

-- 5.1 Rank Subscription Types by Churn Rate
-- Uses a CTE and RANK()

WITH Churn_Rate AS (
    SELECT
        AVG(Churn) * 100 AS Churn_Rate,
        `Subscription Type`
    FROM customer_churn
    GROUP BY `Subscription Type`
)
SELECT
    Churn_Rate,
    `Subscription Type`,
    RANK() OVER (
        ORDER BY Churn_Rate DESC
    ) AS Subscription_Rank
FROM Churn_Rate;


-- 5.2 Rank Customers by Total Spend
-- Uses RANK() and DENSE_RANK()

SELECT
    `Total Spend`,
    CustomerID,
    RANK() OVER (
        ORDER BY `Total Spend` DESC
    ) AS Spend_Rank,
    DENSE_RANK() OVER (
        ORDER BY `Total Spend` DESC
    ) AS Dense_Spend_Rank
FROM customer_churn
ORDER BY `Total Spend` DESC
LIMIT 10;


-- 5.3 Top 10 Customers by Total Spend

SELECT
    `Total Spend`,
    CustomerID
FROM customer_churn
ORDER BY `Total Spend` DESC
LIMIT 10;


-- 5.4 Compare Customer Spend with Subscription Average
-- Uses AVG() OVER()

SELECT
    CustomerID,
    `Subscription Type`,
    `Total Spend`,
    AVG(`Total Spend`) OVER (
        PARTITION BY `Subscription Type`
    ) AS Avg_Subscription_Spend
FROM customer_churn
LIMIT 10;


-- 5.5 Previous Customer Spend Using LAG()

SELECT
    CustomerID,
    `Total Spend`,
    LAG(`Total Spend`) OVER (
        ORDER BY CustomerID
    ) AS Previous_Customer_Spend
FROM customer_churn
ORDER BY CustomerID
LIMIT 10;


-- 5.6 Next Customer Spend Using LEAD()

SELECT
    CustomerID,
    `Total Spend`,
    LEAD(`Total Spend`) OVER (
        ORDER BY CustomerID
    ) AS Next_Customer_Spend
FROM customer_churn
ORDER BY CustomerID
LIMIT 10;


-- 5.7 Running Total by Subscription Type
-- Uses SUM() OVER()

SELECT
    CustomerID,
    `Subscription Type`,
    `Total Spend`,
    SUM(`Total Spend`) OVER (
        PARTITION BY `Subscription Type`
        ORDER BY CustomerID
    ) AS Running_Total
FROM customer_churn
ORDER BY `Subscription Type`, CustomerID
LIMIT 10;


-- =========================================================
-- 6. HIGH-RISK CUSTOMER ANALYSIS
-- =========================================================

-- 6.1 Customers with Frequent Support Calls
-- and Long Payment Delays

SELECT
    COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
WHERE `Support Calls` >= 5
  AND `Payment Delay` >= 21;


-- 6.2 Add Low Usage Frequency as a Third Condition

SELECT
    COUNT(*) AS Total_Customers,
    SUM(Churn) AS Churned_Customers,
    AVG(Churn) * 100 AS Churn_Rate
FROM customer_churn
WHERE `Support Calls` >= 5
  AND `Payment Delay` >= 21
  AND `Usage Frequency` <= 9;


-- 6.3 Inspect Sample High-Risk Customers

SELECT
    CustomerID,
    `Support Calls`,
    `Payment Delay`,
    `Usage Frequency`,
    `Last Interaction`,
    Churn
FROM customer_churn
WHERE `Support Calls` >= 5
  AND `Payment Delay` >= 21
  AND `Usage Frequency` <= 9
ORDER BY CustomerID
LIMIT 10;
