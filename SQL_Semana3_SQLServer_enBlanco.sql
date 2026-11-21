/* =====================================================================
   SQL SEMANA 3 - SCRIPT COMPLETO PARA SQL SERVER (T-SQL / SSMS)
   Contenido:

     1. Clase 4 - DDL  (CREATE / ALTER / DROP)
     2. Clase 5 - DML  (SELECT / INSERT / UPDATE / DELETE)


   Notas:
   - Las lineas "GO" separan lotes (batches); son necesarias en SSMS.
   ===================================================================== */



/* =====================================================================
   1. CLASE 3_1 - SUBLENGUAJE DDL
   ===================================================================== */

-- Nomenclatura de tablas (referencia):
--   Snake_Case  -> numero_de_estudiantes
--   Kebab Case  -> Numero-de-estudiantes
--   Camel Case  -> numeroDeEstudiantes
--   Pascal Case -> NumeroDeEstudiantes   (la usada en estos ejemplos)

-- CREAR BASE DE DATOS
CREATE DATABASE Clase3_1;

-- USEMOS LA BASE DATOS
USE Clase3_1;

-- CREAR TABLA CLIENTES

CREATE TABLE Clientes (
IDCliente int NOT NULL IDENTITY PRIMARY KEY,
NombreCliente varchar(50) NOT NULL,
Dirección varchar(50) NOT NULL,
Ciudad varchar(50) NOT NULL,
CP varchar(50) NOT NULL,
Pais text NOT NULL  -- 'text' está en desuso, ahora se recomienda varchar(max)
);

SELECT * FROM Clientes ;
-- CREAR TABLA EMPLEADOS

CREATE TABLE Empleados (
IDEmpleado int not null identity primary key,
Apellido varchar(50) not null,
Nombre varchar(50) not null,
Nacimiento datetime not null, 
Notas varchar(50) not null
);

SELECT *FROM Empleados;

-- CREAR TABLA ORDENES (con claves foraneas a Clientes y Empleados)

CREATE TABLE Ordenes (
IDOrden int not null identity primary key,
FechaOrden datetime not null,
IDCliente int not null FOREIGN KEY REFERENCES Clientes(IDCliente),
IDEmpleado int not null FOREIGN KEY REFERENCES Empleados(IDEmpleado)
);

-- Ver las tablas creadas 

SELECT * FROM Clientes;
SELECT * FROM Empleados;
SELECT * FROM Ordenes;

-- EJEMPLO ALTER: agregar una columna

ALTER TABLE Ordenes
ADD Cantidad int not null;

-- Cambiar el tipo de datos con ALTER

ALTER TABLE Ordenes
ALTER COLUMN Cantidad varchar(10) null;

-- Renombrar una columna (sintaxis general):
--   EXEC sp_rename 'nombre_de_la_tabla.nombreColumna', 'nuevoNombreColumna', 'COLUMN';

EXEC sp_rename 'Ordenes.Cantidad', 'NuevaCantidad','COLUMN';


-- EJEMPLO DROP: eliminar una columna de una tabla

ALTER TABLE Ordenes
DROP COLUMN Cantidad;

-- Eliminar tablas con DROP
-- IMPORTANTE: Ordenes depende de Clientes por la FK, por eso se elimina primero.
-- (Si se intenta DROP TABLE Clientes antes que Ordenes, SQL Server da error.)


-- Verificar que solo queda Empleados



/* =====================================================================
   2. CLASE 3_2 - SUBLENGUAJE DML
   ===================================================================== */

-- CREAR BASE DE DATOS

CREATE DATABASE Clase3_2;

-- USEMOS LA BASE DATOS

USE Clase3_2;

-- CREAR ESTRUCTURA TABLA CATEGORIAS SIN AUTOINCREMENTAL


-- INSERTAR CONTENIDO (el ID se carga a mano)

insert into Categorias
(IDCategoria, NombreCategoria, Descripcion)
VALUES
(1, 'bebidas', 'cafe, te , cerveza')

-- VISUALIZAR TABLA CATEGORIAS
CREATE TABLE Categorias (
    IDCategoria     int        NOT NULL PRIMARY KEY,
    NombreCategoria varchar(50) NOT NULL,
    Descripcion     varchar(50) NOT NULL
);

SELECT * FROM Categorias;

-- CREAR ESTRUCTURA TABLA CATEGORIAS CON AUTOINCREMENTAL (IDENTITY)
CREATE TABLE CategoriasAuto (
    IDCategoria     int         NOT NULL IDENTITY PRIMARY KEY,
    NombreCategoria varchar(50) NOT NULL,
    Descripcion     varchar(50) NOT NULL
);

SELECT * FROM CategoriasAuto

-- INSERTAR CONTENIDO CON AUTOINCREMENTAL (el ID se genera solo)

INSERT INTO CategoriasAuto
(NombreCategoria, Descripcion)
VALUES
('bebidas', 'cafe, fe, cervaza')

insert into Categorias
(IDCategoria, NombreCategoria, Descripcion)
VALUES
(1, 'bebidas', 'cafe, te , cerveza')

-- INSERTAR MAS DE UN REGISTRO EN UNA TABLA

INSERT INTO CategoriasAuto
(NombreCategoria, Descripcion)
VALUES
('Quesos', 'Brie, Hebras, Para Untar'),
('Carnes', 'Res, Pollo, Mariscos');

-- SELECT de columnas especificas

SELECT
Descripcion,
IDCategoria
FROM CategoriasAuto

-- El orden de las columnas en el SELECT es libre


-- EJEMPLO UPDATE

UPDATE CategoriasAuto set NombreCategoria = 'Milanesa'
where NombreCategoria = 'carnes'

-- AND: deben cumplirse las dos condiciones.
-- Carnes tiene IDCategoria = 3, por lo que (... AND IDCategoria = 1) afecta 0 filas.

UPDATE CategoriasAuto set NombreCategoria = 'Carnes'
where NombreCategoria = 'Milanesa'
and IDCategoria = 1

-- OR: alcanza con que se cumpla una condicion (afecta Carnes e IDCategoria = 1)

UPDATE CategoriasAuto set NombreCategoria = 'Carnes'
where NombreCategoria = 'Milanesa'
or IDCategoria = 1

-- EJEMPLO DELETE


-- Eliminar TODOS los registros (sin WHERE). 


-- Volver a insertar 


-- Se inserta nuevamente 


-- Eliminar un registro en especifico


-- COMPLEMENTO: version que si elimina una fila existente
