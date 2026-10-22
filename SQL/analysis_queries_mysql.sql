-- E-Commerce Sales Analytics | MySQL 8.0+
-- Dataset: ecommerce_orders.csv
-- Import the CSV into a table named orders before running these queries.
-- If importing manually, use DECIMAL for monetary fields and DATE for Order_Date.

-- Optional table definition (matches the included CSV columns)
CREATE TABLE IF NOT EXISTS orders (
    Order_ID VARCHAR(20) PRIMARY KEY,
    Order_Date DATE NOT NULL,
    Customer_ID VARCHAR(20) NOT NULL,
    Customer_Segment VARCHAR(50),
    City VARCHAR(100),
    State VARCHAR(100),
    Sales_Channel VARCHAR(50),
    Payment_Method VARCHAR(50),
    Product_ID VARCHAR(20),
    Product_Name VARCHAR(150),
    Category VARCHAR(100),
    Quantity INT,
    Unit_Price_INR DECIMAL(12,2),
    Discount_Pct DECIMAL(5,2),
    Revenue_INR DECIMAL(14,2),
    Unit_Cost_INR DECIMAL(12,2),
    Total_Cost_INR DECIMAL(14,2),
    Shipping_Cost_INR DECIMAL(12,2),
    Profit_INR DECIMAL(14,2)
);

-- 1. Overall KPIs
SELECT COUNT(*) AS total_orders,
       ROUND(SUM(Revenue_INR), 2) AS total_revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS total_profit_inr,
       ROUND(100.0 * SUM(Profit_INR) / NULLIF(SUM(Revenue_INR), 0), 2) AS profit_margin_pct
FROM orders;

-- 2. Monthly sales and month-over-month revenue change
WITH monthly AS (
    SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS month,
           SUM(Revenue_INR) AS revenue_inr,
           SUM(Profit_INR) AS profit_inr
    FROM orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
with_previous AS (
    SELECT month, revenue_inr, profit_inr,
           LAG(revenue_inr) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly
)
SELECT month,
       ROUND(revenue_inr, 2) AS revenue_inr,
       ROUND(profit_inr, 2) AS profit_inr,
       ROUND(100.0 * (revenue_inr - previous_month_revenue)
             / NULLIF(previous_month_revenue, 0), 2) AS revenue_mom_pct
FROM with_previous
ORDER BY month;

-- 3. Category performance
SELECT Category,
       COUNT(*) AS orders,
       SUM(Quantity) AS units_sold,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM orders
GROUP BY Category
ORDER BY revenue_inr DESC;

-- 4. Top 10 products by revenue
SELECT Product_ID, Product_Name, Category,
       SUM(Quantity) AS units_sold,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM orders
GROUP BY Product_ID, Product_Name, Category
ORDER BY revenue_inr DESC
LIMIT 10;

-- 5. State-level performance
SELECT State,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM orders
GROUP BY State
ORDER BY revenue_inr DESC;

-- 6. Repeat-customer analysis
WITH customer_orders AS (
    SELECT Customer_ID,
           COUNT(DISTINCT Order_ID) AS order_count,
           SUM(Revenue_INR) AS lifetime_revenue
    FROM orders
    GROUP BY Customer_ID
)
SELECT COUNT(*) AS unique_customers,
       SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
       ROUND(100.0 * SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END)
             / NULLIF(COUNT(*), 0), 2) AS repeat_customer_pct
FROM customer_orders;

-- 7. Loss-making products
SELECT Product_ID, Product_Name,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM orders
GROUP BY Product_ID, Product_Name
HAVING SUM(Profit_INR) < 0
ORDER BY profit_inr ASC;

-- 8. Sales-channel performance
SELECT Sales_Channel,
       COUNT(*) AS orders,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr,
       ROUND(AVG(Revenue_INR), 2) AS avg_order_value_inr
FROM orders
GROUP BY Sales_Channel
ORDER BY revenue_inr DESC;

-- 9. Monthly category breakdown
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS month,
       Category,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr
FROM orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m'), Category
ORDER BY month, revenue_inr DESC;

-- 10. Customer segment performance
SELECT Customer_Segment,
       COUNT(*) AS orders,
       COUNT(DISTINCT Customer_ID) AS unique_customers,
       ROUND(SUM(Revenue_INR), 2) AS revenue_inr,
       ROUND(SUM(Profit_INR), 2) AS profit_inr,
       ROUND(AVG(Revenue_INR), 2) AS avg_order_value_inr
FROM orders
GROUP BY Customer_Segment
ORDER BY revenue_inr DESC;
