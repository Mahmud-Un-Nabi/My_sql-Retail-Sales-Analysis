# My_sql-Retail-Sales-Analysis Project
# Overview 
This project was inspired by a YouTube tutorial [Zero Analyst], but I built the code independently, added my own logic, and tested it on my own machine.
The project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.
# Objectives
•	Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
•	Data Cleaning: Identify and remove any records with missing or null values.
•	Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
•	Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.
# Project Structure:
# 1. Database Setup
Database Creation: The project starts by creating a database named “sales”.
Table Creation: A table named “sales_dataset” is created to store the sales data. The table structure includes following columns.
```sql
create database sales;
drop database sales;
use sales;

create table sales_dataset (
transactions_id int primary key,
sale_date date ,
sale_time time,
customer_id int,
gender varchar(50),
age int,
category varchar(20),
quantity int,
price_per_unit float,
cogs float,
total_sale int
);
```
# 2. Data Exploration & Cleaning
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.
```sql
select * from sales_dataset;
select * from sales_dataset limit 10;
select count(*) from sales_dataset;
select * from sales_dataset 
where 
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sales is null;

delete from sales_dataset
where 
transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sales is null;

```
# 3. Data Analysis & Findings
The following SQL queries were developed to answer specific business questions:
1.	Write a SQL query to retrieve all columns for sales made on '2022-11-05.
2.	Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022.
3.	Write a SQL query to calculate the total sales (total_sale) for each category.
Code (1, 2, 3) :
```sql
select * from sales_dataset
where sale_date= '2022-11-05';

select * from sales_dataset
where category = 'Clothing'
and sale_date between '2022-11-01' and '2022-11-30'
and quantity >= 4;

SELECT category, 
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM sales_dataset
GROUP BY 1;
```
# 4.	Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category and to find all transactions where the total_sale is greater than 1000.

```sql
SELECT ROUND(AVG(age), 2) as avg_age
FROM sales_dataset
WHERE category = 'Beauty';

select * from sales_dataset
where total_sale > 1000; 
```
# 5.	Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category and calculate the average sale for each month. Find out best-selling month in each year.

```sql
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM sales_dataset
GROUP BY 
    category,
    gender
ORDER BY 1;
SELECT 
    year,
    month,
    avg_sale
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS ranks
    FROM sales_dataset
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE ranks = 1;
```
