"""
ApexPlanet Software Pvt. Ltd. — Data Analytics Internship
Task 1: Data Immersion & Wrangling
Step 3: Data Cleaning & Transformation Pipeline

Author: Data Analytics Intern
Dataset: ApexPlanet_DataAnalytics_Dataset.xlsx (Sales_Dataset sheet)
"""

import pandas as pd
import numpy as np

# ---------------------------------------------------------------------------
# 1. LOAD DATASET
# ---------------------------------------------------------------------------
RAW_PATH = "/mnt/user-data/uploads/ApexPlanet_DataAnalytics_Dataset.xlsx"
df = pd.read_excel(RAW_PATH, sheet_name="Sales_Dataset")
print(f"Rows loaded: {df.shape[0]}, Columns loaded: {df.shape[1]}")

# ---------------------------------------------------------------------------
# 2. HANDLE MISSING VALUES
# ---------------------------------------------------------------------------
# Age (numeric, ~2% missing): median imputation preserves the distribution
# without being pulled by outliers the way a mean would be.
missing_age_before = df["Age"].isnull().sum()
df["Age"] = df["Age"].fillna(df["Age"].median())

# City (categorical, ~1.3% missing): explicit "Unknown" label rather than
# mode imputation — inventing a city would fabricate geographic signal
# that isn't in the source data.
missing_city_before = df["City"].isnull().sum()
df["City"] = df["City"].fillna("Unknown")

print(f"Age nulls filled: {missing_age_before} -> {df['Age'].isnull().sum()}")
print(f"City nulls filled: {missing_city_before} -> {df['City'].isnull().sum()}")

# ---------------------------------------------------------------------------
# 3. HANDLE DUPLICATES
# ---------------------------------------------------------------------------
# a) Full-row duplicates — safe to drop outright.
full_dupes = df.duplicated().sum()
df = df.drop_duplicates()

# b) Order_ID duplicates with different transaction details (e.g. ORD100050
#    appears 9 times attached to different customers/products/dates). These
#    are NOT the same transaction re-entered — dropping them would silently
#    delete real sales. They are a broken primary key. Fix: reassign a
#    guaranteed-unique surrogate ID and flag the affected rows for the
#    source-system owner instead of destroying the records.
dupe_id_mask = df["Order_ID"].duplicated(keep=False)
n_dupe_id_rows = dupe_id_mask.sum()

df = df.reset_index(drop=True)
df["Order_ID_Original"] = df["Order_ID"]
df["Order_ID_Flag"] = np.where(dupe_id_mask, "Duplicate_ID_Reassigned", "OK")
df.loc[dupe_id_mask, "Order_ID"] = [
    f"{oid}-{i+1:02d}" for i, oid in enumerate(df.loc[dupe_id_mask, "Order_ID"])
]

print(f"Full-row duplicates dropped: {full_dupes}")
print(f"Order_ID collisions repaired (surrogate suffix applied): {n_dupe_id_rows}")

# ---------------------------------------------------------------------------
# 4. STANDARDIZE Order_Date TO DATETIME
# ---------------------------------------------------------------------------
df["Order_Date"] = pd.to_datetime(df["Order_Date"], format="%Y-%m-%d", errors="coerce")
unparseable_dates = df["Order_Date"].isnull().sum()
print(f"Order_Date converted to datetime64. Unparseable dates: {unparseable_dates}")

# ---------------------------------------------------------------------------
# 5. FEATURE ENGINEERING
# ---------------------------------------------------------------------------
# Time-based features for trend/seasonality analysis
df["Order_Year"] = df["Order_Date"].dt.year
df["Order_Month"] = df["Order_Date"].dt.month
df["Order_Month_Name"] = df["Order_Date"].dt.month_name()

# Age_Group banding for demographic segmentation
age_bins = [17, 25, 35, 45, 55, 65]
age_labels = ["18-25", "26-35", "36-45", "46-55", "56-65"]
df["Age_Group"] = pd.cut(df["Age"], bins=age_bins, labels=age_labels, include_lowest=True)

# Revenue-per-unit sanity metric (useful QA + analysis field)
df["Avg_Price_Check"] = (df["Total_Sales"] / df["Quantity"]).round(2)

print("Engineered columns added: Order_Year, Order_Month, Order_Month_Name, "
      "Age_Group, Avg_Price_Check")

# ---------------------------------------------------------------------------
# 6. EXPORT ANALYSIS-READY DATASET
# ---------------------------------------------------------------------------
OUTPUT_PATH = "/home/claude/work/cleaned_sales_dataset.csv"
df.to_csv(OUTPUT_PATH, index=False)
print(f"Cleaned dataset exported to: {OUTPUT_PATH}")
print(f"Final shape: {df.shape}")
