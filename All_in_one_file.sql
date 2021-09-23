-- Question 1

select sum (Quantity*UnitPrice) as TotalSales
from [dbo].[Sales]



-- Question 2

select count (distinct Customer) as Number_of_Customers
from [dbo].[Sales]



-- Question 3

select Product, sum (Quantity) as TotalQuantity
from [dbo].[Sales]
group by Product



-- Question 4

select Customer, sum (UnitPrice*Quantity) as TotalBuy, count (distinct orderid) as Number_of_Orders, sum (Quantity) as TotalQuantity
from [dbo].[Sales]
where Customer in
(select Customer from [dbo].[Sales]
group by Customer, OrderID
having sum (UnitPrice*Quantity) > 1500)
group by Customer



-- Question 5

with P as (select UnitPrice, Quantity, 
case when [dbo].[Profit].[ProfitRatio] is null then Quantity * UnitPrice * 0.1
else Quantity * UnitPrice * ProfitRatio end as Profit
from [dbo].[Sales] full join [dbo].[Profit] on Sales.Product = Profit.Product)

select sum (Profit) as TotalProfit, (sum (Profit)/ sum (Quantity*UnitPrice) *100) as TotalProfitPercentage
from P
