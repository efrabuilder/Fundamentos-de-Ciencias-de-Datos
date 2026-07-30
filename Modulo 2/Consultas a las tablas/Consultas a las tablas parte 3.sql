select count (*) -- count is used to share the total of variable in a table. 
as total_clientes -- as is used to name the new table with the consult.
from cliente
go

select count (limite_credito) -- count is calling variables with the name of the cosult
as clientes_con_credito -- name of the new table.
from cliente
go

select sum (limite_credito) -- sum is  calling the total of all the variables with this name in one value.
as total_credito -- name of the new table.
from cliente
go

select sum (codigo_cliente) -- sum is  calling the total of all the variables with this name in one value.
as total_clientes -- name of the new table.
from cliente
go

select sum (total) -- sum is  calling the total of all the variables with this name in one value.
as total_pagos -- name of the new table.
from pago;
go


select avg (limite_credito) -- avg is calling  the average from the variable has already used.
as promedio_credito --name of the new table.
from cliente
go


select avg (total) -- avg is calling  the average from the variable has already used.
as total_de_pago --name of the new table.
from pago
go

select min (limite_credito) --min is calling the minimun possible from the variable has already used.
as credito_minimo -- name of new table
from cliente
go

select min (total) --min is calling the minimun possible from the variable has already used.
as min_pago -- name of new table
from pago
go


select max (limite_credito) -- max is calling the maximun possible from the variable has already used.
as max_limite_credito -- name of new table.
from cliente
go

select max (total) -- max is calling the maximun possible from the variable has already used.
as max_pago -- name of new table.
from pago
go

select 
    max(limite_credito) as max_credito, -- max is calling the maximun possible from the variable has already used.
    min(limite_credito) as min_credito, -- min is calling the minimun possible from the variable has already used.
    count(limite_credito) as count_credito, -- count is used to share the total of variable in a table.
    avg(limite_credito) as avg_credito,  -- avg is calling  the average from the variable has already used.
    sum(limite_credito) as sum_credito -- sum is  calling the total of all the variables with this name in one value.
from cliente;
go


select codigo_cliente,
count (*)
as total_pedidos
from pedido
group by codigo_cliente -- group by is selecting and agruping in one table all the variables with the name has already used.
having count (*) > 5; -- taking the limit has already defined. 



select nombre,avg(precio_venta) as promedio_venta  -- share all sells
from producto 
group by nombre 
having avg(precio_venta) < 10;
go


select gama, avg(precio_venta) -- share average of sells.
as promedio_venta
from producto
group by gama
having avg (precio_venta) < 10;
go 

select codigo_pedido,-- all code_products from detalle_pedido, that has been sold, but just big orders.
sum(cantidad) as total_productos 
from detalle_pedido 
group by codigo_pedido 
having sum(cantidad) > 100;

select pais, -- share all costumers from country, but just from countries with many costumers.
count(codigo_cliente) as total_clientes 
from cliente 
group by pais 
having count(codigo_cliente) > 5;

select   -- in this consult is possible create a new table with content from two or more tables. Is important to make a sign to difference the variables from one table to the other (c, p)
    c.nombre_cliente, 
    p.codigo_pedido, 
    p.fecha_pedido 
from 
    cliente c 
inner join -- (union interna) inner join, permit the access to both tables.
    pedido p 
on 
    c.codigo_cliente = p.codigo_cliente;
go

select    -- in this consult is possible create a new table with content from two or more tables. Is important to make a sign to difference the variables from different table
    c.nombre_cliente, 
    p.codigo_pedido, 
    pr.nombre as producto, 
    dp.cantidad 
from cliente c 
inner join pedido p on c.codigo_cliente = p.codigo_cliente   -- (union interna) inner join, permit the access to both tables.
inner join detalle_pedido dp on p.codigo_pedido = dp.codigo_pedido 
inner join producto pr on dp.codigo_producto = pr.codigo_producto;
go

select    -- in this consult is possible create a new table with content from two or more tables. Is important to make a sign to difference the variables from different table
    c.nombre_cliente, 
    p.codigo_pedido
from cliente c left join pedido p
on c.codigo_cliente = p.codigo_cliente;
go

select  -- in this consult is possible create a new table with content from two or more tables. Is important to make a sign to difference the variables from different table
    c.nombre_cliente, 
    p.codigo_pedido 
from cliente c 
left join  pedido p on c.codigo_cliente = p.codigo_cliente 
where p.codigo_pedido is null; -- the consult just share nulls.
go

select  -- in this consult is possible create a new table with content from two or more tables. Is important to make a sign to difference the variables from different table
    p.codigo_pedido, 
    pr.nombre, 
    dp.cantidad 
from 
    producto pr 
right join 
    detalle_pedido dp on pr.codigo_producto = dp.codigo_producto 
right join 
    pedido p on dp.codigo_pedido = p.codigo_pedido;
