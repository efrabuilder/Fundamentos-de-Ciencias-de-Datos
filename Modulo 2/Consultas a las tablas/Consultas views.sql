create view total_pagos_cliente --create a new view with new name.
as
select codigo_cliente, sum(total) as total_pagado
from pago
group by codigo_cliente;
go

select *
from total_pagos_cliente;
go

create view productos_caros --create a new view with new name. Create a new table.
as 
select nombre, precio_venta
from producto
where precio_venta > 100;
go

select * 
from productos_caros;
go

create view vista_cliente --create a new view with new name.
as
select nombre_cliente, ciudad, pais
from cliente;
go

select * 
from vista_cliente;
go
