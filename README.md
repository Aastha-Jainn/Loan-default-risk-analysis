# 💰 Loan Default Risk Analysis

## 📌 Project Overview

This project analyzes **loan borrower data to identify the key factors associated with loan defaults** and understand borrower risk patterns.

The analysis combines **SQL for data cleaning, transformation, and exploratory analysis** with **Power BI for interactive visualization and dashboard development**.

The objective is to help identify **high-risk borrower segments**, understand default patterns, and provide data-driven insights that could support better lending and risk-management decisions.

---

## 🎯 Business Objectives

The project aims to answer questions such as:

* What is the overall loan default rate?
* How does **credit score** affect default probability?
* Does a higher **Debt-to-Income (DTI) ratio** indicate greater default risk?
* How does **loan amount relative to income** affect defaults?
* Which **loan purposes** have the highest default rates?
* How does employment status influence loan performance?
* Does home ownership status have an impact on defaults?
* How does borrower age affect default risk?
* Which combinations of borrower characteristics represent the highest-risk segments?
* How do default rates change over time?

---

## 🗂️ Dataset

The dataset contains information about borrowers, their financial profiles, loan characteristics, and loan outcomes.

### Key Variables

| Category              | Variables                                       |
| --------------------- | ----------------------------------------------- |
| Borrower Information  | Age, Employment Status, Education, Dependents   |
| Financial Information | Annual Income, Existing Monthly Debt, DTI Ratio |
| Credit Information    | Credit Score                                    |
| Loan Information      | Loan Amount, Loan Purpose, Interest Rate, Term  |
| Loan Performance      | Loan Status, Defaulted, Days Delinquent         |
| Ownership             | Home Ownership                                  |
| Date Information      | Application Date                                |
| Derived Metrics       | Loan-to-Income Ratio, Risk Score                |

---

## 🛠️ Tools & Technologies

* **SQL / MySQL** – Data cleaning, transformation and analysis
* **Power BI** – Interactive dashboard and data visualization
* **DAX** – Measures and calculated metrics
* **Excel / CSV** – Initial dataset and data preparation
* **GitHub** – Project documentation and version control

---

# 🔍 Data Preparation & Cleaning

Before performing the analysis, the dataset was examined for:

* Missing values
* Duplicate records
* Incorrect data types
* Invalid or inconsistent values
* Outliers
* Inconsistent categorical values

Derived variables were also created to make the analysis more meaningful.

### Important Derived Metrics

#### Debt-to-Income Ratio (DTI)

DTI measures the proportion of a borrower's income that is committed to existing debt obligations.

```text
DTI Ratio = Existing Monthly Debt / Monthly Income
```

A higher DTI generally indicates a greater debt burden relative to income.

---

#### Loan-to-Income Ratio

The Loan-to-Income Ratio compares the requested loan amount with the borrower's annual income.

```text
Loan-to-Income Ratio = Loan Amount / Annual Income
```

This helps identify borrowers taking relatively large loans compared with their income.

---

#### Risk Score

A composite risk score was developed using important borrower risk indicators such as:

* Credit Score
* DTI Ratio
* Loan-to-Income Ratio
* Other borrower/loan characteristics

The score helps segment borrowers into different risk categories.

---

# 🧮 SQL Analysis

SQL was used for data exploration and to identify patterns in loan defaults.

### Overall Default Rate

```sql
SELECT 
    COUNT(loan_id) AS total_loans,
    SUM(defaulted) AS defaulted_loans,
    ROUND(AVG(defaulted) * 100, 2) AS default_rate_pct
FROM loans;
```

### Default Rate by Credit Score Category

Borrowers were categorized into credit score bands such as:

* Poor
* Fair
* Good
* Very Good
* Excellent

This allowed default rates to be compared across different credit-quality segments.

### Default Rate by DTI Category

DTI was categorized into risk bands to understand whether borrowers with higher debt burdens had higher default rates.

### Other SQL Analysis

The analysis also explored default rates by:

* Loan purpose
* Employment status
* Home ownership
* Age groups
* Loan amount
* Interest rate
* Loan-to-income ratio
* Credit score
* DTI ratio
* Risk score
* Application year

---

# 📊 Power BI Dashboard

An interactive Power BI dashboard was developed to present the analysis in an easy-to-understand format.

### Dashboard Features

The dashboard includes:

* 📈 Overall Default Rate
* 💳 Credit Score Analysis
* 💰 DTI Analysis
* 🏦 Loan Purpose Analysis
* 👔 Employment Status Analysis
* 🏠 Home Ownership Analysis
* 📊 Risk Score Distribution
* 📅 Application Date/Year Analysis
* 🔎 Interactive slicers and filters
* 📌 Key Business Insights

---

## 📊 Key Visualizations

### 1. Credit Score vs Default Rate

Shows how default rates vary across different credit score categories.

**Expected insight:** Lower credit scores are generally associated with higher credit risk.

---

### 2. DTI vs Default Rate

Compares default rates across different DTI categories.

This helps identify whether borrowers with higher debt obligations relative to income are more likely to default.

---

### 3. Credit Score + DTI Analysis

A matrix was created to analyze default rates using **Credit Score and DTI together**.

This provides a more detailed view of borrower risk than analyzing either variable independently.

For example, borrowers with:

> Lower credit scores + higher DTI

can represent a particularly high-risk segment.

---

### 4. Loan Purpose vs Default Rate

Compares default rates across different purposes such as:

* Education
* Home Improvement
* Medical
* Debt Consolidation
* Personal
* Other loan purposes

This helps identify which loan purposes have comparatively higher default rates.

---

### 5. Employment Status vs Default Rate

Analyzes loan performance based on borrower employment status.

This can help determine whether employment stability is associated with repayment behavior.

---

### 6. Home Ownership vs Default Rate

Compares default rates among borrowers with different home ownership statuses.

---

### 7. Application Date Analysis

Application dates are analyzed over time to identify changes or trends in default rates.

A date slicer allows users to filter the dashboard based on application periods.

---

# 💡 Key Insights

The analysis focuses on identifying relationships between borrower characteristics and loan default risk.

Some important patterns investigated include:

* **Credit score is an important indicator of borrower risk.**
* Borrowers with **higher DTI ratios** can have greater repayment pressure.
* Combining **Credit Score + DTI** provides a more granular view of borrower risk.
* **Loan-to-Income Ratio** helps identify borrowers taking loans that are large relative to their income.
* Default rates can vary significantly across **loan purposes**.
* Employment status and home ownership can provide additional borrower segmentation.
* A combination of multiple financial indicators can provide a stronger risk assessment than relying on a single variable.

> **Note:** The exact findings and percentages depend on the dataset and are presented in the Power BI dashboard.

---

# 📈 Business Recommendations

Based on the analysis, lenders could consider:

### 1. Risk-Based Loan Assessment

Use credit score, DTI, and loan-to-income ratio together when assessing borrower risk rather than relying on a single metric.

### 2. Enhanced Monitoring of High-Risk Borrowers

Borrowers falling into high-risk combinations of:

```text
Low Credit Score
+
High DTI
+
High Loan-to-Income Ratio
```

could be subject to additional review or monitoring.

### 3. Risk-Based Pricing

Interest rates and loan terms could potentially be adjusted according to borrower risk levels, subject to applicable lending policies and regulations.

### 4. Portfolio Monitoring

Default rates should be monitored across:

* Loan purposes
* Employment segments
* Credit score bands
* DTI categories
* Time periods

This can help identify emerging risk patterns.

---

# 📁 Project Structure

```text
Loan-Default-Risk-Analysis/
│
├── Dataset/
│   └── loan_default_dataset.csv
│
├── SQL/
│   ├── data_cleaning.sql
│   ├── exploratory_analysis.sql
│   └── risk_analysis.sql
│
├── PowerBI/
│   └── Loan_Default_Risk_Analysis.pbix
│
├── Screenshots/
│   └── dashboard.png
│
└── README.md
```

---

# 🚀 Project Workflow

```text
Raw Dataset
     ↓
Data Cleaning
     ↓
Data Validation
     ↓
Feature Engineering
     ↓
SQL Exploratory Analysis
     ↓
Risk Segmentation
     ↓
Power BI Data Modeling
     ↓
DAX Measures
     ↓
Interactive Dashboard
     ↓
Business Insights
```

---

# 📌 Skills Demonstrated

### SQL

* SELECT
* WHERE
* CASE statements
* GROUP BY
* Aggregate functions
* JOINs
* Subqueries
* CTEs
* Window functions
* Data cleaning
* Feature engineering

### Power BI

* Data modeling
* DAX measures
* Calculated columns
* Matrix and chart visualizations
* Slicers
* Conditional formatting
* Sorting custom categories
* Interactive dashboard design
* KPI development

### Analytical Skills

* Exploratory Data Analysis
* Risk segmentation
* Trend analysis
* Pattern identification
* Data-driven business recommendations

---

# 🎓 Project Outcome

This project demonstrates how **SQL and Power BI can be combined to transform raw loan data into actionable risk insights**.

The final dashboard enables users to explore borrower characteristics, identify high-risk segments, compare default rates, and understand the factors associated with loan repayment outcomes.

---

