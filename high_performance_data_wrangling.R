############################################################
# High-Performance In-Memory Data Wrangling
# Week 2 Project
#
# Student Name : Lakshiya S S
# Course : Bachelor of Computer Applications (BCA)
# Language : R
# Package : data.table
############################################################


############################################################
# Part 1 : Generate Dataset
############################################################

install.packages("data.table")
library(data.table)

set.seed(200000)

n <- 500000

sales_data <- data.table(

  TransactionID = 1:n,

  CustomerID = sample(1000:9999, n, replace = TRUE),

  CustomerName = paste0(
    "Customer_",
    sample(1:10000, n, replace = TRUE)
  ),

  Gender = sample(
    c("Male","Female"),
    n,
    replace = TRUE
  ),

  Age = sample(
    18:70,
    n,
    replace = TRUE
  ),

  ProductID = sample(
    100:999,
    n,
    replace = TRUE
  ),

  ProductName = paste0(
    "Product_",
    sample(1:500, n, replace = TRUE)
  ),

  Category = sample(
    c("Electronics",
      "Clothing",
      "Grocery",
      "Home",
      "Sports"),
    n,
    replace = TRUE
  ),

  Quantity = sample(
    1:10,
    n,
    replace = TRUE
  ),

  UnitPrice = round(
    runif(n,100,5000),
    2
  ),

  Discount = round(
    runif(n,0,30),
    2
  ),

  GST = round(
    runif(n,5,18),
    2
  ),

  PaymentMethod = sample(
    c("Cash",
      "Card",
      "UPI",
      "Net Banking"),
    n,
    replace = TRUE
  ),

  City = sample(
    c("Chennai",
      "Madurai",
      "Coimbatore",
      "Trichy",
      "Salem"),
    n,
    replace = TRUE
  ),

  State = "Tamil Nadu",

  OrderDate = sample(
    seq.Date(
      as.Date("2023-01-01"),
      as.Date("2024-12-31"),
      by="day"
    ),
    n,
    replace = TRUE
  ),

  SalesPerson = paste0(
    "SP_",
    sample(1:200,n,replace = TRUE)
  )
)


# Save Dataset

fwrite(
  sales_data,
  "sales_transactions.csv"
)


head(sales_data,10)
tail(sales_data,10)
dim(sales_data)
str(sales_data)



############################################################
# Part 2 : Import Dataset
############################################################


dt <- fread(
  "sales_transactions.csv"
)


head(dt)
tail(dt)

names(dt)

str(dt)

summary(dt)


# Missing Values

colSums(is.na(dt))


# Duplicate Records

sum(duplicated(dt))


# Unique Counts

uniqueN(dt$CustomerID)

uniqueN(dt$ProductID)

uniqueN(dt$City)



############################################################
# Part 3 : Data Cleaning
############################################################


# Remove duplicates

dt <- unique(dt)


# Convert Date

dt[,OrderDate := as.Date(OrderDate)]


# Arrange columns

setcolorder(
dt,
c(
"TransactionID",
"CustomerID",
"CustomerName",
"Gender",
"Age",
"ProductID",
"ProductName",
"Category",
"Quantity",
"UnitPrice",
"Discount",
"GST",
"PaymentMethod",
"City",
"State",
"OrderDate",
"SalesPerson"
)
)


head(dt)



############################################################
# Part 4 : Data Manipulation
############################################################


# Select columns

dt[,.(CustomerName,City)]


# Filtering

dt[City=="Chennai"]


dt[
City=="Chennai" &
Quantity>5
]


# Sorting

dt[order(UnitPrice)]


dt[order(-UnitPrice)]


# Top expensive products

dt[
order(-UnitPrice)
][1:20]


# Highest quantity transactions

dt[
order(-Quantity)
][1:20]



############################################################
# Part 5 : In-place Column Updates
############################################################


dt[
,
Revenue :=
Quantity * UnitPrice
]


dt[
,
DiscountAmount :=
Revenue * Discount /100
]


dt[
,
GSTAmount :=
Revenue * GST /100
]


dt[
,
NetRevenue :=
Revenue - DiscountAmount + GSTAmount
]


head(dt)



############################################################
# Part 6 : Index Keying using setkey()
############################################################


# Customer Index

setkey(dt,CustomerID)


dt[.(1234)]


# Product Index

setkey(dt,ProductID)


dt[.(200)]



############################################################
# Part 7 : Grouping and Aggregation
############################################################


customer_summary <- dt[
,
.(

TotalOrders=.N,

TotalRevenue=sum(NetRevenue),

AverageRevenue=mean(NetRevenue)

),
by=CustomerID
]


product_summary <- dt[
,
.(

TotalQuantity=sum(Quantity),

TotalRevenue=sum(NetRevenue)

),
by=ProductName
]


city_summary <- dt[
,
.(

Transactions=.N,

TotalRevenue=sum(NetRevenue)

),
by=City
]


category_summary <- dt[
,
.(

TotalRevenue=sum(NetRevenue),

AverageRevenue=mean(NetRevenue)

),
by=Category
]



############################################################
# Part 8 : Business Analysis
############################################################


# Highest Revenue City

city_summary[
order(-TotalRevenue)
][1]


# Best Product

product_summary[
order(-TotalRevenue)
][1]


# Highest Order Customer

customer_summary[
order(-TotalOrders)
][1]


# Most Used Payment

dt[
,
.N,
by=PaymentMethod
][order(-N)][1]


# Average Transaction Value

mean(dt$NetRevenue)


# Best Category

category_summary[
order(-TotalRevenue)
][1]


# Top Customers

customer_summary[
order(-TotalRevenue)
][1:20]


# Top Products

product_summary[
order(-TotalQuantity)
][1:20]



############################################################
# Part 9 : Export Reports
############################################################


dir.create(
"Output",
showWarnings = FALSE
)


fwrite(
customer_summary,
"Output/customer_summary.csv"
)


fwrite(
product_summary,
"Output/product_summary.csv"
)


fwrite(
city_summary,
"Output/city_summary.csv"
)


fwrite(
category_summary,
"Output/category_summary.csv"
)



############################################################
# Part 10 : Visualization
############################################################


# City Transactions

png(
"Output/city_transactions.png"
)

barplot(
city_summary$Transactions,
names.arg=city_summary$City,
las=2,
main="Transactions by City"
)

dev.off()



# Category Revenue

png(
"Output/category_revenue.png"
)

barplot(
category_summary$TotalRevenue,
names.arg=category_summary$Category,
las=2,
main="Revenue by Category"
)

dev.off()



# Top Customers

top_customers <-
customer_summary[
order(-TotalRevenue)
][1:20]


png(
"Output/top_customers.png"
)

barplot(
top_customers$TotalRevenue,
names.arg=top_customers$CustomerID,
las=2,
main="Top 20 Customers"
)

dev.off()



# Payment Distribution

payment <-
dt[
,
.N,
by=PaymentMethod
]


png(
"Output/payment_distribution.png"
)

pie(
payment$N,
labels=payment$PaymentMethod,
main="Payment Method Distribution"
)

dev.off()



############################################################
# End of Program
############################################################
