-- Schéma PostgreSQL / PostGIS
-- Découpage administratif de l'Algérie (1984, 2019, 2026)

CREATE SCHEMA IF NOT EXISTS immo;

-- Communes : couche principale -------------------------------------------
CREATE TABLE immo.communes_algerie_global (
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	"oid" int8 NULL,
	"IdCommune" varchar NULL,
	"CdCommune" varchar NULL,
	"CdCommune_Gen_1984" varchar NULL,
	"CdCommune_Gen_2019" varchar NULL,
	"CdCommune_Gen_2026" varchar NULL,
	"LbCommune" varchar NULL,
	"SrcLbCommune" varchar NULL,
	"LbCommune_AR" varchar NULL,
	"LbDaira_1991" varchar NULL,
	"LbChefLieuDaira_1991" varchar NULL,
	"LbDaira" varchar NULL,
	"LbDaira_AR" varchar NULL,
	"LbChefLieuDaira" varchar NULL,
	"CdWilaya_1984" varchar NULL,
	"LbWilaya_1984" varchar NULL,
	"CdWilaya_2019" varchar NULL,
	"LbWilaya_2019" varchar NULL,
	"CdWilaya_2026" varchar NULL,
	"LbWilaya_2026" varchar NULL,
	CONSTRAINT communes_algerie_global_pkey PRIMARY KEY (id)
);
CREATE INDEX sidx_communes_algerie_global_geom ON immo.communes_algerie_global USING gist (geom);

COMMENT ON COLUMN immo.communes_algerie_global."CdCommune" IS 'Réservé au code officiel ONS (vide)';
COMMENT ON COLUMN immo.communes_algerie_global."CdCommune_Gen_2026" IS 'Code généré WWDDCC, non officiel (voir docs/CdCommune_Gen.md)';
COMMENT ON COLUMN immo.communes_algerie_global."SrcLbCommune" IS 'Texte du JO confirmant le nom, ou « non vérifié au JO »';
COMMENT ON COLUMN immo.communes_algerie_global."LbDaira" IS 'Daïra actuelle, source non officielle';
COMMENT ON COLUMN immo.communes_algerie_global."LbDaira_1991" IS 'Daïra selon le décret 91-306';

-- Wilayas ------------------------------------------------------------------
CREATE TABLE immo."Wilaya_1984" (
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	"CdWilaya_1984" varchar NULL,
	"LbWilaya_1984" varchar NULL,
	CONSTRAINT "Wilaya_1984_pkey" PRIMARY KEY (id)
);
CREATE INDEX "sidx_Wilaya_1984_geom" ON immo."Wilaya_1984" USING gist (geom);

CREATE TABLE immo."Wilaya_2019" (
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	"CdWilaya_2019" varchar NULL,
	"LbWilaya_2019" varchar NULL,
	CONSTRAINT "Wilaya_2019_pkey" PRIMARY KEY (id)
);
CREATE INDEX "sidx_Wilaya_2019_geom" ON immo."Wilaya_2019" USING gist (geom);

CREATE TABLE immo."Wilaya_2026" (
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	"CdWilaya_2026" varchar NULL,
	"LbWilaya_2026" varchar NULL,
	CONSTRAINT "Wilaya_2026_pkey" PRIMARY KEY (id)
);
CREATE INDEX "sidx_Wilaya_2026_geom" ON immo."Wilaya_2026" USING gist (geom);

-- Daïras actuelles -----------------------------------------------------------
CREATE TABLE immo."Daira_2026" (
	id serial4 NOT NULL,
	geom public.geometry(multipolygon, 4326) NULL,
	"LbDaira" varchar NULL,
	"LbDaira_AR" varchar NULL,
	"LbChefLieuDaira" varchar NULL,
	"CdWilaya_1984" varchar NULL,
	"LbWilaya_1984" varchar NULL,
	"CdWilaya_2019" varchar NULL,
	"LbWilaya_2019" varchar NULL,
	"CdWilaya_2026" varchar NULL,
	"LbWilaya_2026" varchar NULL,
	CONSTRAINT "Daira_2026_pkey" PRIMARY KEY (id)
);
CREATE INDEX "sidx_Daira_2026_geom" ON immo."Daira_2026" USING gist (geom);
