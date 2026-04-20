use pitza

go

select   *from [pizza_sales_excel_file ]
go
--. Total Revenue:
 create or Alter view total_revnue as 
select sum ( total_price) as [total_revenue]
from [pizza_sales_excel_file ]
go
--Average Order Value
create or alter view Average_order as
select sum(total_price)/count(distinct order_id)as avg_order_value
from [pizza_sales_excel_file ]
go
--Total Pizzas Sold
create or alter view total_pizzas as
select sum (quantity)as total_pizzas
from [pizza_sales_excel_file ]
go
--4. Total Orders
create or alter view total_order as
select count(distinct order_id)as total_orders
from [pizza_sales_excel_file ]
go
--Average Pizzas Per Order
create or alter view Average_Pizzas_Per_Order as
select cast(
 cast(sum (quantity)as Decimal(10,2))/
 cast(count(distinct order_id)as decimal(10,2))
 as decimal(10,2))asAverage_Pizzas_Per_Order 
from [pizza_sales_excel_file ]
go
--. Daily Trend for Total Orders
create or alter view Daily_Trend_for_Total_Orders as

select 
datepart(weekday,order_date) as dey_num,
datename(weekday,order_date)as dey_name,
count(distinct order_date)as Daily_Total_Orders
from [pizza_sales_excel_file ]
group by datepart(weekday,order_date) ,datename(weekday,order_date)

go
--C. Monthly Trend for Orders
create or alter view Monthly_Trend_for_Total_Orders as

select 
datepart(month,order_date) as month_num,
datename(month,order_date)as month_name,
count(distinct order_date)as Daily_Total_Orders
from [pizza_sales_excel_file ]
group by datepart(month,order_date) ,datename(MONTH,order_date)
go
--% of Sales by Pizza Category
create or alter view   of_Sales_by_Pizza_Category as
select 
pizza_category, ROUND (sum(total_price),2)as total_sales,
 round( sum(total_price)*100.0/(select sum (total_price)from [pizza_sales_excel_file ]),2)as pct
from [pizza_sales_excel_file ]
group by pizza_category
go

--% of Sales by Pizza size
create or alter view   of_Sales_by_Pizza_size as
select 
pizza_size, ROUND (sum(total_price),2)as total_sales,
 round( sum(total_price)*100.0/(select sum (total_price)from [pizza_sales_excel_file ]),2)as pst
from [pizza_sales_excel_file ]
group by pizza_size
go
create or alter view   total_pizza_sold_by_category as
select
pizza_category,sum (Quantity)as	total_quantity_sold
from [pizza_sales_excel_file ]
group by pizza_category
go
--top 5 Best seliers===
create or alter view   top_5_pizza_by_Revenue as
select top 5 pizza_name,
round(sum(total_price) ,2 )as total_Revenue
from [pizza_sales_excel_file ]
group by pizza_name
go

--top 5 Best Quantity===
create or alter view   top_5_pizza_by_Quantity as
select top 5 pizza_name,
round(sum(quantity) ,2 )as total_Quantity
from [pizza_sales_excel_file ]
group by pizza_name
go

--top 5 Best order===
create or alter view   top_5_pizza_by_order as
select top 5 pizza_name,
round(count(distinct order_id),2 )as total_order
from [pizza_sales_excel_file ]
group by pizza_name
order by total_order Asc
go
 
--Bottom 5 Best order===
create or alter view   Bottom_5_pizza_by_Revenue as
select top 5 pizza_name,
round(sum (total_price)	,2 )as total_Revenue
from [pizza_sales_excel_file ]
group by pizza_name
order by total_Revenue
go

