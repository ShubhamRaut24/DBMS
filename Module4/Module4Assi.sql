 select * from Customer;
 select * from EventRequest;
-- Q1) List the customer number, the name, the phone number, and the city of customers
   select CustNo, CustName, Phone, City from Customer;
   
-- Q2)List the customer number, the name, the phone number, and the city of customers who reside in Colorado (State is CO).
   select CustNo, CustName, Phone, City from Customer where State="CO";
  
-- Q3)List all columns of the EventRequest table for events costing more than $4000.  Order the result by the event date (DateHeld).
   select * from EventRequest where estcost>4000 order by DateHeld ;
  
-- Q4) List the event number, the event date (DateHeld), and the estimated audience number with approved status and audience greater
--   than 9000 or with pending status and audience greater than 7000.
    select eventno,dateheld,estaudience,status as Statuses from EventRequest WHERE (status = 'Approved' AND estaudience > 9000) 
                                                             OR (status = 'Pending' AND estaudience > 7000);
                                                             
-- Q5) List the event number, event date (DateHeld), customer number and customer name of events
--  placed in January 2018 by customers from Boulder. 
  select EventNo, DateHeld, Customer.CustNo, CustName
  from EventRequest, Customer
  where  City = "Boulder" AND DateHeld BETWEEN '2018-12-01'AND '2018-12-31' AND EventRequest.CustNo = Customer.CustNo; 
  
-- Q6) List the average number of resources used (NumberFld) by plan number. Include only location number L100.
  select PlanNo, avg(NumberFld) as Avarage from EventPlanLine where LocNo='L100' group by PlanNo ;
  
-- Q7) List the average number of resources used (NumberFld) by plan number. 
-- Only include location number L100. Eliminate plans with less than two event lines containing location number L100.
 select PlanNo, avg(NumberFld) as Avarage, count(*) as NumEventLines from EventPlanLine where LocNo = 'L100'
  group by PlanNo
  HAVING COUNT(*) > 1;