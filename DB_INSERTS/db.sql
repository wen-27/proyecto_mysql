CREATE DATABASE IF NOT EXISTS mydb;
USE mydb;


-- PERSONAS


CREATE TABLE documento (
  id_documento INT NOT NULL AUTO_INCREMENT,
  tipo VARCHAR(45),
  numero VARCHAR(45),
  PRIMARY KEY (id_documento)
);

CREATE TABLE email (
  id_email INT NOT NULL AUTO_INCREMENT,
  dominio VARCHAR(45),
  nombre_email VARCHAR(45),
  PRIMARY KEY (id_email)
);

CREATE TABLE personas (
  id_persona INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  apellido VARCHAR(45),
  documento_id_documento INT,
  email_id_email INT,
  PRIMARY KEY (id_persona),
  FOREIGN KEY (documento_id_documento) REFERENCES documento(id_documento),
  FOREIGN KEY (email_id_email) REFERENCES email(id_email)
);

CREATE TABLE telefono (
  id_telefono INT NOT NULL AUTO_INCREMENT,
  codigo VARCHAR(45),
  numero VARCHAR(45),
  tipo_telefono VARCHAR(45),
  personas_id_persona INT,
  PRIMARY KEY (id_telefono),
  FOREIGN KEY (personas_id_persona) REFERENCES personas(id_persona)
);

CREATE TABLE cliente (
  id_cliente INT NOT NULL,
  PRIMARY KEY (id_cliente),
  FOREIGN KEY (id_cliente) REFERENCES personas(id_persona)
);

CREATE TABLE agente (
  id_agente INT NOT NULL,
  comision DECIMAL(5,2),
  PRIMARY KEY (id_agente),
  FOREIGN KEY (id_agente) REFERENCES personas(id_persona)
);

-- PROPIEDADES


CREATE TABLE tipo_propiedad (
  id_tipo_propiedad INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  PRIMARY KEY (id_tipo_propiedad)
);

CREATE TABLE estado_propiedad (
  id_estado_propiedad INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  PRIMARY KEY (id_estado_propiedad)
);

CREATE TABLE ciudad (
  id_ciudad INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  PRIMARY KEY (id_ciudad)
);

CREATE TABLE propiedad (
  id_propiedad INT NOT NULL AUTO_INCREMENT,
  direccion VARCHAR(100),
  precio DECIMAL(12,2),
  id_tipo_propiedad INT,
  id_estado_propiedad INT,
  id_ciudad INT,
  PRIMARY KEY (id_propiedad),
  FOREIGN KEY (id_tipo_propiedad) REFERENCES tipo_propiedad(id_tipo_propiedad),
  FOREIGN KEY (id_estado_propiedad) REFERENCES estado_propiedad(id_estado_propiedad),
  FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);


-- CONTRATO (SIN PARTICIÓN)


CREATE TABLE tipo_contrato (
  id_tipo_contrato INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(20),
  PRIMARY KEY (id_tipo_contrato)
);

CREATE TABLE contrato (
  id_contrato INT NOT NULL AUTO_INCREMENT,
  tipo_contrato_id INT,
  propiedad_id INT,
  fecha_inicio DATETIME NOT NULL,
  fecha_fin DATETIME,
  total DECIMAL(12,2),
  cliente_id INT,
  agente_id INT,
  PRIMARY KEY (id_contrato),

  FOREIGN KEY (tipo_contrato_id)
    REFERENCES tipo_contrato(id_tipo_contrato),

  FOREIGN KEY (propiedad_id)
    REFERENCES propiedad(id_propiedad),

  FOREIGN KEY (cliente_id)
    REFERENCES cliente(id_cliente),

  FOREIGN KEY (agente_id)
    REFERENCES agente(id_agente)
);


-- FACTURACIÓN


CREATE TABLE estado_factura (
  id_estado_factura INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  PRIMARY KEY (id_estado_factura)
);

CREATE TABLE factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  contrato_id INT,
  estado_factura_id INT,
  fecha_emision DATETIME,
  PRIMARY KEY (id_factura),
  FOREIGN KEY (contrato_id) REFERENCES contrato(id_contrato),
  FOREIGN KEY (estado_factura_id) REFERENCES estado_factura(id_estado_factura)
);


-- PAGOS


CREATE TABLE tipo_pago (
  id_tipo_pago INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(45),
  PRIMARY KEY (id_tipo_pago)
);

CREATE TABLE pago (
  id_pago INT NOT NULL AUTO_INCREMENT,
  factura_id INT,
  tipo_pago_id INT,
  monto DECIMAL(12,2),
  fecha_pago DATETIME,
  PRIMARY KEY (id_pago),
  FOREIGN KEY (factura_id) REFERENCES factura(id_factura),
  FOREIGN KEY (tipo_pago_id) REFERENCES tipo_pago(id_tipo_pago)
);


-- LOGS


CREATE TABLE logs (
  id_logs INT NOT NULL AUTO_INCREMENT,
  tabla_afectada VARCHAR(45),
  procedimiento VARCHAR(45),
  accion VARCHAR(45),
  descripcion TEXT,
  fecha_registro DATETIME NOT NULL,
  PRIMARY KEY (id_logs, fecha_registro)
)
PARTITION BY RANGE (YEAR(fecha_registro)) (
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION p_future VALUES LESS THAN MAXVALUE
);

CREATE TABLE logs_error (
  id_logs_error INT NOT NULL AUTO_INCREMENT,
  tabla_afectada VARCHAR(45),
  procedimiento VARCHAR(45),
  tipo_objeto VARCHAR(45),
  codigo_error INT,
  mensaje TEXT,
  fecha_registro DATETIME NOT NULL,
  PRIMARY KEY (id_logs_error, fecha_registro)
)
PARTITION BY RANGE (YEAR(fecha_registro)) (
  PARTITION p2024 VALUES LESS THAN (2025),
  PARTITION p2025 VALUES LESS THAN (2026),
  PARTITION p_future VALUES LESS THAN MAXVALUE
);