--Classes d'altitudes, modifiables selon votre contexte

--DROP TABLE atlas.bib_altitudes;
CREATE TABLE atlas.bib_altitudes
(
  id_altitude integer NOT NULL,
  altitude_min integer NOT NULL,
  altitude_max integer NOT NULL,
  label_altitude character varying(255),
  CONSTRAINT bib_altitudes_pk PRIMARY KEY (id_altitude)
);

INSERT_ALTITUDE
UPDATE atlas.bib_altitudes set label_altitude = '_' || altitude_min || '_' || altitude_max+1;


-- Fonction qui permet de créer la VM contenant le nombre d'observations par classes d'altitude pour chaque taxon

-- DROP FUNCTION atlas.create_vm_altitudes();
/*
CREATE OR REPLACE FUNCTION atlas.create_vm_altitudes()
  RETURNS text AS
$BODY$
  DECLARE
    monsql text;
    mesaltitudes RECORD;

  BEGIN
    DROP MATERIALIZED VIEW IF EXISTS atlas.vm_altitudes;

    monsql = 'CREATE materialized view atlas.vm_altitudes AS WITH ';

    FOR mesaltitudes IN SELECT * FROM atlas.bib_altitudes ORDER BY id_altitude LOOP
      IF mesaltitudes.id_altitude = 1 THEN
        monsql = monsql || 'alt' || mesaltitudes.id_altitude ||' AS (SELECT cd_ref, count(*) as nb FROM atlas.vm_observations WHERE altitude_retenue <' || mesaltitudes.altitude_max || ' GROUP BY cd_ref) ';
      ELSE
        monsql = monsql || ',alt' || mesaltitudes.id_altitude ||' AS (SELECT cd_ref, count(*) as nb FROM atlas.vm_observations WHERE altitude_retenue BETWEEN ' || mesaltitudes.altitude_min || ' AND ' || mesaltitudes.altitude_max || ' GROUP BY cd_ref)';
      END IF;
    END LOOP;

    monsql = monsql || ' SELECT DISTINCT o.cd_ref';

    FOR mesaltitudes IN SELECT * FROM atlas.bib_altitudes LOOP
      monsql = monsql || ',COALESCE(a' ||mesaltitudes.id_altitude || '.nb::integer, 0) as '|| mesaltitudes.label_altitude;
    END LOOP;

    monsql = monsql || ' FROM atlas.vm_observations o';

    FOR mesaltitudes IN SELECT * FROM atlas.bib_altitudes LOOP
      monsql = monsql || ' LEFT JOIN alt' || mesaltitudes.id_altitude ||' a' || mesaltitudes.id_altitude || ' ON a' || mesaltitudes.id_altitude || '.cd_ref = o.cd_ref';
    END LOOP;

    monsql = monsql || ' WHERE o.cd_ref is not null ORDER BY o.cd_ref;';

    EXECUTE monsql;
    create unique index ON atlas.vm_altitudes (cd_ref);

    RETURN monsql;

  END;

$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

select atlas.create_vm_altitudes();
*/


CREATE MATERIALIZED VIEW atlas.vm_altitudes
AS WITH alt1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue < 199
          GROUP BY vm_observations.cd_ref
        ), alt2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 200 AND vm_observations.altitude_retenue <= 399
          GROUP BY vm_observations.cd_ref
        ), alt3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 400 AND vm_observations.altitude_retenue <= 599
          GROUP BY vm_observations.cd_ref
        ), alt4 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 600 AND vm_observations.altitude_retenue <= 799
          GROUP BY vm_observations.cd_ref
        ), alt5 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 800 AND vm_observations.altitude_retenue <= 999
          GROUP BY vm_observations.cd_ref
        ), alt6 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 1000 AND vm_observations.altitude_retenue <= 1199
          GROUP BY vm_observations.cd_ref
        ), alt7 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 1200 AND vm_observations.altitude_retenue <= 1399
          GROUP BY vm_observations.cd_ref
        ), alt8 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 1400 AND vm_observations.altitude_retenue <= 1599
          GROUP BY vm_observations.cd_ref
        ), alt9 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 1600 AND vm_observations.altitude_retenue <= 1799
          GROUP BY vm_observations.cd_ref
        ), alt10 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 1800 AND vm_observations.altitude_retenue <= 1999
          GROUP BY vm_observations.cd_ref
        ), alt11 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 2000 AND vm_observations.altitude_retenue <= 2199
          GROUP BY vm_observations.cd_ref
        ), alt12 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 2200 AND vm_observations.altitude_retenue <= 2399
          GROUP BY vm_observations.cd_ref
        ), alt13 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 2400 AND vm_observations.altitude_retenue <= 2599
          GROUP BY vm_observations.cd_ref
        ), alt14 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 2600 AND vm_observations.altitude_retenue <= 2799
          GROUP BY vm_observations.cd_ref
        ), alt15 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 2800 AND vm_observations.altitude_retenue <= 2999
          GROUP BY vm_observations.cd_ref
        ), alt16 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 3000 AND vm_observations.altitude_retenue <= 3199
          GROUP BY vm_observations.cd_ref
        ), alt17 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE vm_observations.altitude_retenue >= 3200 AND vm_observations.altitude_retenue <= 3399
          GROUP BY vm_observations.cd_ref
        )
 SELECT DISTINCT o.cd_ref,
    COALESCE(a1.nb::integer, 0) AS _0_200,
    COALESCE(a2.nb::integer, 0) AS _200_400,
    COALESCE(a3.nb::integer, 0) AS _400_600,
    COALESCE(a4.nb::integer, 0) AS _600_800,
    COALESCE(a5.nb::integer, 0) AS _800_1000,
    COALESCE(a6.nb::integer, 0) AS _1000_1200,
    COALESCE(a7.nb::integer, 0) AS _1200_1400,
    COALESCE(a8.nb::integer, 0) AS _1400_1600,
    COALESCE(a9.nb::integer, 0) AS _1600_1800,
    COALESCE(a10.nb::integer, 0) AS _1800_2000,
    COALESCE(a11.nb::integer, 0) AS _2000_2200,
    COALESCE(a12.nb::integer, 0) AS _2200_2400,
    COALESCE(a13.nb::integer, 0) AS _2400_2600,
    COALESCE(a14.nb::integer, 0) AS _2600_2800,
    COALESCE(a15.nb::integer, 0) AS _2800_3000,
    COALESCE(a16.nb::integer, 0) AS _3000_3200,
    COALESCE(a17.nb::integer, 0) AS _3200_3400
   FROM atlas.vm_observations o
     LEFT JOIN alt1 a1 ON a1.cd_ref = o.cd_ref
     LEFT JOIN alt2 a2 ON a2.cd_ref = o.cd_ref
     LEFT JOIN alt3 a3 ON a3.cd_ref = o.cd_ref
     LEFT JOIN alt4 a4 ON a4.cd_ref = o.cd_ref
     LEFT JOIN alt5 a5 ON a5.cd_ref = o.cd_ref
     LEFT JOIN alt6 a6 ON a6.cd_ref = o.cd_ref
     LEFT JOIN alt7 a7 ON a7.cd_ref = o.cd_ref
     LEFT JOIN alt8 a8 ON a8.cd_ref = o.cd_ref
     LEFT JOIN alt9 a9 ON a9.cd_ref = o.cd_ref
     LEFT JOIN alt10 a10 ON a10.cd_ref = o.cd_ref
     LEFT JOIN alt11 a11 ON a11.cd_ref = o.cd_ref
     LEFT JOIN alt12 a12 ON a12.cd_ref = o.cd_ref
     LEFT JOIN alt13 a13 ON a13.cd_ref = o.cd_ref
     LEFT JOIN alt14 a14 ON a14.cd_ref = o.cd_ref
     LEFT JOIN alt15 a15 ON a15.cd_ref = o.cd_ref
     LEFT JOIN alt16 a16 ON a16.cd_ref = o.cd_ref
     LEFT JOIN alt17 a17 ON a17.cd_ref = o.cd_ref
  WHERE o.cd_ref IS NOT NULL
  ORDER BY o.cd_ref
WITH DATA;

-- View indexes:
CREATE UNIQUE INDEX vm_altitudes_cd_ref_idx ON atlas.vm_altitudes USING btree (cd_ref);
