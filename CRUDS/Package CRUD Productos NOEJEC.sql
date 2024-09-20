-- Especificación del Paquete
CREATE OR REPLACE PACKAGE PCK_CRUD_PRODUCTOS AS 
    -- Declaraciones públicas
    PROCEDURE C_PRODUCTO (
        ID NUMBER, 
        Nombre VARCHAR2, 
        Descrip VARCHAR2, 
        FechaVen DATE,
        Costo NUMBER, 
        IdFabricante NUMBER,
        IdProveedor NUMBER, 
        Cantidad NUMBER,
        IdSucursal NUMBER
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
        p_CantidadNueva NUMBER,
        p_IdSucursal NUMBER
    );

    PROCEDURE D_PRODUCTO (
        p_id NUMBER
    );

    PROCEDURE sp_obtener_productos ( 
        cur_productos OUT SYS_REFCURSOR 
    );

    PROCEDURE sp_buscar_productos (
        p_query IN VARCHAR2, 
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE sp_obtener_ids_nombres_productos (
        cur_ids OUT SYS_REFCURSOR 
    );

    PROCEDURE sp_obtener_producto_por_nombre (
        p_nombre IN VARCHAR2,
        p_cursor OUT SYS_REFCURSOR
    );

    PROCEDURE sp_obtener_toda_info_productos (
        cur_productos OUT SYS_REFCURSOR
    );

    PROCEDURE sp_buscar_productos_por_nombreE(
        p_query IN VARCHAR2,  
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

-- Cuerpo del Paquete
CREATE OR REPLACE PACKAGE BODY PCK_CRUD_PRODUCTOS AS

    -- Función para encontrar el ID del proveedor
    FUNCTION encontrar_id_proveedor(
        NombreProveedor VARCHAR2
    ) RETURN NUMBER
    IS
        v_id_proveedor NUMBER;
    BEGIN
        SELECT P.ID
        INTO v_id_proveedor
        FROM Proveedor_Farmacia P
        WHERE P.Nombre = NombreProveedor;

        RETURN v_id_proveedor;

    EXCEPTION WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.put_line('No existe un proveedor con el nombre: ' || NombreProveedor);
        RETURN NULL;
    END encontrar_id_proveedor;

    -- Función para encontrar el ID del fabricante
    FUNCTION encontrar_id_fabricante(
        NombreFabricante VARCHAR2
    ) RETURN NUMBER
    IS
        v_id_fabricante NUMBER;
    BEGIN
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
        Cantidad NUMBER,
        IdSucursal NUMBER
    )
    IS
        output_id_proveedor NUMBER;
        output_id_fabricante NUMBER;
        output_id_sucursal NUMBER;
    BEGIN
        -- Validación de IDs para asegurarse de que existen
        SELECT COUNT(*) INTO output_id_proveedor FROM Proveedor_Farmacia WHERE ID = IdProveedor;
        SELECT COUNT(*) INTO output_id_fabricante FROM Fabricante_Farmacia WHERE ID = IdFabricante;
        SELECT COUNT(*) INTO output_id_sucursal FROM Sucursal_Farmacia WHERE ID = IdSucursal;

        -- Verificación de existencia de IDs
        IF output_id_proveedor = 0 THEN
            DBMS_OUTPUT.put_line('El proveedor ingresado no existe');
        ELSIF output_id_fabricante = 0 THEN
            DBMS_OUTPUT.put_line('El fabricante ingresado no existe');
        ELSIF output_id_sucursal = 0 THEN
            DBMS_OUTPUT.put_line('La sucursal ingresada no existe');
        ELSE
            -- Conversión de la fecha al formato esperado antes de insertar
            INSERT INTO PRODUCTO_FARMACIA (
                ID, NOMBRE, DESCRIPCION, FECHAVENCIMIENTO,
                COSTO, IDFABRICANTE, IDPROVEEDOR, CANTIDAD, IDSUCURSAL
            ) VALUES (
                ID, 
                Nombre, 
                Descrip, 
                TO_DATE(TO_CHAR(FechaVen, 'YYYY-MM-DD'), 'YYYY-MM-DD'), 
                Costo, 
                IdFabricante, 
                IdProveedor, 
                Cantidad,
                IdSucursal
            );  
            DBMS_OUTPUT.put_line('Producto agregado correctamente.');
        END IF;   
    END C_PRODUCTO;

    -- Procedimiento para obtener todos los productos
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
        ORDER BY ID;
    END sp_obtener_productos;

    -- Procedimiento para consultar productos
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
            P.CANTIDAD,
            P.IDSUCURSAL
        FROM Producto_Farmacia P
        WHERE (ID IS NULL OR P.ID = ID)
          AND (Nombre IS NULL OR P.Nombre LIKE '%' || Nombre || '%');
    END R_PRODUCTO;

    -- Procedimiento para actualizar productos
    PROCEDURE U_PRODUCTO (
        p_ID NUMBER, 
        p_NombreNuevo VARCHAR2, 
        p_DescripNuevo VARCHAR2, 
        p_FechaVenNuevo DATE,
        p_CostoNuevo NUMBER, 
        p_IdFabricante NUMBER, 
        p_IdProveedor NUMBER, 
        p_CantidadNueva NUMBER,
        p_IdSucursal NUMBER
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
            CANTIDAD = NVL(p_CantidadNueva, CANTIDAD),
            IDSUCURSAL = NVL(p_IdSucursal, IDSUCURSAL)
        WHERE ID = p_ID;

        DBMS_OUTPUT.put_line('Producto actualizado correctamente.');
    END U_PRODUCTO;

    -- Procedimiento para eliminar productos
    PROCEDURE D_PRODUCTO (
        p_id NUMBER
    )
    IS
    BEGIN
        DELETE FROM PRODUCTO_FARMACIA
        WHERE ID = p_id;

        IF SQL%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.put_line('Producto eliminado correctamente.');
        ELSE
            DBMS_OUTPUT.put_line('No se encontró ningún producto con el ID especificado.');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('Error al intentar eliminar el producto: ' || SQLERRM);
    END D_PRODUCTO;

    -- Procedimiento para buscar productos por nombre
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

    -- Procedimiento para obtener todos los IDs y nombres de productos
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

    -- Procedimiento para obtener producto por nombre exacto
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

    -- Procedimiento para obtener toda la información de productos
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
            CANTIDAD,
            IDSUCURSAL
        FROM PRODUCTO_FARMACIA
        ORDER BY ID;
    END sp_obtener_toda_info_productos;

    -- Procedimiento para buscar productos por nombre extendido
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
            CANTIDAD,
            IDSUCURSAL
        FROM PRODUCTO_FARMACIA
        WHERE LOWER(NOMBRE) LIKE '%' || LOWER(p_query) || '%';
    END sp_buscar_productos_por_nombreE;

END PCK_CRUD_PRODUCTOS;
/


CREATE OR REPLACE PROCEDURE sp_producto_existe(
    p_id IN NUMBER,
    p_count OUT NUMBER
) AS
BEGIN
    SELECT COUNT(*) INTO p_count FROM PRODUCTO_FARMACIA WHERE ID = p_id;
END;

CREATE OR REPLACE PROCEDURE sp_proveedor_existe(
    p_id IN NUMBER,
    p_count OUT NUMBER
) AS
BEGIN
    SELECT COUNT(*) INTO p_count FROM PROVEEDOR_FARMACIA WHERE ID = p_id;
END;

CREATE OR REPLACE PROCEDURE sp_fabricante_existe(
    p_id IN NUMBER,
    p_count OUT NUMBER
) AS
BEGIN
    SELECT COUNT(*) INTO p_count FROM FABRICANTE_FARMACIA WHERE ID = p_id;
END;

CREATE OR REPLACE PROCEDURE sp_sucursal_existe(
    p_id IN NUMBER,
    p_count OUT NUMBER
) AS
BEGIN
    SELECT COUNT(*) INTO p_count FROM SUCURSAL_FARMACIA WHERE ID = p_id;
END;

create or replace PROCEDURE SP_ProductosGraficacion (
    cur_out OUT SYS_REFCURSOR  -- Cursor de referencia para devolver el conjunto de resultados
)
AS
BEGIN
    -- Abrir el cursor con la consulta SQL especificada
    OPEN cur_out FOR
        SELECT 
            S.NOMBRE AS NombreSucursal,  -- Nombre de la sucursal
            F.NOMBRE AS ProductoNombre,  -- Nombre del producto
            F.CANTIDAD AS CantidadDisponible  -- Cantidad disponible del producto
        FROM 
            SUCURSAL_FARMACIA S
        INNER JOIN 
            PRODUCTO_FARMACIA F ON S.ID = F.IDSucursal;  -- Unir sucursales y productos
END SP_ProductosGraficacion;

create or replace PROCEDURE SP_ProductoSucursal (
    InIDSucursal IN INT,
    cur_out OUT SYS_REFCURSOR
)
AS
BEGIN
    IF InIDSucursal = -1 THEN
        -- Recuperar todos los productos si el ID de sucursal es -1
        OPEN cur_out FOR
            SELECT 
                S.ID AS SucursalID,
                S.NOMBRE AS NombreSucursal,
                S.PROVINCIA AS ProvinciaSucursal,
                S.TELEFONO AS TelefonoSucursal,
                F.ID AS ProductoID,
                F.NOMBRE AS ProductoNombre,
                F.DESCRIPCION AS ProductoDescripcion,
                F.COSTO AS ProductoCosto,
                FF.NOMBRE AS FabricanteNombre,
                F.CANTIDAD AS CantidadDisponible
            FROM 
                SUCURSAL_FARMACIA S
            INNER JOIN 
                PRODUCTO_FARMACIA F ON S.ID = F.IDSucursal
            LEFT JOIN 
                FABRICANTE_FARMACIA FF ON FF.ID = F.IDFABRICANTE;
    ELSE
        -- Recuperar productos solo de la sucursal especificada
        OPEN cur_out FOR
            SELECT 
                S.ID AS SucursalID,
                S.NOMBRE AS NombreSucursal,
                S.PROVINCIA AS ProvinciaSucursal,
                S.TELEFONO AS TelefonoSucursal,
                F.ID AS ProductoID,
                F.NOMBRE AS ProductoNombre,
                F.DESCRIPCION AS ProductoDescripcion,
                F.COSTO AS ProductoCosto,
                FF.NOMBRE AS FabricanteNombre,
                F.CANTIDAD AS CantidadDisponible
            FROM 
                SUCURSAL_FARMACIA S
            INNER JOIN 
                PRODUCTO_FARMACIA F ON S.ID = F.IDSucursal
            LEFT JOIN 
                FABRICANTE_FARMACIA FF ON FF.ID = F.IDFABRICANTE
            WHERE 
                S.ID = InIDSucursal;
    END IF;
END SP_ProductoSucursal;

