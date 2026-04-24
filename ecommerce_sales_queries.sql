CREATE DATABASE ecommerce_project;

CREATE TABLE sales (
    order_id INT,
    order_date DATE,
    customer_id INT,
    customer_name VARCHAR(100),
    product_id INT,
    product_name VARCHAR(200),
    category VARCHAR(100),
    brand VARCHAR(100),
    quantity INT,
    unit_price FLOAT,
    discount FLOAT,
    tax FLOAT,
    shipping_cost FLOAT,
    total_amount FLOAT,
    payment_method VARCHAR(50),
    order_status VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    seller_id INT
);

DROP TABLE sales;

CREATE TABLE sales (
    order_id VARCHAR,
    order_date VARCHAR,
    customer_id VARCHAR,
    customer_name VARCHAR,
    product_id VARCHAR,
    product_name VARCHAR,
    category VARCHAR,
    brand VARCHAR,
    quantity VARCHAR,
    unit_price VARCHAR,
    discount VARCHAR,
    tax VARCHAR,
    shipping_cost VARCHAR,
    total_amount VARCHAR,
    payment_method VARCHAR,
    order_status VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    seller_id VARCHAR
);

SELECT * FROM sales LIMIT 10;

--total sales
SELECT SUM(total_amount::FLOAT) AS total_sales FROM sales;

--category wise sales
SELECT category, SUM(total_amount::FLOAT) AS sales
FROM sales
GROUP BY category
ORDER BY sales DESC;


--mont
SELECT DATE_TRUNC('month', order_date::DATE) AS month,
SUM(total_amount::FLOAT)
FROM sales
GROUP BY month
ORDER BY month;

SELECT product_name, SUM(quantity::INT) AS total_sold
FROM sales
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 5;

SELECT product_name,
SUM(total_amount::FLOAT - (unit_price::FLOAT * quantity::INT)) AS profit
FROM sales
GROUP BY product_name
ORDER BY profit DESC;

SELECT product_name, SUM(quantity::INT) AS sales
FROM sales
GROUP BY product_name
HAVING SUM(quantity::INT) < 10;


SELECT payment_method, COUNT(*)
FROM sales
GROUP BY payment_method;


SELECT customer_id,
SUM(total_amount::FLOAT) AS spent,
CASE 
    WHEN SUM(total_amount::FLOAT) > 5000 THEN 'High'
    WHEN SUM(total_amount::FLOAT) > 2000 THEN 'Medium'
    ELSE 'Low'
END AS segment
FROM sales
GROUP BY customer_id;


SELECT order_status, COUNT(*)
FROM sales
GROUP BY order_status;