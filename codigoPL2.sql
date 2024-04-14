CREATE DATABASE proyectos_empresa;

psql -h localhost -d proyectos_empresa -U postgres -p 5432

CREATE TABLE empleados (
    numero_empleado NUMERIC PRIMARY KEY,
    nombre TEXT,
    apellidos TEXT,
    salario NUMERIC
);

-- Crear la tabla proyectos
CREATE TABLE proyectos (
    numero_proyecto NUMERIC PRIMARY KEY,
    nombre TEXT,
    localizacion TEXT,
    coste NUMERIC
);

-- Crear la tabla trabaja_proyectos
CREATE TABLE trabaja_proyectos (
    numero_empleado NUMERIC,
    numero_proyecto NUMERIC,
    horas NUMERIC,
    PRIMARY KEY (numero_empleado, numero_proyecto),
    FOREIGN KEY (numero_empleado) REFERENCES empleados(numero_empleado) ON DELETE RESTRICT,
    FOREIGN KEY (numero_proyecto) REFERENCES proyectos(numero_proyecto) ON DELETE RESTRICT
);

/*Cuestion 4*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EXPLAIN SELECT * FROM empleados WHERE  salario>96000;
Select count (*) from empleados;
Select count (distinct salario) from empleados;
Select count (distinct salario) from empleados where salario>96000;

/*Cuestion 5*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

EXPLAIN SELECT * FROM trabaja_proyectos WHERE  horas=8;
Select count (*) from trabaja_proyectos;
Select count (distinct horas) from trabaja_proyectos;
Select count (distinct horas) from trabaja_proyectos where horas=8;

/*Cuestion 6*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

SELECT * FROM proyectos 
INNER JOIN trabaja_proyectos ON proyectos.numero_proyecto = trabaja_proyectos.numero_proyecto
INNER JOIN empleados ON empleados.numero_empleado = trabaja_proyectos.numero_empleado 
WHERE coste > 10000 AND salario = 24000 AND horas < 3;

Select count (*) from trabaja_proyectos;
Select count (*) from proyectos;
SELECT COUNT(DISTINCT numero_proyecto) AS total_valores_diferentes FROM trabaja_proyectos;
SELECT COUNT(DISTINCT numero_proyecto) AS total_valores_diferentes FROM proyectos;

Select count (*) from trabaja_proyectos;
Select count (*) from empleados;
SELECT COUNT(DISTINCT numero_empleado) AS total_valores_diferentes FROM trabaja_proyectos;
SELECT COUNT(DISTINCT numero_empleado) AS total_valores_diferentes FROM empleados;


SELECT COUNT(DISTINCT salario) AS total_valores_diferentes FROM empleados WHERE salario=24000;
SELECT COUNT(DISTINCT coste) AS total_valores_diferentes FROM Proyectos WHERE coste>10000;
SELECT COUNT(DISTINCT horas) AS total_valores_diferentes FROM trabaja_proyectos WHERE horas<3;

/*Cuestion 7*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: new_database | type: DATABASE --
-- DROP DATABASE IF EXISTS new_database;
CREATE DATABASE new_database;
-- ddl-end --


-- object: bultos | type: TABLE --
-- DROP TABLE IF EXISTS bultos CASCADE;
CREATE TABLE bultos (
	id_bulto integer NOT NULL,
	direccion_origen text NOT NULL,
	direccion_destino text NOT NULL,
	provincia_origen text NOT NULL,
	provincia_destino text NOT NULL,
	peso real NOT NULL,
	fecha_salida date NOT NULL,
	fecha_llegada date NOT NULL,
	matricula_vehiculos char(7),
	id_cliente_clientes integer,
	CONSTRAINT bultos_pk PRIMARY KEY (id_bulto)
);
-- ddl-end --
ALTER TABLE bultos OWNER TO postgres;
-- ddl-end --

-- object: vehiculos | type: TABLE --
-- DROP TABLE IF EXISTS vehiculos CASCADE;
CREATE TABLE vehiculos (
	matricula char(7) NOT NULL,
	marca text NOT NULL,
	modelo text NOT NULL,
	kilometros integer NOT NULL,
	fecha_matricula date NOT NULL,
	"DNI_conductores" char(9),
	CONSTRAINT vehiculos_pk PRIMARY KEY (matricula)
);
-- ddl-end --
ALTER TABLE vehiculos OWNER TO postgres;
-- ddl-end --

-- object: empresas | type: TABLE --
-- DROP TABLE IF EXISTS empresas CASCADE;
CREATE TABLE empresas (
	"CIF" char(9) NOT NULL,
	nombre text NOT NULL,
	direccion text NOT NULL,
	"Provincia" text NOT NULL,
	email text NOT NULL,
	telefono integer NOT NULL,
	CONSTRAINT email_unique UNIQUE (email),
	CONSTRAINT telefono_unique UNIQUE (telefono),
	CONSTRAINT emresas_pk PRIMARY KEY ("CIF")
);
-- ddl-end --
ALTER TABLE empresas OWNER TO postgres;
-- ddl-end --

-- object: conductores | type: TABLE --
-- DROP TABLE IF EXISTS conductores CASCADE;
CREATE TABLE conductores (
	"DNI" char(9) NOT NULL,
	nombre text NOT NULL,
	fecha_contrato date NOT NULL,
	telefono integer NOT NULL,
	salario real NOT NULL,
	"CIF_empresas" char(9),
	CONSTRAINT conductores_pk PRIMARY KEY ("DNI")
);
-- ddl-end --
ALTER TABLE conductores OWNER TO postgres;
-- ddl-end --

-- object: clientes | type: TABLE --
-- DROP TABLE IF EXISTS clientes CASCADE;
CREATE TABLE clientes (
	id_cliente integer NOT NULL,
	nombre text NOT NULL,
	direccion text NOT NULL,
	provincia text NOT NULL,
	email text NOT NULL,
	telefono integer NOT NULL,
	CONSTRAINT telefono_cliente_unique UNIQUE (email),
	CONSTRAINT email_cliente_unique UNIQUE (email),
	CONSTRAINT clientes_pk PRIMARY KEY (id_cliente)
);
-- ddl-end --
ALTER TABLE clientes OWNER TO postgres;
-- ddl-end --

-- object: vehiculos_fk | type: CONSTRAINT --
-- ALTER TABLE bultos DROP CONSTRAINT IF EXISTS vehiculos_fk CASCADE;
ALTER TABLE bultos ADD CONSTRAINT vehiculos_fk FOREIGN KEY (matricula_vehiculos)
REFERENCES vehiculos (matricula) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: clientes_fk | type: CONSTRAINT --
-- ALTER TABLE bultos DROP CONSTRAINT IF EXISTS clientes_fk CASCADE;
ALTER TABLE bultos ADD CONSTRAINT clientes_fk FOREIGN KEY (id_cliente_clientes)
REFERENCES clientes (id_cliente) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: empresas_fk | type: CONSTRAINT --
-- ALTER TABLE conductores DROP CONSTRAINT IF EXISTS empresas_fk CASCADE;
ALTER TABLE conductores ADD CONSTRAINT empresas_fk FOREIGN KEY ("CIF_empresas")
REFERENCES empresas ("CIF") MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: conductores_fk | type: CONSTRAINT --
-- ALTER TABLE vehiculos DROP CONSTRAINT IF EXISTS conductores_fk CASCADE;
ALTER TABLE vehiculos ADD CONSTRAINT conductores_fk FOREIGN KEY ("DNI_conductores")
REFERENCES conductores ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

\COPY Camiones FROM "D:\\GISI\\2º\\BASES DE DATOS AVANZADAS\\LABORATORIO\\registros_camiones.txt" DELIMITER ',' CSV;

CREATE DATABASE Logistica;	
psql -h localhost -d Logistica -U postgres -p 5432;

/*CUESTION 8*/

-- Cargar datos de Empresas
\copy empresas("CIF", nombre, direccion, "Provincia", email, telefono) FROM "D:\\GISI\\2º\\BASES DE DATOS AVANZADAS\\LABORATORIO\\archivo_empresas.txt" DELIMITER ';' CSV;

-- Cargar datos de Conductores
\copy conductores("DNI", nombre, fecha_contrato, telefono, salario, "CIF_empresas") FROM "D:\\GISI\\2º\\BASES DE DATOS AVANZADAS\\LABORATORIO\\archivo_conductores.txt" DELIMITER ';' CSV;

-- Cargar datos de Clientes
\copy clientes(id_cliente, nombre, direccion, provincia, email, telefono) FROM "D:\\GISI\\2º\\BASES DE DATOS AVANZADAS\\LABORATORIO\\archivo_clientes.txt" DELIMITER ';' CSV;

-- Cargar datos de Vehículos
\copy vehiculos(matricula, marca, modelo, kilometros, fecha_matricula, "DNI_conductores") FROM "D:\\GISI\\2º\\BASES DE DATOS AVANZADAS\\LABORATORIO\\archivo_vehiculos.txt" DELIMITER ';' CSV;

-- Cargar datos de Bultos
\copy bultos(id_bulto, direccion_origen, direccion_destino, provincia_origen, provincia_destino, peso, fecha_salida, fecha_llegada, matricula_vehiculos, id_cliente_clientes) FROM "D:\\GISI\\2º\\BASES DE DATOS AVANZADAS\\LABORATORIO\\archivo_bultos.txt" DELIMITER ';' CSV;

/*CUESTION 9*/

SELECT 
    (COUNT(*) FILTER (WHERE peso > 5 
    AND (vehiculos.kilometros > 60000 OR conductores.salario > 26000)
    AND empresas.Provincia != 'Castilla La Mancha'
    AND fecha_llegada - fecha_salida > 5)
     * 100.0 / COUNT(*)) AS bultosSuperados
FROM 
    bultos
JOIN 
    vehiculos ON bultos.matricula_vehiculos = vehiculos.matricula
JOIN 
    conductores ON vehiculos.DNI_conductores = conductores.DNI
JOIN 
    empresas ON conductores.CIF_empresas = empresas.CIF;


/*CUESTION 10*/
-- Agregar índices: Para mejorar el rendimiento de las cláusulas WHERE y JOIN, 

CREATE INDEX idx_peso ON bultos (peso);
CREATE INDEX idx_kilometros ON vehiculos (kilometros);
CREATE INDEX idx_salario ON conductores (salario);
CREATE INDEX idx_provincia ON empresas (provincia);

 
-- Ejecutar EXPLAIN ANALYZE: Para obtener el plan de ejecución de la consulta después de realizar las mejoras. 

EXPLAIN ANALYZE
SELECT 
    (COUNT(*) FILTER (WHERE peso > 5 
    AND (vehiculos.kilometros > 60000 OR conductores.salario > 26000)
    AND empresas.Provincia != 'Castilla La Mancha'
    AND fecha_llegada - fecha_salida > 5)
     * 100.0 / COUNT(*)) AS bultosSuperados
FROM 
    bultos
JOIN 
    vehiculos ON bultos.matricula_vehiculos = vehiculos.matricula
JOIN 
    conductores ON vehiculos.DNI_conductores = conductores.DNI
JOIN 
    empresas ON conductores.CIF_empresas = empresas.CIF;

/*CUESTION 11*/

-- El numero de empresas que representan el 30%
SELECT COUNT(*) * 0.3 AS num_to_delete FROM empresas;

-- Utilizar una consulta para seleccionar aleatoriamente el 30% de las empresas y sus datos relacionados para el borrado.

DELETE FROM empresas
WHERE id_empresas IN (
    SELECT id_empresas
    FROM empresas
    ORDER BY random()
    LIMIT (
        SELECT COUNT(*) * 0.3
        FROM empresas
    )
);

-- Para medir el tiempo empleado en el borrado, utilizamos la función EXPLAIN ANALYZE:

EXPLAIN ANALYZE
DELETE FROM empresas
WHERE id_empresas IN (
    SELECT id_empresas
    FROM empresas
    ORDER BY random()
    LIMIT (
        SELECT COUNT(*) * 0.3
        FROM empresas
    )
);

/*CUESTION 12*/

-- Volvemos a ejecutar la consulta 
SELECT 
    (COUNT(*) FILTER (WHERE peso > 5 
    AND (vehiculos.kilometros > 60000 OR conductores.salario > 26000)
    AND empresas.Provincia != 'Castilla La Mancha'
    AND fecha_llegada - fecha_salida > 5)
     * 100.0 / COUNT(*)) AS bultosSuperados
FROM 
    bultos
JOIN 
    vehiculos ON bultos.matricula_vehiculos = vehiculos.matricula
JOIN 
    conductores ON vehiculos.DNI_conductores = conductores.DNI
JOIN 
    empresas ON conductores.CIF_empresas = empresas.CIF;
-- Realizamos el EXPLAIN de nuevo 
EXPLAIN SELECT 
    (COUNT(*) FILTER (WHERE peso > 5 
    AND (vehiculos.kilometros > 60000 OR conductores.salario > 26000)
    AND empresas.Provincia != 'Castilla La Mancha'
    AND fecha_llegada - fecha_salida > 5)
     * 100.0 / COUNT(*)) AS bultosSuperados
FROM 
    bultos
JOIN 
    vehiculos ON bultos.matricula_vehiculos = vehiculos.matricula
JOIN 
    conductores ON vehiculos.DNI_conductores = conductores.DNI
JOIN 
    empresas ON conductores.CIF_empresas = empresas.CIF;

-- Al comparar el plan de ejecución obtenido con el comando EXPLAIN después de realizar las mejoras de la cuestion 10, 
-- observamos que el plan de ejecución se ha optimizado después de agregar los índices, 
-- lo que implica un tiempo de ejecución más rápido y un uso más eficiente de los recursos del sistema.

/*CUESTION 13*/
