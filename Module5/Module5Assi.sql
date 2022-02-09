SELECT * FROM Athelit_Database.EventRequest;

-- Q1) List the event number, date held, customer number, customer name, facility number, and facility name of 2018
--  events placed by Boulder customers.
select EventNo, DateHeld,Customer.CustNo, CustName,Facility.FacNo,FacName from Facility,EventRequest,Customer where
EventRequest.CustNo = Customer.CustNo And EventRequest.FacNo = Facility.FacNo
And City='Boulder' And  DateHeld BETWEEN '2018-12-01' And '2018-12-31';

-- Q2) List the customer number, customer name, event number, date held, facility number, facility name, 
-- and estimated audience cost per person (EstCost / EstAudience) for events held on 2018, 
-- in which the estimated cost per person is less than $0.2
select Customer.CustNo, CustName,EventNo,DateHeld,Facility.FacNo,FacName,
estcost/estaudience as AvgCost from EventRequest,Facility,Customer
where EventRequest.CustNo = Customer.CustNo 
And EventRequest.FacNo = Facility.FacNo And estcost/estaudience < 0.2
and DateHeld between '2018-01-01' AND '2018-12-31';

-- Q3) List the customer number, customer name, and total estimated costs for Approved events. 
-- The total amount of events is the sum of the estimated cost for each event. Group the results by customer number and customer name.

select Customer.CustNo, CustName, sum(estcost) as TotalCost from EventRequest, Customer 
where EventRequest.CustNo = Customer.CustNo And 
status = 'Approved' Group by  Customer.CustNo, CustName;   

  select Customer.CustNo, CustName, SUM(EstCost) As TotEstCost
  from EventRequest inner join Customer 
  on EventRequest.CustNo = Customer.CustNo
  where status = 'Approved'
  group by Customer.CustNo, CustName;
  
  -- Q4) Insert yourself as a new row in the Customer table.
 insert into Customer 
(CustNo, CustName, Address, Internal, Contact, Phone, City, State, Zip)
values ('C9999999', 'Michael Mannino', '123 Any Street', 'Y', 'Self', '720000','Denver', 'CO', '80204');

-- Q5) Increase the rate by 10 percent of nurse resource in the resource table.
  SET SQL_SAFE_UPDATES = 0;
update Resource
  set rate = rate * 1.1 
  where resname = 'nurse';
  
  SET SQL_SAFE_UPDATES = 1;
  
--   Q6) Delete the new row added to the Customer table.
delete from Customer where CustNo = 'C9999999';
  
  
               
               
  