CREATE DATABASE sql_project_2;

DROP TABLE IF EXISTS reatail_sales;
CREATE TABLE retail_sales(
                           transaction_id INT PRIMARY KEY,
						   sale_date DATE,
						   sale_time TIME,
						   customer_id INT,
						   gender VARCHAR(15),
						   age INT,
						   category VARCHAR(15),
						   quantiy INT,
						   price_per_unit FLOAT,
						   cogs FLOAT,
						   total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE transaction_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE customer_id IS NULL;

SELECT * FROM retail_sales
WHERE gender IS NULL;


SELECT * FROM retail_sales
WHERE age IS NULL;

SELECT * FROM retail_sales
WHERE transaction_id IS null
      OR
	  sale_date is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or 
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;

--DATA CLEANING
DELETE FROM retail_sales
WHERE transaction_id IS null
      OR
	  sale_date is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or 
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;

SELECT * FROM retail_sales
WHERE transaction_id IS null
      OR
	  sale_date is null
	  or
	  sale_time is null
	  or
	  customer_id is null
	  or 
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantiy is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or
	  total_sale is null;

--DATA EXPLORATION

--HOW MANY SALES WE HAVE?

SELECT COUNT(*) AS total_sale FROM retail_sales;

--how many customers we have?

SELECT COUNT(customer_id) AS total_sale FROM retail_sales;

--how many unique customers we have?

SELECT COUNT( DISTINCT customer_id) AS total_sale FROM retail_sales;

--Data Analysis

--Q1 :Write a SQL query to retrive all columns for sales made on'2022-11-05'

SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05';

--2Q: Write a SQL query to retrive all transactions where the category is clothing and quantity is more than equal 4 and 
--and in the month of Nov -2022
SELECT * FROM retail_sales
WHERE category='Clothing'
      and
	  quantiy>=4
      and
	  TO_CHAR(sale_date,'YYYY-MM')='2022-11';

--3Q: Write a SQL query the total sales (total_saale ) for each category.

SELECT category,
       SUM(total_sale) as net_sale,
	   COUNT(*) as total_orders
	   FROM retail_sales
	   GROUP BY 1;

--Q4:Write a SQL query to find the average age of customers who purchased items from 'Beauty' category.

SELECT ROUND(AVG(age),2) as avg_age FROM retail_sales 
WHERE category='Beauty';

--5Q: Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * from retail_sales
where total_sale>1000;

--6Q:Write a SQL query to find the total number of transactions(transaction_id) made by each gender in each category.

SELECT category,
       gender,
	   COUNT(*) as total_trans
from retail_sales
group by category,gender;

--7Q:Write a SQL query to calculate the average sale for each month .find the best sales month in each year.

select year,month,avg_sale from
(
     SELECT
         EXTRACT(YEAR FROM sale_date) as year,
		 EXTRACT(MONTH FROM sale_date) as month,
		 AVG(total_sale) as avg_sale,
		 RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
	 from retail_sales
	 GROUP BY 1,2
)as t1
WHERE rank=1;
       
--8Q:Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
      customer_id,
	  SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--9Q: Write a SQL query to find the number of unique customers who purchase items from each category.
SELECT 
      category,
	  COUNT(DISTINCT customer_id) as no_customers
FROM retail_sales
GROUP BY category;

--10Q:Write a SQL query to create each shift and number of orders(Example Morning<=12 , Afternoon Between 12 & 17, Evening > 17)
WITH hourly_sale
AS 
(
SELECT *,
    CASE 
	    WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT
      shift,
	  COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;











