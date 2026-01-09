DROP TABLE IF EXISTS atlas.t_mailles_territoire;

-- MV for having only meshs of the territory
CREATE TABLE atlas.t_mailles_territoire
AS SELECT
st_transform(c.geom, 4326) AS the_geom,
st_asgeojson(st_transform(c.geom, 4326)) AS geojson_maille,
c.id_area AS id_maille
FROM ref_geo.l_areas c
JOIN ref_geo.bib_areas_types t ON t.id_type = c.id_type
JOIN atlas.t_layer_territoire mt ON ST_intersects(c.geom,st_transform(mt.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
WHERE c.enable = true AND t.type_code = :type_maille;

CREATE UNIQUE INDEX t_mailles_territoire_id_maille_idx ON atlas.t_mailles_territoire USING btree (id_maille);


DROP TABLE IF EXISTS atlas.t_mailles_territoire_com;
-- toutes les com enable (ca prends aussi la com Mer Mediterranée)
CREATE TABLE atlas.t_mailles_territoire_com
AS SELECT
st_transform(c.geom, 4326) AS the_geom,
st_asgeojson(st_transform(c.geom, 4326)) AS geojson_maille,
c.id_area AS id_maille
FROM ref_geo.l_areas c
JOIN ref_geo.bib_areas_types t ON t.id_type = c.id_type
--JOIN atlas.t_layer_territoire mt ON ST_intersects(c.geom,st_transform(mt.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
-- JOIN ref_geo.l_areas reg ON ST_intersects(c.geom,st_transform(reg.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
WHERE c.enable = true AND t.type_code = 'COM';

CREATE UNIQUE INDEX t_mailles_territoire_com_id_maille_idx ON atlas.t_mailles_territoire_com USING btree (id_maille);


DROP TABLE IF EXISTS atlas.t_mailles_territoire_dep;
-- tous les dep enable (ca prends aussi le dep Mer Mediterranée)
CREATE TABLE atlas.t_mailles_territoire_dep
AS SELECT
st_transform(c.geom, 4326) AS the_geom,
st_asgeojson(st_transform(c.geom, 4326)) AS geojson_maille,
c.id_area AS id_maille
FROM ref_geo.l_areas c
JOIN ref_geo.bib_areas_types t ON t.id_type = c.id_type
--JOIN atlas.t_layer_territoire mt ON ST_intersects(c.geom,st_transform(mt.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
-- JOIN ref_geo.l_areas reg ON ST_intersects(c.geom,st_transform(reg.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
WHERE c.enable = true AND t.type_code = 'DEP';

CREATE UNIQUE INDEX t_mailles_territoire_dep_id_maille_idx ON atlas.t_mailles_territoire_dep USING btree (id_maille);


DROP TABLE IF EXISTS atlas.t_mailles_territoire_m10;
-- toutes les m10 enable (Attention penser à activer les M10 de la mer)
CREATE TABLE atlas.t_mailles_territoire_m10
AS SELECT
st_transform(c.geom, 4326) AS the_geom,
st_asgeojson(st_transform(c.geom, 4326)) AS geojson_maille,
c.id_area AS id_maille
FROM ref_geo.l_areas c
JOIN ref_geo.bib_areas_types t ON t.id_type = c.id_type
--JOIN atlas.t_layer_territoire mt ON ST_intersects(c.geom,st_transform(mt.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
-- JOIN ref_geo.l_areas reg ON ST_intersects(c.geom,st_transform(reg.the_geom, find_srid('ref_geo', 'l_areas', 'geom')))
WHERE c.enable = true AND t.type_code = 'M10';

CREATE UNIQUE INDEX t_mailles_territoire_m10_id_maille_idx ON atlas.t_mailles_territoire_m10 USING btree (id_maille);

