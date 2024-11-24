CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255)
);


CREATE TABLE menu_items (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50), 
    price DECIMAL(10,2),
    availability BOOLEAN
);


CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50), 
    phone VARCHAR(15),
    salary DECIMAL(10,2)
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    payment_status VARCHAR(20) 
);


CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    item_id INT REFERENCES menu_items(item_id),
    quantity INT,
    item_price DECIMAL(10,2) 
);

CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    phone VARCHAR(15),
    reservation_date DATE,
    reservation_time TIME,
    party_size INT,
    special_requests TEXT
);


INSERT INTO customers (first_name, last_name, email, phone, address) VALUES
('John', 'Doe', 'johndoe@gmail.com', '123-456-7890', '123 Elm Street'),
('Jane', 'Smith', 'janesmith@gmail.com', '987-654-3210', '456 Oak Avenue'),
('Alice', 'Johnson', 'alicej@gmail.com', '555-123-4567', '789 Pine Road');


INSERT INTO menu_items (item_name, category, price, availability) VALUES
('Margherita Pizza', 'Main Course', 12.99, TRUE),
('Caesar Salad', 'Appetizer', 8.50, TRUE),
('Chocolate Cake', 'Dessert', 6.99, TRUE),
('Coke', 'Beverage', 2.50, TRUE),
('Grilled Salmon', 'Main Course', 18.99, FALSE);



INSERT INTO staff (first_name, last_name, role, phone, salary) VALUES
('Emily', 'Brown', 'Chef', '111-222-3333', 40000.00),
('Michael', 'Davis', 'Server', '222-333-4444', 25000.00),
('Sarah', 'Wilson', 'Manager', '333-444-5555', 50000.00);


INSERT INTO orders (customer_id, total_amount, payment_status) VALUES
(1, 25.48, 'Paid'),
(2, 8.50, 'Pending'),
(3, 50.47, 'Paid');


INSERT INTO order_details (order_id, item_id, quantity, item_price) VALUES
(1, 1, 1, 12.99),
(1, 2, 1, 8.50),
(1, 4, 1, 2.50),
(3, 3, 2, 6.99),
(3, 5, 1, 18.99);

INSERT INTO reservations (customer_name, phone, reservation_date, reservation_time, party_size, special_requests) VALUES
('John Doe', '123-456-7890', '2024-11-25', '19:00:00', 4, 'Vegetarian options needed'),
('Jane Smith', '987-654-3210', '2024-11-26', '18:30:00', 2, 'Window seat requested'),
('Alice Johnson', '555-123-4567', '2024-11-27', '20:00:00', 6, 'Birthday celebration, bring cake to table'),
('Robert Brown', '111-222-3333', '2024-11-28', '17:00:00', 3, NULL),
('Emily Clark', '333-444-5555', '2024-11-29', '19:30:00', 5, 'Allergy to nuts');



SELECT * FROM customers;

SELECT * FROM menu_items ORDER BY Price ASC;

SELECT * FROM menu_items WHERE category = "Dessert";

SELECT payment_status, COUNT(*) AS Total FROM orders GROUP BY payment_status;

SELECT * FROM orders WHERE customer_id = 3;

SELECT o.order_id, c.first_name, c.last_name, o.order_date
FROM orders AS o
JOIN customers c ON o.customer_id = c.customer_id;

SELECT * FROM reservations WHERE DATE(reservation_date) = "2024-11-27";
