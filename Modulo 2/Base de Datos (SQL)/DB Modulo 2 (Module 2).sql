/*
(Base de datos) Ejercicio para practicar y familiarizarse con una DB.
En el curso de Fundamentos de Ciencia de Datos (Modulo 2).
Se pueden usar los comandos en mayuscula y minuscula.

(Data Base) Challenge to practice and improve on DB,
Fundaments of Data Science (Module 2),
We can use commands in Capital Letter and Lower Case.

Efrain Sebastian Rojas Artavia

15/07/2026

*/ 

create database dbmodulo2 --crear base de datos -- Create Data Base.
go -- go siempre va en otra linea. -- go always is in another line.

use dbmodulo2 --registrar memoria (TABLAS) en la base de datos creada -- command to log memory on the data base that has been already created. In this case is tables and data.
go 


create table  usuario(id int not null,direccion varchar(50) not null,telefono int not null) -- crear tabla  usuario, que no acepta valores nulos. -- command to create table user (usuario). it doesn't accept nulls.
go 

create table producto (id int not null, nombre varchar(20) not null,precio int not null) -- crear tabla producto, que no acepta valores nulos. -- command to create table product (producto), it doesn't accept nulls.
go


insert into usuario (id, direccion, telefono) -- insertar datos en la tabla usuario. -- command to add and insert data on the specific table. In this case is on 'usuario'.
values
(1, 'Calle Principal 101', 88112233),(2, 'Avenida 2, Casa 45', 88445566),(3, 'Residencial Los Robles 12', 77223344),(4, 'Barrio El Centro, Local 5', 22558899),(5, 'Calle La Luna 789', 66332211),(6, 'Condominio Altamira B-4', 88990011),(7, 'Frente al Parque Central', 22774411),(8, 'Diagonal 4, Sector 3', 88552277),(9, 'Urbanización del Sol 102', 66448822),(10, 'Callejón Los Pinos 5', 77114499);
go

insert into producto (id, nombre, precio) -- insertar datos en la tabla, especificamente en la tabla producto. -- command to add and insert data on the specific table. In this case is on 'producto'.
values
(1, 'Teclado', 25000),(2, 'Mouse', 15000),(3, 'Monitor', 15000),(4, 'Impresora', 80000),(5, 'Webcam', 45000),(6, 'Audifonos', 30000),(7, 'Microfono', 60000),(8, 'Parlantes', 40000),(9, 'Disco Duro', 750000),(10, 'Memoria USB',12000);
go


insert into producto (id, nombre, precio) -- insertar datos en la tabla, especificamente en la tabla producto. -- command to add and insert data on the specific table. In this case is on 'producto'.
values
(11, 'Bolso', 50000);
go

select * from producto --mostrar la tabla. -- command to share the table that is calling.
go

