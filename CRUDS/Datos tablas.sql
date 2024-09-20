--Fabricante Farmacia
TRUNCATE TABLE Fabricante_Farmacia
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
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (13, 'Takeda', 'Japon');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (14, 'Amgen', 'Estados Unidos');
INSERT INTO Fabricante_Farmacia (ID, Nombre, Pais) VALUES (15, 'Teva', 'Israel');

--Proveedor Farmacia
TRUNCATE TABLE Proveedor_Farmacia
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (1, 'CONDEFA', 'San Jose', '12345678');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (2, 'COFASA', 'Alajuela', '87654321');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (3, 'FARMACORP', 'Cartago', '23456789');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (4, 'Medicinas Nacional', 'Heredia', '34567890');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (5, 'Salud Pura Vida', 'Puntarenas', '45678901');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (6, 'BIOFARMA', 'Guanacaste', '56789012');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (7, 'FarmaLuz', 'Limon', '67890123');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (8, 'PHARMA PLUS', 'San Jose', '78901234');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (9, 'MEDICORP', 'Alajuela', '89012345');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (10, 'Farma a tu casa', 'Cartago', '90123456');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (11, 'SALUD Y VIDA', 'Heredia', '01234567');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (12, 'Proveedor Farma S.A', 'Puntarenas', '12345098');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (13, 'Cario S.A', 'Guanacaste', '23450987');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (14, 'FARMACIA POPULAR', 'Limon', '34509876');
INSERT INTO Proveedor_Farmacia (ID, Nombre, Provincia, Telefono) VALUES (15, 'PopuFarma S.A', 'San Jose', '45609875');

--Sucursal Farmacia
TRUNCATE TABLE Sucursal_Farmacia
INSERT INTO Sucursal_Farmacia (ID, Nombre, Provincia, Estado, Telefono, FechaApertura) VALUES (1, 'Sucursal BelÃ©n', 'Heredia', 'A', '11223344', TO_DATE('2020-01-15', 'YYYY-MM-DD'));
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

--Empleados
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (1, '1234567890', 'Juan', 'PÃ©rez', 'M', 30, 1500.00, 'juan.perez@gmail.com', '88887777', '1', 1);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (2, '2345678901', 'Ana', 'GÃ³mez', 'F', 25, 1600.00, 'ana.gomez@gmail.com', '88886666', '1', 1);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (3, '3456789012', 'Luis', 'MartÃ­nez', 'M', 28, 1700.00, 'luis.martinez@gmail.com', '88885555', '1', 2);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (4, '4567890123', 'MarÃ­a', 'RodrÃ­guez', 'F', 32, 1800.00, 'maria.rodriguez@gmail.com', '88884444', '1', 2);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (5, '5678901234', 'Carlos', 'HernÃ¡ndez', 'M', 35, 1900.00, 'carlos.hernandez@gmail.com', '88883333', '1', 3);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (6, '6789012345', 'Laura', 'LÃ³pez', 'F', 27, 2000.00, 'laura.lopez@gmail.com', '88882222', '1', 3);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (7, '7890123456', 'Jorge', 'GonzÃ¡lez', 'M', 29, 2100.00, 'jorge.gonzalez@gmail.com', '88881111', '1', 4);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (8, '8901234567', 'SofÃ­a', 'DÃ­az', 'F', 31, 2200.00, 'sofia.diaz@gmail.com', '88880000', '1', 4);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (9, '9012345678', 'Pedro', 'RamÃ­rez', 'M', 33, 2300.00, 'pedro.ramirez@gmail.com', '88879999', '1', 5);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (10, '0123456789', 'LucÃ­a', 'Torres', 'F', 26, 2400.00, 'lucia.torres@gmail.com', '88878888', '1', 5);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (11, '1123456789', 'Miguel', 'Flores', 'M', 34, 2500.00, 'miguel.flores@gmail.com', '88877777', '1', 6);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (12, '2234567890', 'Elena', 'Morales', 'F', 28, 2600.00, 'elena.morales@gmail.com', '88876666', '1', 6);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (13, '3345678901', 'RaÃºl', 'Ortiz', 'M', 30, 2700.00, 'raul.ortiz@gmail.com', '88875555', '1', 7);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (14, '4456789012', 'Patricia', 'SÃ¡nchez', 'F', 32, 2800.00, 'patricia.sanchez@gmail.com', '88874444', '1', 7);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (15, '5567890123', 'AndrÃ©s', 'Castro', 'M', 35, 2900.00, 'andres.castro@gmail.com', '88873333', '1', 8);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (16, '6678901234', 'Gabriela', 'Vargas', 'F', 27, 3000.00, 'gabriela.vargas@gmail.com', '88872222', '1', 8);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (17, '7789012345', 'Fernando', 'Rojas', 'M', 29, 3100.00, 'fernando.rojas@gmail.com', '88871111', '1', 9);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (18, '8890123456', 'Isabel', 'Mendoza', 'F', 31, 3200.00, 'isabel.mendoza@gmail.com', '88870000', '1', 9);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (19, '9901234567', 'Ricardo', 'Guerrero', 'M', 33, 3300.00, 'ricardo.guerrero@gmail.com', '88869999', '1',1);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (20, '1012345678', 'MÃ³nica', 'Cruz', 'F', 26, 3400.00, 'monica.cruz@gmail.com', '88868888', '1', 10);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (21, '1123456000', 'HÃ©ctor', 'Reyes', 'M', 34, 3500.00, 'hector.reyes@gmail.com', '12347777', '1', 11);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (22, '1234569140', 'Paula', 'JimÃ©nez', 'F', 28, 3600.00, 'paula.jimenez@gmail.com', '82340666', '1', 11);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (23, '1345678901', 'TomÃ¡s', 'Ruiz', 'M', 30, 3700.00, 'tomas.ruiz@gmail.com', '88865555', '1', 12);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (24, '1456789012', 'VerÃ³nica', 'Navarro', 'F', 32, 3800.00, 'veronica.navarro@gmail.com', '88864444', '1', 12);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (25, '1567890123', 'Diego', 'Molina', 'M', 35, 3900.00, 'diego.molina@gmail.com', '88863333', '1', 13);
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, ESTADO, IDSUCURSAL) VALUES (26, '1567123523', 'Ernesto', 'Molina', 'M', 35, 3900.00, 'ernesto.molina@gmail.com', '88864729', '1', 17);

--Productos Farmacia

INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(1, 'Paracetamol', 'Analgésico', TO_DATE('2025-12-31', 'YYYY-MM-DD'), 1250, 1, 1, 100, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(2, 'Ibuprofeno', 'Antiinflamatorio', TO_DATE('2024-06-30', 'YYYY-MM-DD'), 2200, 2, 2, 340, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(3, 'Amoxicilina', 'Antibiótico', TO_DATE('2024-11-15', 'YYYY-MM-DD'), 4500, 3, 3, 650, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(4, 'Loratadina', 'Antihistamínico', TO_DATE('2025-05-20', 'YYYY-MM-DD'), 1500, 4, 4, 940, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(5, 'Omeprazol', 'Inhibidor de la bomba de protones', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 2500, 5, 5, 230, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(6, 'Metformina', 'Antidiabético', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1800, 6, 6, 130, 15);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(7, 'Simvastatina', 'Hipolipemiante', TO_DATE('2024-09-30', 'YYYY-MM-DD'), 3200, 7, 7, 110, 14);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(8, 'Aspirina', 'Analgésico', TO_DATE('2025-03-15', 'YYYY-MM-DD'), 1200, 8, 8, 100, 13);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(9, 'Clopidogrel', 'Antiplaquetario', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 6500, 9, 9, 320, 12);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(10, 'Atorvastatina', 'Hipolipemiante', TO_DATE('2025-07-07', 'YYYY-MM-DD'), 7200, 10, 10, 120, 3);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(11, 'Losartán', 'Antihipertensivo', TO_DATE('2024-08-25', 'YYYY-MM-DD'), 3100, 11, 11, 250, 2);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(12, 'Levotiroxina', 'Hormona tiroidea', TO_DATE('2025-02-28', 'YYYY-MM-DD'), 2800, 12, 12, 1230, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(13, 'Amlodipino', 'Antihipertensivo', TO_DATE('2024-11-11', 'YYYY-MM-DD'), 2400, 13, 13, 160, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(14, 'Metoprolol', 'Betabloqueante', TO_DATE('2025-06-06', 'YYYY-MM-DD'), 4300, 14, 14, 310, 11);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(15, 'Enalapril', 'Antihipertensivo', TO_DATE('2024-10-20', 'YYYY-MM-DD'), 2200, 15, 15, 301, 10);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(16, 'Furosemida', 'Diurético', TO_DATE('2025-04-04', 'YYYY-MM-DD'), 1500, 1, 1, 130, 9);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(17, 'Prednisona', 'Corticosteroide', TO_DATE('2024-12-12', 'YYYY-MM-DD'), 4700, 2, 2, 450, 8);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(18, 'Ciprofloxacino', 'Antibiótico', TO_DATE('2025-01-15', 'YYYY-MM-DD'), 5200, 3, 3, 160, 7);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(19, 'Dexametasona', 'Corticosteroide', TO_DATE('2024-09-09', 'YYYY-MM-DD'), 3900, 4, 4, 130, 6);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(20, 'Tramadol', 'Analgésico', TO_DATE('2025-05-05', 'YYYY-MM-DD'), 5900, 5, 5, 620, 5);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(21, 'Cetirizina', 'Antihistamínico', TO_DATE('2024-08-08', 'YYYY-MM-DD'), 1200, 6, 6, 430, 4);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(22, 'Ranitidina', 'Antihistamínico', TO_DATE('2025-03-03', 'YYYY-MM-DD'), 2500, 7, 7, 340, 3);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(23, 'Fluconazol', 'Antifúngico', TO_DATE('2024-11-11', 'YYYY-MM-DD'), 2700, 8, 8, 660, 2);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(24, 'Azitromicina', 'Antibiótico', TO_DATE('2025-02-02', 'YYYY-MM-DD'), 3100, 9, 9, 900, 2);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(25, 'Clorfenamina', 'Antihistamínico', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 1900, 10, 10, 630, 1);
INSERT INTO Producto_Farmacia (ID, Nombre, Descripcion, FechaVencimiento, Costo, IDFabricante, IDProveedor, Cantidad, IDSUCURSAL) VALUES 
(26, 'Metanfetainao', 'Antihistamínico', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 800, 10, 10, 410, 1);


-- Inserciones en EMPLEADO_FARMACIA
INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, IDSUCURSAL)
VALUES (1, '1234567890', 'Jefferson', 'Salas', 'H', 21, 10000, 'salasCordero@gmail.com', '62191191', 1);

INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, IDSUCURSAL)
VALUES (2, '1234567891', 'Nash', 'Araya', 'F', 20, 48000, 'Nash.Araya@gmail.com', '87654321', 2);

INSERT INTO EMPLEADO_FARMACIA (ID, CEDULA, NOMBRE, APELLIDO, SEXO, EDAD, SALARIO, EMAIL, NUMEROTELEFONO, IDSUCURSAL)
VALUES (3, '1122334455', 'Jose', 'Gonzalez', 'H', 20, 55000, 'Jose.Gonzalez@gmail.com', '11223344', 5);


-- Inserciones en Credencial_Empleado
INSERT INTO Credencial_Empleado (IDEmpleado, Usuario, Contrasena)
VALUES (1, 'Jeshon04', 'password1');

INSERT INTO Credencial_Empleado (IDEmpleado, Usuario, Contrasena)
VALUES (2, 'Nash123', 'password_2');

INSERT INTO Credencial_Empleado (IDEmpleado, Usuario, Contrasena)
VALUES (3, 'Jose456', 'password_3');
