-- Auditoría de cambios en Propiedades

DELIMITER //

CREATE TRIGGER trg_audit_propiedad_estado
AFTER UPDATE ON propiedad
FOR EACH ROW
BEGIN
    -- Comparamos si el ID del estado cambió
    IF OLD.id_estado_propiedad <> NEW.id_estado_propiedad THEN
        INSERT INTO logs (tabla_afectada, procedimiento, accion, descripcion, fecha_registro)
        VALUES (
            'propiedad', 
            'UPDATE_ESTADO', 
            'CAMBIO_DE_ESTADO', 
            CONCAT('Propiedad ID ', OLD.id_propiedad, ' cambió de estado ', OLD.id_estado_propiedad, ' a ', NEW.id_estado_propiedad), 
            NOW()
        );
    END IF;
END //

DELIMITER ;

-- Registro de nuevo Contrato

DELIMITER //

CREATE TRIGGER trg_audit_nuevo_contrato
AFTER INSERT ON contrato
FOR EACH ROW
BEGIN
    INSERT INTO logs (tabla_afectada, procedimiento, accion, descripcion, fecha_registro)
    VALUES (
        'contrato', 
        'INSERT_CONTRATO', 
        'NUEVO_CONTRATO', 
        CONCAT('Se creó el contrato ID ', NEW.id_contrato, ' para la propiedad ', NEW.propiedad_id), 
        NOW()
    );
END //

DELIMITER ;