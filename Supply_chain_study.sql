# Q1. Find the total amount spent and the number of time products ordered by the customer whose ID is 85
Select customerId, sum(totalAmount), count(*) no_of_time_product
from orders group by customerId having customerId = 85;

#2. Find the supplier name who supplies chai to us.
select s.id, CompanyName, ContactName, productName
from supplier s join product p 
on s.id = p.SupplierId
where productName = 'Chai';


# 3. Display the city-wise total products ordered and their total amount.
Select City, sum(totalAmount), Count(Ordernumber) total_products
from customer c join orders o 
on c.Id = o.CustomerId
group by City;


# 4. Get me the customers id, name where they do not spend at all.
Select c.id, FirstName, lastname, totalamount
from customer c left join orders o
on c.id = o.CustomerId
where totalamount is NULL;


# 5. Display the customer's ID, and name where their total spend is least.
Select c.id, firstname, lastname, sum(totalamount)
from customer c join orders o
on c.id = o.customerId
group by c.id, firstname, lastname
order by sum(totalamount) asc limit 1;


# 6.  Display the country-wise total top 5 products where the total number orderes are greater than 50. # Note the top 5 products defind based on total amount.
Select Count(*) total_no_orders, country, productname, sum(totalamount)
from supplier s join product p
on s.Id = p.SupplierId
join orderitem oi
on p.Id = oi.ProductId
join orders o
on oi.orderID = o.Id
group by country, productname
having Count(*) > 50
order by sum(totalamount) desc limit 5;


# 7. Disply the product that has done high business and display the total number of suppliers who supplied it.
Select distinct productname, count(supplierId) total_no_suppliers, sum(oi.unitprice*quantity) high_business
from product p  join orderitem oi
on p.Id = oi.productId 
group by productname 
order by high_business desc limit 1;


# 8. Who are the customer who ordered the above products more than or equal to 2 times?
Select distinct productname, o.customerId, Count(distinct o.Id) as num_ordered
from product p join orderitem oi on p.Id = oi.productid
join orders o on o.id = oi.orderId
where productname = 'Côte de Blaye'
group by 1,2
having num_ordered>=2;


# 9. Display the customer ID who had done more than 4 orders in any of the months during 2013.
Select year(orderdate) as y, month(orderdate) as m, customerId 
from orders 
group by year(orderdate), customerId, month(orderdate)
having count(ordernumber)> 4 and y =2013; 


# 10. Show me the order number which got ordered with less price and display the corresponding product and any one supplier name.
Select ordernumber, totalAmount , productname, Companyname
from orders o join orderitem oi
on o.Id = oi.orderId 
join product p 
on oi.productId = p.Id
join Supplier s 
on p.supplierId = s.Id
order by totalAmount asc;


# 11. Find the average unit price of the products which got ordered by the customer who had done highest nunber of orders during 2014.
Select avg(unitprice), count(ordernumber), customerId, year(Orderdate)
from orders o join orderitem oi
on o.Id = oi.orderId
where year(Orderdate) = 2014
group by customerId, year(Orderdate)
order by count(ordernumber) desc limit 1;


# 12. Find the average unit price of the products which got ordered by the customer who had done lowest purchase during 2012.
Select avg(unitprice), count(ordernumber), customerId, year(Orderdate)
from orders o join orderitem oi
on o.Id = oi.orderId
where year(Orderdate) = 2012
group by customerId, year(Orderdate)
order by count(ordernumber) asc limit 5; 