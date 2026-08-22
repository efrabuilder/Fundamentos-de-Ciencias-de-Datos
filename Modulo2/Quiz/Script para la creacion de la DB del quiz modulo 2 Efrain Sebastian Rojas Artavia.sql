create database registromatricula -- Command to create the data base
go

use registromatricula -- command to save the data and tables on the data base that has been already created
go

create table alumnos (               -- command to create table alumnos
DNI int not null primary key, -- on the table there is one primary key, in this case is DNI that has been declareted as int
nombre varchar (15) not null, --varchar is used to data that use words and numbers
apellido Varchar (15) not null, 
email Varchar (20) not null, 
telefono int not null, -- int is used to data that only use numbers
domicilio Varchar (50) not null)

create table docentes (  -- command to create table docentes
DNI int not null primary key, -- on the table there is one primary key, in this case is DNI that has been declareted as int
nombre varchar (15) not null, 
apellido Varchar (15) not null, --varchar is used to data that use words and numbers
email Varchar (20) not null,  -- not null means that inside the table isn't possible not to add data on the variable asigned on this column
telefono int not null,
domicilio Varchar (50) not null)

create table asignaturas ( -- command to create table asignaturas
codigo int not null primary key, -- on the table there is one primary key, in this case is codigo that has been declareted as int
nombre varchar (15)not null,
periodo int not null,
modalidad varchar (10) not null, --varchar is used to data that use words and numbers
carrera varchar (15) not null,
DNIdocente int not null,
foreign key (DNIdocente) references docentes(DNI)) -- foreign key is used to call the data asigned on other table. We also can understand it as called as the product of the relation-identity between the principal tables.

create table calificacion ( -- command to create table calificacion
DNI_alumno int not null,
codigo_asignatura int not null, 
nota decimal(4,2) not null, -- Decimal is used when you need to define variables that are decimal, in this case the accepted range is before the comma four digites and after the comma just two. I'd decided to use decimal because, float usually represent the decimal with a lot of digites and the variable "nota" needs an exact value, so decimal is used when you have to define range, min and max that is possible to insert. 
primary key (DNI_alumno, codigo_asignatura),
foreign key (DNI_alumno) references alumnos(DNI), -- foreign key is used to call the data asigned on other table. We also can understand it as called as the product of the relation-identity between the principal tables.
foreign key (codigo_asignatura) references asignaturas(codigo))

