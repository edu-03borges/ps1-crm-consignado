-- DROP SCHEMA public;

CREATE SCHEMA public AUTHORIZATION pg_database_owner;

-- DROP SEQUENCE public.adonis_schema_id_seq;

CREATE SEQUENCE public.adonis_schema_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.auth_access_tokens_id_seq;

CREATE SEQUENCE public.auth_access_tokens_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tb_campaigns_id_seq;

CREATE SEQUENCE public.tb_campaigns_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tb_info_id_seq;

CREATE SEQUENCE public.tb_info_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tb_instance_id_seq;

CREATE SEQUENCE public.tb_instance_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.tb_instances_id_seq;

CREATE SEQUENCE public.tb_instances_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE public.users_id_seq;

CREATE SEQUENCE public.users_id_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- public.adonis_schema definition

-- Drop table

-- DROP TABLE public.adonis_schema;

CREATE TABLE public.adonis_schema (
	id serial4 NOT NULL,
	"name" varchar(255) NOT NULL,
	batch int4 NOT NULL,
	migration_time timestamptz DEFAULT CURRENT_TIMESTAMP NULL,
	CONSTRAINT adonis_schema_pkey PRIMARY KEY (id)
);


-- public.adonis_schema_versions definition

-- Drop table

-- DROP TABLE public.adonis_schema_versions;

CREATE TABLE public.adonis_schema_versions (
	"version" int4 NOT NULL,
	CONSTRAINT adonis_schema_versions_pkey PRIMARY KEY (version)
);


-- public.tb_campaigns definition

-- Drop table

-- DROP TABLE public.tb_campaigns;

CREATE TABLE public.tb_campaigns (
	id serial4 NOT NULL,
	"uuid" uuid DEFAULT uuid_generate_v4() NULL,
	"name" varchar NULL,
	company varchar NULL,
	records numeric DEFAULT 0 NULL,
	status varchar DEFAULT 'PROCESSANDO'::character varying NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	file_data json NULL,
	query_data json NULL,
	records_consulted numeric DEFAULT 0 NULL,
	CONSTRAINT tb_campaigns_pk PRIMARY KEY (id)
);


-- public.tb_info definition

-- Drop table

-- DROP TABLE public.tb_info;

CREATE TABLE public.tb_info (
	id serial4 NOT NULL,
	"uuid" uuid NULL,
	created_at date DEFAULT CURRENT_DATE NULL,
	updated_at date DEFAULT CURRENT_DATE NULL,
	CONSTRAINT tb_info_pk PRIMARY KEY (id)
);


-- public.tb_instance definition

-- Drop table

-- DROP TABLE public.tb_instance;

CREATE TABLE public.tb_instance (
	id serial4 NOT NULL,
	"uuid" varchar NOT NULL,
	"name" varchar NOT NULL,
	company varchar NOT NULL,
	records int4 NOT NULL,
	status varchar NOT NULL,
	file_data varchar NOT NULL,
	query_data varchar NOT NULL,
	created_at timestamp NOT NULL,
	updated_at timestamp NOT NULL,
	CONSTRAINT tb_instance_pkey PRIMARY KEY (id),
	CONSTRAINT tb_instance_uuid_key UNIQUE (uuid)
);


-- public.tb_instances definition

-- Drop table

-- DROP TABLE public.tb_instances;

CREATE TABLE public.tb_instances (
	id serial4 NOT NULL,
	"uuid" uuid DEFAULT uuid_generate_v4() NULL,
	time_logged_in float8 DEFAULT 0 NULL,
	updated_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	created_at timestamp DEFAULT CURRENT_TIMESTAMP NULL,
	"user" varchar NULL,
	"password" varchar NULL,
	status varchar DEFAULT 'LIVRE'::character varying NULL,
	"instance" numeric NULL,
	CONSTRAINT tb_instances_pk PRIMARY KEY (id),
	CONSTRAINT tb_instances_unique UNIQUE (instance)
);


-- public.users definition

-- Drop table

-- DROP TABLE public.users;

CREATE TABLE public.users (
	id serial4 NOT NULL,
	full_name varchar(255) NULL,
	email varchar(254) NOT NULL,
	"password" varchar(255) NOT NULL,
	created_at timestamptz NOT NULL,
	updated_at timestamptz NULL,
	CONSTRAINT users_email_unique UNIQUE (email),
	CONSTRAINT users_pkey PRIMARY KEY (id)
);


-- public.auth_access_tokens definition

-- Drop table

-- DROP TABLE public.auth_access_tokens;

CREATE TABLE public.auth_access_tokens (
	id serial4 NOT NULL,
	tokenable_id int4 NOT NULL,
	"type" varchar(255) NOT NULL,
	"name" varchar(255) NULL,
	hash varchar(255) NOT NULL,
	abilities text NOT NULL,
	created_at timestamptz NULL,
	updated_at timestamptz NULL,
	last_used_at timestamptz NULL,
	expires_at timestamptz NULL,
	CONSTRAINT auth_access_tokens_pkey PRIMARY KEY (id),
	CONSTRAINT auth_access_tokens_tokenable_id_foreign FOREIGN KEY (tokenable_id) REFERENCES public.users(id) ON DELETE CASCADE
);



-- DROP FUNCTION public.uuid_generate_v1();

CREATE OR REPLACE FUNCTION public.uuid_generate_v1()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1$function$
;

-- DROP FUNCTION public.uuid_generate_v1mc();

CREATE OR REPLACE FUNCTION public.uuid_generate_v1mc()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v1mc$function$
;

-- DROP FUNCTION public.uuid_generate_v3(uuid, text);

CREATE OR REPLACE FUNCTION public.uuid_generate_v3(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v3$function$
;

-- DROP FUNCTION public.uuid_generate_v4();

CREATE OR REPLACE FUNCTION public.uuid_generate_v4()
 RETURNS uuid
 LANGUAGE c
 PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v4$function$
;

-- DROP FUNCTION public.uuid_generate_v5(uuid, text);

CREATE OR REPLACE FUNCTION public.uuid_generate_v5(namespace uuid, name text)
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_generate_v5$function$
;

-- DROP FUNCTION public.uuid_nil();

CREATE OR REPLACE FUNCTION public.uuid_nil()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_nil$function$
;

-- DROP FUNCTION public.uuid_ns_dns();

CREATE OR REPLACE FUNCTION public.uuid_ns_dns()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_dns$function$
;

-- DROP FUNCTION public.uuid_ns_oid();

CREATE OR REPLACE FUNCTION public.uuid_ns_oid()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_oid$function$
;

-- DROP FUNCTION public.uuid_ns_url();

CREATE OR REPLACE FUNCTION public.uuid_ns_url()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_url$function$
;

-- DROP FUNCTION public.uuid_ns_x500();

CREATE OR REPLACE FUNCTION public.uuid_ns_x500()
 RETURNS uuid
 LANGUAGE c
 IMMUTABLE PARALLEL SAFE STRICT
AS '$libdir/uuid-ossp', $function$uuid_ns_x500$function$
;
