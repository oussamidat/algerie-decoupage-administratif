-- Requêtes d'exemple

-- 1. Les communes d'une wilaya (2026), dans l'ordre du code généré
SELECT "CdCommune_Gen_2026", "LbCommune", "LbDaira"
FROM immo.communes_algerie_global
WHERE "CdWilaya_2026" = '68'
ORDER BY "CdCommune_Gen_2026";

-- 2. Table de passage 2019 -> 2026 (wilayas modifiées)
SELECT DISTINCT "CdWilaya_2019", "LbWilaya_2019", "CdWilaya_2026", "LbWilaya_2026"
FROM immo.communes_algerie_global
WHERE "CdWilaya_2019" <> "CdWilaya_2026"
ORDER BY 1, 3;

-- 3. Communes ayant changé de wilaya entre 1984 et 2019 (Grand Alger et wilayas 49 à 58)
SELECT "LbCommune", "LbWilaya_1984", "LbWilaya_2019"
FROM immo.communes_algerie_global
WHERE "CdWilaya_1984" <> "CdWilaya_2019"
ORDER BY "CdWilaya_2019", "LbCommune";

-- 4. Commune contenant un point (longitude, latitude)
SELECT "LbCommune", "LbDaira", "LbWilaya_2026"
FROM immo.communes_algerie_global
WHERE ST_Contains(geom, ST_SetSRID(ST_MakePoint(3.0588, 36.7538), 4326));

-- 5. Noms non encore confirmés par un JO
SELECT "LbWilaya_2026", "LbCommune"
FROM immo.communes_algerie_global
WHERE "SrcLbCommune" = 'non vérifié au JO'
ORDER BY 1, 2;

-- 6. Reconstruire une couche de wilayas à partir des communes
--    (ST_MakeValid évite les erreurs de topologie lors de la fusion)
INSERT INTO immo."Wilaya_2026" (geom, "CdWilaya_2026", "LbWilaya_2026")
SELECT ST_Multi(ST_CollectionExtract(ST_MakeValid(ST_Union(geom)), 3)),
       "CdWilaya_2026", "LbWilaya_2026"
FROM immo.communes_algerie_global
GROUP BY "CdWilaya_2026", "LbWilaya_2026";

-- 7. Daïras à cheval sur plusieurs wilayas 2026
SELECT "LbDaira", "LbChefLieuDaira", array_agg(DISTINCT "CdWilaya_2026") AS wilayas
FROM immo.communes_algerie_global
GROUP BY "LbDaira", "LbChefLieuDaira"
HAVING count(DISTINCT "CdWilaya_2026") > 1;

-- 8. Superficie des wilayas en km² (calcul géodésique)
SELECT "CdWilaya_2026", "LbWilaya_2026",
       round((ST_Area(geom::geography) / 1e6)::numeric, 0) AS superficie_km2
FROM immo."Wilaya_2026"
ORDER BY superficie_km2 DESC;
