-- Creación de la tabla de bitácora de los productos
CREATE TABLE Bitacora_Productos(
    ID NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    FechaHoraCambio DATE,
    CostoModificado NUMBER (10,2),
    CostoOriginal NUMBER (10,2),
    AccionRealizada VARCHAR (50)
);

-- Creación del Trigger: Declaración
CREATE OR REPLACE TRIGGER Audit_Productos
BEFORE INSERT OR UPDATE OR DELETE ON Producto_Farmacia
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO Bitacora_Productos (FechaHoraCambio, CostoModificado, CostoOriginal, AccionRealizada) 
        VALUES (SYSDATE, NULL, NULL, 'Inserción');
        DBMS_OUTPUT.PUT_LINE ('Se realizó la inserción');
    ELSIF UPDATING THEN
        IF :NEW.Costo != :OLD.Costo THEN
            INSERT INTO Bitacora_Productos (FechaHoraCambio, CostoModificado, CostoOriginal, AccionRealizada) 
            VALUES (SYSDATE, :NEW.Costo, :OLD.Costo, 'Modificación');
            DBMS_OUTPUT.PUT_LINE ('Se realizó una modificación');
        ELSE
            DBMS_OUTPUT.PUT_LINE ('No se realizó la modificación, no se registró en la bitácora');
        END IF;
    ELSIF DELETING THEN
        INSERT INTO Bitacora_Productos (FechaHoraCambio, CostoModificado, CostoOriginal, AccionRealizada) 
        VALUES (SYSDATE, NULL, NULL, 'Eliminación');
        DBMS_OUTPUT.PUT_LINE ('Se realizó la eliminación');    
    END IF;
END;