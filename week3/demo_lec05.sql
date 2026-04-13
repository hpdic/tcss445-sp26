/* 1. Initialization: Clean up and recreate the demo database */
DROP DATABASE IF EXISTS Lec05Demo;
CREATE DATABASE Lec05Demo;
USE Lec05Demo;

/* ========================================= */
/* PART 1: GROUP BY AND HAVING               */
/* Based on the Purchase schema from Lec05.  */
/* ========================================= */

CREATE TABLE AggregationPurchase (
    product VARCHAR(50),
    price DECIMAL(5,2),
    quantity INT
);

/* Insert sample data from lecture slides */
INSERT INTO AggregationPurchase (product, price, quantity) VALUES
('Bagel', 3.00, 20),
('Bagel', 1.50, 20),
('Banana', 0.50, 50),
('Banana', 2.00, 10),
('Banana', 4.00, 10);

/* Demonstration of GROUP BY */
/* Goal: Calculate total quantity for each product where price > 1 */
SELECT product, SUM(quantity) AS TotalSales
FROM AggregationPurchase
WHERE price > 1
GROUP BY product;

/* Demonstration of HAVING */
/* Goal: Filter groups to show only those with total quantity > 30 */
SELECT product, SUM(price * quantity) AS TotalRevenue
FROM AggregationPurchase
WHERE price > 1
GROUP BY product
HAVING SUM(quantity) > 30;

/* ========================================= */
/* PART 2: OUTER JOINS                       */
/* Based on Product and Purchase schemas     */
/* ========================================= */

CREATE TABLE Product (
    name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE StorePurchase (
    prodName VARCHAR(50),
    store VARCHAR(50)
);

/* Insert sample join data [cite: 84, 85] */
INSERT INTO Product (name, category) VALUES
('Gizmo', 'gadget'),
('Camera', 'Photo'),
('OneClick', 'Photo');

INSERT INTO StorePurchase (prodName, store) VALUES
('Gizmo', 'Wiz'),
('Camera', 'Ritz'),
('Camera', 'Wiz'),
('MysteryItem', 'Target');

/* Demonstration of LEFT OUTER JOIN */
/* Includes products even if they have never been sold (e.g., OneClick) */
SELECT Product.name, StorePurchase.store
FROM Product
LEFT OUTER JOIN StorePurchase ON Product.name = StorePurchase.prodName;

/* Demonstration of RIGHT OUTER JOIN */
/* Includes all sales records even if the product info is missing */
SELECT Product.name, StorePurchase.store
FROM Product
RIGHT OUTER JOIN StorePurchase ON Product.name = StorePurchase.prodName;

/* Demonstration of FULL OUTER JOIN  */
/* MySQL doesn't support FULL OUTER JOIN syntax, so we use UNION  */
/* This combines both left and right table unmatched rows */
SELECT Product.name, StorePurchase.store
FROM Product
LEFT OUTER JOIN StorePurchase ON Product.name = StorePurchase.prodName
UNION
SELECT Product.name, StorePurchase.store
FROM Product
RIGHT OUTER JOIN StorePurchase ON Product.name = StorePurchase.prodName;