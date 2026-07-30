--Efrain Sebastian Rojas Artavia, Poryecto Final, Modulo 2


-- Creating DB, creando la DB.
create database registromatriculapf   --crear base de datos -- Create Data Base.
go

use registromatriculapf   --registrar memoria (TABLAS) en la base de datos creada -- command to log memory on the data base that has been already created. In this case is tables and data.
go


-- Creating tables from DB. Creando tablas para la base de datos.


create table carrera (  -- command to create table carrera / comando para crear la tabla carrera
codigo int not null primary key, -- primary key of the table, declared as int / llave primaria de la tabla, declarada como int
nombre varchar (30) not null, -- varchar is used for data with letters and numbers / varchar se usa para datos con letras y números
facultad varchar (50) not null) -- not null means the column can't be left empty / not null significa que la columna no puede quedar vacía
go

create table periodo (
codigo int not null primary key, -- primary key of the table / llave primaria de la tabla
nombre varchar (15) not null,
fecha_inicio date not null, -- date type is used for calendar dates / el tipo date se usa para fechas de calendario
fecha_fin date not null)
go

create table estudiante ( -- command to create table estudiante / comando para crear la tabla estudiante
dni int not null primary key, -- primary key, dni declared as int / llave primaria, dni declarado como int
nombre varchar (20) not null,
apellido1 varchar (20) not null,
apellido2 varchar (20) not null,
email varchar (30) not null,
telefono int not null, -- int is used for number-only data / int se usa para datos que solo contienen números
fecha_nacimiento date not null,
codigo_carrera int not null, -- foreign key column pointing to carrera / columna de llave foránea que apunta a carrera
foreign key (codigo_carrera) references carrera(codigo)) -- foreign key used to link this table with carrera / llave foránea usada para relacionar esta tabla con carrera
go

create table profesor ( -- command to create table profesor / comando para crear la tabla profesor
dni int not null primary key, -- primary key of the table / llave primaria de la tabla
nombre varchar (20) not null,
apellido1 varchar (20) not null,
apellido2 varchar (20) not null,
email varchar (30) not null,
telefono int not null,
especialidad varchar (30) not null)
go

create table curso ( -- command to create table curso / comando para crear la tabla curso
codigo int not null primary key, -- primary key of the table / llave primaria de la tabla
nombre varchar (30) not null,
creditos int not null,
codigo_carrera int not null, -- foreign key column pointing to carrera / columna de llave foránea que apunta a carrera
foreign key (codigo_carrera) references carrera(codigo)) -- links each curso to the carrera it belongs to / relaciona cada curso con la carrera a la que pertenece
go

create table grupo ( -- command to create table grupo / comando para crear la tabla grupo
codigo int not null primary key, -- primary key of the table / llave primaria de la tabla
codigo_curso int not null, -- foreign key column pointing to curso / columna de llave foránea que apunta a curso
codigo_profesor int not null, -- foreign key column pointing to profesor / columna de llave foránea que apunta a profesor
codigo_periodo int not null, -- foreign key column pointing to periodo / columna de llave foránea que apunta a periodo
cupo int not null, -- maximum number of students allowed in the group / cantidad máxima de estudiantes permitidos en el grupo
foreign key (codigo_curso) references curso(codigo), -- links grupo to its curso / relaciona el grupo con su curso
foreign key (codigo_profesor) references profesor(dni), -- links grupo to the profesor teaching it / relaciona el grupo con el profesor que lo imparte
foreign key (codigo_periodo) references periodo(codigo)) -- links grupo to the periodo it's offered in / relaciona el grupo con el periodo en que se ofrece
go

create table matricula ( -- command to create table matricula, resolves the N:M relationship between estudiante and grupo / comando para crear la tabla matricula, resuelve la relación N:M entre estudiante y grupo
dni_estudiante int not null, -- foreign key column pointing to estudiante / columna de llave foránea que apunta a estudiante
codigo_grupo int not null, -- foreign key column pointing to grupo / columna de llave foránea que apunta a grupo
fecha_matricula date not null,
nota decimal(4,2), -- decimal is used because the grade needs an exact value with fixed digits before and after the comma / decimal se usa porque la nota necesita un valor exacto con dígitos fijos antes y después de la coma
estado varchar (15) not null, -- current status of the enrollment (e.g. activo, retirado) / estado actual de la matrícula (ej. activo, retirado)
primary key (dni_estudiante, codigo_grupo), -- composite primary key, made of both foreign keys / llave primaria compuesta, formada por ambas llaves foráneas
foreign key (dni_estudiante) references estudiante(dni), -- links matricula to the enrolled estudiante / relaciona la matrícula con el estudiante matriculado
foreign key (codigo_grupo) references grupo(codigo)) -- links matricula to the grupo the estudiante joined / relaciona la matrícula con el grupo al que se unió el estudiante
go

create table pago ( -- command to create table pago / comando para crear la tabla pago
codigo int not null primary key, -- primary key of the table / llave primaria de la tabla
dni_estudiante int not null, -- foreign key column pointing to estudiante / columna de llave foránea que apunta a estudiante
monto decimal(10,2) not null, -- decimal is used to keep an exact monetary value / decimal se usa para mantener un valor monetario exacto
fecha_pago date not null,
metodo varchar (15) not null, -- payment method used (e.g. tarjeta, efectivo) / método de pago utilizado (ej. tarjeta, efectivo)
foreign key (dni_estudiante) references estudiante(dni)) -- links pago to the estudiante who made it / relaciona el pago con el estudiante que lo realizó
go

-- Making inserts to add data into DB, haciendo inserts para agregar datos a la base de datos.

use registromatriculapf -- select the database to insert data into / seleccionar la base de datos donde se insertarán los datos
go

-- ===================== CARRERA =====================
insert into carrera (codigo, nombre, facultad) values (1, 'Ingenieria en Sistemas', 'Facultad de Ingenieria') -- insert a row with values in column order / insertar una fila con valores en el orden de las columnas
go
insert into carrera (codigo, nombre, facultad) values (2, 'Administracion de Empresas', 'Facultad de Ciencias Economicas')
go
insert into carrera (codigo, nombre, facultad) values (3, 'Derecho', 'Facultad de Derecho')
go
insert into carrera (codigo, nombre, facultad) values (4, 'Medicina', 'Facultad de Ciencias de la Salud')
go

-- ===================== PERIODO =====================
insert into periodo (codigo, nombre, fecha_inicio, fecha_fin) values (1, '2026-I', '2026-01-15', '2026-05-30') -- date values must be in 'YYYY-MM-DD' format / los valores de tipo date deben ir en formato 'YYYY-MM-DD'
go
insert into periodo (codigo, nombre, fecha_inicio, fecha_fin) values (2, '2026-II', '2026-08-10', '2026-12-15')
go

-- ===================== ESTUDIANTE =====================
insert into estudiante (dni, nombre, apellido1, apellido2, email, telefono, fecha_nacimiento, codigo_carrera) -- codigo_carrera must match an existing codigo in carrera / codigo_carrera debe coincidir con un codigo existente en carrera
values (101, 'Maria', 'Rojas', 'Solano', 'maria.rojas@correo.com', 88451122, '2003-04-12', 1)
go
insert into estudiante (dni, nombre, apellido1, apellido2, email, telefono, fecha_nacimiento, codigo_carrera)
values (102, 'Carlos', 'Mendez', 'Vargas', 'carlos.mendez@correo.com', 87552211, '2002-11-03', 1)
go
insert into estudiante (dni, nombre, apellido1, apellido2, email, telefono, fecha_nacimiento, codigo_carrera)
values (103, 'Ana', 'Jimenez', 'Cordero', 'ana.jimenez@correo.com', 86223344, '2004-01-25', 2)
go
insert into estudiante (dni, nombre, apellido1, apellido2, email, telefono, fecha_nacimiento, codigo_carrera)
values (104, 'Luis', 'Fernandez', 'Aguilar', 'luis.fernandez@correo.com', 89114455, '2001-07-19', 3)
go
insert into estudiante (dni, nombre, apellido1, apellido2, email, telefono, fecha_nacimiento, codigo_carrera)
values (105, 'Sofia', 'Castro', 'Brenes', 'sofia.castro@correo.com', 85667788, '2003-09-08', 4)
go
insert into estudiante (dni, nombre, apellido1, apellido2, email, telefono, fecha_nacimiento, codigo_carrera)
values (106, 'Diego', 'Salas', 'Monge', 'diego.salas@correo.com', 84778899, '2002-03-30', 2)
go

-- ===================== PROFESOR =====================
insert into profesor (dni, nombre, apellido1, apellido2, email, telefono, especialidad) values (201, 'Roberto', 'Chacon', 'Ramirez', 'roberto.chacon@uni.com', 83112233, 'Bases de Datos') -- specialty as free text / especialidad como texto libre
go
insert into profesor (dni, nombre, apellido1, apellido2, email, telefono, especialidad) values (202, 'Patricia', 'Vindas', 'Leon', 'patricia.vindas@uni.com', 82223344, 'Redes')
go
insert into profesor (dni, nombre, apellido1, apellido2, email, telefono, especialidad) values (203, 'Jorge', 'Alvarado', 'Ureña', 'jorge.alvarado@uni.com', 81334455, 'Derecho Civil')
go
insert into profesor (dni, nombre, apellido1, apellido2, email, telefono, especialidad) values (204, 'Laura', 'Quiros', 'Barrantes', 'laura.quiros@uni.com', 80445566, 'Anatomia')
go

-- ===================== CURSO =====================
insert into curso (codigo, nombre, creditos, codigo_carrera) values (1, 'Bases de Datos I', 4, 1) -- codigo_carrera links each curso to its carrera / codigo_carrera relaciona cada curso con su carrera
go
insert into curso (codigo, nombre, creditos, codigo_carrera) values (2, 'Redes de Computadoras', 3, 1)
go
insert into curso (codigo, nombre, creditos, codigo_carrera) values (3, 'Contabilidad General', 3, 2)
go
insert into curso (codigo, nombre, creditos, codigo_carrera) values (4, 'Derecho Civil I', 4, 3)
go
insert into curso (codigo, nombre, creditos, codigo_carrera) values (5, 'Anatomia Humana', 5, 4)
go

-- ===================== GRUPO =====================
insert into grupo (codigo, codigo_curso, codigo_profesor, codigo_periodo, cupo) values (1, 1, 201, 1, 30) -- each foreign key must exist in its referenced table / cada llave foránea debe existir en su tabla referenciada
go
insert into grupo (codigo, codigo_curso, codigo_profesor, codigo_periodo, cupo) values (2, 2, 202, 1, 25)
go
insert into grupo (codigo, codigo_curso, codigo_profesor, codigo_periodo, cupo) values (3, 3, 201, 1, 35)
go
insert into grupo (codigo, codigo_curso, codigo_profesor, codigo_periodo, cupo) values (4, 4, 203, 2, 20)
go
insert into grupo (codigo, codigo_curso, codigo_profesor, codigo_periodo, cupo) values (5, 5, 204, 2, 15)
go

-- ===================== MATRICULA =====================
-- composite primary key (dni_estudiante, codigo_grupo), so each student can join the same group only once / llave primaria compuesta, cada estudiante puede unirse al mismo grupo solo una vez
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (101, 1, '2026-01-20', 90.50, 'activo')
go
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (101, 2, '2026-01-20', 85.00, 'activo')
go
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (102, 1, '2026-01-21', 78.25, 'activo')
go
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (103, 3, '2026-01-22', null, 'activo') -- nota can be null because the grade may not exist yet / nota puede ser null porque la calificación aún no existe
go
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (104, 4, '2026-08-11', 95.00, 'activo')
go
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (105, 5, '2026-08-12', 60.00, 'retirado')
go
insert into matricula (dni_estudiante, codigo_grupo, fecha_matricula, nota, estado) values (106, 3, '2026-01-23', 88.75, 'activo')
go

-- ===================== PAGO =====================
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (1, 101, 150000.00, '2026-01-18', 'tarjeta') -- decimal(10,2) keeps two exact digits after the comma / decimal(10,2) mantiene dos dígitos exactos después de la coma
go
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (2, 102, 150000.00, '2026-01-19', 'transferencia')
go
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (3, 103, 120000.00, '2026-01-19', 'efectivo')
go
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (4, 104, 180000.00, '2026-08-05', 'tarjeta')
go
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (5, 105, 200000.00, '2026-08-06', 'transferencia')
go
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (6, 106, 120000.00, '2026-01-20', 'efectivo')
go
insert into pago (codigo, dni_estudiante, monto, fecha_pago, metodo) values (7, 101, 50000.00, '2026-03-10', 'tarjeta') -- a student can appear in more than one pago row / un estudiante puede aparecer en más de una fila de pago
go


-- Making consults to data from DB, haciendo consultas.

use registromatriculapf -- select the database to query / seleccionar la base de datos donde se harán las consultas
go

-- TABLA: ESTUDIANTE

select * -- shows every student with all their data, useful to check the raw table before filtering / muestra todos los estudiantes con todos sus datos, útil para revisar la tabla completa antes de filtrar
from estudiante
go

select nombre, apellido1, apellido2
from estudiante
where codigo_carrera = 1 -- lists only students enrolled in carrera 1 (Ingenieria en Sistemas) / lista solo los estudiantes matriculados en la carrera 1 (Ingeniería en Sistemas)
go

select nombre, apellido1, fecha_nacimiento
from estudiante
order by fecha_nacimiento asc -- orders students from oldest to youngest, useful to see who enrolled at what age / ordena los estudiantes de más viejo a más joven, útil para ver quién se matriculó a qué edad
go

select distinct codigo_carrera -- shows which carreras actually have at least one student registered, without repeating the code / muestra qué carreras tienen al menos un estudiante registrado, sin repetir el código
from estudiante
go

select top 3 nombre, apellido1, apellido2 -- returns only the first 3 students found, useful for quick previews on large tables / devuelve solo los primeros 3 estudiantes encontrados, útil para vistas rápidas en tablas grandes
from estudiante
go

select nombre, apellido1
from estudiante
where nombre like 'M%' -- finds students whose first name starts with 'M', useful for name-based searches / busca estudiantes cuyo nombre empieza con 'M', útil para búsquedas por nombre
go

select nombre, apellido1
from estudiante
where apellido1 like '%ez' -- finds students whose last name ends in 'ez', a common pattern in Spanish surnames / busca estudiantes cuyo apellido termina en 'ez', un patrón común en apellidos en español
go

select nombre, apellido1
from estudiante
where apellido1 like '%ar%' -- finds students whose last name contains 'ar' anywhere, useful when you only remember part of the name / busca estudiantes cuyo apellido contiene 'ar' en cualquier parte, útil cuando solo se recuerda parte del nombre
go

select nombre, fecha_nacimiento
from estudiante
where fecha_nacimiento between '2002-01-01' and '2003-12-31' -- lists students born between 2002 and 2003, useful to group by age range / lista estudiantes nacidos entre 2002 y 2003, útil para agrupar por rango de edad
go

select nombre, codigo_carrera
from estudiante
where codigo_carrera in (1, 3) -- lists students belonging to either carrera 1 or carrera 3, without writing two separate OR conditions / lista estudiantes que pertenecen a la carrera 1 o a la carrera 3, sin escribir dos condiciones OR separadas
go

select nombre, codigo_carrera
from estudiante
where not codigo_carrera = 2 -- lists every student except those in carrera 2, useful to exclude one specific group / lista todos los estudiantes excepto los de la carrera 2, útil para excluir un grupo específico
go

select nombre, telefono, codigo_carrera
from estudiante
where codigo_carrera = 1
and telefono > 87000000 -- lists students from carrera 1 whose phone number is above a threshold, both conditions must be true / lista estudiantes de la carrera 1 cuyo teléfono es mayor a un umbral, ambas condiciones deben cumplirse
go

select nombre, codigo_carrera
from estudiante
where codigo_carrera = 2
or codigo_carrera = 4 -- lists students from carrera 2 or carrera 4, only one condition needs to be true / lista estudiantes de la carrera 2 o de la carrera 4, solo una condición necesita cumplirse
go

select codigo_carrera, count(*) as total_estudiantes -- shows how many students are enrolled per carrera, useful to see which carreras are more popular / muestra cuántos estudiantes hay matriculados por carrera, útil para ver cuáles carreras son más populares
from estudiante
group by codigo_carrera
go

select count(*) as total_estudiantes -- shows the total number of students registered in the university / muestra el total de estudiantes registrados en la universidad
from estudiante
go

-- TABLA: CARRERA

select * -- shows every carrera with its facultad, the base catalog everything else references / muestra todas las carreras con su facultad, el catálogo base que referencian las demás tablas
from carrera
go

select nombre, facultad
from carrera
where codigo in (select codigo_carrera from curso where creditos >= 4) -- shows only carreras that offer at least one course worth 4 or more credits / muestra solo las carreras que ofrecen al menos un curso de 4 créditos o más
go

-- TABLA: CURSO

select * -- shows every course offered, with its credits and the carrera it belongs to / muestra todos los cursos ofrecidos, con sus créditos y la carrera a la que pertenecen
from curso
go

select nombre, creditos
from curso
where codigo_carrera = 1 -- lists only the courses that belong to carrera 1, useful to build a curriculum view / lista solo los cursos que pertenecen a la carrera 1, útil para armar una malla curricular
go


-- TABLA: GRUPO

select * -- shows every group opened, with its course, professor, period and cupo (capacity) / muestra todos los grupos abiertos, con su curso, profesor, periodo y cupo
from grupo
go

select codigo_curso, count(*) as total_grupos -- shows how many groups (sections) were opened per course, useful to detect high-demand courses / muestra cuántos grupos (secciones) se abrieron por curso, útil para detectar cursos de alta demanda
from grupo
group by codigo_curso
having count(*) >= 1
go


-- TABLA: PROFESOR


select * -- shows every professor with their contact info and especialidad / muestra todos los profesores con su información de contacto y especialidad
from profesor
go

select distinct especialidad -- shows the different specialties available among all professors, without repeats / muestra las diferentes especialidades disponibles entre todos los profesores, sin repetir
from profesor
go


-- TABLA: PERIODO

select * -- shows every academic period registered, with its start and end dates / muestra todos los periodos académicos registrados, con sus fechas de inicio y fin
from periodo
go

select nombre, fecha_inicio, fecha_fin
from periodo
order by fecha_inicio asc -- orders periods chronologically, useful to see which one comes first / ordena los periodos cronológicamente, útil para ver cuál viene primero
go

-- TABLA: MATRICULA

select * -- shows every enrollment record, linking a student to a group with its nota and estado / muestra cada registro de matrícula, uniendo un estudiante con un grupo, junto a su nota y estado
from matricula
go

select dni_estudiante, codigo_grupo, nota
from matricula
where nota is null -- finds enrollments that still don't have a grade assigned, useful to track pending grading / encuentra matrículas que aún no tienen nota asignada, útil para dar seguimiento a calificaciones pendientes
go

select dni_estudiante, codigo_grupo, nota
from matricula
where nota is not null -- finds enrollments that already have a final grade / encuentra matrículas que ya tienen una nota final
go

select codigo_grupo, count(*) as total_matriculados -- shows groups with more than one student enrolled, useful to see which groups are actually active / muestra grupos con más de un estudiante matriculado, útil para ver cuáles grupos están realmente activos
from matricula
group by codigo_grupo
having count(*) > 1
go

select avg(nota) as promedio_notas -- calculates the overall average grade across all enrollments with a grade / calcula el promedio general de notas entre todas las matrículas que tienen calificación
from matricula
go


-- TABLA: PAGO
-- (se usa join con estudiante porque pago no tiene columna 'nombre')


select * -- shows every payment record, with amount, date and method used / muestra cada registro de pago, con monto, fecha y método utilizado
from pago
go

select distinct metodo -- shows the different payment methods that students have actually used / muestra los diferentes métodos de pago que los estudiantes realmente han utilizado
from pago
go

select codigo, monto
from pago
order by monto desc -- orders payments from the highest amount to the lowest / ordena los pagos del monto más alto al más bajo
go

select codigo, monto
from pago
where monto between 100000 and 200000 -- finds payments within a specific amount range, useful for auditing mid-range payments / encuentra pagos dentro de un rango específico de monto, útil para auditar pagos de rango medio
go

select sum(monto) as total_recaudado -- shows the total amount of money collected from all payments / muestra el monto total de dinero recaudado entre todos los pagos
from pago
go

select min(monto) as pago_minimo -- shows the smallest single payment ever made / muestra el pago individual más pequeño que se ha realizado
from pago
go

select max(monto) as pago_maximo -- shows the largest single payment ever made / muestra el pago individual más grande que se ha realizado
from pago
go

select
    count(*) as total_pagos, -- total number of payments made / cantidad total de pagos realizados
    sum(monto) as total_recaudado, -- total money collected / dinero total recaudado
    avg(monto) as promedio_pago, -- average payment amount / monto promedio de pago
    min(monto) as pago_minimo, -- smallest payment / pago más pequeño
    max(monto) as pago_maximo -- largest payment / pago más grande
from pago
go

select top 1 e.nombre, p.monto -- shows the student who made the single highest payment / muestra al estudiante que realizó el pago individual más alto
from pago p
inner join estudiante e on p.dni_estudiante = e.dni
order by p.monto desc
go

select e.nombre, p.metodo
from pago p
inner join estudiante e on p.dni_estudiante = e.dni
where p.metodo in ('tarjeta', 'transferencia') -- shows students who paid electronically, excluding cash / muestra estudiantes que pagaron de forma electrónica, excluyendo efectivo
go

select e.nombre, p.metodo
from pago p
inner join estudiante e on p.dni_estudiante = e.dni
where p.metodo not in ('efectivo') -- same idea as above, but written with not in instead of in / misma idea que la anterior, pero escrita con not in en vez de in
go

select e.nombre, p.monto
from pago p
inner join estudiante e on p.dni_estudiante = e.dni
where p.monto > (select avg(monto) from pago) -- shows students whose payment was above the average payment amount / muestra estudiantes cuyo pago fue mayor al monto promedio de pago
go

select nombre, apellido1 -- shows students that have at least one grade above 85, using a subquery to first find the matching dni values / muestra estudiantes que tienen al menos una nota mayor a 85, usando una subconsulta que primero encuentra los dni que coinciden
from estudiante
where dni in (select dni_estudiante from matricula where nota > 85)
go


-- JOINS (consultas que combinan varias tablas)


select -- shows each student together with the name of their carrera, instead of just the numeric code / muestra cada estudiante junto al nombre de su carrera, en vez de solo el código numérico
    e.nombre, e.apellido1, c.nombre as carrera
from estudiante e
inner join carrera c on e.codigo_carrera = c.codigo
go

select -- shows each student together with the course and group they are enrolled in, tracing the full path student -> matricula -> grupo -> curso / muestra cada estudiante junto al curso y grupo en el que está matriculado, recorriendo la ruta completa estudiante -> matricula -> grupo -> curso
    e.nombre as estudiante, cu.nombre as curso, g.codigo as codigo_grupo
from estudiante e
inner join matricula m on e.dni = m.dni_estudiante
inner join grupo g on m.codigo_grupo = g.codigo
inner join curso cu on g.codigo_curso = cu.codigo
go

select -- shows every student and their payment code if they made one; students without a payment still appear, with null in codigo_pago / muestra cada estudiante y su código de pago si hizo alguno; los estudiantes sin pago igual aparecen, con null en codigo_pago
    e.nombre, p.codigo as codigo_pago
from estudiante e
left join pago p on e.dni = p.dni_estudiante
go

select -- shows students who have never enrolled in any group, by keeping only the rows where the match failed / muestra estudiantes que nunca se han matriculado en ningún grupo, quedándose solo con las filas donde la coincidencia falló
    e.nombre, m.codigo_grupo
from estudiante e
left join matricula m on e.dni = m.dni_estudiante
where m.codigo_grupo is null
go

select -- shows every group and, if any, the students matriculated in it; groups with no students still appear / muestra cada grupo y, si tiene, los estudiantes matriculados en él; los grupos sin estudiantes igual aparecen
    g.codigo as codigo_grupo, m.dni_estudiante
from matricula m
right join grupo g on m.codigo_grupo = g.codigo
go

select -- shows every professor and, if any, the group they teach; professors without an assigned group still appear / muestra cada profesor y, si tiene, el grupo que imparte; los profesores sin grupo asignado igual aparecen
    p.nombre as profesor, g.codigo as codigo_grupo
from grupo g
right join profesor p on g.codigo_profesor = p.dni
go


-- Making views, haciendo vistas.

use registromatriculapf -- select the database where the views will be created / seleccionar la base de datos donde se crearán las vistas
go


-- VISTA 1: estudiantes_por_carrera

create view estudiantes_por_carrera -- shows each student together with the full name of their carrera, useful for administrative reports without exposing internal codes / muestra cada estudiante junto al nombre completo de su carrera, útil para reportes administrativos sin exponer códigos internos
as
select
    e.dni,
    e.nombre,
    e.apellido1,
    e.apellido2,
    c.nombre as carrera,
    c.facultad
from estudiante e
inner join carrera c on e.codigo_carrera = c.codigo
go

select * from estudiantes_por_carrera -- test the view / probar la vista
go


-- VISTA 2: pagos_por_estudiante

create view pagos_por_estudiante -- shows the total amount paid by each student, useful for the finance office to check who is up to date / muestra el total pagado por cada estudiante, útil para el área financiera para revisar quién está al día
as
select
    e.dni,
    e.nombre,
    e.apellido1,
    count(p.codigo) as cantidad_pagos,
    sum(p.monto) as total_pagado
from estudiante e
left join pago p on e.dni = p.dni_estudiante -- left join so students with no payments still appear with 0 / left join para que los estudiantes sin pagos igual aparezcan con 0
group by e.dni, e.nombre, e.apellido1
go

select * from pagos_por_estudiante
go


-- VISTA 3: grupos_disponibles

create view grupos_disponibles -- shows each group with its course, professor and period, useful for students choosing which group to enroll in / muestra cada grupo con su curso, profesor y periodo, útil para que los estudiantes elijan en qué grupo matricularse
as
select
    g.codigo as codigo_grupo,
    cu.nombre as curso,
    p.nombre as profesor,
    p.apellido1 as apellido_profesor,
    per.nombre as periodo,
    g.cupo
from grupo g
inner join curso cu on g.codigo_curso = cu.codigo
inner join profesor p on g.codigo_profesor = p.dni
inner join periodo per on g.codigo_periodo = per.codigo
go

select * from grupos_disponibles
go

-- VISTA 4: rendimiento_academico

create view rendimiento_academico -- shows each student's grade per course, useful for academic tracking and generating transcripts / muestra la nota de cada estudiante por curso, útil para seguimiento académico y generar historiales
as
select
    e.dni,
    e.nombre,
    e.apellido1,
    cu.nombre as curso,
    m.nota,
    m.estado
from estudiante e
inner join matricula m on e.dni = m.dni_estudiante
inner join grupo g on m.codigo_grupo = g.codigo
inner join curso cu on g.codigo_curso = cu.codigo
go

select * from rendimiento_academico
go


-- VISTA 5: ocupacion_grupos

create view ocupacion_grupos -- shows how many students are enrolled in each group compared to its cupo (capacity), useful to detect groups that are almost full / muestra cuántos estudiantes hay matriculados en cada grupo comparado con su cupo, útil para detectar grupos casi llenos
as
select
    g.codigo as codigo_grupo,
    cu.nombre as curso,
    g.cupo,
    count(m.dni_estudiante) as matriculados,
    g.cupo - count(m.dni_estudiante) as espacios_disponibles
from grupo g
inner join curso cu on g.codigo_curso = cu.codigo
left join matricula m on g.codigo = m.codigo_grupo -- left join so groups with zero students still show up with 0 matriculados / left join para que los grupos sin estudiantes igual aparezcan con 0 matriculados
group by g.codigo, cu.nombre, g.cupo
go

select * from ocupacion_grupos
go

-- VISTA 6: profesores_carga_academica

create view profesores_carga_academica -- shows how many groups each professor is currently teaching, useful for the university to balance teaching load / muestra cuántos grupos está impartiendo actualmente cada profesor, útil para que la universidad equilibre la carga académica
as
select
    p.dni,
    p.nombre,
    p.apellido1,
    p.especialidad,
    count(g.codigo) as grupos_asignados
from profesor p
left join grupo g on p.dni = g.codigo_profesor -- left join so professors with no group assigned still appear with 0 / left join para que los profesores sin grupo asignado igual aparezcan con 0
group by p.dni, p.nombre, p.apellido1, p.especialidad
go

select * from profesores_carga_academica
go


