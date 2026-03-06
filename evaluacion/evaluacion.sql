-- Consulta 1: Mostrar el precio promedio, máximo y mínimo de las propiedades agrupadas por ciudad (AVG, MAX, MIN, GROUP BY).

SELECT 
    c.nombre AS ciudad,
    AVG(p.precio) AS precio_promedio,
    MAX(p.precio) AS precio_maximo,
    MIN(p.precio) AS precio_minimo
FROM propiedad p
JOIN ciudad c 
    ON p.id_ciudad = c.id_ciudad
GROUP BY c.nombre;

-- Consulta 2: Listar las propiedades disponibles para arriendo cuyo precio esté entre 800000 y 2000000 (BETWEEN, WHERE, AND).

SELECT 
    p.id_propiedad,
    p.direccion,
    p.precio
FROM propiedad p
JOIN contrato c 
    ON p.id_propiedad = c.propiedad_id
WHERE c.tipo_contrato_id = 2
AND p.id_estado_propiedad = 1
AND p.precio BETWEEN 800000 AND 2000000;

-- Consulta 3: Mostrar las propiedades que incluyen la palabra “Parque” en su dirección (LIKE '%Parque%').

SELECT 
    id_propiedad,
    direccion,
    precio
FROM propiedad
WHERE direccion LIKE '%Parque%';

-- Consulta 4: Listar el nombre del agente inmobiliario, la cantidad de propiedades que administra y la ciudad principal donde las tiene (JOIN, GROUP BY, ORDER BY).

SELECT 
    CONCAT(per.nombre,' ',per.apellido) AS agente,
    COUNT(DISTINCT p.id_propiedad) AS total_propiedades,
    c.nombre AS ciudad
FROM agente a
JOIN personas per 
    ON a.id_agente = per.id_persona
JOIN contrato con 
    ON a.id_agente = con.agente_id
JOIN propiedad p 
    ON con.propiedad_id = p.id_propiedad
JOIN ciudad c 
    ON p.id_ciudad = c.id_ciudad
GROUP BY a.id_agente, c.nombre
ORDER BY total_propiedades DESC;

-- Consulta 5: Obtener las 5 propiedades más costosas y su respectivo cliente si ya fueron arrendadas (JOIN, ORDER BY DESC, LIMIT 5).

SELECT 
    p.direccion,
    p.precio,
    CONCAT(per.nombre,' ',per.apellido) AS cliente
FROM propiedad p
LEFT JOIN contrato c 
    ON p.id_propiedad = c.propiedad_id
LEFT JOIN cliente cl 
    ON c.cliente_id = cl.id_cliente
LEFT JOIN personas per 
    ON cl.id_cliente = per.id_persona
ORDER BY p.precio DESC
LIMIT 5;