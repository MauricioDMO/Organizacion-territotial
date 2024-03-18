CREATE TABLE Tipos_usuarios (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(15),
  Descripcion VARCHAR(255),
  Acceso VARCHAR(255)
);

CREATE TABLE Sucursales (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Nombre VARCHAR(255),
  Ubicacion VARCHAR(255)
);

CREATE TABLE Tipo_bodega (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(25),
  Descripcion VARCHAR(255)
);

CREATE TABLE Bodegas (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo_bodegas INT,
  Sucursal_id INT,
  Capacidad INT,
  FOREIGN KEY (Tipo_bodegas) REFERENCES Tipo_bodega(Id),
  FOREIGN KEY (Sucursal_id) REFERENCES Sucursales(Id)
);

CREATE TABLE Tipo_transporte (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(25)
);

CREATE TABLE Estado_transporte (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Estado VARCHAR(20)
);

CREATE TABLE Transportes (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo_transporte INT,
  Sucursal_id INT,
  Estado INT,
  Capacidad INT,
  FOREIGN KEY (Tipo_transporte) REFERENCES Tipo_transporte(Id),
  FOREIGN KEY (Sucursal_id) REFERENCES Sucursales(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_transporte(Id)
);

CREATE TABLE Tipo_cliente (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(20),
  Rango_paquetes VARCHAR(10)
);

CREATE TABLE Tipo_zona (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(15)
);

CREATE TABLE Tipo_tarifa (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(15)
);

CREATE TABLE Tarifa (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo_tarifa INT,
  Tipo_cliente INT,
  Tipo_transporte INT,
  Tipo_zona INT,
  Precio DECIMAL(10, 2),
  FOREIGN KEY (Tipo_tarifa) REFERENCES Tipo_tarifa(Id),
  FOREIGN KEY (Tipo_cliente) REFERENCES Tipo_cliente(Id),
  FOREIGN KEY (Tipo_transporte) REFERENCES Tipo_transporte(Id),
  FOREIGN KEY (Tipo_zona) REFERENCES Tipo_zona(Id)
);

CREATE TABLE Estado_Cliente (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Estado VARCHAR(20)
);

CREATE TABLE Clientes (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Nombre VARCHAR(100),
  Tipo_cliente INT,
  Estado INT,
  FOREIGN KEY (Tipo_cliente) REFERENCES Tipo_cliente(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_Cliente(Id)
);

CREATE TABLE Tipo_telefono (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(10)
);

CREATE TABLE Tipo_correo (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(10)
);

CREATE TABLE Tipo_direccion (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(10)
);

CREATE TABLE Estado_datos (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Estado VARCHAR(20)
);

CREATE TABLE Telefonos (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Cliente_id INT,
  Telefono VARCHAR(15),
  Tipo_id INT,
  Estado INT,
  FOREIGN KEY (Cliente_id) REFERENCES Clientes(Id),
  FOREIGN KEY (Tipo_id) REFERENCES Tipo_telefono(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_datos(Id)
);

CREATE TABLE Direcciones (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Cliente_id INT,
  Direccion VARCHAR(255),
  Tipo_id INT,
  Estado INT,
  FOREIGN KEY (Cliente_id) REFERENCES Clientes(Id),
  FOREIGN KEY (Tipo_id) REFERENCES Tipo_direccion(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_datos(Id)
);

CREATE TABLE Correos_electronicos (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Cliente_id INT,
  Correo VARCHAR(100),
  Tipo_id INT,
  FOREIGN KEY (Cliente_id) REFERENCES Clientes(Id),
  FOREIGN KEY (Tipo_id) REFERENCES Tipo_correo(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_datos(Id)
);

CREATE TABLE Estado_paquete (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Estado VARCHAR(15)
);

CREATE TABLE Tipo_empleado (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(15)
);

CREATE TABLE Estado_empleado (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Estado VARCHAR(15)
);

CREATE TABLE Empleados (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Nombre VARCHAR(100),
  Tipo_empleado INT,
  Salario DECIMAL(10, 2),
  Tipo_usuario INT,
  Sucursal_id INT,
  Estado INT,
  FOREIGN KEY (Tipo_usuario) REFERENCES Tipos_usuarios(Id),
  FOREIGN KEY (Sucursal_id) REFERENCES Sucursales(Id),
  FOREIGN KEY (Tipo_empleado) REFERENCES Tipo_empleado(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_empleado(Id)
);

CREATE TABLE Direcciones_empleados (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Empleado_id INT,
  Direccion VARCHAR(255),
  Tipo_id INT,
  Estado INT,
  FOREIGN KEY (Empleado_id) REFERENCES Empleados(Id),
  FOREIGN KEY (Tipo_id) REFERENCES Tipo_direccion(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_datos(Id)
);

CREATE TABLE Telefonos_empleados (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Empleado_id INT,
  Telefono VARCHAR(15),
  Tipo_id INT,
  Estado INT,
  FOREIGN KEY (Empleado_id) REFERENCES Empleados(Id),
  FOREIGN KEY (Tipo_id) REFERENCES Tipo_telefono(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_datos(Id)
);

CREATE TABLE Correos_electronicos_empleados (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Empleado_id INT,
  Correo VARCHAR(100),
  Tipo_id INT,
  Estado INT,
  FOREIGN KEY (Empleado_id) REFERENCES Empleados(Id),
  FOREIGN KEY (Tipo_id) REFERENCES Tipo_correo(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_datos(Id)
);

CREATE TABLE Tipo_pago (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Tipo VARCHAR(15)
);

CREATE TABLE Paquetes (
  Id INT PRIMARY KEY IDENTITY(1,1),
  Cliente_id INT,
  Peso DECIMAL(10, 2),
  Dimensiones VARCHAR(20),
  Tarifa_id INT,
  Tipo_pago INT,
  Empleado_asignado INT,
  Direccion_id INT,
  Estado INT,
  Desde_bodega INT,
  FOREIGN KEY (Cliente_id) REFERENCES Clientes(Id),
  FOREIGN KEY (Tarifa_id) REFERENCES Tarifa(Id),
  FOREIGN KEY (Tipo_pago) REFERENCES Tipo_pago(Id),
  FOREIGN KEY (Empleado_asignado) REFERENCES Empleados(Id),
  FOREIGN KEY (Direccion_id) REFERENCES Direcciones(Id),
  FOREIGN KEY (Estado) REFERENCES Estado_paquete(Id),
  FOREIGN KEY (Desde_bodega) REFERENCES Bodegas(Id)
);

-- Funcion para insertar empleados en sql server

CREATE FUNCTION InsertarEmpleado(
  @Nombre VARCHAR(100),
  @Tipo_empleado INT,
  @Salario DECIMAL(10, 2),
  @Tipo_usuario INT,
  @Sucursal_id INT,
  @Direccion VARCHAR(255),
  @Tipo_direccion INT,
  @Telefono VARCHAR(15),
  @Tipo_telefono INT,
  @Correo VARCHAR(100),
  @Tipo_correo INT
)

RETURNS INT
AS
BEGIN
  DECLARE @Empleado_id INT;
  INSERT INTO Empleados (Nombre, Tipo_empleado, Salario, Tipo_usuario, Sucursal_id, Estado)
  VALUES (@Nombre, @Tipo_empleado, @Salario, @Tipo_usuario, @Sucursal_id, 1);
  SET @Empleado_id = SCOPE_IDENTITY();
  INSERT INTO Direcciones_empleados (Empleado_id, Direccion, Tipo_id, Estado)
  VALUES (@Empleado_id, @Direccion, @Tipo_direccion, 1);
  INSERT INTO Telefonos_empleados (Empleado_id, Telefono, Tipo_id, Estado)
  VALUES (@Empleado_id, @Telefono, @Tipo_telefono, 1);
  INSERT INTO Correos_electronicos_empleados (Empleado_id, Correo, Tipo_id, Estado)
  VALUES (@Empleado_id, @Correo, @Tipo_correo, 1);
  RETURN @Empleado_id;
END;

-- Funcion para insertar clientes en sql server

CREATE FUNCTION InsertarCliente(
  @Nombre VARCHAR(100),
  @Tipo_cliente INT,
  @Direccion VARCHAR(255),
  @Tipo_direccion INT,
  @Telefono VARCHAR(15),
  @Tipo_telefono INT,
  @Correo VARCHAR(100),
  @Tipo_correo INT
)

RETURNS INT
AS
BEGIN
  DECLARE @Cliente_id INT;
  INSERT INTO Clientes (Nombre, Tipo_cliente, Estado)
  VALUES (@Nombre, @Tipo_cliente, 1);
  SET @Cliente_id = SCOPE_IDENTITY();
  INSERT INTO Direcciones (Cliente_id, Direccion, Tipo_id, Estado)
  VALUES (@Cliente_id, @Direccion, @Tipo_direccion, 1);
  INSERT INTO Telefonos (Cliente_id, Telefono, Tipo_id, Estado)
  VALUES (@Cliente_id, @Telefono, @Tipo_telefono, 1);
  INSERT INTO Correos_electronicos (Cliente_id, Correo, Tipo_id, Estado)
  VALUES (@Cliente_id, @Correo, @Tipo_correo, 1);
  RETURN @Cliente_id;
END;

-- Insertar datos de prueba en la base de datos con sql server

INSERT INTO Tipos_usuarios (Tipo, Descripcion, Acceso)
VALUES ('Administrador', 'Acceso total al sistema', 'crear y modificar usuarios, estatus de envíos, liquidaciones, etc'),
       ('Jefe de Sucursal', 'Acceso limitado al sistema', 'agregar envíos y revisar estados de pedidos, generar reporte de facturación por cliente/pedido, generar orden de traslados para bodega central'),
       ('Cliente', 'Acceso limitado al sistema', 'agregar guías, y revisar estado de paquetes (en bodega, entregado, liquidado etc.'),
       ('Mensajero', 'Acceso limitado al sistema', 'agregar envíos sin modificarlos'),
       ('Colaborador', 'Acceso limitado al sistema', 'crear usuario por cada colaborador que trabaja para nuestro empresa, labor que realiza, código de trabajador, sucursal asignada, datos de sueldo, descuentos, adelantos salariales, dirección de casa, información de los contactos');

INSERT INTO Sucursales (Nombre, Ubicacion)
VALUES ('Sucursal 1', 'Calle 1, Ciudad 1'),
       ('Sucursal 2', 'Calle 2, Ciudad 2'),
       ('Sucursal 3', 'Calle 3, Ciudad 3');

INSERT INTO Tipo_bodega (Tipo, Descripcion)
VALUES ('Ingreso de paquetes', 'Bodega para recibir paquetes'),
       ('Paquetes entregados', 'Bodega para paquetes entregados'),
       ('Devoluciones', 'Bodega para paquetes devueltos');

INSERT INTO Bodegas (Tipo_bodegas, Sucursal_id, Capacidad)
VALUES (1, 1, 1000),
       (2, 1, 1000),
       (3, 1, 1000),
       (1, 2, 1000),
       (2, 2, 1000),
       (3, 2, 1000),
       (1, 3, 1000),
       (2, 3, 1000),
       (3, 3, 1000);

INSERT INTO Tipo_transporte (Tipo)
VALUES ('Moto'),
       ('Panel'),
       ('Camión');

INSERT INTO Estado_transporte (Estado)
VALUES ('Disponible'),
       ('En mantenimiento'),
       ('En uso');

INSERT INTO Transportes (Tipo_transporte, Sucursal_id, Estado, Capacidad)
VALUES (1, 1, 1, 100),
       (2, 1, 1, 100),
       (3, 1, 1, 100),
       (1, 2, 1, 100),
       (2, 2, 1, 100),
       (3, 2, 1, 100),
       (1, 3, 1, 100),
       (2, 3, 1, 100),
       (3, 3, 1, 100);

INSERT INTO Tipo_cliente (Tipo, Rango_paquetes)
VALUES ('Emprendedor', '1-75'),
       ('Pyme', '76-200'),
       ('Premium', '200 o más');

INSERT INTO Tipo_zona (Tipo)
VALUES ('Ciudad'),
       ('Municipio'),
       ('Interior del país');

INSERT INTO Tipo_tarifa (Tipo)
VALUES ('Estándar'),
       ('Personalizado');

INSERT INTO Tarifa (Tipo_tarifa, Tipo_cliente, Tipo_transporte, Tipo_zona, Precio)
VALUES (1, 1, 1, 1, 22.00),
       (1, 1, 1, 2, 28.00),
       (1, 1, 1, 3, 32.00),
       (1, 2, 1, 1, 38.00),
       (1, 2, 1, 2, 48.00),
       (1, 3, 1, 1, 20.00),
       (1, 3, 1, 2, 25.00),
       (1, 3, 1, 3, 31.00),
       (2, 1, 2, 1, 38.00),
       (2, 1, 2, 2, 48.00),
       (2, 2, 2, 1, 35.00),
       (2, 2, 2, 2, 45.00),
       (2, 3, 2, 1, 25.00),
       (2, 3, 2, 2, 30.00);

INSERT INTO Estado_Cliente (Estado)
VALUES ('Activo'),
       ('Inactivo');

INSERT INTO Estado_Empleado (Estado)
VALUES ('Activo'),
       ('Inactivo');

INSERT INTO Tipo_empleado (Tipo)
VALUES ('Administrativo'),
       ('Operativo'),
       ('Mensajero');

INSERT INTO Estado_datos (Estado)
VALUES ('Activo'),
       ('Inactivo');

INSERT INTO Tipo_telefono (Tipo)
VALUES ('Casa'),
       ('Celular'),
       ('Trabajo');

INSERT INTO Tipo_correo (Tipo)
VALUES ('Personal'),
       ('Trabajo');

INSERT INTO Tipo_direccion (Tipo)
VALUES ('Casa'),
       ('Trabajo');

-- Insertar clientes con la función creada

SELECT dbo.InsertarCliente('Cliente 1', 1, 'Calle 1, Ciudad 1', 1, '1234567890', 1, 'ejemplo@ejemplo.com', 1);
SELECT dbo.InsertarCliente('Cliente 2', 2, 'Calle 2, Ciudad 2', 1, '1234567890', 1, 'ejemplo2@ejemplo.com', 1);
SELECT dbo.InsertarCliente('Cliente 3', 3, 'Calle 3, Ciudad 3', 1, '1234567890', 1, 'ejemplo3@ejemplo.com', 1);

-- Insertar empleados con la función creada

  -- @Nombre VARCHAR(100),
  -- @Tipo_empleado INT,
  -- @Salario DECIMAL(10, 2),
  -- @Tipo_usuario INT,
  -- @Sucursal_id INT,
  -- @Direccion VARCHAR(255),
  -- @Tipo_direccion INT,
  -- @Telefono VARCHAR(15),
  -- @Tipo_telefono INT,
  -- @Correo VARCHAR(100),
  -- @Tipo_correo INT

SELECT dbo.InsertarEmpleado('Empleado 1', 1, 1000.00, 1, 1, 'Calle 1, Ciudad 1', 1, '1234567890', 1, 'ejemplo@ejemplo.com', 1);
SELECT dbo.InsertarEmpleado('Empleado 2', 2, 1000.00, 1, 1, 'Calle 2, Ciudad 2', 1, '1234567890', 1, 'ejemplo2@ejemplo.com', 1);
SELECT dbo.InsertarEmpleado('Empleado 3', 3, 1000.00, 1, 1, 'Calle 3, Ciudad 3', 1, '1234567890', 1, 'ejemplo3@ejemplo.com', 1);

INSERT INTO Estado_paquete (Estado)
VALUES ('En bodega'),
       ('En tránsito'),
       ('Entregado'),
       ('Liquidado');

INSERT INTO Tipo_pago (Tipo)
VALUES ('Efectivo'),
       ('Tarjeta de crédito'),
       ('Tarjeta de débito');

INSERT INTO Paquetes (Cliente_id, Peso, Dimensiones, Tarifa_id, Tipo_pago, Empleado_asignado, Direccion_id, Estado, Desde_bodega)
VALUES (1, 10.00, '10x10x10', 1, 1, 1, 1, 1, 1),
       (2, 20.00, '20x20x20', 2, 2, 2, 2, 2, 2),
       (3, 30.00, '30x30x30', 3, 3, 3, 3, 3, 3);



