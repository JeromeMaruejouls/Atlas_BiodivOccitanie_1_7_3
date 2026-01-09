
CREATE MATERIALIZED VIEW atlas.vm_observations_mailles
AS WITH tmp_com AS (
         SELECT obs_1.id_observation,
            com.id_maille,
            com.geojson_maille
           FROM atlas.vm_observations obs_1
             JOIN atlas.t_mailles_territoire_com com ON st_intersects(obs_1.the_geom_point, com.the_geom)
          WHERE obs_1.diffusion_level = 1
        ), tmp_m10 AS (
         SELECT obs_1.id_observation,
            m10.id_maille,
            m10.geojson_maille
           FROM atlas.vm_observations obs_1
             JOIN atlas.t_mailles_territoire_m10 m10 ON st_intersects(obs_1.the_geom_point, m10.the_geom)
          WHERE obs_1.diffusion_level = 2
        ), tmp_dep AS (
         SELECT obs_1.id_observation,
            dep.id_maille,
            dep.geojson_maille
           FROM atlas.vm_observations obs_1
             JOIN atlas.t_mailles_territoire_dep dep ON st_intersects(obs_1.the_geom_point, dep.the_geom)
          WHERE obs_1.diffusion_level = 3
        ), tmp_m5 AS (
         SELECT obs_1.id_observation,
            m5.id_maille,
            m5.geojson_maille
           FROM atlas.vm_observations obs_1
             JOIN atlas.t_mailles_territoire m5 ON st_intersects(obs_1.the_geom_point, m5.the_geom)
          WHERE obs_1.diffusion_level = 0
        )
 SELECT obs.cd_ref,
    obs.id_observation,
    obs.diffusion_level,
        CASE
            WHEN obs.diffusion_level = 1 THEN tmp_com.id_maille
            WHEN obs.diffusion_level = 2 THEN tmp_m10.id_maille
            WHEN obs.diffusion_level = 3 THEN tmp_dep.id_maille
            ELSE tmp_m5.id_maille
        END AS id_maille,
        CASE
            WHEN obs.diffusion_level = 1 THEN tmp_com.geojson_maille
            WHEN obs.diffusion_level = 2 THEN tmp_m10.geojson_maille
            WHEN obs.diffusion_level = 3 THEN tmp_dep.geojson_maille
            ELSE tmp_m5.geojson_maille
        END AS geojson_maille,
    date_part('year'::text, obs.dateobs) AS annee
   FROM atlas.vm_observations obs
     LEFT JOIN tmp_m5 ON obs.id_observation = tmp_m5.id_observation
     LEFT JOIN tmp_m10 ON obs.id_observation = tmp_m10.id_observation
     LEFT JOIN tmp_com ON obs.id_observation = tmp_com.id_observation
     LEFT JOIN tmp_dep ON obs.id_observation = tmp_dep.id_observation
WITH DATA;

-- View indexes:
CREATE INDEX vm_observations_mailles_cd_ref_idx ON atlas.vm_observations_mailles USING btree (cd_ref);
CREATE INDEX vm_observations_mailles_id_maille_idx ON atlas.vm_observations_mailles USING btree (id_maille);
CREATE UNIQUE INDEX vm_observations_mailles_id_observation_idx ON atlas.vm_observations_mailles USING btree (id_observation);
 
