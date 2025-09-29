-- Drop existing tables and views
DROP VIEW IF EXISTS high_value_customers;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

-- Create tables
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT,
    join_date TEXT
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name TEXT,
    category TEXT,
    price REAL
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    order_date TEXT,
    total_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    price REAL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert sample data
INSERT INTO customers VALUES (1, 'Alice', 'alice@mail.com', '2022-01-01');
INSERT INTO customers VALUES (2, 'Bob', 'bob@mail.com', '2022-03-15');

INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 1000);
INSERT INTO products VALUES (2, 'Headphones', 'Electronics', 200);

INSERT INTO orders VALUES (1, 1, '2022-05-01', 1200);
INSERT INTO orders VALUES (2, 2, '2022-06-10', 200);

INSERT INTO order_items VALUES (1, 1, 1, 1, 1000);
INSERT INTO order_items VALUES (2, 1, 2, 1, 200);
INSERT INTO order_items VALUES (3, 2, 2, 1, 200);

-- Queries for preview / results

SELECT * FROM customers;
SELECT * FROM orders;

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
