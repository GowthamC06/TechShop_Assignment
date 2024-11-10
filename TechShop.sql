--Creating a Database
Create Database TechShop

--Creating Customers table
Create Table Customers(
CustomerID int identity Primary Key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Email varchar(50) unique not null,
Phone varchar(20),
Address varchar(50))

--Creating Categories Table
Create Table Categories(
CategoryID int identity Primary key,
CategoryName varchar(50) Not null)

--Creating Products table
Create Table Products(
ProductID int identity Primary Key,
ProductName varchar(100) not null,
Description varchar(500),
Price decimal(10,2) not null,
CategoryID int not null,
Foreign key (CategoryID) references Categories(CategoryID))

--Creating Orders table
Create Table Orders (
OrderID int identity primary Key,
CustomerID int not null,
OrderDate date not null,
TotalAmount decimal(10,2) default 0,
Foreign Key(CustomerID) references Customers(CustomerID))

--Creating OrderDetails table 
Create Table OrderDetails (
OrderDetailID int identity Primary Key,
OrderID int not null,
ProductID int not null,
Quantity int not null,
Foreign Key (OrderID) references Orders(OrderID) on delete Cascade,
Foreign Key (ProductID) references Products(ProductID))

--Creating Inventory table
Create Table Inventory (
InventoryID int identity Primary Key,
ProductID int not null,
QuantityInStock int not null,
LastStockUpdate date not null,
Foreign key (ProductID) references Products(ProductID))

--Inserting data for Customers Table
Insert into Customers (FirstName, LastName, Email, Phone, Address)
Values
      ('Mike', 'Taylor', 'miketaylor23@gmail.com', '1234567890', '1/4 Marine Street'),
      ('john', 'Wick', 'johnwick06@gmail.com', '1234567891', '5/9 Gandhi Street'),
      ('Michael', 'Jackson', 'michaeljackson08@gmail.com', '1234567892', '6/2 clocktower Street'),
      ('Linda', 'Thomson', 'lindathomson89@gmail.com', '1234567893', '48 Redhills Street'),
      ('Robert', 'Junior', 'robertjunior03@gmail.com', '1234567894', '12 Pine Street'),
      ('Daniel', 'Wilson', 'danielwilson56@gmail.com', '1234567895', '4/5 Mars Street'),
      ('Laura', 'Anderson', 'lauraa13@gmail.com', '1234567896', '13 Nehru Street'),
      ('David', 'Brown', 'davidb2@gmail.com', '1234567897', '6 Sona Street'),
      ('Jack', 'Smith', 'jackss4@gmail.com', '1234567898', '3/4 Church Street'),
      ('Sara', 'David', 'sarad6@gmail.com', '1234567899', '186 God valley Street')

--Inserting data for Category Table
 Insert into Categories (CategoryName)
Values 
      ('Electronic Gadgets'),
      ('Home Appliances'),
      ('Office Supplies'),
      ('Outdoor Equipment')

--Inserting data for Products Table
Insert into Products(ProductName, Description, Price,CategoryID)
Values
      ('Laptop', '14 inch screen,FHD Touchscreen, Intel Celeron N4500 processor, 4GB RAM', 19990,3),
      ('Smartphone', '6.1 inch display, dual cameras, 64GB ROM', 30999,1),
      ('Headphone', 'Noise canceling wireless headphones', 1500,1),
      ('Smartwatch', 'Fitness tracking, heart rate monitoring', 1999,1),
      ('Tablet', '8.7 inch screen, 64GB ROM, Wi-Fi', 12999,1),
      ('Camera', 'DSLR camera with 24MP resolution', 42490,1),
      ('Bluetooth Speaker', 'Portable speaker with 20W output', 1599,1),
      ('External Hard Disk Drive', '2TB Portable USB 3.0', 7299,3),
      ('PlayStation5 console', 'lightning Speed,3DAudio3 technology', 44990,1),
      ('Power Bank', '20000 mAh 22.5 W Power Bank', 1699,1)
	  
--Inserting data for Orders Table
Insert into Orders(CustomerID,OrderDate)
Values
      (1, '2024-10-25'),
      (2, '2024-10-26'),
      (3, '2024-10-27'),
      (4, '2024-10-28'),
      (5, '2024-10-29'),
      (6, '2024-10-30'),
      (7, '2024-11-01'),
      (8, '2024-11-02'),
      (9, '2024-11-03'),
      (10, '2024-11-04')
	 
--Inserting data for OrderDetails Table
Insert into OrderDetails(OrderID,ProductID,Quantity)
Values
      (1, 10, 2),
      (2, 7, 2),
      (3, 2, 1),
      (4, 6, 1),
      (5, 4, 1),
      (6, 5, 1),
      (7, 3, 2),
      (8, 1, 1),
      (9, 9, 1),
      (10, 7, 1)

--Inserting data for Inventory Table
Insert into Inventory(ProductID,QuantityInStock,LastStockUpdate)
Values
      (1, 90, '2024-09-06'),
      (2, 100, '2024-09-17'),
      (3, 80, '2024-09-23'),
      (4, 65, '2024-10-30'),
      (5, 125, '2024-10-26'),
      (6, 150, '2024-10-06'),
      (7, 46, '2024-11-02'),
      (8, 60, '2024-10-04'),
      (9, 48, '2024-09-29'),
      (10, 50, '2024-10-28')


--Task 2
--1. Retrieve the names and emails of all customers
Select 
      FirstName,
	  LastName,
	  Email
From 
    Customers

--2. List all orders with their order dates and corresponding customer names.
Select  
      OrderDate,
	  FirstName,
	  LastName
From 
    Orders
Join
    Customers on Customers.CustomerID=Orders.CustomerID 

--3. insert a new customer record into the Customers table
Insert into Customers 
Values
      ('Joe', 'Alex', 'joea04@gmail.com', '1234567800', '456 Wall Street')

--4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.
Select * From Products
Update Products
Set Price=Price*1.10

--5. Delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter.
Declare @OrderID int
Set @OrderID=3
Delete from Orders 
Where OrderID=@OrderID

--6. Insert a new order into the Orders table. Include the customer ID, order date, and any other necessary information.
Insert into Orders
Values
      (1,Getdate(),1500)

--7. Update the contact information of a specific customer in the Customers table. Allow users to input the customer ID and new contact information.
Declare @CustomerID int =1
declare @Phone varchar(20)=2345678901
Declare @Email varchar(50)='sam@gmail.com'
Declare @address varchar(50)='wallE Street'
Update Customers
Set Email=@Email,
    Phone=@Phone,
	Address=@Address
Where CustomerID=@CustomerID

--8. Recalculate and update the total cost of each order in the "Orders" table based on the prices and quantities in the "OrderDetails" table.
Update Orders
Set TotalAmount=(
Select  
      Sum(Od.Quantity *P.Price)
From 
    OrderDetails as Od
Join
    Products as P on Od.ProductID=P.ProductID
Where Od.OrderID=Orders.OrderID)

--9. delete all orders and their associated order details for a specific customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.
Declare @CustomerID int=2
Delete From 
          Orders 
Where CustomerID=@CustomerID

--10. Insert a new electronic gadget product into the "Products" table, including product name, category, price, and any other relevant details.
Insert into Products 
Values ('Mobile Charge','Quick charge 25W',500,1)

--11. update the status of a specific order in the "Orders" table (e.g., from "Pending" to "Shipped"). Allow users to input the order ID and the new status.
Alter table Orders
add Status varchar(20)

Declare @newstatus varchar(20)='Shipped'
Declare @OrderID int =5
Update Orders
Set Status=@newstatus
Where OrderID=@OrderID

--12.calculate and update the number of orders placed by each customer in the "Customers" table based on the data in the "Orders" table.
Alter Table Customers
Add Ordercount int Default 0

Update Customers 
Set Ordercount=(
Select 
      Count(*) from Orders
Where Orders.CustomerID=Customers.CustomerID)


--Task 3
--1. Retrieve a list of all orders along with customer information (e.g., customer name) for each order.
Select 
      O.OrderID,
	  O.OrderDate,
	  O.TotalAmount,
	  Cu.CustomerID,
      Cu.FirstName,
	  Cu.LastName,
	  Cu.Email,
	  Cu.Phone,
	  Cu.Address
From Orders as O
Join 
    Customers as Cu on Cu.CustomerID=O.CustomerID

--2. find the total revenue generated by each electronic gadget product. Include the product name and the total revenue.
Select 
       ProductName,
       Sum(od.Quantity*Price) as TotalRevenue
From 
    Products
Join
    OrderDetails as Od on Products.ProductID=Od.ProductID
Group by 
        ProductName
Order by 
        TotalRevenue

--3. List all customers who have made at least one purchase. Include their names and contact information.
Select 
      Cu.CustomerID,
	  Cu.FirstName,
	  Cu.LastName,
	  Cu.Email,
	  Cu.Phone,
	  Cu.Address 
From Customers as Cu
Join 
    Orders as O on Cu.CustomerID=O.CustomerID
GROUP BY 
        Cu.CustomerID, Cu.FirstName, Cu.LastName, 
        Cu.Email, Cu.Phone, Cu.Address

--4. find the most popular electronic gadget, which is the one with the highest total quantity ordered. Include the product name and the total quantity ordered.
select Top 1
           Products.ProductName, 
		   Sum(Quantity) as TotalQuantity
From 
    OrderDetails
Join
    Products on Products.ProductID=OrderDetails.ProductID
Group by 
        ProductName
Order by 
        TotalQuantity desc

--5. Retrieve a list of electronic gadgets along with their corresponding categories.
Select 
      Products.ProductName,
	  Categories.CategoryName 
From  
     Categories
Join 
    Products on Categories.CategoryID=Products.CategoryID

--6. Calculate the average order value for each customer. Include the customer's name and their average order value.
Select 
      Cu.CustomerID,
	  Cu.FirstName,
	  Cu.LastName,
      Avg(TotalAmount) as AverageOrder
from Customers as Cu
join
Orders as O on O.CustomerID=Cu.CustomerID
Group by 
        Cu.CustomerID,Cu.FirstName,Cu.LastName

--7. Find the order with the highest total revenue. Include the order ID, customer information, and the total revenue.
Select Top 1
    O.OrderID,
    Cu.CustomerID,
    Cu.FirstName,
    Cu.LastName,
    Cu.Email,
    Cu.Phone,
    O.TotalAmount AS TotalRevenue
From 
    Orders as O
Join
    Customers as Cu on O.CustomerID = Cu.CustomerID
Order by
        O.TotalAmount Desc

--8. List electronic gadgets and the number of times each product has been ordered.
Select 
       Products.ProductID,
       ProductName,
       Count(OrderDetails.OrderID) as TimesOrder
From 
     Products
join
     OrderDetails on Products.ProductID=OrderDetails.ProductID
Group by 
        Products.ProductID,ProductName
Order by 
        TimesOrder

--9. find customers who have purchased a specific electronic gadget product. Allow users to input the product name as a parameter.
Declare @ProductName varchar(50)='Headphone'
Select 
      Cu.CustomerID,
	  Cu.FirstName,
	  Cu.LastName,
	  Cu.Email,
	  Cu.Phone
From 
    Customers as Cu
Join
    Orders on Cu.CustomerID=Orders.CustomerID
Join
    OrderDetails on OrderDetails.OrderID=Orders.OrderID
Join
    Products on Products.ProductID=OrderDetails.ProductID
Where ProductName=@ProductName

--10. Calculate the total revenue generated by all orders placed within a specific time period. Allow users to input the start and end dates as parameters
Declare @StartDate Date='2024-10-27'
Declare @EndDate Date='2024-11-01'

Select
      Sum(TotalAmount) as totalRevenue
From 
     Orders
Where Orders.OrderDate between @StartDate and @EndDate


--Task 4
--1. Find out which customers have not placed any orders.
Select  
      Cu.CustomerID,
	  Cu.FirstName,
	  Cu.LastName,
	  Cu.Email,
	  Cu.Phone
From  
      Customers as Cu
Where not exists 
                (Select * From Orders 
                 Where Orders.CustomerID=Cu.CustomerID)

--2. Find the total number of products available for sale.
Select 
      Count(ProductID)
From 
     Products

--3. Calculate the total revenue generated by TechShop.
select
      Sum(TotalAmount)
from
     Orders

--4. Calculate the average quantity ordered for products in a specific category. Allow users to input the category name as a parameter.
Declare @CategoryName varchar(50)='Electronic Gadgets'
Select 
      Avg(Quantity)
from 
      OrderDetails
where ProductID in (
                    Select ProductID
					from Products
					where CategoryID=(
					select CategoryID
					from Categories
					where CategoryName=@CategoryName))


--5. Calculate the total revenue generated by a specific customer. Allow users to input the customer ID as a parameter.
Declare @CustomerID int 
set @CustomerID=1
select 
     Sum(TotalAmount)
from 
     Orders
where
     CustomerID=@CustomerID

--6. find the customers who have placed the most orders. List their names and the number of orders they've placed.
Select top 1
    Cu.CustomerID,
    Cu.FirstName,
    Cu.LastName,
    Count(O.OrderID) as OrderCount
From
    Customers as Cu
Join
    Orders as O on Cu.CustomerID = O.CustomerID
Group by 
    Cu.CustomerID, Cu.FirstName, Cu.LastName
Order by
    OrderCount desc

--7. Find the most popular product category, which is the one with the highest total quantity ordered across all orders.
Select Top 1
      P.CategoryID,
	  Sum(Od.Quantity) as TotalQuantityOrdered
From
    OrderDetails as Od
Join
    Products as P on Od.ProductID=P.ProductID
Group by 
        P.CategoryID
Order by
        TotalQuantityOrdered Desc

--8. Find the customer who has spent the most money (highest total revenue) on electronic gadgets. List their name and total spending.
Select Top 1
      Cu.CustomerID,
	  Cu.FirstName,
	  Cu.LastName,
	  Sum(Od.Quantity*P.Price) as TotalSpending
From 
    Customers as Cu
Join
    Orders as O on Cu.CustomerID=O.CustomerID
Join
    OrderDetails as Od on O.OrderID=Od.OrderID
Join
    Products as P on Od.ProductID=P.ProductID
Join 
    Categories as C on P.CategoryID=C.CategoryID
Where 
     C.CategoryName='Electronic Gadgets'
Group by
        Cu.CustomerID,Cu.FirstName,Cu.LastName
Order by
        TotalSpending Desc

--9. Calculate the average order value (total revenue divided by the number of orders) for all customers.
Select 
     Avg(TotalAmount) as AverageOrderValue
From 
    Orders
	--OR--
Select
    C.CustomerID,
    C.FirstName,
    C.LastName,
    sum(O.TotalAmount) / count(O.OrderID) as AverageOrderValue
From 
    Customers C
Join 
    Orders O on C.CustomerID = O.CustomerID
Group by 
    C.CustomerID, C.FirstName, C.LastName

--10. Find the total number of orders placed by each customer and list their names along with the order count.
Select Cu.CustomerID,
       Cu.FirstName,
	   Cu.LastName,(
	                Select Count(O.OrderID)
					From Orders as O
					Where O.CustomerID=Cu.CustomerID
					) as OrderCount
	   From Customers as Cu
	   Order By OrderCount Desc
                                                 