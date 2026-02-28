USE mydb;

-- 1. CATÁLOGOS
INSERT INTO documento (tipo, numero) VALUES ('CC', '1001'), ('CC', '1002'), ('CE', '1003'), ('NIT', '9001'), ('PAS', '3005');
INSERT INTO email (dominio, nombre_email) VALUES ('gmail.com', 'user1'), ('outlook.com', 'user2'), ('yahoo.com', 'user3'), ('hotmail.com', 'user4'), ('icloud.com', 'user5');
INSERT INTO tipo_propiedad (nombre) VALUES ('casas'), ('apartamentos'), ('locales comerciales');
INSERT INTO estado_propiedad (nombre) VALUES ('disponible'), ('arrendada'), ('vendida');
INSERT INTO ciudad (nombre) VALUES ('Bogotá'), ('Medellín'), ('Cali'), ('Barranquilla'), ('Cartagena');
INSERT INTO tipo_contrato (nombre) VALUES ('venta'), ('arriendo');
INSERT INTO estado_factura (nombre) VALUES ('pagado'), ('pendiente');
INSERT INTO tipo_pago (nombre) VALUES ('efectivo'), ('transferencia'), ('tarjeta'), ('consignación');

-- 2. ENTIDADES (Personas, Teléfonos, Clientes, Agentes)
INSERT INTO personas (nombre, apellido, documento_id_documento, email_id_email) VALUES 
('Juan', 'Perez', 1, 1), ('Maria', 'Lopez', 2, 2), ('Carlos', 'Ruiz', 3, 3), ('Ana', 'Diaz', 4, 4), ('Luis', 'Torres', 5, 5);

INSERT INTO telefono (codigo, numero, tipo_telefono, personas_id_persona) VALUES 
('+57', '3001', 'Movil', 1), ('+57', '3002', 'Fijo', 2), ('+57', '3003', 'Movil', 3), ('+57', '3004', 'Movil', 4), ('+57', '3005', 'Fijo', 5);

-- Clientes
INSERT INTO cliente (id_cliente) VALUES (1), (2), (3), (4), (5);

-- Agentes
INSERT INTO agente (id_agente, comision) VALUES (1, 5.00), (2, 4.50), (3, 3.00), (4, 6.00), (5, 4.00);

-- 3. PROPIEDADES
INSERT INTO propiedad (direccion, precio, id_tipo_propiedad, id_estado_propiedad, id_ciudad) VALUES 
('Calle 1', 500000000.00, 1, 1, 1), ('Calle 2', 200000000.00, 2, 2, 2), ('Calle 3', 800000000.00, 3, 3, 3), ('Calle 4', 150000000.00, 1, 1, 4), ('Calle 5', 300000000.00, 2, 2, 5);

-- 4. CONTRATOS
INSERT INTO contrato (tipo_contrato_id, propiedad_id, fecha_inicio, fecha_fin, total, cliente_id, agente_id) VALUES 
(1, 1, '2026-01-01', '2027-01-01', 500000000.00, 1, 1),
(2, 2, '2026-02-01', '2027-02-01', 200000000.00, 2, 2),
(1, 3, '2026-03-01', '2027-03-01', 800000000.00, 3, 3),
(2, 4, '2026-04-01', '2028-04-01', 150000000.00, 4, 4),
(1, 5, '2026-05-01', '2027-05-01', 300000000.00, 5, 5);

-- 5. FACTURACIÓN
INSERT INTO factura (contrato_id, estado_factura_id, fecha_emision) VALUES 
(1, 1, '2026-01-05'), (2, 2, '2026-02-05'), (3, 1, '2026-03-05'), (4, 2, '2026-04-05'), (5, 1, '2026-05-05');

-- 6. PAGOS
INSERT INTO pago (factura_id, tipo_pago_id, monto, fecha_pago) VALUES 
(1, 1, 500000000.00, '2026-01-10'), (2, 2, 0.00, NULL), (3, 3, 800000000.00, '2026-03-10'), (4, 4, 0.00, NULL), (5, 4, 300000000.00, '2026-05-10');