
--CRUD DE SUCURSALES

--CREAR SUCURSAL
CREATE OR REPLACE PROCEDURE crear_sucursal(
    p_nombre IN VARCHAR2,
    p_provincia IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_fechaapertura IN DATE
) AS
    v_id NUMBER;
BEGIN
    -- Encontrar el máximo ID actual e incrementar en 1
    SELECT NVL(MAX(ID), 0) + 1 INTO v_id FROM SUCURSAL_FARMACIA;

    -- Insertar la nueva sucursal con el ID generado
    INSERT INTO SUCURSAL_FARMACIA (ID, NOMBRE, PROVINCIA, TELEFONO, FECHAAPERTURA)
    VALUES (v_id, p_nombre, p_provincia, p_telefono, p_fechaapertura);

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END crear_sucursal;


--ACTUALIZAR SUCURSAL
CREATE OR REPLACE PROCEDURE actualizar_sucursal(
    p_id IN NUMBER,
    p_nombre IN VARCHAR2,
    p_provincia IN VARCHAR2,
    p_telefono IN VARCHAR2
) AS
BEGIN
    UPDATE SUCURSAL_FARMACIA
    SET NOMBRE = p_nombre,
        PROVINCIA = p_provincia,
        TELEFONO = p_telefono
    WHERE ID = p_id;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END actualizar_sucursal;


--ELIMINAR SUCURSAL
CREATE OR REPLACE PROCEDURE eliminar_sucursal_logico(
    InIdSucursal IN NUMBER
) AS
BEGIN
    UPDATE SUCURSAL_FARMACIA
    SET ESTADO = '0' -- Marca como no activo
    WHERE ID = InIdSucursal;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END eliminar_sucursal_logico;




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


-- SP PARA OBTENER EL ID Y NOMBRE DE LOS PROVEEDORES
CREATE OR REPLACE PROCEDURE sp_obtener_ids_nombres_proveedores(
    cur_proveedores OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN cur_proveedores FOR
    SELECT 
        ID, 
        NOMBRE 
    FROM 
        PROVEEDOR_FARMACIA;
END sp_obtener_ids_nombres_proveedores;
/

-- SP PARA OBTENER EL ID Y NOMBRE DE LOS FABRICANTES 
CREATE OR REPLACE PROCEDURE sp_obtener_ids_nombres_fabricantes(
    cur_fabricantes OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN cur_fabricantes FOR
    SELECT 
        ID, 
        NOMBRE 
    FROM 
        FABRICANTE_FARMACIA;
END sp_obtener_ids_nombres_fabricantes;
/

CREATE OR REPLACE PROCEDURE sp_obtener_sucursales_activas (
    p_cursor OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN p_cursor FOR
    SELECT ID, NOMBRE
    FROM SUCURSAL_FARMACIA
    WHERE ESTADO = 'A';  -- Asegúrate de que el estado sea 'A' para sucursales activas.
END sp_obtener_sucursales_activas;
/




select * from credencial_empleado;
select *  from empleado_farmacia;
select * from sucursal_farmacia;
SELECT * FROM PRODUCTO_FARMACIA;