-- --- 1. Populating dim_date (30 dates: Jan 1st - Jan 30th, 2024) ---
INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES 
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, FALSE),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, FALSE),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, FALSE),
(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, FALSE),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),
(20240116, '2024-01-16', 'Tuesday', 16, 1, 'January', 'Q1', 2024, FALSE),
(20240117, '2024-01-17', 'Wednesday', 17, 1, 'January', 'Q1', 2024, FALSE),
(20240118, '2024-01-18', 'Thursday', 18, 1, 'January', 'Q1', 2024, FALSE),
(20240119, '2024-01-19', 'Friday', 19, 1, 'January', 'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, TRUE),
(20240121, '2024-01-21', 'Sunday', 21, 1, 'January', 'Q1', 2024, TRUE),
(20240122, '2024-01-22', 'Monday', 22, 1, 'January', 'Q1', 2024, FALSE),
(20240123, '2024-01-23', 'Tuesday', 23, 1, 'January', 'Q1', 2024, FALSE),
(20240124, '2024-01-24', 'Wednesday', 24, 1, 'January', 'Q1', 2024, FALSE),
(20240125, '2024-01-25', 'Thursday', 25, 1, 'January', 'Q1', 2024, FALSE),
(20240126, '2024-01-26', 'Friday', 26, 1, 'January', 'Q1', 2024, FALSE),
(20240127, '2024-01-27', 'Saturday', 27, 1, 'January', 'Q1', 2024, TRUE),
(20240128, '2024-01-28', 'Sunday', 28, 1, 'January', 'Q1', 2024, TRUE),
(20240129, '2024-01-29', 'Monday', 29, 1, 'January', 'Q1', 2024, FALSE),
(20240130, '2024-01-30', 'Tuesday', 30, 1, 'January', 'Q1', 2024, FALSE);

-- --- 2. Populating dim_product (15 products) ---
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('P001', 'Samsung S23 Ultra', 'Electronics', 'Smartphones', 105000.00),
('P002', 'Apple MacBook Air', 'Electronics', 'Laptops', 92000.00),
('P003', 'Sony Noise Cancelling Headphones', 'Electronics', 'Audio', 24999.00),
('P004', 'Dell 27-inch Monitor', 'Electronics', 'Monitors', 18500.00),
('P005', 'HP LaserJet Printer', 'Electronics', 'Peripherals', 15000.00),
('P006', 'Nike Air Max 270', 'Fashion', 'Footwear', 12995.00),
('P007', 'Levi 511 Slim Fit', 'Fashion', 'Apparel', 3499.00),
('P008', 'Adidas Originals T-Shirt', 'Fashion', 'Apparel', 1499.00),
('P009', 'Puma RS-X Sneakers', 'Fashion', 'Footwear', 8999.00),
('P010', 'Ray-Ban Wayfarer', 'Fashion', 'Accessories', 9500.00),
('P011', 'Non-Stick Cookware Set', 'Home', 'Kitchenware', 4500.00),
('P012', 'Philips Air Fryer', 'Home', 'Appliances', 8999.00),
('P013', 'Bedsheet King Size', 'Home', 'Decor', 2200.00),
('P014', 'Ergonomic Office Chair', 'Home', 'Furniture', 14500.00),
('P015', 'Wall Clock Modern', 'Home', 'Decor', 1200.00);

-- --- 3. Populating dim_customer (12 customers) ---
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001', 'Rahul Sharma', 'Mumbai', 'Maharashtra', 'Premium'),
('C002', 'Priya Patel', 'Mumbai', 'Maharashtra', 'Regular'),
('C003', 'Vikram Singh', 'Delhi', 'Delhi', 'New'),
('C004', 'Sneha Reddy', 'Bangalore', 'Karnataka', 'Regular'),
('C005', 'Amit Shah', 'Ahmedabad', 'Gujarat', 'Premium'),
('C006', 'Meera Iyer', 'Chennai', 'Tamil Nadu', 'Regular'),
('C007', 'Karan Johar', 'Mumbai', 'Maharashtra', 'Premium'),
('C008', 'Ananya Panday', 'Mumbai', 'Maharashtra', 'New'),
('C009', 'Sunil Gavaskar', 'Bangalore', 'Karnataka', 'Regular'),
('C010', 'Mary Kom', 'Delhi', 'Delhi', 'Premium'),
('C011', 'Virat Kohli', 'Delhi', 'Delhi', 'Premium'),
('C012', 'Saina Nehwal', 'Hyderabad', 'Telangana', 'Regular');

-- --- 4. Populating fact_sales (40 transactions) ---
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240101, 1, 1, 1, 105000.00, 5000, 100000.00),
(20240101, 7, 2, 2, 3499.00, 499, 6499.00),
(20240102, 11, 3, 1, 4500.00, 0, 4500.00),
(20240103, 15, 4, 3, 1200.00, 200, 3400.00),
(20240104, 2, 5, 1, 92000.00, 2000, 90000.00),
(20240105, 8, 6, 4, 1499.00, 500, 5496.00),
(20240106, 1, 7, 1, 105000.00, 10000, 95000.00), -- Weekend Sale
(20240106, 6, 8, 1, 12995.00, 1000, 11995.00), -- Weekend Sale
(20240107, 3, 9, 2, 24999.00, 5000, 44998.00), -- Weekend Sale
(20240107, 12, 10, 1, 8999.00, 0, 8999.00),    -- Weekend Sale
(20240108, 4, 11, 1, 18500.00, 500, 18000.00),
(20240109, 14, 12, 1, 14500.00, 1500, 13000.00),
(20240110, 5, 1, 1, 15000.00, 0, 15000.00),
(20240111, 10, 2, 1, 9500.00, 500, 9000.00),
(20240112, 9, 3, 1, 8999.00, 0, 8999.00),
(20240113, 1, 4, 1, 105000.00, 2000, 103000.00), -- Weekend
(20240113, 13, 5, 2, 2200.00, 400, 4000.00),     -- Weekend
(20240114, 2, 6, 1, 92000.00, 0, 92000.00),      -- Weekend
(20240114, 6, 7, 1, 12995.00, 500, 12495.00),    -- Weekend
(20240115, 3, 8, 1, 24999.00, 1000, 23999.00),
(20240116, 7, 9, 1, 3499.00, 0, 3499.00),
(20240117, 11, 10, 1, 4500.00, 500, 4000.00),
(20240118, 4, 11, 2, 18500.00, 2000, 35000.00),
(20240119, 15, 12, 5, 1200.00, 1000, 5000.00),
(20240120, 1, 1, 1, 105000.00, 5000, 100000.00), -- Weekend
(20240120, 8, 2, 3, 1499.00, 0, 4497.00),       -- Weekend
(20240121, 5, 3, 1, 15000.00, 2000, 13000.00),   -- Weekend
(20240121, 10, 4, 1, 9500.00, 0, 9500.00),       -- Weekend
(20240122, 14, 5, 1, 14500.00, 500, 14000.00),
(20240123, 2, 6, 1, 92000.00, 2000, 90000.00),
(20240124, 6, 7, 2, 12995.00, 3000, 22990.00),
(20240125, 9, 8, 1, 8999.00, 0, 8999.00),
(20240126, 12, 9, 1, 8999.00, 1000, 7999.00),
(20240127, 3, 10, 1, 24999.00, 2000, 22999.00), -- Weekend
(20240127, 13, 11, 2, 2200.00, 200, 4200.00),   -- Weekend
(20240128, 4, 12, 1, 18500.00, 0, 18500.00),    -- Weekend
(20240128, 1, 1, 1, 105000.00, 0, 105000.00),   -- Weekend
(20240129, 7, 2, 1, 3499.00, 500, 2999.00),
(20240129, 11, 3, 1, 4500.00, 0, 4500.00),
(20240130, 15, 4, 2, 1200.00, 100, 2300.00);