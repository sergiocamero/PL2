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

EXPLAIN SELECT* FROM Proyectos 
INNER JOIN trabaja_proyectos on proyectos.numero_proyecto= trabaja_proyectos.numero_proyecto_Proyectos 
INNER JOIN Empleados on empleados.numero_empleado=trabaja_proyecto.numero_empleado_Empleado 
WHERE coste>10000 and salario=24000 and horas<3

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


-- object: public.bultos | type: TABLE --
-- DROP TABLE IF EXISTS public.bultos CASCADE;
CREATE TABLE public.bultos (
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
ALTER TABLE public.bultos OWNER TO postgres;
-- ddl-end --

-- object: public.vehiculos | type: TABLE --
-- DROP TABLE IF EXISTS public.vehiculos CASCADE;
CREATE TABLE public.vehiculos (
	matricula char(7) NOT NULL,
	marca text NOT NULL,
	modelo text NOT NULL,
	kilometros integer NOT NULL,
	fecha_matricula date NOT NULL,
	"DNI_conductores" char(9),
	CONSTRAINT vehiculos_pk PRIMARY KEY (matricula)
);
-- ddl-end --
ALTER TABLE public.vehiculos OWNER TO postgres;
-- ddl-end --

-- object: public.empresas | type: TABLE --
-- DROP TABLE IF EXISTS public.empresas CASCADE;
CREATE TABLE public.empresas (
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
ALTER TABLE public.empresas OWNER TO postgres;
-- ddl-end --

-- object: public.conductores | type: TABLE --
-- DROP TABLE IF EXISTS public.conductores CASCADE;
CREATE TABLE public.conductores (
	"DNI" char(9) NOT NULL,
	nombre text NOT NULL,
	fecha_contrato date NOT NULL,
	telefono integer NOT NULL,
	salario real NOT NULL,
	"CIF_empresas" char(9),
	CONSTRAINT conductores_pk PRIMARY KEY ("DNI")
);
-- ddl-end --
ALTER TABLE public.conductores OWNER TO postgres;
-- ddl-end --

-- object: public.clientes | type: TABLE --
-- DROP TABLE IF EXISTS public.clientes CASCADE;
CREATE TABLE public.clientes (
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
ALTER TABLE public.clientes OWNER TO postgres;
-- ddl-end --

-- object: vehiculos_fk | type: CONSTRAINT --
-- ALTER TABLE public.bultos DROP CONSTRAINT IF EXISTS vehiculos_fk CASCADE;
ALTER TABLE public.bultos ADD CONSTRAINT vehiculos_fk FOREIGN KEY (matricula_vehiculos)
REFERENCES public.vehiculos (matricula) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: clientes_fk | type: CONSTRAINT --
-- ALTER TABLE public.bultos DROP CONSTRAINT IF EXISTS clientes_fk CASCADE;
ALTER TABLE public.bultos ADD CONSTRAINT clientes_fk FOREIGN KEY (id_cliente_clientes)
REFERENCES public.clientes (id_cliente) MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: empresas_fk | type: CONSTRAINT --
-- ALTER TABLE public.conductores DROP CONSTRAINT IF EXISTS empresas_fk CASCADE;
ALTER TABLE public.conductores ADD CONSTRAINT empresas_fk FOREIGN KEY ("CIF_empresas")
REFERENCES public.empresas ("CIF") MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --

-- object: conductores_fk | type: CONSTRAINT --
-- ALTER TABLE public.vehiculos DROP CONSTRAINT IF EXISTS conductores_fk CASCADE;
ALTER TABLE public.vehiculos ADD CONSTRAINT conductores_fk FOREIGN KEY ("DNI_conductores")
REFERENCES public.conductores ("DNI") MATCH FULL
ON DELETE RESTRICT ON UPDATE RESTRICT;
-- ddl-end --


