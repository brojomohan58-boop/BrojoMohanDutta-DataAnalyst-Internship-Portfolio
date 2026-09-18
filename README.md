# Brojo Mohan Dutta — Data Analyst Internship Portfolio

<p align="center">
  <strong>60-Day Data Analytics Internship | ApexPlanet Software Pvt. Ltd.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-Data%20Analysis-blue?logo=python&logoColor=white" alt="Python">
  <img src="https://img.shields.io/badge/SQL-BigQuery-orange?logo=googlecloud&logoColor=white" alt="SQL">
  <img src="https://img.shields.io/badge/Power%20BI-Business%20Intelligence-yellow?logo=powerbi&logoColor=black" alt="Power BI">
  <img src="https://img.shields.io/badge/Pandas-Data%20Wrangling-150458?logo=pandas&logoColor=white" alt="Pandas">
  <img src="https://img.shields.io/badge/Statistics-Hypothesis%20Testing-purple" alt="Statistics">
</p>

---

## 📌 About This Portfolio

This repository is the **master portfolio and final capstone integration** of my 60-day Data Analytics Internship at **ApexPlanet Software Pvt. Ltd.** It documents an end-to-end analytics workflow covering data wrangling, SQL-based business intelligence, Python EDA, RFM customer segmentation, Power BI dashboarding, statistical validation, and executive storytelling.

The project analyzes **1,000 sales transactions representing approximately ₹139.4M in revenue**, transforming raw transactional data into structured analysis, customer insights, interactive dashboards, and statistically validated findings.

---

## 📊 Project Snapshot

| Metric | Details |
|---|---:|
| **Transactions Analyzed** | 1,000 |
| **Revenue Analyzed** | ₹139.4M |
| **Unique Customers** | 947 |
| **RFM Segments** | 6 |
| **Primary Language** | Python |
| **SQL Engine** | Google BigQuery |
| **BI Platform** | Microsoft Power BI |
| **Statistical Methods** | Independent T-Test, Chi-Square |
| **Visualization** | Power BI, Matplotlib, Seaborn |
| **Internship Duration** | 60 Days |

---

## 📑 Table of Contents

- [About This Portfolio](#-about-this-portfolio)
- [Project Snapshot](#-project-snapshot)
- [Internship Task Breakdown](#-internship-task-breakdown)
- [End-to-End Workflow](#-end-to-end-workflow)
- [Final Deliverables](#-final-deliverables)
- [Technical Skills Demonstrated](#-technical-skills-demonstrated)
- [Key Analytical Areas](#-key-analytical-areas)
- [Key Learnings & Professional Reflection](#-key-learnings--professional-reflection)
- [Repository Structure](#-repository-structure)
- [Author](#-author)

---

# 🚀 Internship Task Breakdown

The internship followed a progressive analytical workflow, with each task building upon the outputs of the previous stage.

---

## 01 — Data Immersion & Wrangling

**Focus:** Data quality assessment, cleaning, transformation, and analytical readiness.

**Tools:** Python · Pandas · NumPy · Jupyter Notebook

### Key Activities

- Loaded and profiled the source sales dataset
- Assessed dataset structure and data types
- Identified missing values and duplicate records
- Validated `Order_ID` uniqueness
- Standardized date formats
- Applied appropriate missing-value treatment
- Addressed duplicate identifier collisions while preserving transactions
- Engineered analytical fields
- Exported the cleaned analysis-ready dataset

### Main Outputs

- Raw sales dataset
- Cleaned sales dataset
- Data wrangling notebook
- Python cleaning script
- Technical data-wrangling report

🔗 **[View Task 1 Repository]()**

---

## 02 — Exploratory Data Analysis & Business Intelligence

**Focus:** Business-question-driven analysis using SQL and Python.

**Tools:** Google BigQuery · SQL · Python · Pandas · Matplotlib · Seaborn

### Key Activities

- Developed SQL queries to answer business questions
- Analyzed monthly and yearly revenue trends
- Identified top-performing products
- Evaluated category performance and revenue contribution
- Analyzed city-level sales performance
- Examined purchasing behavior across age groups and gender
- Identified high-value and repeat customers
- Calculated month-over-month category growth
- Performed multivariate exploratory analysis
- Created analytical visualizations
- Developed a static executive dashboard mock-up

### Main Outputs

- BigQuery SQL business-question queries
- SQL analysis report
- Python EDA notebook
- Python EDA script
- Analytical visualization collection
- Static dashboard mock-up
- Python analysis dataset

🔗 **[View Task 2 Repository]()**

---

## 03 — Deep-Dive Analysis & Interactive Dashboarding

**Focus:** Customer intelligence, RFM segmentation, and interactive business intelligence.

**Tools:** BigQuery · SQL · Power BI · DAX

### Key Activities

- Constructed customer-level RFM analysis
- Calculated:
  - Recency
  - Frequency
  - Monetary Value
- Applied quartile-based RFM scoring
- Developed customer segmentation rules
- Created six customer segments:
  - Champions
  - Loyal Customers
  - Potential Loyalist
  - New / Recent
  - At Risk
  - Lost
- Built an interactive Power BI reporting suite
- Developed an Executive Overview dashboard
- Developed a Customer Segmentation Deep-Dive dashboard
- Implemented DAX-based KPIs and analytical measures
- Added interactive slicers
- Implemented customer-level drill-through analysis
- Reconciled RFM monetary values with the transactional dataset

### Main Outputs

- Customer-level RFM dataset
- RFM analysis
- Power BI `.pbix` report
- Executive Overview dashboard
- Customer Segmentation dashboard
- RFM & Power BI documentation

🔗 **[View Task 3 Repository]()**

---

## 04 — Statistical Validation & Storytelling

**Focus:** Statistical inference, hypothesis testing, and analytical communication.

**Tools:** Python · Pandas · SciPy · Matplotlib · Seaborn

### Key Activities

- Performed statistical input validation
- Tested gender-based spending differences using an independent t-test
- Tested Age Group × Category independence using a Chi-Square test
- Evaluated results at a significance level of α = 0.05
- Calculated confidence intervals
- Evaluated effect size using Cramér's V
- Created statistical visualizations
- Consolidated statistical findings
- Integrated statistical results into the final analytical narrative

### Main Outputs

- Statistical analysis notebook
- Python statistical analysis script
- Hypothesis-testing visualizations
- Statistical analysis report
- Final analytical narrative

🔗 **[View Task 4 Repository]()**

---

# 🔄 End-to-End Workflow

```text
                    RAW SALES DATA
                          │
                          ▼
             ┌────────────────────────┐
             │ 01. DATA WRANGLING     │
             │ Python + Pandas        │
             │ Cleaning & Validation  │
             │ Transformation         │
             └───────────┬────────────┘
                         │
                         ▼
                  CLEANED DATASET
                         │
                         ▼
             ┌────────────────────────┐
             │ 02. EDA & BI           │
             │ BigQuery + SQL         │
             │ Python EDA             │
             │ Business Questions     │
             └───────────┬────────────┘
                         │
              ┌──────────┴──────────┐
              ▼                     ▼
       BUSINESS INSIGHTS       EDA VISUALS
              │                     │
              └──────────┬──────────┘
                         ▼
             ┌────────────────────────┐
             │ 03. CUSTOMER ANALYSIS  │
             │ RFM Segmentation       │
             │ Power BI + DAX         │
             └───────────┬────────────┘
                         │
                         ▼
              INTERACTIVE DASHBOARD
                         │
                         ▼
             ┌────────────────────────┐
             │ 04. STATISTICAL        │
             │ VALIDATION              │
             │ T-Test + Chi-Square    │
             └───────────┬────────────┘
                         │
                         ▼
             ┌────────────────────────┐
             │ FINAL STORYTELLING     │
             │ Presentation + Report  │
             └───────────┬────────────┘
                         │
                         ▼
                BUSINESS INSIGHTS
