create or replace PROCEDURE SP_ObtenerProductos (
    cur_out OUT SYS_REFCURSOR  -- Cursor de referencia para devolver el conjunto de resultados
)
AS
BEGIN
    -- Abrir el cursor con la consulta SQL especificada
    OPEN cur_out FOR
        SELECT 
            PR.ID AS IDProveedor,
            PR.NOMBRE AS NombreProveedor,
            PR.TELEFONO AS TelefonoProveedor,
            P.ID AS IDProducto,
            P.NOMBRE AS NombreProducto,
            P.DESCRIPCION AS DescripcionProducto,
            F.NOMBRE AS NombreFabricante,
            P.COSTO AS CostoProducto
        FROM 
            PRODUCTO_FARMACIA P                        -- Tabla de productos farmacéuticos
            INNER JOIN FABRICANTE_FARMACIA F ON P.IDFABRICANTE = F.ID  -- Unión con la tabla de fabricantes
            INNER JOIN PROVEEDOR_FARMACIA PR ON P.IDPROVEEDOR = PR.ID  -- Unión con la tabla de proveedores
        ORDER BY 
            PR.NOMBRE ASC;                         -- Ordenar los resultados por la descripción del producto en orden ascendente
END SP_ObtenerProductos;