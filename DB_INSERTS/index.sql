-- 1. Optimización en Personas y sus relaciones
CREATE INDEX idx_persona_documento ON personas(documento_id_documento);
CREATE INDEX idx_persona_email ON personas(email_id_email);
CREATE INDEX idx_telefono_persona ON telefono(personas_id_persona);

-- 2. Optimización en Propiedades (Muy importante para búsquedas de clientes)
-- Índice compuesto para filtrar por ciudad y estado rápidamente
CREATE INDEX idx_propiedad_ciudad_estado ON propiedad(id_ciudad, id_estado_propiedad);
CREATE INDEX idx_propiedad_tipo ON propiedad(id_tipo_propiedad);

-- 3. Optimización en Contratos (Crucial para reportes y facturación)
CREATE INDEX idx_contrato_cliente ON contrato(cliente_id);
CREATE INDEX idx_contrato_agente ON contrato(agente_id);
CREATE INDEX idx_contrato_propiedad ON contrato(propiedad_id);

-- 4. Optimización en Facturación y Pagos
CREATE INDEX idx_factura_contrato ON factura(contrato_id);
CREATE INDEX idx_pago_factura ON pago(factura_id);
CREATE INDEX idx_pago_fecha ON pago(fecha_pago);