"""E-Commerce Sales Analytics"""

from pathlib import Path
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

DATA_PATH = Path(__file__).with_name("ecommerce_orders.csv")
OUTPUT_DIR = Path(__file__).with_name("outputs")
OUTPUT_DIR.mkdir(exist_ok=True)

df = pd.read_csv(DATA_PATH, parse_dates=["Order_Date"])

# Basic quality checks
print("Rows, columns:", df.shape)
print("Missing values:\n", df.isna().sum())
print("Duplicate Order_IDs:", df["Order_ID"].duplicated().sum())

# Core KPIs
total_revenue = df["Revenue_INR"].sum()
total_profit = df["Profit_INR"].sum()
total_orders = df["Order_ID"].nunique()
profit_margin = (total_profit / total_revenue * 100) if total_revenue else 0
print(f"Total orders: {total_orders:,}")
print(f"Revenue (INR): {total_revenue:,.2f}")
print(f"Profit (INR): {total_profit:,.2f}")
print(f"Profit margin: {profit_margin:.2f}%")

# Monthly trend
df["Month"] = df["Order_Date"].dt.to_period("M").astype(str)
monthly = df.groupby("Month", as_index=False).agg(
    Revenue_INR=("Revenue_INR", "sum"),
    Profit_INR=("Profit_INR", "sum"),
    Orders=("Order_ID", "nunique")
)
monthly.to_csv(OUTPUT_DIR / "monthly_trends.csv", index=False)

sns.set_theme()
plt.figure(figsize=(12, 6))
sns.lineplot(data=monthly, x="Month", y="Revenue_INR", marker="o")
plt.xticks(rotation=60, ha="right")
plt.title("Monthly Revenue Trend")
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "monthly_revenue.png", dpi=160)
plt.close()

# Category and product performance
category = df.groupby("Category", as_index=False).agg(
    Revenue_INR=("Revenue_INR", "sum"),
    Profit_INR=("Profit_INR", "sum"),
    Units_Sold=("Quantity", "sum")
).sort_values("Revenue_INR", ascending=False)
category.to_csv(OUTPUT_DIR / "category_performance.csv", index=False)

plt.figure(figsize=(9, 5))
sns.barplot(data=category, x="Revenue_INR", y="Category")
plt.title("Revenue by Category")
plt.tight_layout()
plt.savefig(OUTPUT_DIR / "revenue_by_category.png", dpi=160)
plt.close()

products = df.groupby(["Product_ID", "Product_Name", "Category"], as_index=False).agg(
    Revenue_INR=("Revenue_INR", "sum"),
    Profit_INR=("Profit_INR", "sum"),
    Units_Sold=("Quantity", "sum")
).sort_values("Revenue_INR", ascending=False)
products.to_csv(OUTPUT_DIR / "product_performance.csv", index=False)

# Customer repeat rate
customer = df.groupby("Customer_ID").agg(
    Orders=("Order_ID", "nunique"),
    Lifetime_Revenue=("Revenue_INR", "sum")
)
repeat_rate = (customer["Orders"].gt(1).mean() * 100) if len(customer) else 0
print(f"Unique customers: {len(customer):,}")
print(f"Repeat customer rate: {repeat_rate:.2f}%")
print("\nTop 5 products by revenue:\n", products.head(5).to_string(index=False))
print("\nCategory performance:\n", category.to_string(index=False))
print(f"\nAnalysis outputs saved to: {OUTPUT_DIR}")
