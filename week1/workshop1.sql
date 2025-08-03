-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'week1_workshop' AND pid <> pg_backend_pid();
-- (re)create the database
DROP DATABASE IF EXISTS week1_workshop;
CREATE DATABASE week1_workshop;
-- connect via psql
\c week1_workshop

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;


---
--- CREATE tables
---

CREATE TABLE products (
    id SERIAL,
    name TEXT NOT NULL,
    discontinued BOOLEAN NOT NULL,
    supplier_id INT,
    category_id INT,
    PRIMARY KEY (id)
);


CREATE TABLE categories (
    id SERIAL,
    name TEXT UNIQUE NOT NULL,
    description TEXT,
    picture TEXT,
    PRIMARY KEY (id)
);

-- TODO create more tables here...
-- Task 1
CREATE TABLE suppliers (
    id SERIAL,
    name TEXT NOT NULL,
    PRIMARY KEY (id)
);

-- Task 2: create a customers table
CREATE TABLE customers (
    id SERIAL,
    company_name TEXT NOT NULL,
    PRIMARY KEY (id)
);

-- Task 3: create an employees table
CREATE TABLE employees (
    id SERIAL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    PRIMARY KEY (id)
);

-- Task 4: create an orders table
CREATE TABLE orders (
    id SERIAL,
    date DATE,
    customer_id INT NOT NULL,
    employee_id INT,
    PRIMARY KEY (id)
);

-- Task 5: create an orders_products table as a bridge table to implement the many-to-many relationship between the Order and Product entities
CREATE TABLE orders_products (
    product_id INT,
    order_id INT,
    quantity INT NOT NULL,
    discount NUMERIC NOT NULL,
    PRIMARY KEY (product_id, order_id)
);

-- Task 6: create territories table
CREATE TABLE territories (
    id SERIAL,
    description TEXT NOT NULL,
    PRIMARY KEY (id)
);

-- Task 7: create employees_territories table
CREATE TABLE employees_territories (
    employee_id INT,
    territory_id INT,
    PRIMARY KEY (employee_id, territory_id)
);

-- Task 8: create offices table
CREATE TABLE offices (
    id SERIAL,
    address_line TEXT NOT NULL,
    territory_id INT NOT NULL,
    PRIMARY KEY (id)
); 

-- Task 9: create us_states table
CREATE TABLE us_states (
    id SERIAL,
    name TEXT NOT NULL,
    abbreviation CHARACTER(2) NOT NULL,
    PRIMARY KEY (id)
);

---
--- Add foreign key constraints
---

-- PRODUCTS

ALTER TABLE products
ADD CONSTRAINT fk_products_categories 
FOREIGN KEY (category_id) 
REFERENCES categories (id);


-- TODO create more constraints here...
-- Task 10: write two ALTER TABLE statements to enforce the two foreign key references from the orders table (order-to-customer and order-to-employee). For the first of the two ALTER TABLE statements, add a constraint named fk_orders_customers with the foreign key of customer_id that references customers. For the second, add a constraint named fk_orders_employees with the foreign key of employee_id that references employees.
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customers 
FOREIGN KEY (customer_id)
REFERENCES customers (id);

ALTER TABLE orders
ADD CONSTRAINT fk_orders_employees 
FOREIGN KEY (employee_id)
REFERENCES employees (id);


