use db_jardineria -- commmand to use db.
go



-- consulting in specific table
select * -- * means that is equal to everything.
from cliente 
go 

select *
from cliente 
where nombre_contacto != 'Jose' -- <> != means that the result will be different
go

select nombre_contacto, apellido_contacto, telefono
from cliente 
where nombre_contacto 
like 'luis%' -- like '----%' means that the result will be as similar as the variable you are thinking. And the percentage signal is after the word 
go

select nombre_contacto, apellido_contacto, telefono
from cliente 
where nombre_contacto 
like '%an' -- like '%----' means that the result will be the variable that ends with the word used to make the consult. And the percentage signal is before the word 
go

select nombre_contacto, apellido_contacto, telefono
from cliente 
where nombre_contacto 
like '%io' -- like '%----' means that the result will be the variable that ends with the word used to make the consult. And the percentage signal is before the word 
go

select nombre_contacto, apellido_contacto, telefono
from cliente 
where nombre_contacto 
like 'j%' -- like '----%' means that the result will be as similar as the variable you are thinking. And the percentage signal is after the word
go


select nombre_contacto, apellido_contacto, telefono
from cliente 
where nombre_contacto 
like '%b%' -- like '%----%' means that the result will contain the word in the consult. And the percentage signal are before and after the word.
go


select *
from cliente 
where limite_credito > 3000 -- '<' lower, '<=' lower or equal, '>' higher, '>=' higher or equal; means that the result of the consult will share the limits, in besides.
go


select *
from cliente 
where limite_credito >= 1000 -- '<' lower, '<=' lower or equal, '>' higher, '>=' higher or equal; means that the result of the consult will share the limits, in besides.
go

select *
from cliente
where nombre_contacto = 'Anne'
and limite_credito > 18 -- logical operators, and it succeed to add more consults at the same time.   
go

select *
from cliente
where limite_credito > 3000
and ciudad = 'miami' -- logical operators, and it succeed to add more consults at the same time.  And share just the variables from the name of the consult.         
go


select *
from cliente
where limite_credito > 3000
or ciudad = 'miami' -- logical operators, or it succeed to add more consults at the same time.  Or share all the variables, two oe more conditions.          
go

select *
from cliente
where linea_direccion2 is null -- logical operators, null is used to find variables null.          
go

select nombre_contacto, telefono
from cliente
where linea_direccion2 is null -- logical operators, null is used to find variables null.          
go

select * 
from cliente
where not ciudad = 'San Francisco'
go
