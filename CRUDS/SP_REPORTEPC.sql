CREATE OR REPLACE PROCEDURE sp_obtener_resumen_productos(
    p_total_productos OUT NUMBER,
    p_stock_bajo OUT NUMBER,
    p_proximos_a_vencer OUT NUMBER,
    p_sucursales_activas OUT NUMBER
)
IS
BEGIN
    -- Total de productos registrados
    SELECT COUNT(*)
    INTO p_total_productos
    FROM PRODUCTO_FARMACIA;

    -- Productos con stock bajo (ejemplo: stock menor a 10 unidades)
    SELECT COUNT(*)
    INTO p_stock_bajo
    FROM PRODUCTO_FARMACIA
    WHERE CANTIDAD < 10;  -- Ajusta el valor según tu definición de "stock bajo"

    -- Productos próximos a vencer en los próximos 30 días
    SELECT COUNT(*)
    INTO p_proximos_a_vencer
    FROM PRODUCTO_FARMACIA
    WHERE FECHAVENCIMIENTO BETWEEN SYSDATE AND SYSDATE + 30;

    -- Sucursales activas
    SELECT COUNT(*)
    INTO p_sucursales_activas
    FROM SUCURSAL_FARMACIA
    WHERE ESTADO = 'A';  -- Suponiendo que 'A' indica una sucursal activa

END sp_obtener_resumen_productos;
/
