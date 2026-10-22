# E-Commerce Data Analytics Project

## Project Overview

This project analyzes e-commerce order data to understand sales performance, profitability, product performance, and regional trends. It uses MySQL, Python, Excel, and Power BI to explore the data and present insights through dashboards.

## Project Objectives

* Analyze total sales, profit, orders, and profit margin.
* Identify top-performing products and product categories.
* Analyze revenue and profit across states.
* Understand monthly revenue trends.
* Compare performance across sales channels.
* Build interactive dashboards for business reporting.

## Tools & Technologies

* **MySQL:** Data storage, SQL queries, and business analysis.
* **Python:** Data inspection, cleaning checks, calculations, and output generation using Pandas, NumPy, and Matplotlib.
* **Microsoft Excel:** PivotTables, PivotCharts, KPI cards, and interactive slicers.
* **Power BI:** Interactive dashboard and business performance visualization.

## Dataset

The project uses `ecommerce_orders.csv`, containing 1,500 records.

The dataset is used to analyze order information, revenue, costs, profit, products, locations, dates, and sales channels, based on the available columns.

## Key Performance Indicators (KPIs)

* Total Sales / Revenue
* Total Profit
* Total Orders
* Profit Margin

## Analysis Performed

## 📈 Key Findings

* **Total Revenue:** ₹5.38M (₹53.8 lakh)
* **Total Profit:** ₹1.83M (₹18.3 lakh)
* **Total Orders:** 1,500
* **Profit Margin:** 33.9%
* **Top State by Revenue:** Madhya Pradesh
* **Top Product:** Office Chair

### Business Insights

* The dataset contains 1,500 orders with total revenue of ₹53.8 lakh.
* Total profit is ₹18.3 lakh, with a reported profit margin of 33.9%.
* Madhya Pradesh is the leading state by revenue in this analysis.
* Office Chair is the top-performing product based on the analysis.

These findings can help identify strong-performing regions and products and support data-driven business decisions.

### SQL

* Business KPI calculations
* Top 10 products analysis
* State-wise revenue analysis
* State-wise profit analysis
* Additional sales and profitability queries

### Python

* Dataset dimensions and data inspection
* Missing-value checks
* Duplicate order ID checks
* Revenue and profit calculations
* Output generation for analysis

### Excel

* Interactive sales and profit dashboard
* KPI cards
* Monthly revenue trend
* State-wise revenue and profit
* Product and sales-channel analysis
* Slicers for interactive filtering

### Power BI

* Interactive dashboard for sales and profitability analysis.
* KPI cards for Total Sales, Total Profit, Total Orders, and Profit Margin.
* DAX measures for business calculations and KPI reporting.
* Interactive slicers for filtering dashboard visuals.
* Product, regional, and monthly performance analysis.

## DAX Measures (Power BI)

### 1. Total Sales

Total Sales = SUM(ecommerce_orders[Revenue_INR])

### 2. Total Profit

Total Profit =SUM(ecommerce_orders[Profit_INR])

### 3. Total Orders

Total Orders = DISTINCTCOUNT(ecommerce_orders[Order_ID])

### 4. Profit Margin

Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)


## Project Structure

E-Commerce-Data-Analytics/
├── Dataset/
│   └── ecommerce_orders.csv
├── SQL/
│   ├── create_tables.sql
│   └── analysis_queries_mysql.sql
├── Python/
│   ├── sales_analysis.py
│   └── outputs/
├── Excel/
│   └── excel_analysis.xlsx
├── PowerBI/
│   └── ecommerce_dashboard.pbix
└── README.md


## Project Outcomes

This project demonstrates the use of SQL, Python, Excel, and Power BI to analyze e-commerce data and communicate business performance through reports and interactive dashboards.

## Author

Shubham Ku. kushwaha
Aspiring Data Analyst

* GitHub: https://github.com/shubhamkushwaha24
* Skills: MySQL, Python, Microsoft Excel, Power BI

Dashboard Preview

Power BI Dashboard

<img width="981" height="547" alt="PowerBI_dashboard" src="https://github.com/user-attachments/assets/c1ef41a5-cb78-4b50-99eb-cc452dd9e1e7" />


Excel Dashboard

<img width="966" height="557" alt="Excel_dashboard" src="https://github.com/user-attachments/assets/6832c268-c6d1-482f-b8f3-020b16c13f59" />




