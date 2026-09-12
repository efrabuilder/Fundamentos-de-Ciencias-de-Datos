-- script sql generado a partir de farmacia_bd_examen.xlsx
-- tablas: sucursales, medicamentos, clientes, ventas (desde 'ventas corregido')
-- modelo: esquema en estrella -> ventas es tabla de hechos, las otras tres son
-- dimensiones referenciadas por llave foranea. sintaxis ansi estandar
-- (compatible con sql server / mysql / postgresql con ajustes minimos de tipos).
-- Efrain Sebastian Rojas Artavia 117970209
-- Grupo 5


if db_id('farmacia') is null
    create database farmacia;
go

use farmacia;
go

drop table if exists ventas;
drop table if exists clientes;
drop table if exists medicamentos;
drop table if exists sucursales;

create table sucursales (
    sucursal_id   int             not null,
    nombre        varchar(100)    not null,
    provincia     varchar(50)     not null,
    encargado     varchar(100)    not null,
    constraint pk_sucursales primary key (sucursal_id)
);

create table medicamentos (
    medicamento_id     int             not null,
    nombre             varchar(100)    not null,
    categoria          varchar(50)     not null,
    precio_unitario    decimal(10,2)   not null,
    requiere_receta    bit             not null,
    constraint pk_medicamentos primary key (medicamento_id)
);

create table clientes (
    cliente_id     int             not null,
    nombre         varchar(100)    not null,
    telefono       varchar(20)     not null,
    provincia      varchar(50)     not null,
    tipo_seguro    varchar(20)     not null,
    constraint pk_clientes primary key (cliente_id)
);

create table ventas (
    venta_id           int             not null,
    fecha              date            not null,
    sucursal_id        int             not null,
    medicamento_id     int             not null,
    cantidad           int             not null,
    precio_unitario    decimal(10,2)   not null,
    cliente_id         int             null,
    total              decimal(10,2)   not null,
    constraint pk_ventas primary key (venta_id),
    constraint fk_ventas_sucursal    foreign key (sucursal_id)    references sucursales (sucursal_id),
    constraint fk_ventas_medicamento foreign key (medicamento_id) references medicamentos (medicamento_id),
    constraint fk_ventas_cliente     foreign key (cliente_id)     references clientes (cliente_id)
);

-- ---------------------------------------------------------------------------
-- datos: sucursales
-- ---------------------------------------------------------------------------
insert into sucursales (sucursal_id, nombre, provincia, encargado) values (1, 'Sucursal San José', 'San José', 'Marco Solano');
insert into sucursales (sucursal_id, nombre, provincia, encargado) values (2, 'Sucursal Alajuela', 'Alajuela', 'Diana Castillo');
insert into sucursales (sucursal_id, nombre, provincia, encargado) values (3, 'Sucursal Cartago', 'Cartago', 'Rodrigo Alfaro');
insert into sucursales (sucursal_id, nombre, provincia, encargado) values (4, 'sucursal Heredia', 'Heredia', 'Ivannia Sequeira');
insert into sucursales (sucursal_id, nombre, provincia, encargado) values (5, 'Sucursal Puntarenas', 'Puntarenas', 'Esteban Chinchilla');

-- ---------------------------------------------------------------------------
-- datos: medicamentos
-- ---------------------------------------------------------------------------
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (1, 'Acetaminofén 500mg', 'Analgésicos', 1200, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (2, 'Ibuprofeno 400mg', 'Analgésicos', 1500, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (3, 'Diclofenaco 50mg', 'Analgésicos', 1800, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (4, 'Amoxicilina 500mg', 'Antibióticos', 3500, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (5, 'Azitromicina 500mg', 'Antibióticos', 4200, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (6, 'Ciprofloxacino 500mg', 'Antibióticos', 3900, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (7, 'Loratadina 10mg', 'Antialérgicos', 1600, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (8, 'Cetirizina 10mg', 'Antialérgicos', 1700, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (9, 'Vitamina C 1g', 'Vitaminas', 2200, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (10, 'Complejo B', 'Vitaminas', 2500, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (11, 'Vitamina D3', 'Vitaminas', 2800, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (12, 'Jarabe para la Tos', 'Antigripales', 2100, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (13, 'Descongestionante Nasal', 'Antigripales', 1900, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (14, 'Paracetamol Pediátrico', 'Antigripales', 1750, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (15, 'Omeprazol 20mg', 'Gastrointestinales', 2300, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (16, 'Ranitidina 150mg', 'Gastrointestinales', 2000, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (17, 'Suero Oral', 'Gastrointestinales', 900, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (18, 'Crema Hidrocortisona', 'Dermatológicos', 2600, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (19, 'Loción de Calamina', 'Dermatológicos', 1800, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (20, 'Protector Solar FPS 50', 'Dermatológicos', 6500, 0);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (21, 'Losartán 50mg', 'Cardiovasculares', 3200, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (22, 'Atorvastatina 20mg', 'Cardiovasculares', 3800, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (23, 'Enalapril 10mg', 'Cardiovasculares', 2900, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (24, 'Metformina 850mg', 'Cardiovasculares', 2400, 1);
insert into medicamentos (medicamento_id, nombre, categoria, precio_unitario, requiere_receta) values (25, 'Ácido Acetilsalicílico 100mg', 'Cardiovasculares', 1400, 0);

-- ---------------------------------------------------------------------------
-- datos: clientes
-- ---------------------------------------------------------------------------
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (1, 'María Fernández', '83767393', 'Heredia', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (2, 'Juan Pérez', '88013380', 'Guanacaste', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (3, 'Ana Gómez', '89037972', 'Limón', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (4, 'Carlos Rodríguez', '88963259', 'Limón', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (5, 'Laura Jiménez', '84079983', 'Puntarenas', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (6, 'Diego Castro', '84960368', 'Limón', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (7, 'Sofía Rojas', '81236916', 'Cartago', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (8, 'Andrés Mora', '88183854', 'San José', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (9, 'Valeria Chacón', '84896553', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (10, 'Luis Herrera', '81710270', 'Heredia', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (11, 'Camila Araya', '87824452', 'Puntarenas', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (12, 'José Fernández', '81571600', 'Cartago', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (13, 'Gabriela Salas', '89347542', 'Guanacaste', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (14, 'Kevin Brenes', '87181508', 'San José', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (15, 'Paola Quirós', '82484177', 'San José', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (16, 'Esteban Alvarado', '88602219', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (17, 'Natalia Cordero', '86753266', 'Heredia', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (18, 'Mario Sánchez', '83534996', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (19, 'Fernanda Ureña', '81623098', 'Heredia', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (20, 'Ricardo Gómez', '82251971', 'Limón', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (21, 'Melissa Zamora', '84499093', 'Guanacaste', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (22, 'Alejandro Vega', '82189954', 'San José', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (23, 'Karla Monge', '88991413', 'Puntarenas', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (24, 'Daniel Rodríguez', '84373552', 'Cartago', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (25, 'Priscilla Barrantes', '89989619', 'Heredia', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (26, 'Rebeca Solís', '87127383', 'Heredia', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (27, 'Fabián Guzmán', '87472275', 'Cartago', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (28, 'Tatiana Campos', '87485958', 'Cartago', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (29, 'Roberto Miranda', '82564685', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (30, 'Silvia Navarro', '89321679', 'San José', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (31, 'Óscar Delgado', '82176361', 'Puntarenas', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (32, 'Marcela Vindas', '89760606', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (33, 'Iván Rojas', '86345911', 'Puntarenas', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (34, 'Grettel Salazar', '82890953', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (35, 'Randall Cordero', '83853667', 'Guanacaste', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (36, 'Vanessa Ugalde', '86576380', 'Cartago', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (37, 'Mauricio Zúñiga', '86144128', 'Alajuela', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (38, 'Wendy Chavarría', '83830189', 'San José', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (39, 'Sergio Blanco', '88192649', 'Cartago', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (40, 'Adriana Rivera', '81615679', 'Guanacaste', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (41, 'Bryan Contreras', '85052586', 'Heredia', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (42, 'Yolanda Méndez', '81239289', 'Cartago', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (43, 'Emmanuel Vargas', '89491517', 'Heredia', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (44, 'Cindy Ramírez', '85147458', 'Alajuela', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (45, 'Warner Aguilar', '82163250', 'Heredia', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (46, 'Shirley Duarte', '89106296', 'San José', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (47, 'Pablo Cascante', '81875328', 'Limón', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (48, 'Ericka Chaves', '85863289', 'San José', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (49, 'Alonso Villalobos', '85170724', 'Alajuela', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (50, 'Marjorie Obando', '82165198', 'Limón', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (51, 'Kenneth Solano', '83451397', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (52, 'Yorleny Umaña', '89035836', 'San José', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (53, 'Federico Brenes', '83341909', 'Guanacaste', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (54, 'Hazel Porras', '89037404', 'San José', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (55, 'Minor Araya', '87135843', 'Limón', 'CCSS');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (56, 'Xinia Calderón', '87186739', 'Puntarenas', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (57, 'Geovanny Rojas', '89127865', 'Puntarenas', 'Privado');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (58, 'Lourdes Hidalgo', '86167001', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (59, 'Wilmer Castro', '85630206', 'Alajuela', 'Ninguno');
insert into clientes (cliente_id, nombre, telefono, provincia, tipo_seguro) values (60, 'Yamileth Barquero', '81171690', 'Heredia', 'Ninguno');

-- ---------------------------------------------------------------------------
-- datos: ventas (fuente: hoja 'ventas corregido')
-- correccion aplicada: venta_id 249 (sucursal_id 9 -> 3, id fuera de catalogo)
-- correccion aplicada: venta_id 299 (medicamento_id 88 -> 21, id fuera de catalogo)
-- ---------------------------------------------------------------------------
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (1, '2026-02-02', 1, 19, 2, 1800, 17, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (2, '2026-06-14', 2, 19, 2, 1800, 55, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (3, '2026-03-07', 4, 5, 1, 4200, 49, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (4, '2026-02-06', 1, 4, 1, 3500, 26, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (5, '2026-01-07', 4, 5, 1, 4200, 51, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (6, '2026-01-31', 3, 10, 3, 2500, 9, 7500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (7, '2026-03-25', 4, 8, 3, 1700, 32, 5100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (8, '2026-02-12', 2, 13, 1, 1900, 12, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (9, '2026-05-21', 1, 23, 3, 2900, 39, 8700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (10, '2026-01-15', 1, 15, 1, 2300, 25, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (11, '2026-04-12', 5, 23, 1, 2900, 12, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (12, '2026-03-06', 5, 24, 1, 2400, 21, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (13, '2026-03-04', 4, 10, 4, 2500, 10, 10000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (14, '2026-03-17', 5, 18, 2, 2600, 52, 5200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (15, '2026-05-27', 1, 20, 1, 5375, 35, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (16, '2026-05-11', 5, 11, 3, 2800, 48, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (17, '2026-03-21', 3, 20, 3, 5375, 45, 16125);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (18, '2026-05-24', 2, 20, 2, 5375, 5, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (19, '2026-02-21', 3, 11, 4, 2800, 5, 11200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (20, '2026-04-18', 1, 3, 4, 1800, 56, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (21, '2026-01-19', 4, 20, 1, 5375, 33, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (22, '2026-06-24', 4, 17, 3, 900, 31, 2700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (23, '2026-04-10', 4, 8, 1, 1700, 5, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (24, '2026-01-13', 4, 8, 2, 1700, 3, 3400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (25, '2026-06-30', 5, 13, 4, 1900, 53, 7600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (26, '2026-04-20', 4, 8, 2, 1700, 52, 3400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (27, '2026-04-09', 3, 8, 4, 1700, 32, 6800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (28, '2026-06-17', 1, 16, 1, 2000, 3, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (29, '2026-05-06', 3, 20, 1, 5375, 46, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (30, '2026-04-26', 5, 24, 3, 2400, 43, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (31, '2026-06-28', 3, 16, 2, 2000, 16, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (32, '2026-04-09', 3, 13, 3, 1900, 40, 5700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (33, '2026-01-02', 2, 7, 2, 1600, 21, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (34, '2026-04-11', 2, 18, 1, 2600, 6, 2600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (35, '2026-01-21', 5, 20, 2, 5375, 20, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (36, '2026-04-29', 1, 23, 2, 2900, 11, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (37, '2026-02-22', 3, 21, 3, 3200, 24, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (38, '2026-06-24', 2, 3, 1, 1800, 17, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (39, '2026-03-24', 5, 5, 4, 4200, 17, 16800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (40, '2026-05-10', 2, 20, 4, 5375, 16, 21500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (41, '2026-03-13', 4, 13, 2, 1900, 11, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (42, '2026-04-13', 4, 20, 4, 5375, 30, 21500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (43, '2026-03-13', 2, 13, 3, 1900, 43, 5700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (44, '2026-03-11', 1, 7, 1, 1600, 13, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (45, '2026-03-31', 3, 3, 3, 1800, 2, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (46, '2026-05-29', 1, 20, 2, 5375, 26, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (47, '2026-06-29', 4, 1, 3, 1200, 16, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (48, '2026-02-07', 1, 7, 2, 1600, 20, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (49, '2026-04-05', 1, 6, 1, 3900, 24, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (50, '2026-05-27', 4, 2, 2, 1500, 34, 3000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (51, '2026-02-18', 4, 18, 1, 2600, 26, 2600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (52, '2026-02-27', 5, 19, 2, 1800, 52, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (53, '2026-01-05', 5, 3, 2, 1800, 5, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (54, '2026-06-18', 2, 2, 2, 1500, 10, 3000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (55, '2026-05-15', 5, 20, 2, 5375, 35, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (56, '2026-05-01', 3, 9, 1, 2200, 10, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (57, '2026-04-01', 3, 21, 4, 3200, 20, 12800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (58, '2026-01-03', 1, 3, 1, 1800, 43, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (59, '2026-05-12', 1, 7, 2, 1600, 44, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (60, '2026-03-11', 3, 6, 1, 3900, 4, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (61, '2026-05-30', 4, 22, 4, 3800, 18, 15200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (62, '2026-04-13', 2, 4, 1, 3500, 3, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (63, '2026-04-02', 5, 14, 1, 1750, 17, 1750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (64, '2026-06-26', 2, 17, 2, 900, 47, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (65, '2026-01-21', 3, 8, 1, 1700, 53, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (66, '2026-05-09', 1, 12, 3, 2100, 47, 6300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (67, '2026-05-17', 2, 23, 2, 2900, 2, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (68, '2026-05-07', 4, 15, 1, 2300, 11, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (69, '2026-03-13', 1, 22, 4, 3800, 14, 15200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (70, '2026-06-07', 5, 4, 2, 3500, 39, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (71, '2026-04-10', 2, 23, 2, 2900, 30, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (72, '2026-01-03', 3, 20, 2, 5375, 12, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (73, '2026-06-05', 1, 13, 4, 1900, 49, 7600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (74, '2026-02-11', 2, 18, 3, 2600, 60, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (75, '2026-04-16', 2, 17, 3, 900, 15, 2700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (76, '2026-03-15', 4, 25, 2, 1400, 48, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (77, '2026-01-22', 2, 20, 1, 5375, 26, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (78, '2026-04-01', 5, 12, 3, 2100, 43, 6300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (79, '2026-02-03', 1, 14, 3, 1750, 59, 5250);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (80, '2026-01-07', 2, 4, 1, 3500, 48, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (81, '2026-05-17', 5, 17, 2, 900, 24, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (82, '2026-02-01', 2, 22, 2, 3800, 16, 7600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (83, '2026-06-07', 4, 16, 1, 2000, 50, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (84, '2026-06-16', 2, 6, 2, 3900, 17, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (85, '2026-04-07', 2, 16, 2, 2000, 32, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (86, '2026-01-11', 5, 15, 1, 2300, 55, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (87, '2026-01-10', 3, 15, 2, 2300, 38, 4600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (88, '2026-02-05', 2, 13, 1, 1900, 11, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (89, '2026-04-11', 1, 25, 4, 1400, 1, 5600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (90, '2026-05-29', 3, 15, 1, 2300, 37, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (91, '2026-05-05', 2, 24, 3, 2400, 56, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (92, '2026-05-04', 1, 12, 1, 2100, 2, 2100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (93, '2026-05-08', 3, 12, 2, 2100, 30, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (94, '2026-05-25', 4, 23, 4, 2900, 39, 11600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (95, '2026-01-19', 3, 4, 2, 3500, 49, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (96, '2026-06-17', 3, 15, 1, 2300, 47, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (97, '2026-02-20', 5, 11, 1, 2800, 55, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (98, '2026-03-20', 2, 5, 1, 4200, 41, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (99, '2026-03-09', 1, 20, -2, 5375, 44, -10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (100, '2026-06-15', 2, 7, 1, 1600, 33, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (101, '2026-05-08', 4, 2, 4, 1500, 14, 6000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (102, '2026-03-27', 5, 1, 1, 1200, 24, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (103, '2026-02-06', 3, 9, 4, 2200, 4, 8800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (104, '2026-04-16', 1, 25, 3, 1400, 8, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (105, '2026-06-17', 5, 24, 1, 2400, 2, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (106, '2026-06-02', 4, 17, 3, 900, 32, 2700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (107, '2026-05-21', 3, 21, 1, 3200, 28, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (108, '2026-06-12', 3, 12, 2, 2100, 10, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (109, '2026-04-24', 4, 17, 3, 900, 47, 2700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (110, '2026-02-27', 4, 8, 1, 1700, 51, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (111, '2026-06-14', 4, 8, 3, 1700, 54, 5100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (112, '2026-05-30', 1, 16, 1, 2000, 23, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (113, '2026-02-12', 1, 9, 2, 2200, 52, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (114, '2026-06-27', 3, 7, 1, 1600, 20, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (115, '2026-04-27', 2, 5, 1, 4200, 13, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (116, '2026-06-09', 2, 5, 1, 4200, 55, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (117, '2026-05-22', 1, 18, 4, 2600, 11, 10400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (118, '2026-01-30', 4, 25, 1, 1400, 8, 1400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (119, '2026-02-22', 2, 1, 1, 1200, 35, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (120, '2026-03-04', 2, 19, 1, 1800, 39, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (121, '2026-03-04', 2, 19, 3, 1800, 28, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (122, '2026-06-28', 1, 10, 2, 2500, 26, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (123, '2026-06-25', 3, 14, 1, 1750, 57, 1750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (124, '2026-05-28', 4, 13, 3, 1900, 3, 5700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (125, '2026-05-04', 2, 21, 1, 3200, 3, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (126, '2026-03-07', 4, 9, 3, 2200, 47, 6600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (127, '2026-02-11', 3, 12, 4, 2100, 22, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (128, '2026-05-06', 3, 10, 1, 2500, 25, 2500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (129, '2026-01-30', 3, 3, 2, 1800, 38, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (130, '2026-03-25', 2, 24, 1, 2400, 49, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (131, '2026-03-21', 3, 4, 2, 3500, 25, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (132, '2026-06-19', 4, 8, 1, 1700, 59, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (133, '2026-04-06', 4, 23, 1, 2900, 33, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (134, '2026-06-10', 4, 18, 2, 2600, 14, 5200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (135, '2026-02-20', 1, 21, 2, 3200, 32, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (136, '2026-06-05', 3, 6, 1, 3900, 28, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (137, '2026-04-19', 5, 6, 1, 3900, 13, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (138, '2026-02-25', 2, 11, 1, 2800, 11, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (139, '2026-06-20', 2, 21, 2, 3200, 55, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (140, '2026-03-05', 3, 13, 1, 1900, 34, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (141, '2026-03-13', 5, 6, 4, 3900, 58, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (142, '2026-04-05', 4, 11, 2, 2800, 10, 5600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (143, '2026-06-16', 2, 22, 4, 3800, 19, 15200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (144, '2026-06-23', 1, 2, 1, 1500, 57, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (145, '2026-03-19', 3, 13, 1, 1900, 36, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (146, '2026-04-12', 1, 19, 2, 1800, 41, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (147, '2026-03-10', 2, 20, 4, 5375, 51, 21500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (148, '2026-03-01', 1, 1, 1, 1200, 56, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (149, '2026-04-07', 2, 21, 4, 3200, null, 12800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (150, '2026-06-20', 5, 6, 4, 3900, 14, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (151, '2026-04-21', 4, 10, 1, 2500, 43, 2500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (152, '2026-05-13', 4, 5, 4, 4200, 4, 16800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (153, '2026-01-02', 1, 15, 1, 2300, 11, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (154, '2026-05-02', 1, 21, 2, 3200, 5, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (155, '2026-01-29', 2, 19, 2, 1800, 33, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (156, '2026-06-17', 4, 23, 2, 2900, 56, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (157, '2026-04-16', 4, 18, 1, 2600, 47, 2600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (158, '2026-03-13', 3, 23, 2, 2900, 1, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (159, '2026-03-07', 4, 11, 4, 2800, 41, 11200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (160, '2026-03-09', 3, 17, 2, 900, 9, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (161, '2026-06-16', 3, 21, 1, 3200, 14, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (162, '2026-01-24', 3, 6, 1, 3900, 51, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (163, '2026-03-29', 1, 12, 4, 2100, 11, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (164, '2026-02-24', 5, 2, 1, 1500, 2, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (165, '2026-02-14', 3, 22, 3, 3800, 37, 11400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (166, '2026-03-01', 2, 11, 3, 2800, 55, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (167, '2026-02-13', 5, 7, 1, 1600, 49, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (168, '2026-02-14', 3, 9, 2, 2200, 27, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (169, '2026-02-25', 4, 10, 4, 2500, 25, 10000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (170, '2026-01-11', 2, 11, 1, 2800, 20, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (171, '2026-03-19', 4, 7, 1, 1600, 50, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (172, '2026-06-08', 4, 23, 4, 2900, 30, 11600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (173, '2026-02-16', 2, 20, 2, 5375, 47, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (174, '2026-01-13', 4, 16, 1, 2000, 59, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (175, '2026-05-23', 4, 6, 3, 3900, 58, 11700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (176, '2026-01-31', 5, 1, 4, 1200, 52, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (177, '2026-01-08', 3, 5, 4, 4200, 34, 16800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (178, '2026-06-12', 1, 3, 2, 1800, 41, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (179, '2026-01-24', 5, 12, 3, 2100, 27, 6300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (180, '2026-04-12', 4, 24, 2, 2400, 32, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (181, '2026-02-17', 5, 21, 1, 3200, 20, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (182, '2026-03-19', 1, 5, 1, 4200, 60, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (183, '2026-04-16', 3, 9, 2, 2200, 36, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (184, '2026-04-11', 5, 4, 2, 3500, 48, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (185, '2026-05-17', 5, 3, 4, 1800, 4, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (186, '2026-02-21', 2, 11, 2, 2800, 30, 5600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (187, '2026-03-16', 5, 8, 4, 1700, 54, 6800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (188, '2026-05-22', 4, 25, 1, 1400, 18, 1400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (189, '2026-06-25', 5, 11, 3, 2800, 21, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (190, '2026-05-31', 4, 14, 1, 1750, 35, 1750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (191, '2026-06-11', 3, 22, 1, 3800, 14, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (192, '2026-05-19', 5, 6, 1, 3900, 58, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (193, '2026-02-17', 3, 25, 2, 1400, 54, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (194, '2026-04-19', 5, 9, 1, 2200, 35, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (195, '2026-05-09', 3, 20, 4, 5375, 6, 21500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (196, '2026-06-10', 1, 10, 3, 2500, 55, 7500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (197, '2026-01-17', 2, 6, 4, 3900, 35, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (198, '2026-01-03', 5, 18, 3, 2600, 50, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (199, '2026-02-27', 2, 14, 4, 1750, 41, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (200, '2026-04-18', 4, 20, 4, 5375, 17, 21500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (201, '2026-02-16', 4, 1, 4, 1200, 13, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (202, '2026-03-16', 4, 7, 4, 1600, 27, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (203, '2026-06-18', 3, 24, 4, 2400, 60, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (204, '2026-06-20', 4, 10, 3, 2500, 32, 7500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (205, '2026-03-01', 1, 12, 2, 2100, 43, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (206, '2026-04-06', 3, 14, 3, 1750, 34, 5250);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (207, '2026-01-15', 3, 6, 1, 3900, 44, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (208, '2026-02-17', 1, 21, 1, 3200, 22, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (209, '2026-02-13', 5, 11, 3, 2800, 12, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (210, '2026-05-15', 5, 2, 1, 1500, 6, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (211, '2026-06-22', 4, 19, 3, 1800, 53, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (212, '2026-02-16', 2, 13, 2, 1900, 26, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (213, '2026-04-29', 1, 5, 1, 4200, 11, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (214, '2026-05-31', 4, 21, 2, 3200, 42, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (215, '2026-02-12', 4, 13, 2, 1900, 52, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (216, '2026-01-31', 2, 17, 1, 900, 42, 900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (217, '2026-01-26', 1, 2, 1, 1500, 22, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (218, '2026-04-08', 3, 13, 4, 1900, 36, 7600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (219, '2026-05-03', 3, 24, 2, 2400, 6, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (220, '2026-01-14', 5, 9, 1, 2200, 37, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (221, '2026-04-02', 5, 3, 2, 1800, 32, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (222, '2026-01-26', 4, 14, 4, 1750, 26, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (223, '2026-04-26', 4, 10, 3, 2500, 49, 7500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (224, '2026-01-15', 4, 21, 1, 3200, 16, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (225, '2026-05-28', 3, 16, 2, 2000, 16, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (226, '2026-03-11', 5, 18, 2, 2600, 51, 5200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (227, '2026-03-01', 4, 11, 1, 2800, 25, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (228, '2026-03-22', 3, 10, 2, 2500, 54, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (229, '2026-06-25', 4, 21, 1, 3200, 2, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (230, '2026-03-12', 1, 4, 2, 3500, 43, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (231, '2026-06-17', 4, 14, 2, 1750, 21, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (232, '2026-04-10', 2, 9, 1, 2200, 34, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (233, '2026-02-05', 2, 24, 1, 2400, 35, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (234, '2026-02-21', 3, 13, 3, 1900, 41, 5700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (235, '2026-05-21', 5, 16, 1, 2000, 26, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (236, '2026-05-13', 2, 20, 2, 5375, 6, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (237, '2026-05-07', 2, 8, 1, 1700, 27, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (238, '2026-03-12', 2, 6, 4, 3900, 2, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (239, '2026-02-21', 1, 20, 2, 5375, 22, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (240, '2026-06-03', 2, 4, 2, 3500, 37, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (241, '2026-03-14', 1, 19, 2, 1800, 53, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (242, '2026-01-10', 2, 16, 2, 2000, 59, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (243, '2026-04-19', 3, 12, 2, 2100, 4, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (244, '2026-06-17', 3, 1, 3, 1200, 2, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (245, '2026-02-02', 1, 18, 3, 2600, 32, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (246, '2026-04-10', 3, 15, 4, 2300, 46, 9200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (247, '2026-01-21', 5, 9, 4, 2200, 55, 8800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (248, '2026-06-25', 1, 24, 2, 2400, 17, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (249, '2026-03-20', 3, 2, 1, 1500, 47, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (250, '2026-06-02', 2, 2, 2, 1500, 37, 3000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (251, '2026-05-11', 2, 20, 3, 5375, 25, 16125);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (252, '2026-02-27', 1, 9, 2, 2200, 6, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (253, '2026-06-27', 1, 17, 2, 900, 51, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (254, '2026-04-08', 4, 9, 1, 2200, 31, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (255, '2026-05-05', 3, 18, 4, 2600, 16, 10400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (256, '2026-03-28', 2, 6, 2, 3900, 1, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (257, '2026-06-15', 4, 6, 1, 3900, 38, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (258, '2026-05-16', 1, 9, 1, 2200, 31, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (259, '2026-02-06', 2, 2, 1, 1500, 17, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (260, '2026-06-14', 5, 16, 4, 2000, 15, 8000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (261, '2026-06-12', 2, 12, 2, 2100, 13, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (262, '2026-03-22', 1, 5, 1, 4200, 56, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (263, '2026-06-15', 3, 14, 4, 1750, 19, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (264, '2026-03-13', 3, 13, 2, 1900, 24, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (265, '2026-02-23', 5, 11, 3, 2800, 12, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (266, '2026-01-09', 3, 17, 2, 900, 16, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (267, '2026-06-12', 5, 14, 1, 1750, 37, 1750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (268, '2026-06-15', 5, 11, 1, 2800, 21, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (269, '2026-05-22', 1, 20, 1, 5375, 48, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (270, '2026-05-27', 1, 15, 1, 2300, 52, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (271, '2026-05-07', 4, 17, 1, 900, 30, 900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (272, '2026-05-13', 4, 22, 4, 3800, 28, 15200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (273, '2026-02-28', 2, 17, 3, 900, 34, 2700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (274, '2026-01-11', 3, 4, 3, 3500, 31, 10500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (275, '2026-05-09', 4, 9, 2, 2200, 21, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (276, '2026-02-01', 3, 1, 2, 1200, 58, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (277, '2026-03-05', 3, 22, 1, 3800, 31, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (278, '2026-01-18', 3, 15, 4, 2300, 22, 9200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (279, '2026-06-12', 3, 6, 4, 3900, 29, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (280, '2026-04-22', 3, 16, 1, 2000, 45, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (281, '2026-06-16', 5, 20, 1, 5375, 12, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (282, '2026-06-06', 4, 20, 1, 5375, 56, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (283, '2026-04-07', 2, 12, 1, 2100, 5, 2100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (284, '2026-04-25', 5, 10, 3, 2500, 55, 7500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (285, '2026-05-02', 4, 3, 1, 1800, 21, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (286, '2026-04-07', 3, 20, 1, 5375, 37, 5375);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (287, '2026-05-14', 1, 11, 2, 2800, 51, 5600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (288, '2026-03-18', 5, 11, 3, 2800, 51, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (289, '2026-06-12', 1, 22, 1, 3800, 12, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (290, '2026-04-10', 3, 4, 1, 3500, 29, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (291, '2026-06-25', 1, 7, 1, 1600, 2, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (292, '2026-06-27', 4, 20, 4, 5375, 5, 21500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (293, '2026-04-12', 2, 7, 1, 1600, 40, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (294, '2026-04-24', 1, 3, 4, 1800, 37, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (295, '2026-05-06', 4, 2, 1, 1500, 40, 1500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (296, '2026-05-04', 4, 19, 1, 1800, 58, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (297, '2026-02-05', 1, 19, 4, 1800, 4, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (298, '2026-06-15', 3, 25, 1, 1400, 9, 1400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (299, '2026-03-21', 5, 21, 3, 3200, 59, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (300, '2026-01-25', 3, 14, 2, 1750, 12, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (301, '2026-04-12', 1, 19, 2, 1800, 46, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (302, '2026-05-24', 5, 14, 2, 1750, 29, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (303, '2026-06-14', 1, 8, 1, 1700, 28, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (304, '2026-02-03', 3, 16, 4, 2000, 58, 8000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (305, '2026-06-26', 4, 3, 2, 1800, 55, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (306, '2026-06-15', 5, 13, 4, 1900, 23, 7600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (307, '2026-06-11', 5, 3, 3, 1800, 59, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (308, '2026-01-10', 3, 16, 2, 2000, 15, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (309, '2026-04-19', 1, 12, 1, 2100, 55, 2100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (310, '2026-02-09', 3, 14, 1, 1750, 36, 1750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (311, '2026-06-27', 2, 10, 2, 2500, 52, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (312, '2026-02-01', 4, 4, 1, 3500, 26, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (313, '2026-03-31', 1, 5, 4, 4200, 13, 16800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (314, '2026-02-17', 2, 21, 3, 3200, 30, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (315, '2026-04-25', 5, 9, 2, 2200, 8, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (316, '2026-05-25', 5, 5, 1, 4200, 11, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (317, '2026-04-03', 1, 3, 2, 1800, 28, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (318, '2026-04-06', 3, 3, 1, 1800, 58, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (319, '2026-04-04', 2, 17, 2, 900, 39, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (320, '2026-03-25', 2, 10, 1, 2500, 31, 2500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (321, '2026-03-20', 2, 25, 1, 1400, 28, 1400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (322, '2026-04-21', 5, 1, 4, 1200, 27, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (323, '2026-03-12', 5, 7, 2, 1600, 18, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (324, '2026-06-07', 4, 15, 4, 2300, 35, 9200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (325, '2026-02-10', 2, 15, 2, 2300, 6, 4600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (326, '2026-04-04', 4, 19, 2, 1800, 8, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (327, '2026-06-08', 1, 7, 1, 1600, 18, 1600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (328, '2026-06-22', 1, 8, 1, 1700, 5, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (329, '2026-06-14', 5, 2, 2, 1500, 22, 3000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (330, '2026-01-26', 5, 11, 3, 2800, 53, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (331, '2026-05-11', 5, 4, 1, 3500, 33, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (332, '2026-03-18', 5, 15, 1, 2300, 52, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (333, '2026-04-02', 5, 15, 1, 2300, 41, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (334, '2026-04-22', 1, 8, 3, 1700, 54, 5100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (335, '2026-05-14', 4, 7, 2, 1600, 52, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (336, '2026-02-04', 3, 5, 1, 4200, 14, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (337, '2026-02-05', 2, 12, 4, 2100, 20, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (338, '2026-02-17', 5, 17, 2, 900, 25, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (339, '2026-01-08', 5, 8, 2, 1700, 8, 3400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (340, '2026-05-26', 1, 4, 2, 3500, 29, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (341, '2026-02-11', 3, 8, 3, 1700, 30, 5100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (342, '2026-05-30', 5, 25, 2, 1400, 43, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (343, '2026-02-15', 1, 2, 3, 1500, 24, 4500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (344, '2026-01-12', 4, 1, 3, 1200, 41, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (345, '2026-02-03', 1, 6, 2, 3900, 43, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (346, '2026-06-29', 3, 11, 3, 2800, 19, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (347, '2026-05-19', 2, 8, 3, 1700, 45, 5100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (348, '2026-03-12', 3, 13, 4, 1900, 43, 7600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (349, '2026-05-14', 1, 1, 3, 200, 24, 600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (350, '2026-06-26', 4, 12, 1, 2100, 30, 2100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (351, '2026-06-03', 5, 4, 2, 3500, 19, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (352, '2026-03-24', 1, 17, 2, 900, 59, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (353, '2026-04-30', 3, 8, 1, 1700, 26, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (354, '2026-01-17', 2, 1, 1, 1200, 2, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (355, '2026-01-19', 1, 23, 4, 2900, 32, 11600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (356, '2026-04-27', 5, 13, 2, 1900, 20, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (357, '2026-04-14', 4, 6, 1, 3900, 43, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (358, '2026-06-08', 1, 7, 3, 1600, 37, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (359, '2026-06-01', 1, 8, 2, 1700, 40, 3400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (360, '2026-04-01', 2, 23, 1, 2900, 15, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (361, '2026-01-09', 1, 8, 4, 1700, 27, 6800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (362, '2026-04-07', 4, 8, 2, 1700, 2, 3400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (363, '2026-05-12', 4, 5, 1, 4200, 52, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (364, '2026-05-20', 1, 14, 3, 1750, 30, 5250);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (365, '2026-03-01', 1, 5, 1, 4200, 35, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (366, '2026-01-30', 4, 15, 1, 2300, 60, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (367, '2026-01-21', 5, 2, 2, 1500, 32, 3000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (368, '2026-01-01', 3, 6, 1, 3900, 49, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (369, '2026-02-27', 5, 5, 1, 4200, 48, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (370, '2026-05-14', 3, 22, 4, 3800, 20, 15200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (371, '2026-05-15', 4, 8, 1, 1700, 15, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (372, '2026-01-02', 5, 14, 2, 1750, 52, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (373, '2026-05-06', 5, 15, 3, 2300, 31, 6900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (374, '2026-02-25', 5, 19, 2, 1800, 37, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (375, '2026-06-20', 3, 20, 2, 5375, 18, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (376, '2026-03-29', 5, 16, 1, 2000, 36, 2000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (377, '2026-02-07', 2, 11, 3, 2800, 38, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (378, '2026-01-22', 3, 6, 2, 3900, 20, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (379, '2026-03-18', 5, 18, 1, 2600, 51, 2600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (380, '2026-01-23', 5, 13, 1, 1900, 59, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (381, '2026-06-12', 3, 15, 2, 2300, 32, 4600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (382, '2026-06-08', 5, 6, 1, 3900, 2, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (383, '2026-02-17', 4, 24, 2, 2400, 2, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (384, '2026-02-17', 1, 16, 2, 2000, 41, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (385, '2026-06-05', 4, 19, 2, 1800, 53, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (386, '2026-02-15', 4, 4, 2, 3500, 4, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (387, '2026-05-16', 3, 13, 1, 1900, 6, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (388, '2026-03-30', 3, 4, 1, 3500, 50, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (389, '2026-01-13', 2, 1, 1, 1200, 4, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (390, '2026-04-28', 5, 3, 1, 1800, 23, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (391, '2026-03-06', 3, 23, 2, 2900, 45, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (392, '2026-01-20', 2, 23, 1, 2900, 30, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (393, '2026-05-23', 1, 14, 1, 1750, 19, 1750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (394, '2026-04-06', 1, 5, 2, 4200, 48, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (395, '2026-06-15', 1, 21, 2, 3200, 49, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (396, '2026-01-12', 2, 4, 2, 3500, 36, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (397, '2026-01-19', 1, 8, 1, 1700, 32, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (398, '2026-06-29', 4, 6, 1, 3900, 53, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (399, '2026-04-10', 5, 22, 3, 3800, 51, 11400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (400, '2026-02-19', 3, 13, 2, 1900, 35, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (401, '2026-01-07', 1, 17, 1, 900, 5, 900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (402, '2026-01-14', 4, 15, 3, 2300, 19, 6900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (403, '2026-02-13', 4, 25, 3, 1400, 50, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (404, '2026-02-09', 1, 6, 4, 3900, 29, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (405, '2026-05-15', 4, 6, 2, 3900, 49, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (406, '2026-05-10', 4, 21, 1, 3200, 21, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (407, '2026-02-07', 5, 21, 3, 3200, 30, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (408, '2026-04-17', 1, 4, 1, 3500, 4, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (409, '2026-03-12', 1, 20, 2, 5375, 47, 10750);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (410, '2026-02-04', 1, 18, 4, 2600, 42, 10400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (411, '2026-03-11', 4, 25, 1, 1400, 6, 1400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (412, '2026-02-02', 2, 12, 1, 2100, 55, 2100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (413, '2026-02-16', 3, 19, 1, 1800, 7, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (414, '2026-02-10', 5, 12, 1, 2100, 53, 2100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (415, '2026-06-05', 2, 22, 1, 3800, 2, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (416, '2026-04-06', 5, 11, 4, 2800, 39, 11200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (417, '2026-06-10', 1, 14, 2, 1750, 60, 3500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (418, '2026-05-12', 3, 7, 2, 1600, 2, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (419, '2026-05-27', 1, 24, 1, 2400, 48, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (420, '2026-01-29', 2, 11, 2, 2800, 12, 5600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (421, '2026-02-18', 4, 6, 2, 3900, 60, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (422, '2026-06-22', 2, 13, 2, 1900, 51, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (423, '2026-03-09', 4, 5, 3, 4200, 24, 12600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (424, '2026-04-14', 5, 5, 2, 4200, 54, 8400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (425, '2026-06-03', 1, 12, 2, 2100, 23, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (426, '2026-05-29', 4, 15, 2, 2300, 39, 4600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (427, '2026-02-03', 2, 24, 3, 2400, 35, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (428, '2026-02-18', 1, 8, 1, 1700, 21, 1700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (429, '2026-04-27', 4, 8, 4, 1700, 42, 6800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (430, '2026-02-21', 2, 24, 4, 2400, 29, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (431, '2026-01-19', 5, 21, 4, 3200, 37, 12800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (432, '2026-01-19', 1, 15, 1, 2300, 14, 2300);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (433, '2026-02-09', 2, 13, 1, 1900, 27, 1900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (434, '2026-03-29', 4, 8, 3, 1700, 3, 5100);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (435, '2026-06-10', 1, 11, 4, 2800, 48, 11200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (436, '2026-04-16', 3, 19, 3, 1800, 18, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (437, '2026-02-21', 3, 23, 1, 2900, 47, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (438, '2026-06-01', 4, 4, 3, 3500, 8, 10500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (439, '2026-05-14', 3, 15, 3, 2300, 12, 6900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (440, '2026-04-15', 1, 1, 3, 1200, 41, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (441, '2026-05-26', 2, 9, 4, 2200, 36, 8800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (442, '2026-02-10', 4, 19, 2, 1800, 30, 3600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (443, '2026-02-01', 5, 11, 1, 2800, 47, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (444, '2026-04-21', 5, 24, 3, 2400, 56, 7200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (445, '2026-06-30', 5, 1, 1, 1200, 43, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (446, '2026-06-18', 5, 10, 2, 2500, 49, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (447, '2026-01-01', 4, 2, 3, 1500, 32, 4500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (448, '2026-02-12', 1, 24, 4, 2400, 6, 9600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (449, '2026-04-27', 5, 1, 2, 1200, 35, 2400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (450, '2026-02-11', 3, 9, 1, 2200, 26, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (451, '2026-03-23', 5, 6, 1, 3900, 36, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (452, '2026-02-15', 1, 15, 4, 2300, 47, 9200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (453, '2026-05-14', 4, 23, 4, 2900, 49, 11600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (454, '2026-04-13', 5, 11, 1, 2800, 33, 2800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (455, '2026-01-29', 2, 9, 1, 2200, 1, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (456, '2026-03-28', 2, 12, 2, 2100, 39, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (457, '2026-03-15', 3, 24, 2, 2400, 11, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (458, '2026-06-26', 5, 23, 2, 2900, 10, 5800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (459, '2026-01-23', 5, 17, 3, 900, 41, 2700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (460, '2026-05-03', 5, 6, 1, 3900, 46, 3900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (461, '2026-03-23', 5, 7, 2, 1600, 53, 3200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (462, '2026-06-09', 1, 15, 2, 2300, 53, 4600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (463, '2026-03-21', 1, 10, 2, 2500, 22, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (464, '2026-05-05', 5, 9, 1, 2200, 25, 2200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (465, '2026-03-11', 5, 10, 2, 2500, 46, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (466, '2026-01-30', 2, 18, 1, 2600, 36, 2600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (467, '2026-02-21', 3, 1, 1, 1200, 12, 1200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (468, '2026-04-30', 3, 8, 4, 1700, 40, 6800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (469, '2026-01-19', 4, 7, 3, 1600, 34, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (470, '2026-03-10', 2, 25, 3, 1400, 60, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (471, '2026-02-25', 1, 17, 2, 900, 5, 1800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (472, '2026-02-16', 3, 13, 2, 1900, 41, 3800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (473, '2026-02-02', 2, 23, 3, 2900, 12, 8700);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (474, '2026-01-31', 4, 18, 1, 2600, 15, 2600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (475, '2026-04-20', 5, 6, 2, 3900, 28, 7800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (476, '2026-05-13', 1, 3, 3, 1800, 24, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (477, '2026-05-29', 2, 6, 4, 3900, 46, 15600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (478, '2026-04-23', 3, 10, 2, 2500, 2, 5000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (479, '2026-06-19', 3, 23, 1, 2900, 4, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (480, '2026-03-24', 5, 15, 3, 2300, 10, 6900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (481, '2026-04-16', 2, 21, 2, 3200, 9, 6400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (482, '2026-03-10', 3, 11, 2, 2800, 15, 5600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (483, '2026-02-08', 2, 4, 2, 3500, 31, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (484, '2026-01-22', 4, 23, 4, 2900, 41, 11600);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (485, '2026-01-29', 4, 25, 1, 1400, 44, 1400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (486, '2026-05-11', 4, 4, 4, 3500, 41, 14000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (487, '2026-01-02', 3, 19, 3, 1800, 38, 5400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (488, '2026-01-20', 3, 12, 2, 2100, 6, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (489, '2026-06-01', 3, 23, 1, 2900, 21, 2900);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (490, '2026-01-12', 1, 9, 2, 2200, 58, 4400);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (491, '2026-01-19', 1, 10, 1, 2500, 31, 2500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (492, '2026-02-24', 5, 2, 3, 1500, 35, 4500);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (493, '2026-06-15', 1, 20, 3, 5375, 35, 16125);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (494, '2026-03-03', 2, 24, 2, 2400, 26, 4800);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (495, '2026-03-11', 1, 16, 2, 2000, 13, 4000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (496, '2026-02-27', 2, 12, 2, 2100, 18, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (497, '2026-01-31', 5, 12, 2, 2100, 24, 4200);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (498, '2026-06-28', 2, 4, 2, 3500, 34, 7000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (499, '2026-06-25', 4, 2, 2, 1500, 27, 3000);
insert into ventas (venta_id, fecha, sucursal_id, medicamento_id, cantidad, precio_unitario, cliente_id, total) values (500, '2026-02-17', 1, 9, 2, 2200, 22, 4400);