# -*- coding:utf-8 -*-
from flask import current_app
from sqlalchemy.sql import text

from atlas.modeles import utils
from atlas.modeles.entities.tBibTaxrefRang import TBibTaxrefRang
from atlas.modeles.entities.vmTaxref import VmTaxref


def searchEspece(connection, cd_ref):
    """
    recherche l espece corespondant au cd_nom et tout ces fils
    """
    query = """
    WITH limit_obs AS (
        SELECT
            :cdRef AS cd_ref,
            MIN(yearmin) AS yearmin,
            MAX(yearmax) AS yearmax,
            SUM(nb_obs) AS nb_obs
        FROM atlas.vm_taxons
        WHERE cd_ref IN (SELECT * FROM atlas.find_all_taxons_childs(:cdRef))
            OR cd_ref = :cdRef
    )
    SELECT taxref.*,
        l.cd_ref, l.yearmin, l.yearmax, COALESCE(l.nb_obs, 0) AS nb_obs,
        t2.patrimonial, t2.protection_stricte,
        t2.badge_lrm,t2.badge_lrm_citation,t2.badge_lrm_url,
        t2.badge_lre,t2.badge_lre_citation,t2.badge_lre_url,
        t2.badge_lrn,t2.badge_lrn_citation,t2.badge_lrn_url,
        t2.badge_lrr,t2.badge_lrr_citation,t2.badge_lrr_url,
        t2.badge_zdet,t2.badge_zdet_citation,t2.badge_zdet_url,
        t2.badge_eee,t2.badge_eee_citation,t2.badge_eee_url
    FROM atlas.vm_taxref taxref
    JOIN limit_obs l
    ON l.cd_ref = taxref.cd_nom
    LEFT JOIN atlas.vm_taxons t2
    ON t2.cd_ref = taxref.cd_ref
    WHERE taxref.cd_nom = :cdRef
    """
    results = connection.execute(text(query), {"cdRef": cd_ref})
    taxonSearch = dict()
    for r in results:
        nom_vern = None
        if r.nom_vern:
            nom_vern = (
                r.nom_vern.split(",")[0] if current_app.config["SPLIT_NOM_VERN"] else r.nom_vern
            )
        taxonSearch = {
            "cd_ref": r.cd_ref,
            "lb_nom": r.lb_nom,
            "nom_vern": nom_vern,
            "lb_auteur": r.lb_auteur,
            "nom_complet_html": r.nom_complet_html,
            "group1_inpn": utils.deleteAccent(r.group1_inpn),
            "group2_inpn": utils.deleteAccent(r.group2_inpn),
            "groupAccent": r.group2_inpn,
            "yearmin": r.yearmin,
            "yearmax": r.yearmax,
            "nb_obs": r.nb_obs,
            "patrimonial": r.patrimonial,
            "protection": r.protection_stricte,
            "lrm": r.badge_lrm,
            "lrm_citation": r.badge_lrm_citation,
            "lrm_url": r.badge_lrm_url,
            "lre": r.badge_lre,
            "lre_citation": r.badge_lre_citation,
            "lre_url": r.badge_lre_url,
            "lrn": r.badge_lrn,
            "lrn_citation": r.badge_lrn_citation,
            "lrn_url": r.badge_lrn_url,
            "lrr": r.badge_lrr,
            "lrr_citation": r.badge_lrr_citation,
            "lrr_url": r.badge_lrr_url,
            "zdet": r.badge_zdet,
            "zdet_citation": r.badge_zdet_citation,
            "zdet_url": r.badge_zdet_url,
            "eee": r.badge_eee,
            "eee_citation": r.badge_eee_citation,
            "eee_url": r.badge_eee_url
        }

    query = """
        SELECT
            tax.lb_nom,
            tax.nom_vern,
            tax.cd_ref,
            br.tri_rang,
            tax.group1_inpn,
            tax.group2_inpn,
            tax.patrimonial,
            tax.protection_stricte,
            tax.badge_lrm,
            tax.badge_lre,
            tax.badge_lrn,
            tax.badge_lrr,
            tax.badge_zdet,
            tax.badge_eee,
            tax.nb_obs
        FROM atlas.vm_taxons AS tax
            JOIN atlas.bib_taxref_rangs AS br
                ON br.id_rang = tax.id_rang
        WHERE tax.cd_ref IN (
            SELECT * FROM atlas.find_all_taxons_childs(:cdRef)
        )
        ORDER BY tax.lb_nom ASC, tax.nb_obs DESC
    """
    results = connection.execute(text(query), {"cdRef": cd_ref})
    listTaxonsChild = list()
    for r in results:
        temp = {
            "lb_nom": r.lb_nom,
            "nom_vern": r.nom_vern,
            "cd_ref": r.cd_ref,
            "tri_rang": r.tri_rang,
            "group1_inpn": utils.deleteAccent(r.group1_inpn),
            "group2_inpn": utils.deleteAccent(r.group2_inpn),
            "patrimonial": r.patrimonial,
            "nb_obs": r.nb_obs,
            "protection": r.protection_stricte,
            "lrm":r.badge_lrm,
            "lre":r.badge_lre,
            "lrn":r.badge_lrn,
            "lrr":r.badge_lrr,
            "zdet":r.badge_zdet,
            "eee":r.badge_eee,
        }
        listTaxonsChild.append(temp)

    return {"taxonSearch": taxonSearch, "listTaxonsChild": listTaxonsChild}


def getSynonymy(connection, cd_ref):
    sql = """
        SELECT nom_complet_html, lb_nom
        FROM atlas.vm_taxref
        WHERE cd_ref = :thiscdref
        ORDER BY lb_nom ASC
    """
    req = connection.execute(text(sql), {"thiscdref": cd_ref})
    tabSyn = list()
    for r in req:
        temp = {"lb_nom": r.lb_nom, "nom_complet_html": r.nom_complet_html}
        tabSyn.append(temp)
    return tabSyn


def getTaxon(session, cd_nom):
    return (
        session.query(
            VmTaxref.lb_nom,
            VmTaxref.id_rang,
            VmTaxref.cd_ref,
            VmTaxref.cd_taxsup,
            TBibTaxrefRang.nom_rang,
            TBibTaxrefRang.tri_rang,
        )
        .join(TBibTaxrefRang, TBibTaxrefRang.id_rang == VmTaxref.id_rang)
        .filter(VmTaxref.cd_nom == cd_nom)
        .one_or_none()
    )


def getCd_sup(session, cd_ref):
    req = session.query(VmTaxref.cd_taxsup).filter(VmTaxref.cd_nom == cd_ref).first()
    return req.cd_taxsup


def getInfoFromCd_ref(session, cd_ref):
    req = (
        session.query(VmTaxref.lb_nom, TBibTaxrefRang.nom_rang)
        .join(TBibTaxrefRang, TBibTaxrefRang.id_rang == VmTaxref.id_rang)
        .filter(VmTaxref.cd_ref == cd_ref)
    )

    return {"lb_nom": req[0].lb_nom, "nom_rang": req[0].nom_rang}


def getAllTaxonomy(session, cd_ref):
    taxonSup = getCd_sup(session, cd_ref)  # cd_taxsup
    taxon = getTaxon(session, taxonSup)
    tabTaxon = list()
    while taxon and taxon.tri_rang >= current_app.config["LIMIT_RANG_TAXONOMIQUE_HIERARCHIE"]:
        temp = {
            "rang": taxon.id_rang,
            "lb_nom": taxon.lb_nom,
            "cd_ref": taxon.cd_ref,
            "nom_rang": taxon.nom_rang,
            "tri_rang": taxon.tri_rang,
        }
        tabTaxon.insert(0, temp)
        taxon = getTaxon(session, taxon.cd_taxsup)  # on avance
    return tabTaxon


def get_cd_ref(connection, cd_nom):
    sql = """
        SELECT cd_ref
        FROM atlas.vm_taxref AS t
        WHERE t.cd_nom = :cdNom
    """
    results = connection.execute(text(sql), {"cdNom": cd_nom})
    row = results.fetchone()
    return row.cd_ref
