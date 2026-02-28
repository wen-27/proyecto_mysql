-- Vista de Propiedades

CREATE VIEW vw_resumen_propiedades AS
SELECT 
    p.id_propiedad,
    p.direccion,
    p.precio,
    t.nombre AS tipo_propiedad,
    e.nombre AS estado_actual,
    c.nombre AS ciudad
FROM propiedad p
JOIN tipo_propiedad t ON p.id_tipo_propiedad = t.id_tipo_propiedad
JOIN estado_propiedad e ON p.id_estado_propiedad = e.id_estado_propiedad
JOIN ciudad c ON p.id_ciudad = c.id_ciudad;

-- Vista de Contratos Detallados

CREATE VIEW vw_contratos_detallados AS
SELECT 
    con.id_contrato,
    p.direccion AS propiedad,
    CONCAT(per_c.nombre, ' ', per_c.apellido) AS cliente,
    CONCAT(per_a.nombre, ' ', per_a.apellido) AS agente,
    con.fecha_inicio,
    con.total
FROM contrato con
JOIN propiedad p ON con.propiedad_id = p.id_propiedad
JOIN cliente cli ON con.cliente_id = cli.id_cliente
JOIN personas per_c ON cli.id_cliente = per_c.id_persona
JOIN agente ag ON con.agente_id = ag.id_agente
JOIN personas per_a ON ag.id_agente = per_a.id_persona;

-- Vista de Saldo Financiero

CREATE VIEW vw_saldo_contratos AS
SELECT 
    c.id_contrato,
    c.total AS valor_contrato,
    IFNULL(SUM(p.monto), 0) AS total_pagado,
    (c.total - IFNULL(SUM(p.monto), 0)) AS saldo_pendiente
FROM contrato c
LEFT JOIN factura f ON c.id_contrato = f.contrato_id
LEFT JOIN pago p ON f.id_factura = p.factura_id
GROUP BY c.id_contrato, c.total;