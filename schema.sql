-- Drop tables if they exist
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS payment_methods;

-- Create Products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    in_stock INTEGER NOT NULL,
    user_uid VARCHAR(255) NOT NULL,
    category VARCHAR(50)
);

-- Create Customers table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(20),
    user_uid VARCHAR(255) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('active', 'inactive')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    total_amount DECIMAL(10, 2) NOT NULL,
    user_uid VARCHAR(255) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pending', 'completed', 'cancelled')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create OrderItems table
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER REFERENCES orders(id),
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Create PaymentMethods table
CREATE TABLE payment_methods (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Create Transactions table
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    description TEXT,
    order_id INTEGER REFERENCES orders(id),
    payment_method_id INTEGER REFERENCES payment_methods(id),
    amount DECIMAL(10, 2) NOT NULL,
    user_uid VARCHAR(255) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('income', 'expense')),
    category VARCHAR(100),
    status VARCHAR(20) CHECK (status IN ('pending', 'completed', 'failed')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert initial payment methods
INSERT INTO payment_methods (name) VALUES ('Credit Card'), ('Debit Card'), ('Cash');

-- Insert products
INSERT INTO products (name, description, price, in_stock, user_uid, category)
VALUES
    ('Rice Pack', '5kg of premium quality rice', 12.50, 100, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'food'),
    ('Bottled Water', 'Pack of 12, 1-liter bottles', 8.99, 200, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'water-beverages'),
    ('Hygiene Kit', 'Includes soap, toothbrush, toothpaste, and shampoo', 5.75, 150, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'hygiene-kits'),
    ('First Aid Kit', 'Basic medical supplies for emergencies', 20.00, 50, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'medical-supplies'),
    ('Winter Jacket', 'Warm insulated jacket for cold weather', 45.99, 80, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'clothing'),
    ('Running Shoes', 'Comfortable running shoes for adults', 30.00, 60, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'footwear'),
    ('Blanket', 'Soft and warm fleece blanket', 18.99, 120, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'blankets-bedding'),
    ('Camping Tent', 'Waterproof 2-person tent', 75.00, 25, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'tents'),
    ('Notebook Set', 'Set of 5 ruled notebooks', 6.50, 180, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'stationery'),
    ('Backpack', 'Durable 30L backpack with multiple compartments', 28.99, 90, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'bags-backpacks'),
    ('Smartphone', 'Android device with 64GB storage', 199.99, 30, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'digital-devices'),
    ('Cooking Pot', 'Non-stick 5L cooking pot', 22.99, 50, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'cooking-supplies'),
    ('Mop & Bucket Set', 'Cleaning mop with spin bucket', 15.75, 70, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'cleaning-supplies'),
    ('LED Lantern', 'Rechargeable lantern for emergency use', 12.50, 90, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'lighting'),
    ('Emergency Kit', 'Survival kit with essential items', 40.00, 35, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'emergency-kits'),
    ('Fire Extinguisher', 'Compact fire extinguisher for home use', 55.00, 25, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'rescue-equipment'),
    ('Tarpaulin Sheet', 'Waterproof 10x12 ft sheet for shelter', 25.99, 40, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'shelter-materials'),
    ('Toy Car Set', 'Pack of 5 miniature cars', 9.99, 150, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'toys'),
    ('Football', 'Standard size 5 football', 18.50, 60, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'sports-equipment'),
    ('Paint Set', '12-color acrylic paint set with brushes', 14.75, 100, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'art-craft'),
    ('Wireless Earbuds', 'Bluetooth noise-canceling earbuds', 49.99, 45, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'electronics'),
    ('Bed Sheet Set', 'Cotton double-bed sheet with pillow covers', 30.99, 80, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'home'),
    ('Digital Watch', 'Waterproof sports digital watch', 35.00, 70, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'electronics'),
    ('LED Flashlight', 'High-power rechargeable flashlight', 20.50, 55, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'lighting'),
    ('Solar Power Bank', '10,000mAh solar charging power bank', 29.99, 40, '651c6c5a-008e-4d73-af2a-9165c6bde384', 'digital-devices');
