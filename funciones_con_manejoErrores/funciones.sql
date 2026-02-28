DELIMITER //

-- A. Calcular comisión del agente
CREATE FUNCTION fn_calcular_comision(p_id_contrato INT) 
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12,2);
    DECLARE v_comision_pct DECIMAL(5,2);
    
    SELECT c.total, a.comision INTO v_total, v_comision_pct
    FROM contrato c
    JOIN agente a ON c.agente_id = a.id_agente
    WHERE c.id_contrato = p_id_contrato;
    
    IF v_total IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Contrato no encontrado';
    END IF;
    
    RETURN v_total * (v_comision_pct / 100);
END //

-- B. Calcular deuda pendiente (Arriendo)
CREATE FUNCTION fn_calcular_deuda(p_id_contrato INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(12,2);
    DECLARE v_pagado DECIMAL(12,2);
    
    SELECT total INTO v_total FROM contrato WHERE id_contrato = p_id_contrato;
    
    IF v_total IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Contrato inválido';
    END IF;
    
    SELECT IFNULL(SUM(monto), 0) INTO v_pagado
    FROM pago p
    JOIN factura f ON p.factura_id = f.id_factura
    WHERE f.contrato_id = p_id_contrato;
    
    RETURN (v_total - v_pagado);
END //

-- C. Total propiedades disponibles por tipo
CREATE FUNCTION fn_count_propiedades_disponibles(p_id_tipo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_count INT;
    
    SELECT COUNT(*) INTO v_count
    FROM propiedad
    WHERE id_tipo_propiedad = p_id_tipo 
    AND id_estado_propiedad = 1; 
    
    RETURN v_count;
END //

DELIMITER ;