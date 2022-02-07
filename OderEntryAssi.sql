SELECT * FROM Order_Entry.Product;
-- Q1) List the order number, order date, customer number, customer name (first and last), 
-- employee number, and employee name (first and last) ofJanuary 2017 orders placed by Colorado customers.
select  OrdNo, OrdDate, Customer.CustNo, CustFirstName, CustLastName, Employee.EmpNo, EmpFirstName, EmpLastName
from OrderTbl, Customer, Employee
where  CustState = 'CO' and OrdDate between '2017-01-01' and '2017-01-31'
and OrderTbl.CustNo = Customer.CustNo 
and OrderTbl.EmpNo = Employee.EmpNo;

SELECT OrdNo, OrdDate, Customer.CustNo, CustFirstName, CustLastName,Employee.EmpNo, EmpFirstName, EmpLastName
FROM OrderTbl INNER JOIN Customer ON OrderTbl.CustNo = Customer.CustNo 
INNER JOIN Employee ON OrderTbl.EmpNo = Employee.EmpNo
WHERE CustState = 'CO' AND OrdDate BETWEEN '2017-01-01' AND '2017-01-31';

-- Q2)List the customer number, name (first and last), order number, order date, employee number, employee 
-- name (first and last), product number, product name, and order cost (OrdLine.Qty * ProdPrice) for 
-- products ordered on January 23, 2017, in which the order cost exceeds $150.

select Customer.CustNo, CustFirstName, CustLastName, OrderTbl.OrdNo, OrdDate, Employee.EmpNo, EmpFirstName, EmpLastName, Product.ProdNo, ProdName, ProdPrice*Qty AS OrderCost
from OrderTbl, OrdLine, Product, Customer, Employee
where OrdDate = '2017-01-23' and ProdPrice*Qty > 150
and OrderTbl.OrdNo = OrdLine.OrdNo
and OrdLine.ProdNo = Product.ProdNo
and OrderTbl.CustNo = Customer.CustNo
and Employee.EmpNo = OrderTbl.EmpNo;

SELECT Customer.CustNo, CustFirstName, CustLastName, OrderTbl.OrdNo,OrdDate, Employee.EmpNo, EmpFirstName, EmpLastName, Product.ProdNo, ProdName, ProdPrice*Qty AS OrderCost
FROM OrderTbl INNER JOIN Customer ON OrderTbl.CustNo = Customer.CustNo 
              INNER JOIN Employee ON OrderTbl.EmpNo = Employee.EmpNo
              INNER JOIN OrdLine ON OrderTbl.OrdNo = OrdLine.OrdNo
              INNER JOIN Product ON OrdLine.ProdNo = Product.ProdNo
WHERE OrdDate = '2017-01-23' AND ProdPrice*Qty > 150;

-- Q3. List the order number and total amount for orders placed on January 23, 2017. 
-- The total amount of an order is the sum of the quantity times the product price of each product on the order.

select OrderTbl.OrdNo, SUM(Qty*ProdPrice) as TotOrdAmt
from OrderTbl, OrdLine, Product
where OrdDate = '2017-01-23'
and OrderTbl.OrdNo = OrdLine.OrdNo
and OrdLine.ProdNo = Product.ProdNo
group by OrderTbl.OrdNo;
  
  SELECT OrderTbl.OrdNo, SUM(Qty*ProdPrice) AS TotOrdAmt
  FROM OrderTbl 
  INNER JOIN OrdLine ON OrderTbl.OrdNo = OrdLine.OrdNo
  INNER JOIN Product ON OrdLine.ProdNo = Product.ProdNo
  WHERE OrdDate = '2017-01-23'
  GROUP BY OrderTbl.OrdNo;


-- Q4. List the order number, order date, customer name (first and last), and total amount for orders placed on 
-- January 23, 2017. The total amount of an order is the sum of the quantity times the product price of each product on the order.

select OrderTbl.OrdNo, OrdDate, CustFirstName, CustLastName, SUM(Qty*ProdPrice) as TotOrdAmt
from OrderTbl, OrdLine, Product, Customer
where OrdDate = '2017-01-23'
and OrderTbl.OrdNo = OrdLine.OrdNo
and OrdLine.ProdNo = Product.ProdNo
and Customer.CustNo = OrderTbl.CustNo
group by OrderTbl.OrdNo, OrdDate, CustFirstName, CustLastName;

SELECT OrderTbl.OrdNo, OrdDate, CustFirstName, CustLastName, 
SUM(Qty*ProdPrice) AS TotOrdAmt
FROM OrderTbl INNER JOIN OrdLine ON OrderTbl.OrdNo = OrdLine.OrdNo
              INNER JOIN Product ON OrdLine.ProdNo = Product.ProdNo
              INNER JOIN Customer ON Customer.CustNo = OrderTbl.CustNo
              WHERE OrdDate = '2017-01-23'
		      GROUP BY OrderTbl.OrdNo, OrdDate, CustFirstName, CustLastName;


-- Q5. Insert yourself as a new row in the Customer table.

insert into Customer (CustNo, CustFirstName, CustLastName, CustStreet, CustCity, CustState,CustZip, CustBal)
values ('C9999999', 'Michael', 'Mannino', '123 Any Street', 'MyTown', 'CO','80217-0211', 500);


-- Q6. Insert an imaginary friend as a new row in the Employee table.
insert into Employee ( EmpNo, EmpFirstName, EmpLastName, EmpPhone, EmpCommRate, EmpEmail)
values ('E9999999', 'Mary', 'Mannino', '(720)543-1234', 0.04, 'Mary.Mannino@abc.com');

-- Q7. Increase the price by 10 percent of products containing the words Ink Jet.
set SQL_SAFE_UPDATES = 0;

update Product set ProdPrice = ProdPrice * 1.1 
  where  ProdName like '%Ink Jet%';
  
set SQL_SAFE_UPDATES = 1;

-- Q8. Delete the new row added to the Customer table.
delete from Customer where CustNo = 'C9999999';

