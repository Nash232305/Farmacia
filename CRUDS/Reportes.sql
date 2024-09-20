CREATE OR REPLACE PROCEDURE SP_ObtenerProductos (
    cur_out OUT SYS_REFCURSOR  -- Cursor de referencia para devolver el conjunto de resultados
)
AS
BEGIN
    -- Abrir el cursor con la consulta SQL especificada
    OPEN cur_out FOR
        SELECT 
            P.ID AS ProductoID,                        -- Identificador único del producto
            P.NOMBRE AS ProductoNombre,                -- Nombre del producto
            P.DESCRIPCION AS ProductoDescripcion,      -- Descripción detallada del producto
            P.FECHAVENCIMIENTO AS ProductoFechaVencimiento, -- Fecha de vencimiento del producto
            P.COSTO AS ProductoCosto,                  -- Costo del producto
            F.NOMBRE AS FabricanteNombre,              -- Nombre del fabricante del producto
            PR.NOMBRE AS ProveedorNombre,              -- Nombre del proveedor del producto
            P.CANTIDAD AS CantidadDisponible           -- Cantidad disponible del producto en inventario
        FROM 
            PRODUCTO_FARMACIA P                        -- Tabla de productos farmacéuticos
            INNER JOIN FABRICANTE_FARMACIA F ON P.IDFABRICANTE = F.ID  -- Unión con la tabla de fabricantes
            INNER JOIN PROVEEDOR_FARMACIA PR ON P.IDPROVEEDOR = PR.ID  -- Unión con la tabla de proveedores
        ORDER BY 
            P.DESCRIPCION ASC;                         -- Ordenar los resultados por la descripción del producto en orden ascendente
END SP_ObtenerProductos;

-- Procedimiento Almacenado: SP_ProductosXSucursal
CREATE OR REPLACE PROCEDURE SP_ProductosXSucursal (
    cur_out OUT SYS_REFCURSOR  -- Cursor de referencia para devolver el conjunto de resultados
)
AS
BEGIN
    -- Abrir el cursor con la consulta SQL especificada
    OPEN cur_out FOR
        SELECT 
            S.NOMBRE AS NombreSucursal,               -- Nombre de la sucursal
            S.PROVINCIA AS ProvinciaSucursal,         -- Provincia de la sucursal
            S.TELEFONO AS TelefonoSucursal,           -- Teléfono de la sucursal
            F.ID AS ProductoID,                       -- ID del producto
            F.NOMBRE AS ProductoNombre,               -- Nombre del producto
            F.DESCRIPCION AS ProductoDescripcion,     -- Descripción del producto
            F.COSTO AS ProductoCosto,                 -- Costo del producto
            FF.NOMBRE AS FabricanteNombre,            -- Nombre del fabricante
            F.CANTIDAD AS CantidadDisponible          -- Cantidad disponible del producto
        FROM 
            SUCURSAL_FARMACIA S
            INNER JOIN PRODUCTO_FARMACIA F ON S.ID = F.ID_Sucursal  -- Unir sucursales y productos
            LEFT JOIN FABRICANTE_FARMACIA FF ON FF.ID = F.IDFABRICANTE;  -- Unir productos con fabricantes
            
END SP_ProductosXSucursal;


CREATE OR REPLACE PROCEDURE SP_ProductoSucursal (
    InIDSucursal IN INT,                     -- Parámetro de entrada: Identificador de la sucursal para filtrar los productos.
    cur_out OUT SYS_REFCURSOR                -- Parámetro de salida: Cursor de referencia que contiene los resultados de la consulta.
)
AS
BEGIN
    -- Abrir el cursor con la consulta SQL especificada
    OPEN cur_out FOR
        SELECT 
            S.NOMBRE AS NombreSucursal,           -- Nombre de la sucursal.
            S.PROVINCIA AS ProvinciaSucursal,     -- Provincia en la que se encuentra la sucursal.
            S.TELEFONO AS TelefonoSucursal,       -- Número de teléfono de la sucursal.
            F.ID AS ProductoID,                   -- Identificador del producto.
            F.NOMBRE AS ProductoNombre,           -- Nombre del producto.
            F.DESCRIPCION AS ProductoDescripcion, -- Descripción del producto.
            F.COSTO AS ProductoCosto,             -- Costo del producto.
            FF.NOMBRE AS FabricanteNombre,        -- Nombre del fabricante del producto.
            F.CANTIDAD AS CantidadDisponible      -- Cantidad disponible del producto en la sucursal.
        FROM 
            SUCURSAL_FARMACIA S
            INNER JOIN PRODUCTO_FARMACIA F ON S.ID = F.ID_Sucursal  -- Unir la tabla de sucursales con la de productos usando el identificador de sucursal.
            LEFT JOIN FABRICANTE_FARMACIA FF ON FF.ID = F.IDFABRICANTE  -- Unir la tabla de productos con la de fabricantes usando el identificador de fabricante.
        WHERE
            S.ID = InIDSucursal;  -- Filtrar los resultados para la sucursal con el identificador proporcionado.
END SP_ProductoSucursal;



--Como probarlo en SP_ObtenerProductos
DECLARE
    cur SYS_REFCURSOR;
    v_ProductoID NUMBER;
    v_ProductoNombre VARCHAR2(50);
    v_ProductoDescripcion VARCHAR2(50);
    v_ProductoFechaVencimiento DATE;
    v_ProductoCosto NUMBER(10, 2);
    v_FabricanteNombre VARCHAR2(50);
    v_ProveedorNombre VARCHAR2(50);
    v_CantidadDisponible NUMBER;
BEGIN
    -- Llamar al procedimiento almacenado
    SP_ObtenerProductos(cur);
    
    -- Procesar los resultados del cursor
    LOOP
        FETCH cur INTO v_ProductoID, v_ProductoNombre, v_ProductoDescripcion, v_ProductoFechaVencimiento,
                      v_ProductoCosto, v_FabricanteNombre, v_ProveedorNombre, v_CantidadDisponible;
        EXIT WHEN cur%NOTFOUND;
        
        -- Mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Producto ID: ' || v_ProductoID || ', Nombre: ' || v_ProductoNombre || 
                             ', Fabricante: ' || v_FabricanteNombre || ', Proveedor: ' || v_ProveedorNombre ||
                             ', Costo: ' || v_ProductoCosto || ', Cantidad: ' || v_CantidadDisponible);
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cur;
END;
/

--Como probarlo en SP_ProductosXSucursal
DECLARE
    cur SYS_REFCURSOR;  -- Cursor para recibir el conjunto de resultados del procedimiento
    v_NombreSucursal VARCHAR2(50);          
    v_ProvinciaSucursal VARCHAR2(50);        
    v_TelefonoSucursal VARCHAR2(20);         
    v_ProductoID NUMBER;                    
    v_ProductoNombre VARCHAR2(50);          
    v_ProductoDescripcion VARCHAR2(50);    
    v_ProductoCosto NUMBER(10, 2);          
    v_FabricanteNombre VARCHAR2(50);       
    v_CantidadDisponible NUMBER;           
BEGIN
    -- Llamar al procedimiento almacenado
    SP_ProductosXSucursal(cur);
    
    -- Procesar los resultados del cursor
    LOOP
        FETCH cur INTO v_NombreSucursal, v_ProvinciaSucursal, v_TelefonoSucursal, 
                      v_ProductoID, v_ProductoNombre, v_ProductoDescripcion, v_ProductoCosto, 
                      v_FabricanteNombre, v_CantidadDisponible;
        EXIT WHEN cur%NOTFOUND;  -- Salir del bucle si no hay más datos en el cursor
        
        -- Mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_NombreSucursal || ', Provincia: ' || v_ProvinciaSucursal || 
                             ', Teléfono: ' || v_TelefonoSucursal || ', Producto ID: ' || v_ProductoID || 
                             ', Nombre: ' || v_ProductoNombre || ', Descripción: ' || v_ProductoDescripcion || 
                             ', Costo: ' || v_ProductoCosto || ', Fabricante: ' || v_FabricanteNombre || 
                             ', Cantidad disponible: ' || v_CantidadDisponible);
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cur;
END;



DECLARE
    cur SYS_REFCURSOR;  -- Cursor para recibir el conjunto de resultados del procedimiento
    v_NombreSucursal VARCHAR2(50);
    v_ProvinciaSucursal VARCHAR2(50);
    v_TelefonoSucursal VARCHAR2(20);
    v_ProductoID NUMBER;
    v_ProductoNombre VARCHAR2(50);
    v_ProductoDescripcion VARCHAR2(50);
    v_ProductoCosto NUMBER(10, 2);
    v_FabricanteNombre VARCHAR2(50);
    v_CantidadDisponible NUMBER;
BEGIN
    -- Llamar al procedimiento almacenado
    SP_ProductoSucursal(2, cur); -- Reemplaza 1 con el ID de sucursal que desees probar
    
    -- Procesar los resultados del cursor
    LOOP
        FETCH cur INTO v_NombreSucursal, v_ProvinciaSucursal, v_TelefonoSucursal, 
                      v_ProductoID, v_ProductoNombre, v_ProductoDescripcion, v_ProductoCosto, 
                      v_FabricanteNombre, v_CantidadDisponible;
        EXIT WHEN cur%NOTFOUND;
        
        -- Mostrar los resultados
        DBMS_OUTPUT.PUT_LINE('Sucursal: ' || v_NombreSucursal || 
                             ', Provincia: ' || v_ProvinciaSucursal || 
                             ', Teléfono: ' || v_TelefonoSucursal || 
                             ', Producto ID: ' || v_ProductoID || 
                             ', Nombre: ' || v_ProductoNombre || 
                             ', Descripción: ' || v_ProductoDescripcion || 
                             ', Costo: ' || v_ProductoCosto || 
                             ', Fabricante: ' || v_FabricanteNombre || 
                             ', Cantidad disponible: ' || v_CantidadDisponible);
    END LOOP;
    
    -- Cerrar el cursor
    CLOSE cur;
END;
