# My_sql-Retail-Sales-Analysis Project
# Database: “sales”
# Overview 
This project was inspired by a YouTube tutorial [Zero Analyst], but I built the code independently, added my own logic, and tested it on my own machine.
The project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.
# Objectives
•	Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
•	Data Cleaning: Identify and remove any records with missing or null values.
•	Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
•	Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.
# Project Structure:
1. Database Setup
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

