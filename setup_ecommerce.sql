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

-- Insert sample customers
INSERT INTO customers VALUES (1, 'Alice', 'alice@mail.com', '2022-01-01');
INSERT INTO customers VALUES (2, 'Bob', 'bob@mail.com', '2022-03-15');

-- Insert sample products
INSERT INTO products VALUES (1, 'Laptop', 'Electronics', 1000);
INSERT INTO products VALUES (2, 'Headphones', 'Electronics', 200);

-- Insert sample orders
INSERT INTO orders VALUES (1, 1, '2022-05-01', 1200);
INSERT INTO orders VALUES (2, 2, '2022-06-10', 200);

-- Insert sample order items
INSERT INTO order_items VALUES (1, 1, 1, 1, 1000);
INSERT INTO order_items VALUES (2, 1, 2, 1, 200);
INSERT INTO order_items VALUES (3, 2, 2, 1, 200);
