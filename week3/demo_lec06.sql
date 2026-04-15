/* Initialize the database */
DROP DATABASE IF EXISTS Lec06Demo;
CREATE DATABASE Lec06Demo;
USE Lec06Demo;

/* Create tables based on the lecture schema */
CREATE TABLE Company (
    cid INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE Product (
    pid INT PRIMARY KEY,
    pname VARCHAR(50),
    price DECIMAL(10, 2),
    cid INT,
    FOREIGN KEY (cid) REFERENCES Company(cid)
);

/* Insert sample data */
INSERT INTO Company (cid, cname, city) VALUES
(1, 'TechCorp', 'Seattle'),
(2, 'GadgetInc', 'Bellevue'),
(3, 'EmptyBoxCo', 'Tacoma');

INSERT INTO Product (pid, pname, price, cid) VALUES
(101, 'Laptop', 1200.00, 1),
(102, 'Mouse', 25.00, 1),
(103, 'Keyboard', 75.00, 2);


/* ========================================= */
/* Example 1: Subquery in SELECT clause      */
/* ========================================= */

/* Retrieve product name and the city of its manufacturer using a subquery */
SELECT 
    X.pname, 
    (SELECT Y.city FROM Company Y WHERE Y.cid = X.cid) AS City
FROM 
    Product X;

/* Unnested version using implicit INNER JOIN as shown in the lecture */
SELECT 
    X.pname, 
    Y.city
FROM 
    Product X, Company Y
WHERE 
    X.cid = Y.cid;


/* ========================================= */
/* Example 2: Aggregation + Nested Queries   */
/* ========================================= */

/* Count the number of products for each company using a subquery in SELECT */
SELECT 
    DISTINCT C.cname,
    (SELECT COUNT(*) FROM Product P WHERE P.cid = C.cid) AS ProductCount
FROM 
    Company C;

/* Unnested using implicit INNER JOIN and GROUP BY */
/* This query misses EmptyBoxCo because it has zero products */
SELECT 
    C.cname, 
    COUNT(*) AS ProductCount
FROM 
    Company C, Product P
WHERE 
    C.cid = P.cid
GROUP BY 
    C.cname;

/* Correct unnested version using LEFT OUTER JOIN */
/* We use COUNT(P.pid) instead of COUNT(*) to correctly report 0 for EmptyBoxCo */
SELECT 
    C.cname, 
    COUNT(P.pid) AS ProductCount
FROM 
    Company C
LEFT OUTER JOIN 
    Product P ON C.cid = P.cid
GROUP BY 
    C.cname;