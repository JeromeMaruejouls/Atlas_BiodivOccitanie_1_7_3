-- Creation d'une vue permettant de reproduire le contenu de la table du même nom dans les versions précédentes


-- synthese.vm_cor_synthese_area source : on crée cette VM qui sera ensuite utilisé dans la nouvelle version de syntheseff
CREATE MATERIALIZED VIEW synthese.vm_cor_synthese_area
TABLESPACE pg_default
AS SELECT DISTINCT ON (sa.id_synthese, t.type_code) sa.id_synthese,
    sa.id_area,
    st_transform(a.centroid, 4326) AS centroid_4326,
    t.type_code,
    a.area_code
   FROM synthese.cor_area_synthese sa
     JOIN ref_geo.l_areas a ON sa.id_area = a.id_area
     JOIN ref_geo.bib_areas_types t ON a.id_type = t.id_type
  WHERE t.type_code::text = 'M10'::text OR t.type_code::text = 'COM'::text AND (substr(a.area_code::text, 1, 2) = ANY (ARRAY['09'::text, '11'::text, '12'::text, '30'::text, '31'::text, '32'::text, '34'::text, '46'::text, '48'::text, '65'::text, '66'::text, '81'::text, '82'::text, '99'::text])) OR t.type_code::text = 'DEP'::text AND (a.area_code::text = ANY (ARRAY['09'::character varying::text, '11'::character varying::text, '12'::character varying::text, '30'::character varying::text, '31'::character varying::text, '32'::character varying::text, '34'::character varying::text, '46'::character varying::text, '48'::character varying::text, '65'::character varying::text, '66'::character varying::text, '81'::character varying::text, '82'::character varying::text, '99'::character varying::text]))
WITH DATA;

-- View indexes:
CREATE UNIQUE INDEX vm_cor_synthese_area_id_synthese_id_area_idx ON synthese.vm_cor_synthese_area USING btree (id_synthese, id_area);
CREATE INDEX vm_cor_synthese_area_type_code_idx ON synthese.vm_cor_synthese_area USING btree (type_code);


-- Avant On crée cette fonction qui sera utilisé dans syntheseff
CREATE OR REPLACE FUNCTION atlas.get_blurring_centroid_geom_by_code(code character varying, idsynthese integer)
 RETURNS geometry
 LANGUAGE plpgsql
 IMMUTABLE
AS $function$
	-- Function which return the centroid for a sensitivity or diffusion_level code and a synthese id
	DECLARE centroid geometry;

	BEGIN
		SELECT INTO centroid csa.centroid_4326
		FROM synthese.vm_cor_synthese_area AS csa
		WHERE csa.id_synthese = idSynthese
			AND csa.type_code = (CASE WHEN code = '1' THEN 'COM' WHEN code = '2' THEN 'M10' WHEN code = '3' THEN 'DEP' END)
		LIMIT 1 ;

		RETURN centroid ;
	END;
$function$
;

CREATE VIEW synthese.syntheseff 
AS SELECT s.id_synthese, 
    s.id_dataset, 
    s.cd_nom, 
    s.date_min AS dateobs, 
    s.observers AS observateurs, 
    (s.altitude_min + s.altitude_max) / 2 AS altitude_retenue, 
        CASE 
            WHEN s.id_nomenclature_sensitivity IS NOT NULL AND s.id_nomenclature_diffusion_level IS NOT NULL THEN 
            CASE 
                WHEN dl.cd_nomenclature::integer > sens.cd_nomenclature::integer AND dl.cd_nomenclature::integer >= 1 AND dl.cd_nomenclature::integer <= 3 THEN atlas.get_blurring_centroid_geom_by_code(dl.cd_nomenclature, s.id_synthese) 
                WHEN sens.cd_nomenclature::integer >= dl.cd_nomenclature::integer AND sens.cd_nomenclature::integer >= 1 AND sens.cd_nomenclature::integer <= 3 THEN atlas.get_blurring_centroid_geom_by_code(sens.cd_nomenclature, s.id_synthese) 
                ELSE s.the_geom_point 
            END 
            WHEN s.id_nomenclature_sensitivity IS NULL AND s.id_nomenclature_diffusion_level IS NULL THEN s.the_geom_point 
            WHEN s.id_nomenclature_sensitivity IS NULL AND s.id_nomenclature_diffusion_level IS NOT NULL THEN 
            CASE 
                WHEN dl.cd_nomenclature::integer >= 1 AND dl.cd_nomenclature::integer <= 3 THEN atlas.get_blurring_centroid_geom_by_code(dl.cd_nomenclature, s.id_synthese) 
                ELSE s.the_geom_point 
            END 
            WHEN s.id_nomenclature_sensitivity IS NOT NULL AND s.id_nomenclature_diffusion_level IS NULL THEN 
            CASE 
                WHEN sens.cd_nomenclature::integer >= 1 AND sens.cd_nomenclature::integer <= 3 THEN atlas.get_blurring_centroid_geom_by_code(sens.cd_nomenclature, s.id_synthese) 
                ELSE s.the_geom_point 
            END 
            ELSE NULL::geometry 
        END AS the_geom_point, 
    s.count_min AS effectif_total, 
    areas.area_code AS insee, 
        CASE 
            WHEN dl.cd_nomenclature IS NULL THEN sens.cd_nomenclature::integer 
            ELSE dl.cd_nomenclature::integer 
        END AS diffusion_level 
   FROM synthese.synthese s 
     JOIN synthese.vm_cor_synthese_area areas ON s.id_synthese = areas.id_synthese 
     LEFT JOIN synthese.t_nomenclatures sens ON s.id_nomenclature_sensitivity = sens.id_nomenclature 
     LEFT JOIN synthese.t_nomenclatures dl ON s.id_nomenclature_diffusion_level = dl.id_nomenclature 
     LEFT JOIN synthese.t_nomenclatures st ON s.id_nomenclature_observation_status = st.id_nomenclature
     LEFT JOIN synthese.jdd_hors_biodiv dif ON dif.id_dataset = s.id_dataset
  WHERE areas.type_code::text = 'COM'::text AND (NOT dl.cd_nomenclature::text = '4'::text OR s.id_nomenclature_diffusion_level IS NULL) AND (NOT sens.cd_nomenclature::text = '4'::text OR s.id_nomenclature_sensitivity IS NULL) AND st.cd_nomenclature::text = 'Pr'::text AND s.id_nomenclature_valid_status <> 320 AND s.id_nomenclature_valid_status <> 321 AND dif.id_dataset IS NULL;
