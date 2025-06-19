-- Nombre d'observations par decades pour chaque taxon observé

CREATE MATERIALIZED VIEW atlas.vm_decades
AS WITH _01_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '1'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision AND date_part('day'::text, vm_observations.dateobs) > '1'::double precision
          GROUP BY vm_observations.cd_ref
        ), _01_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '1'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _01_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '1'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _02_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '2'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _02_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '2'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _02_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '2'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _03_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '3'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _03_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '3'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _03_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '3'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _04_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '4'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _04_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '4'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _04_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '4'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _05_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '5'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _05_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '5'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _05_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '5'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _06_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '6'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _06_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '6'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _06_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '6'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _07_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '7'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _07_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '7'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _07_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '7'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _08_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '8'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _08_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '8'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _08_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '8'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _09_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '9'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _09_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '9'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _09_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '9'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _10_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '10'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _10_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '10'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _10_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '10'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _11_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _11_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '11'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _11_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '11'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _12_1 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '12'::double precision AND date_part('day'::text, vm_observations.dateobs) < '11'::double precision
          GROUP BY vm_observations.cd_ref
        ), _12_2 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '12'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '11'::double precision AND date_part('day'::text, vm_observations.dateobs) < '21'::double precision
          GROUP BY vm_observations.cd_ref
        ), _12_3 AS (
         SELECT vm_observations.cd_ref,
            count(*) AS nb
           FROM atlas.vm_observations
          WHERE date_part('month'::text, vm_observations.dateobs) = '12'::double precision AND date_part('day'::text, vm_observations.dateobs) >= '21'::double precision AND date_part('day'::text, vm_observations.dateobs) < '31'::double precision
          GROUP BY vm_observations.cd_ref
        )
 SELECT DISTINCT o.cd_ref,
    COALESCE(a1.nb::integer, 0) AS _01_1,
    COALESCE(a2.nb::integer, 0) AS _01_2,
    COALESCE(a3.nb::integer, 0) AS _01_3,
    COALESCE(b1.nb::integer, 0) AS _02_1,
    COALESCE(b2.nb::integer, 0) AS _02_2,
    COALESCE(b3.nb::integer, 0) AS _02_3,
    COALESCE(c1.nb::integer, 0) AS _03_1,
    COALESCE(c2.nb::integer, 0) AS _03_2,
    COALESCE(c3.nb::integer, 0) AS _03_3,
    COALESCE(d1.nb::integer, 0) AS _04_1,
    COALESCE(d2.nb::integer, 0) AS _04_2,
    COALESCE(d3.nb::integer, 0) AS _04_3,
    COALESCE(e1.nb::integer, 0) AS _05_1,
    COALESCE(e2.nb::integer, 0) AS _05_2,
    COALESCE(e3.nb::integer, 0) AS _05_3,
    COALESCE(f1.nb::integer, 0) AS _06_1,
    COALESCE(f2.nb::integer, 0) AS _06_2,
    COALESCE(f3.nb::integer, 0) AS _06_3,
    COALESCE(g1.nb::integer, 0) AS _07_1,
    COALESCE(g2.nb::integer, 0) AS _07_2,
    COALESCE(g3.nb::integer, 0) AS _07_3,
    COALESCE(h1.nb::integer, 0) AS _08_1,
    COALESCE(h2.nb::integer, 0) AS _08_2,
    COALESCE(h3.nb::integer, 0) AS _08_3,
    COALESCE(i1.nb::integer, 0) AS _09_1,
    COALESCE(i2.nb::integer, 0) AS _09_2,
    COALESCE(i3.nb::integer, 0) AS _09_3,
    COALESCE(j1.nb::integer, 0) AS _10_1,
    COALESCE(j2.nb::integer, 0) AS _10_2,
    COALESCE(j3.nb::integer, 0) AS _10_3,
    COALESCE(k1.nb::integer, 0) AS _11_1,
    COALESCE(k2.nb::integer, 0) AS _11_2,
    COALESCE(k3.nb::integer, 0) AS _11_3,
    COALESCE(l1.nb::integer, 0) AS _12_1,
    COALESCE(l2.nb::integer, 0) AS _12_2,
    COALESCE(l3.nb::integer, 0) AS _12_3
   FROM atlas.vm_observations o
     LEFT JOIN _01_1 a1 ON a1.cd_ref = o.cd_ref
     LEFT JOIN _01_2 a2 ON a2.cd_ref = o.cd_ref
     LEFT JOIN _01_3 a3 ON a3.cd_ref = o.cd_ref
     LEFT JOIN _02_1 b1 ON b1.cd_ref = o.cd_ref
     LEFT JOIN _02_2 b2 ON b2.cd_ref = o.cd_ref
     LEFT JOIN _02_3 b3 ON b3.cd_ref = o.cd_ref
     LEFT JOIN _03_1 c1 ON c1.cd_ref = o.cd_ref
     LEFT JOIN _03_2 c2 ON c2.cd_ref = o.cd_ref
     LEFT JOIN _03_3 c3 ON c3.cd_ref = o.cd_ref
     LEFT JOIN _04_1 d1 ON d1.cd_ref = o.cd_ref
     LEFT JOIN _04_2 d2 ON d2.cd_ref = o.cd_ref
     LEFT JOIN _04_3 d3 ON d3.cd_ref = o.cd_ref
     LEFT JOIN _05_1 e1 ON e1.cd_ref = o.cd_ref
     LEFT JOIN _05_2 e2 ON e2.cd_ref = o.cd_ref
     LEFT JOIN _05_3 e3 ON e3.cd_ref = o.cd_ref
     LEFT JOIN _06_1 f1 ON f1.cd_ref = o.cd_ref
     LEFT JOIN _06_2 f2 ON f2.cd_ref = o.cd_ref
     LEFT JOIN _06_3 f3 ON f3.cd_ref = o.cd_ref
     LEFT JOIN _07_1 g1 ON g1.cd_ref = o.cd_ref
     LEFT JOIN _07_2 g2 ON g2.cd_ref = o.cd_ref
     LEFT JOIN _07_3 g3 ON g3.cd_ref = o.cd_ref
     LEFT JOIN _08_1 h1 ON h1.cd_ref = o.cd_ref
     LEFT JOIN _08_2 h2 ON h2.cd_ref = o.cd_ref
     LEFT JOIN _08_3 h3 ON h3.cd_ref = o.cd_ref
     LEFT JOIN _09_1 i1 ON i1.cd_ref = o.cd_ref
     LEFT JOIN _09_2 i2 ON i2.cd_ref = o.cd_ref
     LEFT JOIN _09_3 i3 ON i3.cd_ref = o.cd_ref
     LEFT JOIN _10_1 j1 ON j1.cd_ref = o.cd_ref
     LEFT JOIN _10_2 j2 ON j2.cd_ref = o.cd_ref
     LEFT JOIN _10_3 j3 ON j3.cd_ref = o.cd_ref
     LEFT JOIN _11_1 k1 ON k1.cd_ref = o.cd_ref
     LEFT JOIN _11_2 k2 ON k2.cd_ref = o.cd_ref
     LEFT JOIN _11_3 k3 ON k3.cd_ref = o.cd_ref
     LEFT JOIN _12_1 l1 ON l1.cd_ref = o.cd_ref
     LEFT JOIN _12_2 l2 ON l2.cd_ref = o.cd_ref
     LEFT JOIN _12_3 l3 ON l3.cd_ref = o.cd_ref
  WHERE o.cd_ref IS NOT NULL
  ORDER BY o.cd_ref
WITH DATA;

-- View indexes:
CREATE UNIQUE INDEX vm_decades_cd_ref_idx ON atlas.vm_decades USING btree (cd_ref);
    