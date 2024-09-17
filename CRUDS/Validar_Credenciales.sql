CREATE OR REPLACE PROCEDURE Validar_Credenciales(
    InUsuario IN VARCHAR2,       -- Nombre de usuario a validar
    InContrasena IN VARCHAR2,    -- Contraseña asociada con el usuario
    OutResultado OUT NUMBER      -- Resultado de la operación: 0 si no se encontró el usuario, IDEmpleado si se encontró exitosamente, -1 si ocurrió un error
)
IS 

    -- Variable local que almacena el ID del empleado encontrado.
    -- Su tipo de dato se toma de la columna IDEmpleado de la tabla Credencial_Empleado.
    v_IDEmpleado Credencial_Empleado.IDEmpleado%TYPE; 

BEGIN 
    
    -- Consulta que busca el IDEmpleado en la tabla Credencial_Empleado
    -- donde el Usuario y la Contrasena coinciden con los valores de entrada.
    SELECT IDEmpleado
    INTO v_IDEmpleado
    FROM Credencial_Empleado
    WHERE Usuario = InUsuario AND Contrasena = InContrasena;

    -- Si se encuentra una coincidencia, se asigna el IDEmpleado al parámetro de salida
    OutResultado := v_IDEmpleado;
    
    -- Mensaje de salida que indica que el usuario existe y muestra su ID
    dbms_output.put_line('El usuario existe con ID: ' || v_IDEmpleado);
    
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


DECLARE
    resultado NUMBER;
BEGIN
    Validar_Credenciales('juan.perez', 'password123', resultado);
END;