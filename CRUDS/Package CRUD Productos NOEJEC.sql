CREATE OR REPLACE PACKAGE PCK_CRUD_PRODUCTOS AS -- Specification
    -- Declaraciones públicas
    PROCEDURE C_PRODUCTO (
        ID NUMBER, 
        Nombre VARCHAR2, 
        Descrip VARCHAR2, 
        FechaVen DATE,
        Costo NUMBER, 
        IdFabricante NUMBER,
        IdProveedor NUMBER, 
        Cantidad NUMBER
    );
    
    PROCEDURE R_PRODUCTO (
        p_cursor OUT SYS_REFCURSOR, 
        ID NUMBER, 
        Nombre VARCHAR2
    );
    
     PROCEDURE U_PRODUCTO (
        p_ID NUMBER, 
        p_NombreNuevo VARCHAR2, 
        p_DescripNuevo VARCHAR2, 
        p_FechaVenNuevo DATE,
        p_CostoNuevo NUMBER, 
        p_IdFabricante NUMBER, 
        p_IdProveedor NUMBER, 
        p_CantidadNueva NUMBER
    );

    
    PROCEDURE D_PRODUCTO (
        ID NUMBER
    );
    
    PROCEDURE sp_obtener_productos ( 
        cur_productos OUT SYS_REFCURSOR 
    );
    
      PROCEDURE sp_buscar_productos (
        p_query IN VARCHAR2, 
        p_cursor OUT SYS_REFCURSOR
    ); -- A

    
    PROCEDURE sp_obtener_ids_nombres_productos (
        cur_ids OUT SYS_REFCURSOR 
    ); -- Procedimiento para obtener todos los IDs de productos
    
    PROCEDURE sp_obtener_producto_por_nombre (
    p_nombre IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE sp_obtener_toda_info_productos (
        cur_productos OUT SYS_REFCURSOR
    );
    
    PROCEDURE sp_buscar_productos_por_nombreE(
         p_query IN VARCHAR2,  -- Añadir el parámetro de búsqueda
        cur_productos OUT SYS_REFCURSOR
    );
    FUNCTION encontrar_id_proveedor (
        NombreProveedor VARCHAR2
    ) RETURN NUMBER;
    
    FUNCTION encontrar_id_fabricante (
        NombreFabricante VARCHAR2
    ) RETURN NUMBER;
    
    
END PCK_CRUD_PRODUCTOS;
/

CREATE OR REPLACE PACKAGE BODY PCK_CRUD_PRODUCTOS AS

    -- Funciones privadas (ya existentes)
    FUNCTION encontrar_id_proveedor(
        NombreProveedor VARCHAR2
    ) RETURN NUMBER
    IS
        v_id_proveedor NUMBER;
    BEGIN
        -- Buscar ID del proveedor
        SELECT P.ID
        INTO v_id_proveedor
        FROM Proveedor_Farmacia P
        WHERE P.Nombre = NombreProveedor;
        
        RETURN v_id_proveedor;
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No existe un proveedor con el nombre: ' || NombreProveedor);
            RETURN NULL;
    END encontrar_id_proveedor;

    FUNCTION encontrar_id_fabricante(
        NombreFabricante VARCHAR2
    ) RETURN NUMBER
    IS
        v_id_fabricante NUMBER;
    BEGIN
        -- Buscar ID del fabricante
        SELECT F.ID
        INTO v_id_fabricante
        FROM Fabricante_Farmacia F
        WHERE F.Nombre = NombreFabricante;
        
        RETURN v_id_fabricante;
        
        EXCEPTION WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('No existe un fabricante con el nombre: ' || NombreFabricante);
            RETURN NULL;
    END encontrar_id_fabricante;

    -- Procedimiento para agregar productos
    PROCEDURE C_PRODUCTO (
        ID NUMBER, 
        Nombre VARCHAR2, 
        Descrip VARCHAR2, 
        FechaVen DATE,
        Costo NUMBER, 
        IdFabricante NUMBER,
        IdProveedor NUMBER, 
        Cantidad NUMBER
    )
    IS
        output_id_proveedor NUMBER;
        output_id_fabricante NUMBER;
    BEGIN
        -- Validación de IDs para asegurarse de que existen
        SELECT COUNT(*) INTO output_id_proveedor FROM Proveedor_Farmacia WHERE ID = IdProveedor;
        SELECT COUNT(*) INTO output_id_fabricante FROM Fabricante_Farmacia WHERE ID = IdFabricante;
    
        -- Verificación de existencia de IDs
        IF output_id_proveedor = 0 THEN
            DBMS_OUTPUT.put_line('El proveedor ingresado no existe');
        ELSIF output_id_fabricante = 0 THEN
            DBMS_OUTPUT.put_line('El fabricante ingresado no existe');
        ELSE
            -- Conversión de la fecha al formato esperado antes de insertar
            INSERT INTO PRODUCTO_FARMACIA (
                ID, NOMBRE, DESCRIPCION, FECHAVENCIMIENTO,
                COSTO, IDFABRICANTE, IDPROVEEDOR, CANTIDAD
            ) VALUES (
                ID, 
                Nombre, 
                Descrip, 
                TO_DATE(TO_CHAR(FechaVen, 'YYYY-MM-DD'), 'YYYY-MM-DD'), -- Conversión de fecha
                Costo, 
                IdFabricante, 
                IdProveedor, 
                Cantidad
            );  
            DBMS_OUTPUT.put_line('Producto agregado correctamente.');
        END IF;   
    END C_PRODUCTO;


    -- Procedimiento para obtener todos los productos (ya existente)
    PROCEDURE sp_obtener_productos ( 
        cur_productos OUT SYS_REFCURSOR 
    ) 
    AS 
    BEGIN 
        OPEN cur_productos FOR
        SELECT 
            ID, 
            NOMBRE, 
            DESCRIPCION, 
            FECHAVENCIMIENTO, 
            COSTO, 
            CANTIDAD 
        FROM 
            PRODUCTO_FARMACIA
        ORDER BY ID; -- Ordenar por ID
    END sp_obtener_productos;


    -- Procedimiento para consultar productos (ya existente)
    PROCEDURE R_PRODUCTO (
        p_cursor OUT SYS_REFCURSOR,
        ID NUMBER,
        Nombre VARCHAR2
    )
    IS
    BEGIN
        OPEN p_cursor FOR
        SELECT
            P.ID,
            P.NOMBRE,
            P.DESCRIPCION,
            P.FECHAVENCIMIENTO,
            P.COSTO,
            P.IDFABRICANTE,
            P.IDPROVEEDOR,
            P.CANTIDAD
        FROM Producto_Farmacia P
        WHERE (ID IS NULL OR P.ID = ID)
          AND (Nombre IS NULL OR P.Nombre LIKE '%' || Nombre || '%');
    END R_PRODUCTO;
    
    
    PROCEDURE U_PRODUCTO (
        p_ID NUMBER, 
        p_NombreNuevo VARCHAR2, 
        p_DescripNuevo VARCHAR2, 
        p_FechaVenNuevo DATE,
        p_CostoNuevo NUMBER, 
        p_IdFabricante NUMBER, 
        p_IdProveedor NUMBER, 
        p_CantidadNueva NUMBER
    )
    IS
    BEGIN
        UPDATE PRODUCTO_FARMACIA
        SET 
            NOMBRE = NVL(p_NombreNuevo, NOMBRE),
            DESCRIPCION = NVL(p_DescripNuevo, DESCRIPCION),
            FECHAVENCIMIENTO = NVL(p_FechaVenNuevo, FECHAVENCIMIENTO),
            COSTO = NVL(p_CostoNuevo, COSTO),
            IDFABRICANTE = NVL(p_IdFabricante, IDFABRICANTE),
            IDPROVEEDOR = NVL(p_IdProveedor, IDPROVEEDOR),
            CANTIDAD = NVL(p_CantidadNueva, CANTIDAD)
        WHERE ID = p_ID;

        DBMS_OUTPUT.put_line('Producto actualizado correctamente.');
    END U_PRODUCTO;
    
    -- Modificación del procedimiento de eliminación
    PROCEDURE D_PRODUCTO (
        p_id NUMBER  -- Cambiar el nombre del parámetro a p_id para evitar conflictos
    )
    IS
    BEGIN
        -- Eliminar el producto de la tabla PRODUCTO_FARMACIA según el ID proporcionado
        DELETE FROM PRODUCTO_FARMACIA
        WHERE ID = p_id;  -- Usar el parámetro p_id para la comparación
        
        -- Verificar cuántas filas fueron afectadas por la eliminación
        IF SQL%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.put_line('Producto eliminado correctamente.');
        ELSE
            DBMS_OUTPUT.put_line('No se encontró ningún producto con el ID especificado.');
        END IF;
    
    EXCEPTION
        -- Manejo de excepciones para capturar cualquier error durante la eliminación
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('Error al intentar eliminar el producto: ' || SQLERRM);
    END D_PRODUCTO;




    -- Procedimiento para buscar productos (ya existente)
    PROCEDURE sp_buscar_productos(
        p_query IN VARCHAR2,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT ID, NOMBRE, DESCRIPCION, FECHAVENCIMIENTO, COSTO, CANTIDAD
        FROM PRODUCTO_FARMACIA
        WHERE LOWER(NOMBRE) LIKE '%' || LOWER(p_query) || '%';
    END sp_buscar_productos;

    -- Definición del procedimiento faltante
    PROCEDURE sp_obtener_ids_nombres_productos(
        cur_ids OUT SYS_REFCURSOR 
    ) 
    AS 
    BEGIN 
        OPEN cur_ids FOR
        SELECT 
            ID, 
            NOMBRE 
        FROM 
            PRODUCTO_FARMACIA;
    END sp_obtener_ids_nombres_productos;
    
    PROCEDURE sp_obtener_producto_por_nombre (
        p_nombre IN VARCHAR2,
        p_cursor OUT SYS_REFCURSOR
    ) AS
    BEGIN
        OPEN p_cursor FOR
        SELECT 
            ID, 
            NOMBRE, 
            DESCRIPCION, 
            FECHAVENCIMIENTO, 
            COSTO, 
            IDFABRICANTE, 
            IDPROVEEDOR, 
            CANTIDAD
        FROM PRODUCTO_FARMACIA
        WHERE LOWER(NOMBRE) = LOWER(p_nombre);
    END sp_obtener_producto_por_nombre;


     -- Nuevo procedimiento para obtener toda la información de productos
    PROCEDURE sp_obtener_toda_info_productos (
    cur_productos OUT SYS_REFCURSOR
    ) 
    AS
    BEGIN
        OPEN cur_productos FOR
        SELECT 
            ID, 
            NOMBRE, 
            DESCRIPCION, 
            FECHAVENCIMIENTO, 
            COSTO, 
            IDFABRICANTE, 
            IDPROVEEDOR, 
            CANTIDAD
        FROM PRODUCTO_FARMACIA
        ORDER BY ID;
    END sp_obtener_toda_info_productos;

        
        PROCEDURE sp_buscar_productos_por_nombreE (
        p_query IN VARCHAR2,
        cur_productos OUT SYS_REFCURSOR
    )
    AS
    BEGIN
        OPEN cur_productos FOR
        SELECT 
            ID, 
            NOMBRE, 
            DESCRIPCION, 
            FECHAVENCIMIENTO, 
            COSTO, 
            IDFABRICANTE, 
            IDPROVEEDOR, 
            CANTIDAD
        FROM PRODUCTO_FARMACIA
        WHERE LOWER(NOMBRE) LIKE '%' || LOWER(p_query) || '%';
    END sp_buscar_productos_por_nombreE;



END PCK_CRUD_PRODUCTOS;
/
-- Agrega '/' al final del paquete para indicar el fin de la ejecución
