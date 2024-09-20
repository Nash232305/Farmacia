CREATE OR REPLACE PROCEDURE Validar_Credenciales(
    InUsuario IN VARCHAR2,       -- Nombre de usuario a validar
    InContrasena IN VARCHAR2,    -- Contraseña asociada con el usuario
    OutResultado OUT NUMBER      -- Resultado de la operación: 0 si no se encontró el usuario, IDEmpleado si se encontró exitosamente, -1 si ocurrió un error
)
IS 

    -- Variable local que almacena el ID del empleado encontrado.
    v_IDEmpleado Credencial_Empleado.IDEmpleado%TYPE; 
    
    -- Variable local para almacenar el estado del empleado.
    v_EstadoEmpleado EMPLEADO_FARMACIA.ESTADO%TYPE;

BEGIN
    -- Consulta que busca el IDEmpleado en la tabla Credencial_Empleado
    -- donde el Usuario y la Contrasena coinciden con los valores de entrada.
    SELECT IDEmpleado
    INTO v_IDEmpleado
    FROM Credencial_Empleado
    WHERE Usuario = InUsuario AND Contrasena = InContrasena;

    -- Verificar el estado del empleado en la tabla EMPLEADO_FARMACIA.
    SELECT ESTADO
    INTO v_EstadoEmpleado
    FROM EMPLEADO_FARMACIA
    WHERE ID = v_IDEmpleado;

    -- Si el empleado está activo (ESTADO = '1'), se devuelve el IDEmpleado.
    IF v_EstadoEmpleado = '1' OR v_EstadoEmpleado = 'A' THEN
        OutResultado := v_IDEmpleado;
        dbms_output.put_line('El usuario existe con ID: ' || v_IDEmpleado || ' y está activo.');
    ELSE
        -- Si el empleado no está activo, se devuelve 0.
        OutResultado := 0;
        dbms_output.put_line('El empleado con ID: ' || v_IDEmpleado || ' no está activo.');
    END IF;
    
EXCEPTION
    -- Manejo de excepción si no se encuentran coincidencias
    WHEN NO_DATA_FOUND THEN
        OutResultado := 0;  -- Se asigna 0 al parámetro de salida para indicar que el usuario no existe
        -- Mensaje de salida que indica que el usuario no existe
        dbms_output.put_line('El usuario NO existe');
        
    -- Manejo de cualquier otro tipo de error
    WHEN OTHERS THEN
        -- Se realiza un ROLLBACK en caso de un error inesperado
        ROLLBACK;
        OutResultado := -1; -- Se asigna -1 al parámetro de salida para indicar que ocurrió un error
        -- Mensaje de salida que indica que ocurrió un error inesperado
        dbms_output.put_line('Ocurrió un error inesperado: ' || SQLERRM);
        
END Validar_Credenciales;

