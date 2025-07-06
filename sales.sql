create database sales;
drop database sales;
use sales;
select * from sales_dataset;

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
or total_sale is null;

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
or total_sale is null;


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


SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sales_dataset
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales_dataset
GROUP BY category;

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sales_dataset
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
