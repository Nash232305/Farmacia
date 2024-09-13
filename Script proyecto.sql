CREATE TABLE EMPLEADO_FARMACIA 
(
  ID NUMBER(*,0), 
  CEDULA VARCHAR2(10 BYTE) NOT NULL, 
  NOMBRE VARCHAR2(50 BYTE) NOT NULL, 
  APELLIDO VARCHAR2(100 BYTE) NOT NULL, 
  SEXO CHAR(1 BYTE) NOT NULL, 
  EDAD NUMBER NOT NULL, 
  SALARIO NUMBER(10,2) NOT NULL, 
  EMAIL VARCHAR2(100 BYTE) NOT NULL, 
  NUMEROTELEFONO VARCHAR2(8 BYTE) NOT NULL, 
  ESTADO CHAR(1 BYTE) DEFAULT '1', 
  IDSUCURSAL NUMBER NOT NULL,
  CONSTRAINT ID_EMPLEADOFARMACIA_PK PRIMARY KEY (ID)
);

CREATE UNIQUE INDEX SYS_C00117542 ON EMPLEADO_FARMACIA (CEDULA);
CREATE UNIQUE INDEX SYS_C00117543 ON EMPLEADO_FARMACIA (EMAIL);
CREATE UNIQUE INDEX SYS_C00117544 ON EMPLEADO_FARMACIA (NUMEROTELEFONO);

ALTER TABLE EMPLEADO_FARMACIA ADD CONSTRAINT ID_EMPLEADOFARMACIA_IDSURSAL_FK1 FOREIGN KEY (IDSUCURSAL)
  REFERENCES SUCURSAL_FARMACIA (ID) ENABLE;
  
CREATE TABLE PROVEEDOR_FARMACIA 
(
  ID NUMBER(*,0), 
  NOMBRE VARCHAR2(50 BYTE) NOT NULL, 
  PROVINCIA VARCHAR2(50 BYTE) NOT NULL, 
  TELEFONO VARCHAR2(20 BYTE) NOT NULL,
  CONSTRAINT ID_PROVEEDORFARMACIA_PK PRIMARY KEY (ID)
);

CREATE UNIQUE INDEX SYS_C00117509 ON PROVEEDOR_FARMACIA (NOMBRE);
CREATE UNIQUE INDEX SYS_C00117510 ON PROVEEDOR_FARMACIA (TELEFONO);

-- Crear tabla FABRICANTE_FARMACIA
CREATE TABLE FABRICANTE_FARMACIA (
    ID NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    PAIS VARCHAR2(50) NOT NULL
);

-- Crear Ã­ndice Ãºnico para el campo NOMBRE
CREATE UNIQUE INDEX IDX_NOMBRE_UNIQUE ON FABRICANTE_FARMACIA (NOMBRE);


-- Crear tabla PRODUCTO_FARMACIA
CREATE TABLE PRODUCTO_FARMACIA (
    ID NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    DESCRIPCION VARCHAR2(50) NOT NULL,
    FECHAVENCIMIENTO DATE NOT NULL,
    COSTO NUMBER(10,2) NOT NULL,
    IDFABRICANTE NUMBER NOT NULL,
    IDPROVEEDOR NUMBER NOT NULL,
    CANTIDAD NUMBER NOT NULL
);

-- Crear Ã­ndice Ãºnico para el campo NOMBRE
CREATE UNIQUE INDEX IDX_NOMBRE_UNIQUE ON PRODUCTO_FARMACIA (NOMBRE);

-- Crear restricciones de clave forÃ¡nea
ALTER TABLE PRODUCTO_FARMACIA ADD CONSTRAINT IDFABRICANTE_FK1 FOREIGN KEY (IDFABRICANTE)
    REFERENCES FABRICANTE_FARMACIA (ID);

ALTER TABLE PRODUCTO_FARMACIA ADD CONSTRAINT IDPROVEEDOR_FK1 FOREIGN KEY (IDPROVEEDOR)
    REFERENCES PROVEEDOR_FARMACIA (ID);
	
-- Crear tabla SUCURSAL_FARMACIA
CREATE TABLE SUCURSAL_FARMACIA (
    ID NUMBER PRIMARY KEY,
    NOMBRE VARCHAR2(50) NOT NULL,
    PROVINCIA VARCHAR2(50) NOT NULL,
    ESTADO CHAR(1 BYTE) DEFAULT '1',
    TELEFONO VARCHAR2(20) NOT NULL,
    FECHAAPERTURA DATE
);

-- Crear Ã­ndice Ãºnico para el campo NOMBRE
CREATE UNIQUE INDEX IDX_NOMBRE_UNIQUE ON SUCURSAL_FARMACIA (NOMBRE);

-- Crear Ã­ndice Ãºnico para el campo TELEFONO
CREATE UNIQUE INDEX IDX_TELEFONO_UNIQUE ON SUCURSAL_FARMACIA (TELEFONO);	
	
	

--Listo
CREATE TABLE Credencial_Empleado (
    IDEmpleado INT NOT NULL,
    Usuario VARCHAR2(50) NOT NULL,
    Contrasena VARCHAR2(255) NOT NULL,

    CONSTRAINT ID_CredencialEmpleado_PK PRIMARY KEY (IDEmpleado),
    CONSTRAINT ID_CredencialEmpleado_FK1 FOREIGN KEY (IDEmpleado) REFERENCES Empleado_Farmacia (ID),
    CONSTRAINT UC_Usuario UNIQUE (Usuario)  -- Asegura que el nombre de usuario sea Ãºnico
);

    
-- Inserts para Fabricante_Farmacia READY
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (1, 'Pfizer', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (2, 'Johnson Johnson', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (3, 'Roche', 'Suiza');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (4, 'Novartis', 'Suiza');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (5, 'Merck Co.', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (6, 'Sanofi', 'Francia');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (7, 'GSK', 'Reino Unido');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (8, 'AstraZeneca', 'Suecia');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (9, 'AbbVie', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (10, 'Bristol-Myers Squibb', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (11, 'Bayer', 'Alemania');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (12, 'Novo Nordisk', 'Dinamarca');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (13, 'Takeda', 'Japón');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (14, 'Amgen', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (15, 'Teva', 'Israel');


-- Inserts para Proveedor_Farmacia READY
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (1, 'CONDEFA', 'San José', '12345678');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (2, 'COFASA', 'Alajuela', '87654321');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (3, 'FARMACORP', 'Cartago', '23456789');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (4, 'Medicinas Nacional', 'Heredia', '34567890');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (5, 'Salud Pura Vida', 'Puntarenas', '45678901');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (6, 'BIOFARMA', 'Guanacaste', '56789012');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (7, 'FarmaLuz', 'Limón', '67890123');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (8, 'PHARMA PLUS', 'San José', '78901234');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (9, 'MEDICORP', 'Alajuela', '89012345');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (10, 'Farma a tu casa', 'Cartago', '90123456');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (11, 'SALUD Y VIDA', 'Heredia', '01234567');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (12, 'Proveedor Farma S.A', 'Puntarenas', '12345098');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (13, 'Cariño S.A', 'Guanacaste', '23450987');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (14, 'FARMACIA POPULAR', 'Limón', '34509876');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (15, 'PopuFarma S.A', 'San José', '45609875');
-- Inserts para Producto_Farmacia READY
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (1, 'Paracetamol', 'Analgésico', TO_DATE('2025-12-31', 'YYYY-MM-DD'), 55.50, 1, 1, 0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (2, 'Ibuprofeno', 'Antiinflamatorio', TO_DATE('2024-06-30', 'YYYY-MM-DD'), 77.25, 2, 2, 0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (3, 'Amoxicilina', 'Antibiótico', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 120.00, 3,3, 0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (4, 'Loratadina', 'Antihistamínico', TO_DATE('2025-05-20', 'YYYY-MM-DD'), 45.75, 4, 4, 0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (5, 'Omeprazol', 'Inhibidor de la bomba de protones', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 85.50, 5, 5, 0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (6, 'Metformina', 'Antidiabético', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 65.00, 6, 6,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (7, 'Simvastatina', 'Hipolipemiante', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 95.25, 7,7,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (8, 'Aspirina', 'Analgésico', TO_DATE('2025-03-15', 'YYYY-MM-DD'), 50.00, 8,8,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (9, 'Clopidogrel', 'Antiplaquetario', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 110.75, 9,9,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (10, 'Atorvastatina', 'Hipolipemiante', TO_DATE('2025-07-07', 'YYYY-MM-DD'), 130.50, 10,10,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (11, 'Losartán', 'Antihipertensivo', TO_DATE('2024-08-25', 'YYYY-MM-DD'), 75.00, 11,11,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (12, 'Levotiroxina', 'Hormona tiroidea', TO_DATE('2025-02-28', 'YYYY-MM-DD'), 90.00, 12,12,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (13, 'Amlodipino', 'Antihipertensivo', TO_DATE('2024-11-11', 'YYYY-MM-DD'), 80.50, 13,13,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (14, 'Metoprolol', 'Betabloqueante', TO_DATE('2025-06-06', 'YYYY-MM-DD'), 105.00, 14,14,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (15, 'Enalapril', 'Antihipertensivo', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 70.25, 15,15,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (16, 'Furosemida', 'Diurético', TO_DATE('2025-04-04', 'YYYY-MM-DD'), 60.00, 1,1,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (17, 'Prednisona', 'Corticosteroide', TO_DATE('2024-12-12', 'YYYY-MM-DD'), 115.50, 2,2,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (18, 'Ciprofloxacino', 'Antibiótico', TO_DATE('2025-01-15', 'YYYY-MM-DD'), 125.00, 3,3,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (19, 'Dexametasona', 'Corticosteroide', TO_DATE('2024-09-09', 'YYYY-MM-DD'), 100.00, 4,4,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (20, 'Tramadol', 'Analgésico', TO_DATE('2025-05-05', 'YYYY-MM-DD'), 140.75, 5,5,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (21, 'Cetirizina', 'Antihistamínico', TO_DATE('2024-08-08', 'YYYY-MM-DD'), 55.00, 6,6,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (22, 'Ranitidina', 'Antihistamínico', TO_DATE('2025-03-03', 'YYYY-MM-DD'), 75.50, 7,7,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (23, 'Fluconazol', 'Antifúngico', TO_DATE('2024-11-11', 'YYYY-MM-DD'), 85.00, 8,8,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (24, 'Azitromicina', 'Antibiótico', TO_DATE('2025-02-02', 'YYYY-MM-DD'), 95.75, 9,9,0);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad) VALUES (25, 'Clorfenamina', 'Antihistamínico', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 65.50, 10,10,0);
-- Inserts para Sucursal_Farmacia READY
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (1, 'Sucursal Belén', 'Heredia', 'A', '11223344', TO_DATE('2020-01-15', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (2, 'Sucursal Lindora', 'San Jose', 'A', '22334455', TO_DATE('2021-02-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (3, 'Sucursal Merced', 'San Jose', 'A', '33445566', TO_DATE('2021-01-22', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (4, 'Sucursal Santa Ana', 'San Jose', 'A', '44556677', TO_DATE('2020-09-02', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (5, 'Sucursal Heredia', 'Heredia', 'A', '55667788', TO_DATE('2019-05-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (6, 'Sucursal Tarcoles', 'Puntarenas', 'A', '66778899', TO_DATE('2008-05-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (7, 'Sucursal Esparza', 'Puntarenas', 'A', '77889900', TO_DATE('2007-04-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (8, 'Sucursal Sarapiqui', 'Heredia', 'A', '88990011', TO_DATE('2004-03-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (9, 'Sucursal Cartago', 'Cartago', 'A', '99001122', TO_DATE('2009-05-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (10, 'Sucursal Santo Domingo', 'Heredia', 'A', '00112233', TO_DATE('2002-08-22', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (11, 'Sucursal San Rafael', 'Heredia', 'A', '11223355', TO_DATE('2022-03-19', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (12, 'Sucursal San Marcos', 'Heredia', 'A', '22334466', TO_DATE('2023-05-18', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (13, 'Sucursal San Luis', 'Heredia', 'A', '33445577', TO_DATE('2022-06-14', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (14, 'Sucursal Jaco', 'Puntarenas', 'A', '44556688', TO_DATE('2020-07-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (15, 'Sucursal Puerto Limon', 'Limon', 'A', '55667799', TO_DATE('2011-08-13', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (16, 'Sucursal Puerto Puntarenas', 'Puntarenas', 'A', '66778800', TO_DATE('2012-01-11', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (17, 'Sucursal Atenas', 'Alajuela', 'A', '77889911', TO_DATE('2013-02-12', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (18, 'Sucursal Alajuela', 'Alajuela', 'A', '88990022', TO_DATE('2014-06-13', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (19, 'Sucursal La Garita', 'Alajuela', 'A', '99001133', TO_DATE('2020-04-20', 'YYYY-MM-DD'));
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (20, 'Sucursal Norte', 'Limon', 'A', '00112244', TO_DATE('2022-09-20', 'YYYY-MM-DD'));



-- SP Obtener todas las SUCURSALES.
CREATE OR REPLACE PROCEDURE obtener_sucursales_farmacia (
    p_resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_resultado FOR
    SELECT ID, NOMBRE, PROVINCIA, ESTADO, TELEFONO, FECHAAPERTURA 
    FROM SUCURSAL_FARMACIA;
END obtener_sucursales_farmacia;
/

-- SP para buscar sucursales 
CREATE OR REPLACE PROCEDURE buscar_sucursales_farmacia (
    p_busqueda IN VARCHAR2,
    p_resultado OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_resultado FOR
    SELECT ID, NOMBRE, PROVINCIA, ESTADO, TELEFONO, FECHAAPERTURA 
    FROM SUCURSAL_FARMACIA
    WHERE UPPER(NOMBRE) LIKE '%' || UPPER(p_busqueda) || '%' 
       OR UPPER(PROVINCIA) LIKE '%' || UPPER(p_busqueda) || '%';
END buscar_sucursales_farmacia;
/