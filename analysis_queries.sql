
   E-Commerce Sales & Profitability Analysis Project
   Author: Rakshitha H V
   Database: ecommerce_project
   Table: ecommerce_sales
   Total Records: 34,500+
-----------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE ecommerce_project;
use ecommerce_project;


CREATE TABLE ecommerce_sales(
order_id VARCHAR(50),
customer_id VARCHAR(50),
product_id VARCHAR(50),
category VARCHAR(50),
price DECIMAL(10,2),
discount DECIMAL(5,2),
quantity INT,
payment_method VARCHAR(50),
order_date DATE,
delivery_time_days INT,
region VARCHAR(20),
returned VARCHAR(5),
total_amount DECIMAL(10,2),
shipping_cost DECIMAL(10,2),
profit_margin DECIMAL(10,2),
customer_age INT,
customer_gender VARCHAR(10)
);



 1️⃣ What is the total revenue generated? 
      SELECT SUM(total_amount) AS total_revenue
      FROM ecommerce_sales;

 2️⃣ How many total orders were placed?
     SELECT 
          COUNT(order_id) AS total_orders
     FROM ecommerce_sales;



 3️⃣ Which category generates the highest revenue? 
    SELECT category,
           ROUND(SUM(total_amount),2) AS revenue
    FROM ecommerce_sales
    GROUP BY category
    ORDER BY revenue DESC;


 4️⃣ Which category has the highest profit percentage? 
      SELECT category,
           ROUND(SUM(total_amount),2) AS revenue,
           ROUND(SUM(profit_margin),2) AS profit,
           ROUND(SUM(profit_margin)*100/SUM(total_amount),2) AS profit_percentage
     FROM ecommerce_sales
     GROUP BY category
     ORDER BY profit_percentage DESC;


 5️⃣ Which region performs best and worst? 
   SELECT region,
         ROUND(SUM(total_amount),2) AS revenue
   FROM ecommerce_sales
   GROUP BY region
   ORDER BY revenue DESC;


 6️⃣ Does delivery time affect returns? 
   SELECT returned,
         ROUND(AVG(delivery_time_days),2) AS avg_delivery_time
   FROM ecommerce_sales
   GROUP BY returned;

7️⃣ What percentage of total revenue does each category contribute? */
   SELECT  category,
       ROUND(SUM(total_amount),2) AS revenue,
       ROUND(SUM(total_amount) * 100 /
              (SELECT SUM(total_amount) FROM ecommerce_sales),2) AS revenue_percentage
   FROM ecommerce_sales
   GROUP BY category
   ORDER BY revenue DESC;

8️⃣ What is the monthly sales trend? 
   SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        ROUND(SUM(total_amount),2) AS monthly_sales
   FROM ecommerce_sales
   GROUP BY month
   ORDER BY month;


 9️⃣ Who are the top 5 customers by total spending? */
    SELECT customer_id,
         ROUND(SUM(total_amount),2) AS total_spent
    FROM ecommerce_sales
    GROUP BY customer_id
    ORDER BY total_spent DESC
    LIMIT 5;

1️⃣0️⃣  What is the overall return rate? 
      SELECT returned,
        COUNT(*) AS total_orders,
          ROUND(COUNT(*) * 100 /
               (SELECT COUNT(*) FROM ecommerce_sales),2) AS return_percentage
      FROM ecommerce_sales
      GROUP BY returned;


1️⃣1️⃣ Which category has the highest return percentage? 
      SELECT category,
        COUNT(*) AS total_orders,
           SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returned_orders,
             ROUND(
                 SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*),
        2) AS return_percentage
      FROM ecommerce_sales
      GROUP BY category
      ORDER BY return_percentage DESC;


1️⃣2️⃣ What is the average delivery time across all orders? 
     SELECT 
         ROUND(AVG(delivery_time_days),2) AS avg_delivery_time
     FROM ecommerce_sales;



1️⃣3️⃣ Which category generates the highest total profit? 
     SELECT category,
           ROUND(SUM(profit_margin),2) AS total_profit
     FROM ecommerce_sales
     GROUP BY category
     ORDER BY total_profit DESC;




 1️⃣4️⃣ What is the distribution of payment methods used? 
       SELECT payment_method,
         COUNT(*) AS total_orders,
             ROUND(COUNT(*) * 100 /
                   (SELECT COUNT(*) FROM ecommerce_sales),2) AS usage_percentage
       FROM ecommerce_sales
       GROUP BY payment_method
       ORDER BY total_orders DESC; 


