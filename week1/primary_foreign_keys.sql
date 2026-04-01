-- For MySQL, run the following command to set up the database environment:
DROP DATABASE IF EXISTS tcss445_sp26;
CREATE DATABASE tcss445_sp26;
USE tcss445_sp26;

-- Create the first table: Customers
-- CustomerID is the Primary Key. It uniquely identifies each customer.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

-- Create the second table: Orders
-- OrderID is the Primary Key for this table.
-- CustomerID is the Foreign Key linking back to the Customers table.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Step 1: Insert initial valid customers.
-- These statements will execute successfully.
INSERT INTO Customers (CustomerID, CustomerName) VALUES (1, 'Alice');
INSERT INTO Customers (CustomerID, CustomerName) VALUES (2, 'Bob');

-- Step 2: Test Primary Key uniqueness.
-- This will FAIL because CustomerID 1 is already assigned to Alice.
INSERT INTO Customers (CustomerID, CustomerName) VALUES (1, 'Charlie');

-- Step 3: Test Primary Key nullability.
-- This will FAIL because a Primary Key cannot be empty.
INSERT INTO Customers (CustomerID, CustomerName) VALUES (NULL, 'David');

-- Step 4: Insert valid orders.
-- These will execute successfully. Notice that Alice can have multiple orders.
INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES (101, '2026-04-01', 1);
INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES (102, '2026-04-02', 2);
INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES (103, '2026-04-03', 1);

-- Step 5: Test Primary Key on the Orders table.
-- This will FAIL because OrderID 101 already exists in the system.
INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES (101, '2026-04-04', 2);

-- Step 6: Test Foreign Key constraint on insert.
-- This will FAIL because CustomerID 99 does not exist in the Customers table.
INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES (104, '2026-04-05', 99);

-- Step 7: Test Foreign Key constraint on update.
-- This will FAIL because you cannot assign an existing order to a non-existent customer.
UPDATE Orders SET CustomerID = 99 WHERE OrderID = 101;

-- Step 8: Test Foreign Key constraint on delete.
-- This will FAIL because Bob still has an active order in the Orders table.
-- The database protects the child records from becoming orphans.
DELETE FROM Customers WHERE CustomerID = 2;

-- Step 9: Resolve the dependency to allow deletion.
-- First, delete the child record belonging to Bob. This will succeed.
DELETE FROM Orders WHERE OrderID = 102;

-- Step 10: Now try deleting the parent record again.
-- This will SUCCEED because Bob no longer has any associated orders.
DELETE FROM Customers WHERE CustomerID = 2;

-- Step 11: Final check to view the remaining clean data.
SELECT * FROM Customers;
SELECT * FROM Orders;