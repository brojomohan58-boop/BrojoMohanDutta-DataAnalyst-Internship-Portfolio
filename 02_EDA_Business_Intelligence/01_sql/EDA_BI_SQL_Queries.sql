-- ============================================================
-- ApexPlanet Software Pvt. Ltd.
-- Data Analytics Internship
-- Task 2: Exploratory Data Analysis & Business Intelligence
--
-- Project: ApexPlanet Sales Dataset Analysis
-- Prepared By: Brojo Mohan Dutta
-- Database: BigQuery Standard SQL
-- Dataset: aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset
-- ============================================================


-- ============================================================
-- Query 1: Monthly Revenue Trend
-- Business Question:
-- How does revenue trend month over month and year over year?
-- ============================================================

WITH monthly_sales AS (
    SELECT
        EXTRACT(YEAR FROM Order_Date) AS Order_Year,
        EXTRACT(MONTH FROM Order_Date) AS Order_Month,
        DATE_TRUNC(Order_Date, MONTH) AS Sales_Month,
        SUM(Total_Sales) AS Total_Revenue,
        COUNT(DISTINCT Order_ID) AS Total_Orders
    FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`
    GROUP BY Order_Year, Order_Month, Sales_Month
)

SELECT
    Order_Year,
    Order_Month,
    FORMAT_DATE('%B %Y', Sales_Month) AS Month_Label,
    ROUND(Total_Revenue,2) AS Total_Revenue,
    Total_Orders,
    ROUND(Total_Revenue / Total_Orders,2) AS Avg_Order_Value
FROM monthly_sales
ORDER BY Order_Year, Order_Month;



-- ============================================================
-- Query 2: Top 10 Best-Selling Products
-- Business Question:
-- Which products generate the most revenue?
-- ============================================================

SELECT
    Product,
    Category,
    ROUND(SUM(Total_Sales),2) AS Total_Revenue,
    SUM(Quantity) AS Units_Sold,
    COUNT(DISTINCT Order_ID) AS Order_Count,
    ROUND(SUM(Total_Sales)/COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value
FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`
GROUP BY Product, Category
ORDER BY Total_Revenue DESC
LIMIT 10;



-- ============================================================
-- Query 3: Category Performance Overview
-- Business Question:
-- Which product categories perform best?
-- ============================================================

WITH category_summary AS (

    SELECT
        Category,
        SUM(Total_Sales) AS Total_Revenue,
        SUM(Quantity) AS Units_Sold,
        COUNT(DISTINCT Order_ID) AS Order_Count,
        ROUND(AVG(Unit_Price),2) AS Avg_Unit_Price
    FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`
    GROUP BY Category

)

SELECT
    Category,
    ROUND(Total_Revenue,2) AS Total_Revenue,
    Units_Sold,
    Order_Count,
    Avg_Unit_Price,
    ROUND(Total_Revenue / SUM(Total_Revenue) OVER (),4) AS Pct_Of_Total_Revenue
FROM category_summary
ORDER BY Total_Revenue DESC;



-- ============================================================
-- Query 4: City-wise Sales Performance
-- Business Question:
-- Which cities generate the highest revenue?
-- ============================================================

SELECT

    City,
    ROUND(SUM(Total_Sales),2) AS Total_Revenue,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Unique_Customers,
    ROUND(SUM(Total_Sales)/COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value

FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`

GROUP BY City

ORDER BY Total_Revenue DESC;



-- ============================================================
-- Query 5: Customer Demographics
-- Business Question:
-- How does purchasing behaviour differ by age group and gender?
-- ============================================================

WITH demographics AS (

SELECT

CASE
WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
WHEN Age BETWEEN 56 AND 65 THEN '56-65'
ELSE 'Other'
END AS Age_Group,

Gender,
Order_ID,
Total_Sales

FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`

)

SELECT

Age_Group,
Gender,
ROUND(SUM(Total_Sales),2) AS Total_Revenue,
COUNT(DISTINCT Order_ID) AS Order_Count,
ROUND(SUM(Total_Sales)/COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value

FROM demographics

GROUP BY Age_Group, Gender

ORDER BY Age_Group, Gender;



-- ============================================================
-- Query 6: High-Value & Repeat Customers
-- Business Question:
-- Who are the highest-value customers?
-- ============================================================

WITH customer_summary AS (

SELECT

Customer_ID,
Customer_Name,
COUNT(DISTINCT Order_ID) AS Order_Count,
SUM(Total_Sales) AS Total_Spend,
ROUND(SUM(Total_Sales)/COUNT(DISTINCT Order_ID),2) AS Avg_Order_Value

FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`

GROUP BY Customer_ID, Customer_Name

)

SELECT

Customer_ID,
Customer_Name,
Order_Count,
Total_Spend,
Avg_Order_Value,

CASE
WHEN Order_Count > 1 THEN 'Repeat Customer'
ELSE 'One-Time Customer'
END AS Customer_Type

FROM customer_summary

ORDER BY Total_Spend DESC

LIMIT 10;



-- ============================================================
-- Query 7: Month-over-Month Category Growth
-- Business Question:
-- Which categories are growing month over month?
-- ============================================================

WITH monthly_category_sales AS (

SELECT

Category,
DATE_TRUNC(Order_Date, MONTH) AS Sales_Month,
SUM(Total_Sales) AS Monthly_Revenue

FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`

GROUP BY Category, Sales_Month

),

growth AS (

SELECT

Category,
Sales_Month,
Monthly_Revenue,

LAG(Monthly_Revenue)
OVER(PARTITION BY Category ORDER BY Sales_Month)
AS Prev_Month_Revenue

FROM monthly_category_sales

)

SELECT

Category,
FORMAT_DATE('%B %Y', Sales_Month) AS Month_Label,
ROUND(Monthly_Revenue,2) AS Monthly_Revenue,
ROUND(Prev_Month_Revenue,2) AS Prev_Month_Revenue,

ROUND(
SAFE_DIVIDE(
Monthly_Revenue-Prev_Month_Revenue,
Prev_Month_Revenue
)*100,2) AS MoM_Growth_Pct

FROM growth

ORDER BY Category, Sales_Month;



-- ============================================================
-- Export Query for Python EDA
-- Analysis-ready dataset
-- ============================================================

SELECT

Order_ID,
Order_Date,
Customer_ID,
Customer_Name,
Age,

CASE
WHEN Age BETWEEN 18 AND 25 THEN '18-25'
WHEN Age BETWEEN 26 AND 35 THEN '26-35'
WHEN Age BETWEEN 36 AND 45 THEN '36-45'
WHEN Age BETWEEN 46 AND 55 THEN '46-55'
WHEN Age BETWEEN 56 AND 65 THEN '56-65'
ELSE 'Other'
END AS Age_Group,

Gender,
City,
Product,
Category,
Quantity,
Unit_Price,
Total_Sales,

EXTRACT(YEAR FROM Order_Date) AS Order_Year,
EXTRACT(MONTH FROM Order_Date) AS Order_Month,
FORMAT_DATE('%B', Order_Date) AS Order_Month_Name

FROM `aesthetic-fiber-504115-v4.apexplanet_sales_analysis.cleaned_sales_dataset`

ORDER BY Order_Date;