            
-- Store Table: Stores information about Nike stores.
CREATE TABLE Store (
    StoreID INT PRIMARY KEY, -- Unique identifier for each store.
    StoreName VARCHAR(255), -- Name of the store.
    StoreLocation VARCHAR(255), -- Location of the store.
    OpeningDate DATE -- Date when the store opened.
);

-- Insert data into the Store table
INSERT INTO Store (StoreID, StoreName, StoreLocation, OpeningDate)
VALUES
(1, 'Nike Store 1', 'New York', '2023-01-01');
	
select * from store;

-- Employee Table: Stores information about employees working at Nike.
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY, -- Unique identifier for each employee.
    StoreID INT, -- Identifies the store where the employee works.
    FirstName VARCHAR(255), -- First name of the employee.
    LastName VARCHAR(255), -- Last name of the employee.
    Address VARCHAR(255), -- Employee's address.
    Performance INT, -- Employee's performance metric.
    Salary DECIMAL(10, 2), -- Employee's salary.
    Department VARCHAR(255), -- Employee's department.
    JobTitle VARCHAR(255), -- Employee's job title.
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID) -- Establishes a relationship with the Store table.
);

-- Insert data into the Employee table
INSERT INTO Employee (EmployeeID, StoreID, FirstName, LastName, Address, Performance, Salary, Department, JobTitle)
VALUES
    (1, 1, 'John', 'Doe', '789 Elm St, Villagetown', 90, 50000.00, 'Sales', 'Sales Associate');

select * from employee;

-- Suppliers Table: Stores information about suppliers.
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY, -- Unique identifier for each supplier.
    Name VARCHAR(255), -- Supplier's name.
    ContactNumber VARCHAR(255), -- Supplier's contact number.
    PaymentTerms VARCHAR(255), -- Payment terms with the supplier.
    Rating INT -- Supplier's rating.
);

INSERT INTO Suppliers (SupplierID, Name, ContactNumber, PaymentTerms, Rating)
VALUES
    (1, 'Supplier A', '123-456-7890', 'Net 30', 4);

select * from suppliers;

-- Manufacturers Table: Stores information about manufacturers.
CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY, -- Unique identifier for each manufacturer.
    Name VARCHAR(255), -- Manufacturer's name.
    ContactNumber VARCHAR(255), -- Manufacturer's contact number.
    LeadTime INT -- Waiting time until the order is received.
);

-- Insert data into the Manufacturers table
INSERT INTO Manufacturers (ManufacturerID, Name, ContactNumber, LeadTime)
VALUES
    (1, 'Manufacturer X', '111-222-3333', 10);
	
select * from manufacturers;

-- Inventory Table: Stores information about items in the inventory.
CREATE TABLE Inventory (
    ItemID INT PRIMARY KEY, -- Unique identifier for each inventory item.
    ItemName VARCHAR(255), -- Name of the item.
    Price DECIMAL(10, 2), -- Price of the item.
    InStockQuantity INT, -- Quantity of the item in stock.
    ToOrderQuantity INT, -- Quantity to order.
    LastOrderDate DATE -- Date of the last order for the item.
);

INSERT INTO Inventory (ItemID, ItemName, Price, InStockQuantity, ToOrderQuantity, LastOrderDate)
VALUES
    (1, 'Running Shoes', 89.99, 100, 50, '2023-01-15');

select * from inventory;

-- Orders Table: Keeps track of all orders placed by Nike.
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY, -- Unique identifier for each order.
    SupplierID INT, -- Identifies the supplier associated with the order.
    ManufacturerID INT, -- Identifies the manufacturer associated with the order.
    OrderDate DATE, -- Date when the order was placed.
    OrderStatus VARCHAR(255), -- Status of the order.
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID), -- Establishes a relationship with the Suppliers table.
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID) -- Establishes a relationship with the Manufacturers table.
);

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, SupplierID, ManufacturerID, OrderDate, OrderStatus)
VALUES
    (1, 1, 1, '2023-01-20', 'Pending');

select * from orders;

-- OrderDetail Table: Provides detailed information about items in an order.
CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY, -- Unique identifier for each order detail.
    OrderID INT, -- Identifies the order associated with the detail.
    ItemID INT, -- Identifies the item associated with the detail.
    ItemQuantity INT, -- Quantity of the item in the order.
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), -- Establishes a relationship with the Orders table.
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID) -- Establishes a relationship with the Inventory table.
);

-- Insert data into the OrderDetail table
INSERT INTO OrderDetail (OrderDetailID, OrderID, ItemID, ItemQuantity)
VALUES
    (1, 1, 1, 30);
	
select * from orderdetail;

-- Customers Table: Stores information about customers.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY, -- Unique identifier for each customer.
    JoiningDate DATE, -- Date when the customer joined.
    FirstName VARCHAR(255), -- Customer's first name.
    LastName VARCHAR(255), -- Customer's last name.
    ShippingAddress VARCHAR(255), -- Customer's shipping address.
    BillingAddress VARCHAR(255), -- Customer's billing address.
    ContactNumber VARCHAR(255) -- Customer's contact number.
);

-- Insert data into the Customers table
INSERT INTO Customers (CustomerID, JoiningDate, FirstName, LastName, ShippingAddress, BillingAddress, ContactNumber)
VALUES
  (1, '2023-01-01', 'Alice', 'Smith', '123 Main St, Cityville', '456 Business St, Cityville', '555-123-4567');

select * from customers;

-- WebSales Table: Keeps track of sales made through the website.
CREATE TABLE WebSales (
    TransactionID INT PRIMARY KEY, -- Unique identifier for each web sale.
    CustomerID INT, -- Identifies the customer associated with the sale.
    TotalAmount DECIMAL(10, 2), -- Total amount of the sale.
    PaymentMethod VARCHAR(255), -- Payment method used.
    PaymentStatus VARCHAR(255), -- Payment status of the sale.
    ShippingAddress VARCHAR(255), -- Shipping address for the sale.
    ShippingMethod VARCHAR(255), -- Shipping method used.
    ShippingStatus VARCHAR(255), -- Shipping status of the sale.
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) -- Establishes a relationship with the Customers table.
);

INSERT INTO WebSales (TransactionID, CustomerID, TotalAmount, PaymentMethod, PaymentStatus, ShippingAddress, ShippingMethod, ShippingStatus)
VALUES
    (1, 1, 150.00, 'Credit Card', 'Paid', '123 Main St, Cityville', 'Standard', 'Shipped');

select * from websales;

-- StoreSales Table: Keeps track of sales made in Nike stores.
CREATE TABLE StoreSales (
    TransactionID INT PRIMARY KEY, -- Unique identifier for each store sale.
    StoreID INT, -- Identifies the store associated with the sale.
    CustomerID INT, -- Identifies the customer associated with the sale.
    EmployeeID INT, -- Identifies the employee associated with the sale.
    TotalAmount DECIMAL(10, 2), -- Total amount of the sale.
    TransactionDate DATE, -- Date of the sale.
    PaymentMethod VARCHAR(255), -- Payment method used.
    FOREIGN KEY (StoreID) REFERENCES Store(StoreID), -- Establishes a relationship with the Store table.
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID), -- Establishes a relationship with the Customers table.
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) -- Establishes a relationship with the Employee table.
);

INSERT INTO StoreSales (TransactionID, StoreID, CustomerID, EmployeeID, TotalAmount, TransactionDate, PaymentMethod)
VALUES
    (1, 1, 1, 1, 120.00, '2023-01-05', 'Cash');
	
select * from storesales;

-- StoreSalesItems Table: Provides detailed information about items sold in a store sale.
CREATE TABLE StoreSalesItems (
    SalesID INT PRIMARY KEY, -- Unique identifier for each store sale item.
    TransactionID INT, -- Identifies the store sale associated with the item.
    ItemID INT, -- Identifies the item associated with the item.
    QuantitySold INT, -- Quantity of the item sold.
    FOREIGN KEY (TransactionID) REFERENCES StoreSales(TransactionID), -- Establishes a relationship with the StoreSales table.
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID) -- Establishes a relationship with the Inventory table.
);

-- Insert data into the StoreSalesItems table
INSERT INTO StoreSalesItems (SalesID, TransactionID, ItemID, QuantitySold)
VALUES
    (1, 1, 1, 3);
	
select * from storesalesitems;

-- WebSalesItems Table: Provides detailed information about items sold in a web sale.
CREATE TABLE WebSalesItems (
    SalesID INT PRIMARY KEY, -- Unique identifier for each web sale item.
    TransactionID INT, -- Identifies the web sale associated with the item.
    ItemID INT, -- Identifies the item associated with the item.
    QuantitySold INT, -- Quantity of the item sold.
    FOREIGN KEY (TransactionID) REFERENCES WebSales(TransactionID), -- Establishes a relationship with the WebSales table.
    FOREIGN KEY (ItemID) REFERENCES Inventory(ItemID) -- Establishes a relationship with the Inventory table.
);

-- Insert data into the WebSalesItems table
INSERT INTO WebSalesItems (SalesID, TransactionID, ItemID, QuantitySold)
VALUES
    (1, 1, 1, 2);
	
select * from websalesitems;

--*******************************************Report Section*******************************************************************************
------------------- Report #1 Financial Overview for Chief Financial Officer----------------------------------
-- Retrieves total revenue, expenses, and net profit
-- Total revenue: The sum of total sales from web transactions
-- Expenses: The sum of expenses calculated based on ordered prices and their prices
-- Net Profit: Total revenue - Expenses
SELECT
    -- Total Revenue
    COALESCE(SUM(ws.TotalAmount), 0) AS total_revenue,-- Using COALESCE to handle cases where there are no web sales. Default to 0 if there are no sales.
    
    -- Total Expenses
    COALESCE(SUM(od.ItemQuantity * i.Price), 0) AS total_expenses,-- Using COALESCE to handle cases where there are no orders or items.. Default to 0 if there are no sales.
    
    -- Net Profit
    COALESCE(SUM(ws.TotalAmount), 0) - COALESCE(SUM(od.ItemQuantity * i.Price), 0) AS net_profit --Using COALESCE to handle cases where either revenue or expenses are null.Default to 0 if there is no revenue or expenses.

-- Retrieving data from the relevant tables:
FROM
    WebSales ws 
    LEFT JOIN WebSalesItems wsi ON ws.TransactionID = wsi.TransactionID -- Joining WebSalesItems to get details of items sold in web transactions.
    LEFT JOIN OrderDetail od ON ws.TransactionID = od.OrderID -- Joining OrderDetail to link web transactions with ordered items.
    LEFT JOIN Inventory i ON wsi.ItemID = i.ItemID; -- Joining Inventory to fetch item prices for expense calculation.

-----------------------Report #2: Supply Chain Overview: For Spply Chain Manager-----------------------------------------------
-- Selecting key supply chain metrics
--Inventory Summary:

SELECT
    -- Inventory Summary
    COUNT(Inventory.ItemID) AS total_items,-- Counting the total number of items in the inventory
    SUM(InStockQuantity) AS total_in_stock,-- Summing up the instock quantities 
    SUM(ToOrderQuantity) AS total_to_order,-- Summing up the quantities to order
    
    -- Supplier Performance
    -- Calculating the average rating of suppliers rounded to two decimal places
    round(AVG(Rating),2) AS average_supplier_rating,	--utilize the AVG function to assess overall supplier performance; DISINCT used to count only unique orders
 
    -- Open Orders
    COUNT(DISTINCT orders.OrderID) AS open_orders,-- counting the number of distinct open orders; helps monitoring the current workload 
    
	-- Late Deliveries
	
    COUNT(DISTINCT CASE WHEN OrderStatus = 'Delivered' AND CURRENT_DATE > OrderDate + LeadTime THEN orders.OrderID END) AS late_deliveries --Counting the number of distinct late deliveries
  -- identified orders marked as 'Delivered' where the current date exceeds the expected delivery date                                              


-- Retrieving data from the relevant tables:
FROM
    Inventory
    LEFT JOIN orderdetail ON Inventory.itemID = orderdetail.itemID --Joining OrderDetail to link inventory items with order details
    LEFT JOIN Orders ON orderdetail.orderID = Orders.orderID --joining orders to get order status and expected delivery dates
	LEFT JOIN suppliers ON orders.supplierID = suppliers.supplierID --joining suppliers to assess supplier performance based on ratings
    LEFT JOIN Manufacturers ON orders.orderID = Manufacturers.ManufacturerID;-- Joining manufacturers to get lead time for late delivery calculations

----------------------------Report #3: Store Performance Overview for Accounting Department-------------------------------------------------

--Selecting Key store performance metrics

--Store Sales Summary:
--Grouping by StoreID and StoreName to provide a summary for each store
--Summing up the total store sales and counting the number of distinct transactions
--Gives an overview of the sales performance for each store

SELECT
    s.StoreID,
    s.StoreName,
    SUM(ss.TotalAmount) AS total_store_sales, ----Summing up the total store sales
    COUNT(DISTINCT ss.TransactionID) AS total_transactions, -- counting the number of distinct transactions
    
	--Employee Performance 
	round(AVG(e.Performance),2) AS average_employee_performance --Calculate the average performance rating of employees for each store
--Utilizes the AVG function to assess the overall performance of store employees 

-- Retrieving data from the relevant tables:
FROM
    StoreSales ss
    JOIN Store s ON ss.StoreID = s.StoreID -- joining store to link store sales with with store details
    JOIN Employee e ON ss.EmployeeID = e.EmployeeID -- joining employee to assess the average performance of store employees
GROUP BY
    s.StoreID, s.StoreName; --grouping by storeID and storeName for a summary at the store level

---------------------------Report #4 Product Diversity and Customer Preferences: For Product Innovation Manager-----------------------------

--Selecting key metrics related to product diversity and customer preferences:

-- Product Details:
-- Retrieveing essential information about each product, including its ID, name, price, instock-quantity, and quantity to order
SELECT
    i.ItemID,
    i.ItemName,
    i.Price,
    i.InStockQuantity,
    i.ToOrderQuantity,
    COUNT(wsi.TransactionID) AS total_sales, -- counting the total sales for each product
    round(AVG(wsi.QuantitySold),2) AS avg_quantity_sold, --calculating the average quantity sold and round it up to the second decimal place
    MAX(wsi.QuantitySold) AS max_quantity_sold,--calculating the maximul quantity sold for each product
    MIN(wsi.QuantitySold) AS min_quantity_sold,--calculating the minimal quantity sold for each product
    MAX(ws.TotalAmount) AS max_transaction_amount,--capturing the heighst transaction amount
    MIN(ws.TotalAmount) AS min_transaction_amount,--capturing the lowest transaction amount
    COUNT(DISTINCT ws.CustomerID) AS unique_customers --counting the number of unique customers who purchased each product.

-- Retrieving data from the relevant tables:
FROM
    Inventory i
    LEFT JOIN WebSalesItems wsi ON i.ItemID = wsi.ItemID --Joining WebSalesItems to link products with web transactions and their sales details
    LEFT JOIN WebSales ws ON wsi.TransactionID = ws.TransactionID --joining websales to get additional transaction details

GROUP BY --(grouping by product attributes for a comprehensive summary at the product level)
    i.ItemID, i.ItemName, i.Price, i.InStockQuantity, i.ToOrderQuantity

ORDER BY
    total_sales DESC -- Sorting the results by total sales in descending order

LIMIT 10; --limiting to the top 10 products.






















