# High-Performance In-Memory Data Wrangling on Terabyte-Scale Arrays using data.table

## Week 2 Project

### Student Details

**Student Name:** Lakshiya S S  
**Course:** Bachelor of Computer Applications (BCA)  
**Programming Language:** R  
**Package Used:** data.table  

---

# Project Objective

The objective of this project is to understand how enterprise organizations process and analyze extremely large transactional datasets using high-performance data manipulation techniques in R.

This project implements an efficient in-memory data processing pipeline using the **data.table** package. Unlike traditional data.frame operations, data.table uses **reference semantics (pointer-level references)** to modify data directly in memory without creating unnecessary copies.

The project demonstrates high-speed data generation, importing, cleaning, filtering, indexing, aggregation, business analysis, and visualization of a large-scale sales transaction dataset containing **500,000 records**.

---

# Software Used

- R Programming Language
- RStudio / Google Colab (R Runtime)
- data.table Package
- Git
- GitHub

---

# Dataset Description

A synthetic enterprise sales transaction dataset was generated using R.

### Dataset Size

- Number of Transactions: **500,000 records**
- File Name:

```
sales_transactions.csv
```

### Dataset Features

| Column | Description |
|--------|-------------|
| TransactionID | Unique transaction number |
| CustomerID | Customer identifier |
| CustomerName | Customer name |
| Gender | Customer gender |
| Age | Customer age |
| ProductID | Product identifier |
| ProductName | Purchased product |
| Category | Product category |
| Quantity | Number of products purchased |
| UnitPrice | Price per unit |
| Discount | Discount percentage |
| GST | GST percentage |
| PaymentMethod | Payment mode |
| City | Customer city |
| State | Customer state |
| OrderDate | Date of purchase |
| SalesPerson | Sales executive |

---

# Project Tasks Completed

## Task 1: Dataset Generation

- Generated a synthetic sales transaction dataset with 500,000 observations.
- Used random data generation techniques.
- Saved dataset as:

```
sales_transactions.csv
```

---

## Task 2: Dataset Import and Exploration

Performed:

- Dataset loading using `fread()`
- Displayed first and last observations
- Checked column names
- Verified data types
- Generated summary statistics
- Checked missing values
- Identified duplicate records
- Counted unique customers, products, and cities

---

## Task 3: Data Cleaning and Preparation

Performed:

- Removed duplicate records
- Converted data into correct formats
- Reordered columns
- Prepared dataset for analysis

---

## Task 4: High-Speed Data Manipulation

Implemented:

- Column selection
- Multiple column selection
- Single condition filtering
- Multiple condition filtering
- Ascending sorting
- Descending sorting
- Top 20 expensive products
- Top 20 highest quantity transactions

---

## Task 5: In-Place Column Updates using `:=`

Created new columns using data.table reference semantics.

Generated:

### Revenue

```
Quantity × UnitPrice
```

### Discount Amount

```
Revenue × Discount / 100
```

### GST Amount

```
Revenue × GST / 100
```

### Net Revenue

```
Revenue - DiscountAmount + GSTAmount
```

---

## Task 6: Indexing using setkey()

Implemented indexing for faster searching.

Created keys on:

- CustomerID
- ProductID

Performed indexed searches and compared execution efficiency.

---

## Task 7: Grouping and Aggregation

Generated business reports:

### Customer Summary

Includes:

- Total Orders
- Total Revenue
- Average Revenue


### Product Summary

Includes:

- Total Quantity Sold
- Total Revenue


### City Summary

Includes:

- Number of Transactions
- Total Revenue


### Category Summary

Includes:

- Total Revenue
- Average Revenue

---

# Business Analysis Performed

The following business questions were answered:

### 1. Which city generated the highest revenue?

Identified the city with maximum total revenue.

### 2. Which product generated maximum sales?

Found the highest-performing product.

### 3. Which customer placed the highest number of orders?

Identified the most active customer.

### 4. Which payment method is used most frequently?

Analyzed customer payment preferences.

### 5. What is the average transaction value?

Calculated average Net Revenue per transaction.

### 6. Which category generated maximum revenue?

Identified the best-performing product category.

### 7. Top 20 Customers by Revenue

Generated customer ranking based on revenue.

### 8. Top 20 Products by Quantity Sold

Generated product ranking based on sales quantity.

---

# Data Visualization

Generated visual reports using **Base R**.

The following plots were created:

## 1. Transactions by City

File:

```
city_transactions.png
```

Shows the number of transactions from each city.


## 2. Revenue by Product Category

File:

```
category_revenue.png
```

Shows revenue contribution from each category.


## 3. Top 20 Customers

File:

```
top_customers.png
```

Displays customers generating maximum revenue.


## 4. Payment Method Distribution

File:

```
payment_distribution.png
```

Shows customer payment preferences.

---

# Output Files

The generated outputs are stored inside the Output folder.

```
Output/
│
├── city_transactions.png
├── category_revenue.png
├── top_customers.png
├── payment_distribution.png
│
├── customer_summary.csv
├── product_summary.csv
├── city_summary.csv
└── category_summary.csv
```

---

# Project Structure

```
High-Performance-DataWrangling-Week2/

│── README.md

│── Week2_Report.pdf

│── sales_transactions.csv

│── high_performance_data_wrangling.R

│
└── Output/

    ├── city_transactions.png
    ├── category_revenue.png
    ├── top_customers.png
    ├── payment_distribution.png
    ├── customer_summary.csv
    ├── product_summary.csv
    ├── city_summary.csv
    └── category_summary.csv
```

---

# Steps to Run the Project

### Step 1

Install required package:

```r
install.packages("data.table")
```

---

### Step 2

Load package:

```r
library(data.table)
```

---

### Step 3

Run the R program:

```
high_performance_data_wrangling.R
```

---

### Step 4

Generated files will be available:

```
sales_transactions.csv
Output folder
```

---

# Learning Outcomes

Through this project, the following concepts were learned:

- Large-scale dataset generation
- High-performance data processing using data.table
- Reference semantics and memory efficiency
- Fast filtering and sorting techniques
- Data indexing using setkey()
- Grouping and aggregation operations
- Business analytics using transactional data
- Report generation
- Data visualization using Base R

---

# Conclusion

This project successfully demonstrates how enterprise-level transactional datasets can be processed efficiently using the **data.table** package in R.

The implementation shows improved memory management, faster data manipulation, and effective business insights generation from large-scale datasets.
