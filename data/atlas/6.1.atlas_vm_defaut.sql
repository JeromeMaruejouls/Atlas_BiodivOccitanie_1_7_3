-- Nombre d'observations par zone biogéographique
-- atlas.vm_bdefaut source

CREATE MATERIALIZED VIEW atlas.vm_bdefaut
AS WITH tmp1 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'I-A'::text
          GROUP BY s.cd_ref
        ), tmp2 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'I-B'::text
          GROUP BY s.cd_ref
        ), tmp3 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'II-A'::text
          GROUP BY s.cd_ref
        ), tmp4 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'II-B'::text
          GROUP BY s.cd_ref
        ), tmp5 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'III-A'::text
          GROUP BY s.cd_ref
        ), tmp6 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'III-B'::text
          GROUP BY s.cd_ref
        ), tmp7 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'IV-A'::text
          GROUP BY s.cd_ref
        ), tmp8 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'IV-B'::text
          GROUP BY s.cd_ref
        ), tmp9 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'V-A'::text
          GROUP BY s.cd_ref
        ), tmp10 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'V-B'::text
          GROUP BY s.cd_ref
        ), tmp11 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'V-C'::text
          GROUP BY s.cd_ref
        ), tmp12 AS (
         SELECT s.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations s
             JOIN synthese.cor_area_synthese cor ON cor.id_synthese = s.id_observation
             JOIN ref_geo.l_areas area ON area.id_area = cor.id_area
          WHERE area.id_type = 38 AND area.area_code::text = 'V-D'::text
          GROUP BY s.cd_ref
        )
 SELECT DISTINCT o.cd_ref,
    COALESCE(tmp1.nb::integer, 0) AS "I-A",
    COALESCE(tmp2.nb::integer, 0) AS "I-B",
    COALESCE(tmp3.nb::integer, 0) AS "II-A",
    COALESCE(tmp4.nb::integer, 0) AS "II-B",
    COALESCE(tmp5.nb::integer, 0) AS "III-A",
    COALESCE(tmp6.nb::integer, 0) AS "III-B",
    COALESCE(tmp7.nb::integer, 0) AS "IV-A",
    COALESCE(tmp8.nb::integer, 0) AS "IV-B",
    COALESCE(tmp9.nb::integer, 0) AS "V-A",
    COALESCE(tmp10.nb::integer, 0) AS "V-B",
    COALESCE(tmp11.nb::integer, 0) AS "V-C",
    COALESCE(tmp12.nb::integer, 0) AS "V-D"
   FROM atlas.vm_observations o
     LEFT JOIN tmp1 ON tmp1.cd_ref = o.cd_ref
     LEFT JOIN tmp2 ON tmp2.cd_ref = o.cd_ref
     LEFT JOIN tmp3 ON tmp3.cd_ref = o.cd_ref
     LEFT JOIN tmp4 ON tmp4.cd_ref = o.cd_ref
     LEFT JOIN tmp5 ON tmp5.cd_ref = o.cd_ref
     LEFT JOIN tmp6 ON tmp6.cd_ref = o.cd_ref
     LEFT JOIN tmp7 ON tmp7.cd_ref = o.cd_ref
     LEFT JOIN tmp8 ON tmp8.cd_ref = o.cd_ref
     LEFT JOIN tmp9 ON tmp9.cd_ref = o.cd_ref
     LEFT JOIN tmp10 ON tmp10.cd_ref = o.cd_ref
     LEFT JOIN tmp11 ON tmp11.cd_ref = o.cd_ref
     LEFT JOIN tmp12 ON tmp12.cd_ref = o.cd_ref
  WHERE o.cd_ref IS NOT NULL
  ORDER BY o.cd_ref
WITH DATA;

-- View indexes:
CREATE UNIQUE INDEX vm_bdefaut_cd_ref_idx ON atlas.vm_bdefaut USING btree (cd_ref);
