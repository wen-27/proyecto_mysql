DELIMITER //

CREATE PROCEDURE sp_insertar_propiedad_seguro(
    IN p_direccion VARCHAR(100),
    IN p_precio DECIMAL(12,2),
    IN p_tipo INT,
    IN p_estado INT,
    IN p_ciudad INT
)
BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Capturamos el error
        GET DIAGNOSTICS CONDITION 1
        @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        
        -- Guardamos en tu tabla de logs_error automáticamente
        INSERT INTO logs_error (tabla_afectada, procedimiento, tipo_objeto, codigo_error, mensaje, fecha_registro)
        VALUES ('propiedad', 'sp_insertar_propiedad_seguro', 'PROCEDURE', @errno, @text, NOW());
        
        -- Relanzamos el error para que la aplicación sepa que falló
        RESIGNAL SET MESSAGE_TEXT = @text;
    END;


    INSERT INTO propiedad (direccion, precio, id_tipo_propiedad, id_estado_propiedad, id_ciudad) 
    VALUES (p_direccion, p_precio, p_tipo, p_estado, p_ciudad);
    
END //

DELIMITER ;