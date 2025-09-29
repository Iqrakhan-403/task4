SELECT * 
FROM customers;

SELECT * 
FROM orders
WHERE total_amount > 500
ORDER BY total_amount DESC;

SELECT p.name, SUM(oi.price * oi.quantity) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_revenue DESC;

SELECT c.name, AVG(o.total_amount) AS avg_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT p.name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name
ORDER BY total_quantity DESC
LIMIT 5;

SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

CREATE VIEW high_value_customers AS
SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(o.total_amount) > 1000;

SELECT name 
FROM products
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_items);

SELECT SUM(total_amount) AS total_revenue
FROM orders;

SELECT c.name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY order_count DESC;

SELECT strftime('%Y-%m', order_date) AS order_month, SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY order_month
ORDER BY order_month;

SELECT customer_id, COALESCE(email, 'no_email@domain.com') AS email
FROM customers;
