--Tous les taxons ayant au moins une observation

CREATE FOREIGN TABLE taxonomie.bdc_statut_occitanie_pour_atlas (
	id int4 NULL,
	cd_nom int4 NULL,
	cd_ref int4 NULL,
	rq_statut varchar(1000) NULL,
	cd_type_statut varchar(50) NULL,
	lb_type_statut varchar(250) NULL,
	code_statut varchar(50) NULL,
	label_statut varchar(250) NULL,
	lb_adm_tr varchar(250) NULL,
	full_citation text NULL,
	doc_url text NULL
)
SERVER geonaturedbserver
OPTIONS (schema_name 'jerome', table_name 'bdc_statut_occitanie_pour_atlas');


-- atlas.vm_taxons source

CREATE MATERIALIZED VIEW atlas.vm_taxons
TABLESPACE pg_default
AS WITH obs_min_taxons AS (
         SELECT vm_observations.cd_ref,
            min(date_part('year'::text, vm_observations.dateobs)) AS yearmin,
            max(date_part('year'::text, vm_observations.dateobs)) AS yearmax,
            count(vm_observations.id_observation) AS nb_obs
           FROM atlas.vm_observations
          GROUP BY vm_observations.cd_ref
        ), tx_ref AS (
         SELECT tx_1.cd_ref,
            tx_1.regne,
            tx_1.phylum,
            tx_1.classe,
            tx_1.ordre,
            tx_1.famille,
            tx_1.cd_taxsup,
            tx_1.lb_nom,
            tx_1.lb_auteur,
            tx_1.nom_complet,
            tx_1.nom_valide,
            tx_1.nom_vern,
            tx_1.nom_vern_eng,
            tx_1.group1_inpn,
            tx_1.group2_inpn,
            tx_1.nom_complet_html,
            tx_1.id_rang
           FROM atlas.vm_taxref tx_1
          WHERE (tx_1.cd_ref IN ( SELECT obs_min_taxons.cd_ref
                   FROM obs_min_taxons)) AND tx_1.cd_nom = tx_1.cd_ref
        ), my_taxons AS (
         SELECT DISTINCT ON (n.cd_ref) n.cd_ref,
                CASE
                    WHEN pat.id IS NOT NULL THEN 'oui'::text
                    ELSE NULL::text
                END AS patrimonial,
                CASE
                    WHEN pr.id IS NOT NULL THEN 'oui'::text
                    ELSE NULL::text
                END AS protection_stricte,
                CASE
                    WHEN lrm.id IS NOT NULL THEN lrm.code_statut
                    ELSE NULL::character varying
                END AS badge_lrm,
                CASE
                    WHEN lrm.id IS NOT NULL THEN lrm.full_citation
                    ELSE NULL::text
                END AS badge_lrm_citation,
                CASE
                    WHEN lrm.id IS NOT NULL THEN lrm.doc_url
                    ELSE NULL::text
                END AS badge_lrm_url,
                CASE
                    WHEN lre.id IS NOT NULL THEN lre.code_statut
                    ELSE NULL::character varying
                END AS badge_lre,
                CASE
                    WHEN lre.id IS NOT NULL THEN lre.full_citation
                    ELSE NULL::text
                END AS badge_lre_citation,
                CASE
                    WHEN lre.id IS NOT NULL THEN lre.doc_url
                    ELSE NULL::text
                END AS badge_lre_url,
                CASE
                    WHEN lrn.id IS NOT NULL THEN lrn.code_statut
                    ELSE NULL::character varying
                END AS badge_lrn,
                CASE
                    WHEN lrn.id IS NOT NULL THEN lrn.full_citation
                    ELSE NULL::text
                END AS badge_lrn_citation,
                CASE
                    WHEN lrn.id IS NOT NULL THEN lrn.doc_url
                    ELSE NULL::text
                END AS badge_lrn_url,
                CASE
                    WHEN lrr.id IS NOT NULL THEN lrr.code_statut
                    ELSE NULL::character varying
                END AS badge_lrr,
                CASE
                    WHEN lrr.id IS NOT NULL THEN lrr.full_citation
                    ELSE NULL::text
                END AS badge_lrr_citation,
                CASE
                    WHEN lrr.id IS NOT NULL THEN lrr.doc_url
                    ELSE NULL::text
                END AS badge_lrr_url
           FROM tx_ref n
             LEFT JOIN taxonomie.bdc_statut_occitanie_pour_atlas pat ON pat.cd_ref = n.cd_ref AND pat.cd_type_statut::text = 'ZDET'::text
             LEFT JOIN taxonomie.bdc_statut_occitanie_pour_atlas pr ON pr.cd_ref = n.cd_ref AND pr.cd_type_statut::text = 'PN'::text
             LEFT JOIN taxonomie.bdc_statut_occitanie_pour_atlas lrm ON lrm.cd_ref = n.cd_ref AND lrm.cd_type_statut::text = 'LRM'::text AND lrm.code_statut::text <> 'NA'::text
             LEFT JOIN taxonomie.bdc_statut_occitanie_pour_atlas lre ON lre.cd_ref = n.cd_ref AND lre.cd_type_statut::text = 'LRE'::text AND lre.code_statut::text <> 'NA'::text
             LEFT JOIN taxonomie.bdc_statut_occitanie_pour_atlas lrn ON lrn.cd_ref = n.cd_ref AND lrn.cd_type_statut::text = 'LRN'::text AND lrn.code_statut::text <> 'NA'::text
             LEFT JOIN taxonomie.bdc_statut_occitanie_pour_atlas lrr ON lrr.cd_ref = n.cd_ref AND lrr.cd_type_statut::text = 'LRR'::text AND lrr.code_statut::text <> 'NA'::text
          WHERE (n.cd_ref IN ( SELECT obs_min_taxons.cd_ref
                   FROM obs_min_taxons))
        ), filtre_doublons_zdet AS (
         SELECT zdet_1.cd_ref,
                CASE
                    WHEN zdet_1.rq_statut::text ~~* '%Déterminant Zone Sud-Ouest%'::text OR zdet_1.rq_statut::text ~~* '%Déterminant Zone Sud-Ouest%'::text OR zdet_1.rq_statut::text ~~* '%Déterminant Massif Central%'::text OR zdet_1.rq_statut::text ~~* '%Déterminant Pyrénées%'::text OR zdet_1.rq_statut::text ~~* '%Déterminant Zone Méditerranéenne%'::text OR zdet_1.rq_statut::text ~~* '%Espèce uniquement déterminante pour la zone géographique dite%'::text THEN zdet_1.rq_statut
                    ELSE 'Région Occitanie'::character varying
                END AS z_zone,
            max(zdet_1.full_citation) AS full_citation
           FROM taxonomie.bdc_statut_occitanie_pour_atlas zdet_1
          WHERE zdet_1.cd_type_statut::text = 'ZDET'::text
          GROUP BY zdet_1.cd_ref, zdet_1.rq_statut
        ), my_taxons_zdet AS (
         SELECT n.cd_ref,
                CASE
                    WHEN string_agg(zdet_1.z_zone::text, '  '::text) ~~* '%Région Occitanie%'::text THEN 'REGION'::text
                    ELSE 'ZONE'::text
                END AS badge_zdet,
                CASE
                    WHEN string_agg(zdet_1.z_zone::text, '  '::text) ~~* '%Région Occitanie%'::text THEN 'Région Occitanie'::text
                    ELSE string_agg(zdet_1.z_zone::text, '  '::text)
                END AS badge_zdet_citation,
            max(zdet_1.full_citation) AS badge_zdet_url
           FROM tx_ref n
             JOIN filtre_doublons_zdet zdet_1 ON zdet_1.cd_ref = n.cd_ref
          WHERE (n.cd_ref IN ( SELECT obs_min_taxons.cd_ref
                   FROM obs_min_taxons))
          GROUP BY n.cd_ref
        ), my_taxons_eee AS (
         SELECT n.cd_ref,
            'EEE'::text AS badge_eee,
            'https://eee-occitanie.org/'::text AS badge_eee_citation,
            concat('https://dashboards.cen-occitanie.org/public/dashboards/yrNjrLrq0GKJjVlXh7R4c6S6UPUN93MMyd99rxMs?org_slug=default&p_espece=', n.cd_ref) AS badge_eee_url
           FROM tx_ref n
          WHERE (n.cd_ref IN ( SELECT obs_min_taxons.cd_ref
                   FROM obs_min_taxons)) AND (n.cd_ref = ANY (ARRAY[601183, 61667, 162667, 162668, 363942, 961323, 2775, 373662, 984366, 534642, 529979, 2776, 794752, 779482, 647694, 162669, 246191, 67220, 844327, 28726, 444425, 815842, 61448, 69346, 345311, 243063, 779457, 200254, 837379, 639933, 911606, 269178, 837382, 62462, 2747, 544505, 819808, 199209, 241893, 954937, 848626, 162902, 67817, 163293, 972128, 641319, 225132, 459626, 2731, 67277, 369111, 249412, 244606, 67210, 235060, 235061, 235062, 222519, 930604, 552627, 360765, 163433, 538593, 247327, 239096, 306432, 67246, 12928, 782405, 350548, 61025, 983403, 712145, 790708, 225, 64629, 701921, 712230, 853999, 2823, 379588, 1478, 3448, 199194, 593184, 2750, 645061, 199188, 60822, 68827, 366400, 424218, 828737, 239261, 242240, 647679, 459325, 199869, 67275, 927434, 221735, 236057, 369759, 69338, 529517, 459644, 219492, 8290, 61697, 67286, 67304, 374348, 219464, 247078, 256975, 530330, 234932, 2702, 720069, 234123, 67415, 224041, 243328, 223107, 853681, 726070, 646056, 707069, 432938, 442064, 458766, 543954, 219402, 60746, 932824, 61028, 312885, 375954, 375955, 163459, 783812, 14651, 837225, 60582, 837059, 239236, 714610, 823078, 244224, 67804, 236066, 66783, 1014245, 727311, 67208, 273055, 67571, 240724, 647654, 245573, 241926, 384673, 244704, 837522, 647582, 234671, 223593, 221594, 444443, 223142, 223595, 62131, 240955, 240958, 17658, 235192, 67420, 328478, 239137, 239138, 444457, 67812, 67819, 69372, 236067, 67585, 163426, 241107, 372804, 372808, 69041, 3000, 77428, 77424, 378264, 783806, 433589, 242359, 911079, 223106, 79265]))
          GROUP BY n.cd_ref
        )
 SELECT tx.cd_ref,
    tx.regne,
    tx.phylum,
    tx.classe,
    tx.ordre,
    tx.famille,
    tx.cd_taxsup,
    tx.lb_nom,
    tx.lb_auteur,
    tx.nom_complet,
    tx.nom_valide,
    tx.nom_vern,
    tx.nom_vern_eng,
    tx.group1_inpn,
    tx.group2_inpn,
    tx.nom_complet_html,
    tx.id_rang,
    t.patrimonial,
    t.protection_stricte,
    t.badge_lrm,
    t.badge_lrm_citation,
    COALESCE(t.badge_lrm_url, concat('https://inpn.mnhn.fr/espece/cd_nom/', tx.cd_ref, '/tab/statut')) AS badge_lrm_url,
    t.badge_lre,
    t.badge_lre_citation,
    COALESCE(t.badge_lre_url, concat('https://inpn.mnhn.fr/espece/cd_nom/', tx.cd_ref, '/tab/statut')) AS badge_lre_url,
    t.badge_lrn,
    t.badge_lrn_citation,
    COALESCE(t.badge_lrn_url, concat('https://inpn.mnhn.fr/espece/cd_nom/', tx.cd_ref, '/tab/statut')) AS badge_lrn_url,
    t.badge_lrr,
    t.badge_lrr_citation,
    COALESCE(t.badge_lrr_url, concat('https://inpn.mnhn.fr/espece/cd_nom/', tx.cd_ref, '/tab/statut')) AS badge_lrr_url,
    zdet.badge_zdet,
    zdet.badge_zdet_citation,
    zdet.badge_zdet_url,
    eee.badge_eee,
    eee.badge_eee_citation,
    eee.badge_eee_url,
    omt.yearmin,
    omt.yearmax,
    omt.nb_obs
   FROM tx_ref tx
     LEFT JOIN obs_min_taxons omt ON omt.cd_ref = tx.cd_ref
     LEFT JOIN my_taxons t ON t.cd_ref = tx.cd_ref
     LEFT JOIN my_taxons_zdet zdet ON zdet.cd_ref = tx.cd_ref
     LEFT JOIN my_taxons_eee eee ON eee.cd_ref = tx.cd_ref
WITH DATA;

-- View indexes:
CREATE UNIQUE INDEX vm_taxons_cd_ref_idx ON atlas.vm_taxons USING btree (cd_ref);
