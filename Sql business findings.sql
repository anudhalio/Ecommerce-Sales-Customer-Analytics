/*=====================================================================
  PROJECT: E-commerce Customer Behaviour & Sales Intelligence
  DATASET: UCI Online Retail (cleaned project dataset)
  DATABASE: ecommerce_analysis
  TABLE: online_retail

  Tools: MySQL 8.0 / MySQL Workbench
  Scope: Analysis is performed on the cleaned dataset imported into
         online_retail. It does not represent rows removed during cleaning.

  Table columns:
    InvoiceNo, StockCode, Description, Quantity, InvoiceDate,
    UnitPrice, CustomerID, Country, Revenue

  Before running:
    USE ecommerce_analysis;
=====================================================================*/

USE ecommerce_analysis;

/*=====================================================================
  SECTION 1 — OVERALL SALES PERFORMANCE
  Purpose: Establish the main business KPIs.
=====================================================================*/

-- Task 1: Overall sales performance
SELECT
    COUNT(DISTINCT InvoiceNo) AS Total_Orders,
    COUNT(DISTINCT CustomerID) AS Total_Customers,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(AVG(Revenue), 2) AS Average_Revenue_Per_Row
FROM online_retail;

-- Task 2: Average order value (AOV)
SELECT
    ROUND(SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 2) AS Average_Order_Value
FROM online_retail;

/*=====================================================================
  SECTION 2 — SALES TRENDS
=====================================================================*/

-- Task 3: Monthly revenue and order trend (year-month level)
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS Sales_Month,
    ROUND(SUM(Revenue), 2) AS Monthly_Revenue,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY Sales_Month;

-- Task 9: Revenue and orders by day of week
SELECT
    DAYNAME(InvoiceDate) AS Day_Name,
    DAYOFWEEK(InvoiceDate) AS Day_Number,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail
GROUP BY Day_Name, Day_Number
ORDER BY Day_Number;

-- Task 9a: Check whether Saturday transactions exist in this cleaned table
SELECT
    COUNT(*) AS Saturday_Rows,
    COUNT(DISTINCT InvoiceNo) AS Saturday_Orders,
    ROUND(SUM(Revenue), 2) AS Saturday_Revenue
FROM online_retail
WHERE DAYNAME(InvoiceDate) = 'Saturday';

-- Task 10: Orders by calendar month (December combines both years)
SELECT
    MONTHNAME(InvoiceDate) AS Month_Name,
    MONTH(InvoiceDate) AS Month_Number,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;

-- Task 11: Quarterly revenue and order trend
SELECT
    YEAR(InvoiceDate) AS Sales_Year,
    QUARTER(InvoiceDate) AS Sales_Quarter,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail
GROUP BY YEAR(InvoiceDate), QUARTER(InvoiceDate)
ORDER BY Sales_Year, Sales_Quarter;

-- Task 14: Revenue and orders by hour of day
SELECT
    HOUR(InvoiceDate) AS Sales_Hour,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders
FROM online_retail
GROUP BY HOUR(InvoiceDate)
ORDER BY Sales_Hour;

/*=====================================================================
  SECTION 3 — COUNTRY AND PRODUCT PERFORMANCE
=====================================================================*/

-- Task 4: Top 10 countries by revenue
SELECT
    Country,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders,
    COUNT(DISTINCT CustomerID) AS Total_Customers
FROM online_retail
GROUP BY Country
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Task 12: Top 10 countries and their percentage of total revenue
SELECT
    Country,
    ROUND(SUM(Revenue), 2) AS Country_Revenue,
    ROUND(
        SUM(Revenue) * 100 /
        (SELECT SUM(Revenue) FROM online_retail),
        2
    ) AS Revenue_Percentage
FROM online_retail
GROUP BY Country
ORDER BY Country_Revenue DESC
LIMIT 10;

-- Task 5: Top 10 descriptions by revenue (includes non-merchandise entries)
SELECT
    Description,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM online_retail
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Optional: Top 10 merchandise descriptions, excluding service/administrative entries
SELECT
    Description,
    SUM(Quantity) AS Total_Quantity_Sold,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM online_retail
WHERE UPPER(TRIM(Description)) NOT IN ('POSTAGE', 'MANUAL', 'BANK CHARGES')
GROUP BY Description
ORDER BY Total_Revenue DESC
LIMIT 10;

/*=====================================================================
  SECTION 4 — CUSTOMER BEHAVIOUR
=====================================================================*/

-- Task 6: Top 10 customers by revenue
SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Total_Orders,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM online_retail
GROUP BY CustomerID
ORDER BY Total_Revenue DESC
LIMIT 10;

-- Task 7: One-time and repeat customer counts
SELECT
    COUNT(*) AS Total_Customers,
    SUM(Order_Count > 1) AS Repeat_Customers,
    SUM(Order_Count = 1) AS One_Time_Customers
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS Order_Count
    FROM online_retail
    GROUP BY CustomerID
) AS Customer_Orders;

-- Task 7a: Repeat and one-time customer percentages
SELECT
    COUNT(*) AS Total_Customers,
    SUM(Order_Count > 1) AS Repeat_Customers,
    ROUND(100 * SUM(Order_Count > 1) / COUNT(*), 2) AS Repeat_Customer_Percentage,
    SUM(Order_Count = 1) AS One_Time_Customers,
    ROUND(100 * SUM(Order_Count = 1) / COUNT(*), 2) AS One_Time_Customer_Percentage
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS Order_Count
    FROM online_retail
    GROUP BY CustomerID
) AS Customer_Orders;

-- Task 8: Customer spending segments (project-defined thresholds)
-- High Value: >= £5,000; Medium Value: £1,000 to < £5,000; Low Value: < £1,000
SELECT
    Customer_Segment,
    COUNT(*) AS Number_of_Customers
FROM (
    SELECT
        CustomerID,
        CASE
            WHEN SUM(Revenue) >= 5000 THEN 'High Value'
            WHEN SUM(Revenue) >= 1000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment
    FROM online_retail
    GROUP BY CustomerID
) AS Customer_Spending
GROUP BY Customer_Segment
ORDER BY Number_of_Customers DESC;

-- Task 8a: Revenue and average spend by customer spending segment
SELECT
    Customer_Segment,
    COUNT(*) AS Number_of_Customers,
    ROUND(SUM(Customer_Revenue), 2) AS Segment_Revenue,
    ROUND(AVG(Customer_Revenue), 2) AS Average_Customer_Spend
FROM (
    SELECT
        CustomerID,
        SUM(Revenue) AS Customer_Revenue,
        CASE
            WHEN SUM(Revenue) >= 5000 THEN 'High Value'
            WHEN SUM(Revenue) >= 1000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Customer_Segment
    FROM online_retail
    GROUP BY CustomerID
) AS Customer_Spending
GROUP BY Customer_Segment
ORDER BY Segment_Revenue DESC;

-- Task 13: Customer purchase frequency categories
-- One-time: 1 order; Occasional: 2–5; Frequent: 6–10; Very Frequent: >10
SELECT
    CASE
        WHEN Order_Count = 1 THEN 'One-time'
        WHEN Order_Count BETWEEN 2 AND 5 THEN 'Occasional'
        WHEN Order_Count BETWEEN 6 AND 10 THEN 'Frequent'
        ELSE 'Very Frequent'
    END AS Purchase_Category,
    COUNT(*) AS Number_of_Customers
FROM (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS Order_Count
    FROM online_retail
    GROUP BY CustomerID
) AS Customer_Frequency
GROUP BY Purchase_Category
ORDER BY Number_of_Customers DESC;

/*=====================================================================
  SECTION 5 — RFM ANALYSIS
  Recency is measured relative to the latest InvoiceDate in this dataset,
  not today's date. Scores are quintiles (1 to 5) using NTILE(5).
=====================================================================*/

-- Task 15: Calculate Recency, Frequency and Monetary for the top 10 spenders
SELECT
    CustomerID,
    DATEDIFF(
        (SELECT MAX(InvoiceDate) FROM online_retail),
        MAX(InvoiceDate)
    ) AS Recency_Days,
    COUNT(DISTINCT InvoiceNo) AS Frequency,
    ROUND(SUM(Revenue), 2) AS Monetary
FROM online_retail
GROUP BY CustomerID
ORDER BY Monetary DESC
LIMIT 10;

-- Task 15a: RFM scores for the top 15 spenders
WITH RFM AS (
    SELECT
        CustomerID,
        DATEDIFF(
            (SELECT MAX(InvoiceDate) FROM online_retail),
            MAX(InvoiceDate)
        ) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(Revenue) AS Monetary
    FROM online_retail
    GROUP BY CustomerID
),
RFM_Scores AS (
    SELECT
        CustomerID,
        Recency,
        Frequency,
        ROUND(Monetary, 2) AS Monetary,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM
)
SELECT
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score
FROM RFM_Scores
ORDER BY Monetary DESC
LIMIT 15;

-- Task 16: Count customers in each RFM segment
WITH RFM AS (
    SELECT
        CustomerID,
        DATEDIFF(
            (SELECT MAX(InvoiceDate) FROM online_retail),
            MAX(InvoiceDate)
        ) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(Revenue) AS Monetary
    FROM online_retail
    GROUP BY CustomerID
),
RFM_Scores AS (
    SELECT
        CustomerID,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM
),
Customer_Segments AS (
    SELECT
        CustomerID,
        R_Score,
        F_Score,
        M_Score,
        CASE
            WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4
                THEN 'Champions'
            WHEN F_Score >= 4 AND M_Score >= 4
                THEN 'Loyal Customers'
            WHEN R_Score >= 4 AND F_Score BETWEEN 2 AND 3
                THEN 'Potential Loyalists'
            WHEN R_Score <= 2 AND F_Score >= 3
                THEN 'At Risk'
            ELSE 'Others'
        END AS Customer_Segment
    FROM RFM_Scores
)
SELECT
    Customer_Segment,
    COUNT(*) AS Number_of_Customers
FROM Customer_Segments
GROUP BY Customer_Segment
ORDER BY Number_of_Customers DESC;

-- Task 17: Revenue contribution and average spend by RFM segment
WITH RFM AS (
    SELECT
        CustomerID,
        DATEDIFF(
            (SELECT MAX(InvoiceDate) FROM online_retail),
            MAX(InvoiceDate)
        ) AS Recency,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        SUM(Revenue) AS Monetary
    FROM online_retail
    GROUP BY CustomerID
),
RFM_Scores AS (
    SELECT
        CustomerID,
        Monetary,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM
),
Customer_Segments AS (
    SELECT
        CustomerID,
        Monetary,
        CASE
            WHEN R_Score >= 4 AND F_Score >= 4 AND M_Score >= 4
                THEN 'Champions'
            WHEN F_Score >= 4 AND M_Score >= 4
                THEN 'Loyal Customers'
            WHEN R_Score >= 4 AND F_Score BETWEEN 2 AND 3
                THEN 'Potential Loyalists'
            WHEN R_Score <= 2 AND F_Score >= 3
                THEN 'At Risk'
            ELSE 'Others'
        END AS Customer_Segment
    FROM RFM_Scores
)
SELECT
    Customer_Segment,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(Monetary), 2) AS Total_Revenue,
    ROUND(AVG(Monetary), 2) AS Average_Customer_Revenue
FROM Customer_Segments
GROUP BY Customer_Segment
ORDER BY Total_Revenue DESC;

/*=====================================================================
  END OF PROJECT SQL ANALYSIS

  Notes / interpretation cautions:
  1. Results are based on the cleaned table loaded for this project.
  2. The hour/day/month patterns describe recorded transactions only.
  3. Calendar-month order analysis groups January across years, and
     December across years; use the year-month query for time trends.
  4. The RFM segments are based on project-defined rules and quintiles;
     they are not universal industry definitions.
  5. Check the original import warnings for UnitPrice precision before
     treating every decimal value as fully exact. The import previously
     reported 21 truncation warnings when UnitPrice was DECIMAL(10,2).
=====================================================================*/
