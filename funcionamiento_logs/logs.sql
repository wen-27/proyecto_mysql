DELIMITER //

CREATE PROCEDURE sp_registrar_log(
    IN p_tabla VARCHAR(45),
    IN p_procedimiento VARCHAR(45),
    IN p_accion VARCHAR(45),
    IN p_descripcion TEXT
)
BEGIN
    INSERT INTO logs (tabla_afectada, procedimiento, accion, descripcion, fecha_registro)
    VALUES (p_tabla, p_procedimiento, p_accion, p_descripcion, NOW());
END //

DELIMITER ;


-- disparador logs

DELIMITER //

CREATE TRIGGER trg_insert_propiedad
AFTER INSERT ON propiedad
FOR EACH ROW
BEGIN
    CALL sp_registrar_log('propiedad', 'trg_insert_propiedad', 'INSERT', CONCAT('Nueva propiedad ID: ', NEW.id_propiedad));
END //

DELIMITER ;

