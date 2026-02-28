CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPassword123!';
GRANT ALL PRIVILEGES ON mydb.* TO 'admin_user'@'localhost';

CREATE USER 'agente_user'@'localhost' IDENTIFIED BY 'AgentePassword456!';

-- Permisos de lectura/escritura en tablas operativas
GRANT SELECT, INSERT, UPDATE ON mydb.propiedad TO 'agente_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydb.contrato TO 'agente_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydb.personas TO 'agente_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydb.cliente TO 'agente_user'@'localhost';

-- Permisos de solo lectura para tablas de catálogo
GRANT SELECT ON mydb.tipo_propiedad TO 'agente_user'@'localhost';
GRANT SELECT ON mydb.estado_propiedad TO 'agente_user'@'localhost';
GRANT SELECT ON mydb.ciudad TO 'agente_user'@'localhost';

CREATE USER 'contador_user'@'localhost' IDENTIFIED BY 'ContadorPassword789!';

-- Permisos financieros
GRANT SELECT, INSERT, UPDATE ON mydb.factura TO 'contador_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mydb.pago TO 'contador_user'@'localhost';
GRANT SELECT, INSERT ON mydb.tipo_pago TO 'contador_user'@'localhost';

-- Permisos de lectura para contexto y reportes
GRANT SELECT ON mydb.contrato TO 'contador_user'@'localhost';
GRANT SELECT ON mydb.vw_saldo_contratos TO 'contador_user'@'localhost';
GRANT SELECT ON mydb.reporte_pagos_mensual TO 'contador_user'@'localhost';

FLUSH PRIVILEGES;