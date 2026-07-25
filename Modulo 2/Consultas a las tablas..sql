select * from pago --command to see a specif table.
go
select * from cliente --command to see a specif table.
go
select * from detalle_pedido --command to see a specif table.
go
select * from empleado --command to see a specif table.
go
select * from gama_producto --command to see a specif table.
go
select * from oficina --command to see a specif table.
go
select * from pedido --command to see a specif table.
go
select * from producto --command to see a specif table.
go

select codigo_oficina, ciudad --command to find a specific data from a table
from oficina
go

select codigo_oficina, ciudad --command to find a specific data from a table
from oficina
where pais = 'España'
go

select codigo_oficina, ciudad, telefono, region --command to find a specific data from a table
from oficina
go

select codigo_oficina, ciudad --command to find a specific data from a table
from oficina
where pais = 'EEUU'
go

select codigo_empleado, nombre, apellido1, apellido2, email --command to find a specific data from any table, where means a filter.
from empleado
where codigo_jefe = 7
go

select codigo_empleado, nombre, apellido1, apellido2, email --command to find a specific data from any table, where means a filter.
from empleado
where codigo_jefe is NULL -- when data is null is necesary to use "is" before, because null isn't a value 
go

select codigo_empleado, nombre, apellido1, apellido2, puesto --command to find a specific data from any table, where means a filter.
from empleado
where puesto != 'Representante Ventas' -- we use single quotation mark when the variable is varchar  or are words.
go