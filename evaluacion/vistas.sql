-- vista precions por ciudad

create view vw_precio_propiedades_ciudad 
as 
select 
	c.nombre as ciudad,
    avg(p.precio) as precio_promedio,
    max(p.precio) as precio_maximo,
    min(p.precio) as precio_minimo
from propiedad p
join ciudad c 
on p.id_ciudad = c.id_ciudad
group by c.nombre;

select* from vw_precio_propiedades_ciudad;


-- propiedades por agente 

create view vw_agentes_propiedades as
select
	concat(per.nombre, ' ', per.apellido) as
    agente,
    p.id_propiedad,
    p.direccion,
    p.precio,
    c.nombre as ciudad
FROM agente a 
join personas per 
on a.id_agente = per.id_persona
join contrato con 
on a.id_agente = con.agente_id
join propiedad p 
on con.propiedad_id =p.id_propiedad
join ciudad c
on p.id_ciudad = c.id_ciudad;

select 
	agente,
    count(id_propiedad) as 
total_propiedades
from vw_agentes_propiedades
group by agente;

