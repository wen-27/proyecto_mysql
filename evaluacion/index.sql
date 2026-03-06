-- Búsquedas de propiedades por ciudad

CREATE INDEX idx_propiedad_ciudad
ON propiedad(id_ciudad);

-- Índice compuesto para contratos

CREATE INDEX idx_contrato_agente_propiedad
ON contrato(agente_id, propiedad_id);