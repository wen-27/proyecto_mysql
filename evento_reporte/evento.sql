-- 1. Tabla de reporte
CREATE TABLE reporte_pagos_mensual (
    id_reporte INT AUTO_INCREMENT PRIMARY KEY,
    fecha_ejecucion DATETIME,
    contrato_id INT,
    saldo_pendiente DECIMAL(12,2)
);

-- 2. Evento
DELIMITER //

CREATE EVENT evt_reporte_mensual_deudas
ON SCHEDULE EVERY 1 MONTH
STARTS (CURRENT_DATE + INTERVAL 1 MONTH - INTERVAL DAY(CURRENT_DATE)-1 DAY)
DO
BEGIN
    INSERT INTO reporte_pagos_mensual (fecha_ejecucion, contrato_id, saldo_pendiente)
    SELECT NOW(), id_contrato, fn_calcular_deuda(id_contrato)
    FROM contrato
    WHERE fn_calcular_deuda(id_contrato) > 0;
END //

DELIMITER ;