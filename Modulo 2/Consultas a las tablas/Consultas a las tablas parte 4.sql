use db_jardineria
go

--Looking for logs with region null
select *
from cliente
where region is null;
go

--Looking for logs with codido_jefe null
select nombre, apellido1, apellido2, codigo_jefe
from empleado
where codigo_jefe is null;
go

--share orders even tought wasn't delivery
select codigo_pedido, fecha_pedido, fecha_entrega
from pedido
where fecha_entrega is null;
go

-- share clients where limite_credito isn't null
select nombre_cliente, limite_credito
from cliente
where limite_credito is not null; -- !=
go

--share offices that has a second address, when you can see a space empty, but you have requested just logs without null, is because it had inserted with '' empty.

select ciudad, linea_direccion2
from oficina
where linea_direccion2 is not null;
go

--share the oppositive of variable when the logs are null. COALESCE
select nombre_cliente, coalesce (region, 'sin_region') as region
from cliente;
go

--share the oppositive of variable when the logs are null. COALESCE
select nombre, apellido1, apellido2, 
coalesce(cast(codigo_jefe as varchar), 'no tiene jefe') --cast is used when the variable isn't from the same type of the variable from the query. So it's helping to transform and access to the space from the column with other variable.
as codigo_jefe
from empleado;
go


--Pedidos que ya fueron entregados
SELECT codigo_pedido, fecha_entrega
FROM pedido
WHERE fecha_entrega IS NOT NULL;

--Clientes con representante de ventas
SELECT nombre_cliente, codigo_empleado_rep_ventas
FROM cliente
WHERE codigo_empleado_rep_ventas IS NOT NULL;

--Clientes con límite de crédito
SELECT nombre_cliente, limite_credito
FROM cliente
WHERE limite_credito IS NOT NULL;

---Clientes que tienen región y límite de crédito

SELECT nombre_cliente, region, limite_credito
FROM cliente
WHERE region IS NOT NULL
AND limite_credito IS NOT NULL;
