CREATE OR REPLACE PACKAGE PKG_Empleado_Farmacia_CRUD AS

    -- Procedimiento para crear un nuevo empleado
    PROCEDURE Crear_Empleado(
        InCedula IN VARCHAR2,       -- C�dula del empleado (debe ser �nica)
        InNombre IN VARCHAR2,       -- Nombre del empleado
        InApellido IN VARCHAR2,     -- Apellido del empleado
        InSexo IN CHAR,             -- Sexo del empleado ('M' para masculino, 'F' para femenino)
        InEdad IN INT,              -- Edad del empleado
        InSalario IN NUMBER,        -- Salario del empleado
        InEmail IN VARCHAR2,        -- Correo electr�nico del empleado (debe ser �nico)
        InNumeroTelefono IN VARCHAR,-- N�mero de tel�fono del empleado (debe ser �nico)
        InIDSucursal IN INT,        -- Identificador de la sucursal a la que pertenece el empleado: NOTE: Esto se puede cambiar por el nombre
        InUsuario IN VARCHAR2,      -- Nombre de usuario para el empleado en la tabla Credencial_Empleado (debe ser �nico)
        InContrasena IN VARCHAR2,   -- Contrase�a para el usuario en la tabla Credencial_Empleado
        OutResultado OUT NUMBER     -- Resultado de la operaci�n: 0 si no se insert�, 1 si se insert�, -1 si hubo un error
    );

    -- Procedimiento para leer los detalles de un empleado
    PROCEDURE Leer_Empleado(
        InCedula IN VARCHAR2,          -- C�dula del empleado a leer
        OutNombre OUT VARCHAR2,        -- Nombre del empleado
        OutApellido OUT VARCHAR2,      -- Apellido del empleado
        OutSexo OUT CHAR,              -- Sexo del empleado 
        OutEdad OUT INT,               -- Edad del empleado
        OutSalario OUT NUMBER,         -- Salario del empleado
        OutEmail OUT VARCHAR2,         -- Email del empleado
        OutNumeroTelefono OUT VARCHAR2,-- N�mero de tel�fono del empleado
        OutIDSucursal OUT INT,         -- ID de sucursal del empleado
        OutResultado OUT NUMBER        -- Resultado de la operaci�n: 0 si no se encontr� el empleado, 1 si se encontr� exitosamente, -1 si ocurri� un error
    );
    
    PROCEDURE Modificar_Empleado(
        InCedula IN VARCHAR2,        -- C�dula del empleado a actualizar
        InNombre IN VARCHAR2,        -- Nuevo nombre del empleado
        InApellido IN VARCHAR2,      -- Nuevo apellido del empleado
        InSexo IN CHAR,              -- Nuevo sexo del empleado ('M' para masculino, 'F' para femenino)
        InEdad IN INT,               -- Nueva edad del empleado
        InSalario IN NUMBER,         -- Nuevo salario del empleado
        InEmail IN VARCHAR2,         -- Nuevo correo electr�nico del empleado
        InNumeroTelefono IN VARCHAR2,-- Nuevo n�mero de tel�fono del empleado
        InIDSucursal IN INT,         -- Nuevo identificador de la sucursal
        OutResultado OUT NUMBER      -- Resultado de la operaci�n: 0 si no se actualiz�, 1 si se actualiz�, -1 si hubo un error
    );
    
    -- Procedimiento para eliminar un empleado l�gicamente
    PROCEDURE Eliminar_Empleado(
        InCedula IN VARCHAR2,       -- C�dula del empleado a eliminar l�gicamente
        OutResultado OUT NUMBER     -- Resultado de la operaci�n: 0: Error, 1: �xito
    );
    
    -- Funci�n para encontrar el ID de un empleado basado en su nombre
    FUNCTION Encontrar_Id_Empleado 
        RETURN NUMBER;
        
END PKG_Empleado_Farmacia_CRUD;
/

CREATE OR REPLACE PACKAGE BODY PKG_Empleado_Farmacia_CRUD AS

    -- Funci�n para encontrar el pr�ximo ID disponible para un nuevo empleado
    FUNCTION Encontrar_Id_Empleado
        RETURN NUMBER
    
    IS
        Id_Empleado NUMBER;  -- Variable para almacenar el pr�ximo ID disponible
    BEGIN
        -- Busca el ID m�ximo en la tabla Empleado_Farmacia y le suma 1 para obtener el siguiente ID disponible
        SELECT NVL(MAX(ID), 0) + 1
        INTO Id_Empleado
        FROM Empleado_Farmacia;
    
        RETURN Id_Empleado; -- Retorna el pr�ximo ID disponible
        
    EXCEPTION
        WHEN OTHERS THEN
            -- Captura cualquier error que ocurra y muestra un mensaje de error
            DBMS_OUTPUT.put_line('Ocurri� un error al encontrar el ID del empleado: ' || SQLERRM);
            RETURN NULL;  -- Retorna NULL en caso de error
    END Encontrar_Id_Empleado;
    

    -- Implementaci�n de Crear_Empleado
    PROCEDURE Crear_Empleado(
        InCedula IN VARCHAR2, 
        InNombre IN VARCHAR2, 
        InApellido IN VARCHAR2, 
        InSexo IN CHAR, 
        InEdad IN INT, 
        InSalario IN NUMBER, 
        InEmail IN VARCHAR2, 
        InNumeroTelefono IN VARCHAR, 
        InIDSucursal IN INT,
        InUsuario IN VARCHAR2,
        InContrasena IN VARCHAR2,
        OutResultado OUT NUMBER
    ) 
    IS
        Bandera NUMBER;     -- Variable para verificar si ya existe un empleado con los mismos datos
        IdEmpleado NUMBER;  -- Variable para almacenar el nuevo ID del empleado
    BEGIN
        -- Verifica si ya existe un empleado con la misma c�dula, email o n�mero de tel�fono
        SELECT COUNT(*) INTO Bandera 
        FROM Empleado_Farmacia 
        WHERE Cedula = InCedula
           OR Email = InEmail
           OR NumeroTelefono = InNumeroTelefono;

        IF (Bandera > 0) THEN
            -- Si existe un empleado con los mismos datos, no se puede registrar el nuevo empleado
            dbms_output.put_line('El usuario no se puede registrar');
            OutResultado := 0;  --Indica que existe datos los cuales son unicos por empleado
        ELSE
             -- Obtiene el pr�ximo ID disponible para el nuevo empleado
            IdEmpleado := Encontrar_Id_Empleado;
            
            -- Inserta el nuevo empleado en la tabla
            INSERT INTO Empleado_Farmacia (ID, Cedula, Nombre, Apellido, Sexo, Edad, Salario, Email, NumeroTelefono, IDSucursal)
            VALUES (IdEmpleado, InCedula, InNombre, InApellido, InSexo, InEdad, InSalario, InEmail, InNumeroTelefono, InIDSucursal);
            
            INSERT INTO Credencial_Empleado(IDEmpleado, Usuario, Contrasena)
            VALUES (IdEmpleado,InUsuario, InContrasena);
            -- Confirma los cambios en la base de datos
            COMMIT;
            OutResultado := 1;  -- Indica que el empleado se insert� correctamente
            dbms_output.put_line('El usuario ha sido insertado correctamente');
        END IF;

    EXCEPTION
        -- Si ocurre un error, revierte los cambios y muestra un mensaje de error
        WHEN OTHERS THEN
            ROLLBACK;
            dbms_output.put_line('Ocurri� un error inesperado: ' || SQLERRM);
            OutResultado := -1; -- Indica que hubo un error
    END Crear_Empleado;

    -- Implementaci�n de Leer_Empleado
    PROCEDURE Leer_Empleado(
        InCedula IN VARCHAR2, 
        OutNombre OUT VARCHAR2, 
        OutApellido OUT VARCHAR2, 
        OutSexo OUT CHAR, 
        OutEdad OUT INT, 
        OutSalario OUT NUMBER, 
        OutEmail OUT VARCHAR2, 
        OutNumeroTelefono OUT VARCHAR2, 
        OutIDSucursal OUT INT, 
        OutResultado OUT NUMBER
    )
    IS
    BEGIN
         -- Obtiene los detalles del empleado
        SELECT Nombre, Apellido, Sexo, Edad, Salario, Email, NumeroTelefono, IDSucursal
        INTO OutNombre, OutApellido, OutSexo, OutEdad, OutSalario, OutEmail, OutNumeroTelefono, OutIDSucursal
        FROM Empleado_Farmacia
        WHERE Cedula = InCedula AND Estado = 1;
        
        dbms_output.put_line('Empleado le�do exitosamente.');
        OutResultado := 1;   -- Indica que el empleado se encontro

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Si no se encuentra el empleado
            dbms_output.put_line('No se encontr� un empleado con la c�dula proporcionada.');
            OutResultado := 0;   -- Indica que el empleado no se encuentra
        -- Manejo de otras excepciones generales
        WHEN OTHERS THEN
            dbms_output.put_line('Ocurri� un error al leer el empleado: ' || SQLERRM);
            OutResultado := -1; -- Indica que ocurrio un error
    END Leer_Empleado;
    
    -- Implementaci�n de Modificar_Empleado
    PROCEDURE Modificar_Empleado(
        InCedula IN VARCHAR2,        
        InNombre IN VARCHAR2,        
        InApellido IN VARCHAR2,     
        InSexo IN CHAR,             
        InEdad IN INT,              
        InSalario IN NUMBER,       
        InEmail IN VARCHAR2,       
        InNumeroTelefono IN VARCHAR2,
        InIDSucursal IN INT,      
        OutResultado OUT NUMBER     
    )
    IS
        Bandera NUMBER;     -- Variable para verificar si ya existe un empleado con los mismos datos
        IdEmpleado NUMBER;  -- Variable para almacenar el nuevo ID del empleado
    BEGIN
        -- Obtiene el pr�ximo ID disponible para el nuevo empleado
        IdEmpleado := Encontrar_Id_Empleado;
        -- Verifica si ya existe un empleado con la misma c�dula, email o n�mero de tel�fono
        SELECT COUNT(*) INTO Bandera 
        FROM Empleado_Farmacia 
        WHERE (Email = InEmail OR NumeroTelefono = InNumeroTelefono)
          AND ID != IdEmpleado
          AND Estado = '1';

        IF (Bandera > 0) THEN
            -- Si existe un empleado con los mismos datos, no se puede registrar el nuevo empleado
            dbms_output.put_line('El usuario no se puedo modificar');
            OutResultado := 0;  --Indica que existe datos los cuales son unicos por empleado
        ELSE
        
            -- Inserta el nuevo empleado en la tabla
            UPDATE EMPLEADO_FARMACIA
                SET Nombre = InNombre,
                    Apellido = InApellido,
                    Sexo = InSexo,
                    Edad = InEdad,
                    Salario = InSalario,
                    Email = InEmail,
                    NumeroTelefono = InNumeroTelefono,
                    IDSucursal = InIDSucursal
                WHERE ID = IdEmpleado;
            -- Confirma los cambios en la base de datos
            COMMIT;
            OutResultado := 1;  -- Indica que el empleado se insert� correctamente
            dbms_output.put_line('El usuario ha sido modificado correctamente');
        END IF;
        
    EXCEPTION
        -- Manejo de excepciones generales
        WHEN OTHERS THEN
            ROLLBACK;  -- Revertir cualquier cambio en caso de error
            dbms_output.put_line('Ocurri� un error inesperado: ' || SQLERRM);
            OutResultado := -1; -- Indica que hubo un error
    END Modificar_Empleado;
    
    -- Implementaci�n de Eliminar_Empleado
    PROCEDURE Eliminar_Empleado(
        InCedula IN VARCHAR2, 
        OutResultado OUT NUMBER
    )
    IS
        IdEmpleado NUMBER; -- Variable para almacenar el ID del empleado
    BEGIN
        -- Verifica si existe un registro con la c�dula proporcionada y con el estado activo
        BEGIN
            SELECT ID INTO IdEmpleado
            FROM Empleado_Farmacia
            WHERE Cedula = InCedula AND Estado = 1;
            
            -- Actualiza el estado del empleado a 0 para eliminarlo l�gicamente
            UPDATE Empleado_Farmacia
            SET Estado = 0
            WHERE ID = IdEmpleado;
            
            COMMIT;
            dbms_output.put_line('Empleado eliminado (l�gicamente) exitosamente.');
            OutResultado := 1;  -- Indica que el empleado se encontr� y se elimin�
            
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                -- Si no se encuentra el registro con la c�dula y estado activo
                dbms_output.put_line('No se encontr� un empleado con la c�dula proporcionada para eliminar.');
                OutResultado := 0;  -- Indica que el empleado no se encuentra
                
            WHEN OTHERS THEN
                -- Manejo de excepciones generales
                ROLLBACK;
                dbms_output.put_line('Ocurri� un error al eliminar el empleado: ' || SQLERRM);
                OutResultado := -1;  -- Indica que ocurri� un error
        END;
    END Eliminar_Empleado;

END PKG_Empleado_Farmacia_CRUD;
/
