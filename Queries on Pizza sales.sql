--Basic
--Retrieve the total number of orders placed.
select count(order_id) as total_orders from orders;

----Calculate the total revenue generated from pizza sales.
select ROUND(sum(od.quantity * p.price),2) as total_sales
from order_details od
join pizzas p
on p.pizza_id = od.pizza_id 

--Identify the highest-priced pizza.
select top 1 pt.name,p.price 
from pizza_types pt
join pizzas p
on pt.pizza_type_id=p.pizza_type_id
order by p.price DESC;

--Identify the most common pizza quantity ordered.
select quantity , count(order_details_id)
from order_details 
group by quantity
order by quantity ;

--Identify the most common pizza size ordered.
select p.size , count(od.order_details_id) as order_count
from pizzas p
join order_details od
on p.pizza_id= od.pizza_id 
group by p.size 
order by order_count desc ;

--List the top 5 most ordered pizza types 
--along with their quantities.
select top 5 pt.name , sum(od.quantity) as quantity
from pizza_types pt
join pizzas p
on pt.pizza_type_id= p.pizza_type_id
join order_details od
on od.pizza_id =p.pizza_id
group by pt.name 
order by quantity desc;

--intermediate
--Join the necessary tables to find the 
--total quantity of each pizza category ordered.
select pt.category, sum(od.quantity) as quantity
from pizza_types pt
join pizzas p
on pt.pizza_type_id= p.pizza_type_id
join order_details od
on od.pizza_id = p.pizza_id
group by pt.category 
order by quantity desc;

--Determine the distribution of orders by hour of the day.
select datepart(hour,order_time) as hour , count(order_id) as order_count
from orders
group by datepart(hour,order_time)
order by order_count desc;

--Join relevant tables to find the 
--category-wise distribution of pizzas.
select category , count(name) from pizza_types
group by category;

--Group the orders by date and calculate the average 
--number of pizzas ordered per day.
select round(avg(quantity),0)as avg_pizza_ordered_per_day from 
(select o.order_date, sum(od.quantity) as quantity
from orders o
join order_details od
on o.order_id = od.order_id 
group by o.order_date) as order_quantity; 

--Determine the top 3 most ordered pizza types based on revenue.
select pt.name , 
od.quantity * p.price as revenue 
from pizza_types pt
join pizzas p
on p.pizza_type_id= pt.pizza_type_id
join order_details od
on od.pizza_id = p.pizza_id;


--Advance
--Analyze the cumulative revenue generated over time
select order_date , sum(revenue) over (order by order_date) as cum_revenue
from 
(select o.order_date,
sum(od.quantity * p.price) as revenue 
from order_details od 
join pizzas p 
on od.pizza_id = p.pizza_id
join orders o 
on o.order_id = od.order_id
group by o.order_date) as sales ;


--Calculate the percentage contribution of each pizza type to total revenue
select pt.category , 
round(sum(od.quantity * p.price)/(select round(sum(od.quantity * p.price),2) as total_sales
from order_details od
join pizzas p 
on p.pizza_id = od.pizza_id)*100,2) as revenue 
from pizza_types pt 
join pizzas p 
on pt.pizza_type_id = p.pizza_type_id
join order_details od 
on od.pizza_id = p.pizza_id
group by pt.category 
order by revenue desc;

--Determine the top 3 most ordered pizza types based on revenue for each pizza category
select name , revenue 
from (select category , name , revenue , 
rank() over(partition by category order by revenue desc) as rn
from 
(select pt.category , pt.name , 
sum((od.quantity )* p.price) as revenue 
from pizza_types pt 
join pizzas p 
on pt.pizza_type_id = p.pizza_type_id
join order_details od 
on od.pizza_id = p.pizza_id
group by pt.category , pt.name) as a) as b
where rn<=3;
