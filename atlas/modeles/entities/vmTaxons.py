# -*- coding:utf-8 -*-

from sqlalchemy import Column, Integer, MetaData, String, Table, Float
from sqlalchemy.ext.declarative import declarative_base

from atlas.env import db

Base = declarative_base()
metadata = MetaData()

class VmTaxons(Base):
    __tablename__ = "vm_taxons"
    __table_args__ = {"schema": "atlas"}
    cd_ref = Column("cd_ref", Integer, primary_key=True, unique=True)
    regne = Column("regne", String(20))
    phylum = Column("phylum", String(50))
    classe = Column("classe", String(50))
    ordre = Column("ordre", String(50))
    famille = Column("famille", String(50))
    cd_taxsup = Column("cd_taxsup", Integer)
    lb_nom = Column("lb_nom", String(100))
    lb_auteur = Column("lb_auteur", String(250))
    nom_complet = Column("nom_complet", String(255))
    nom_valide = Column("nom_valide", String(255))
    nom_vern = Column("nom_vern", String(1000))
    nom_vern_eng = Column("nom_vern_eng", String(500))
    group1_inpn = Column("group1_inpn", String(50))
    group2_inpn = Column("group2_inpn", String(50))
    nom_complet_html = Column("nom_complet_html", String(500))
    patrimonial = Column("patrimonial", String(255))
    protection_stricte = Column("protection_stricte", String(255))
    yearmin = Column("yearmin", Float(53))
    yearmax = Column("yearmax", Float(53))
    badge_lrm = Column("badge_lrm", String(255))
    badge_lrm_citation = Column("badge_lrm_citation", String(255))
    badge_lrm_url = Column("badge_lrm_url", String(255))
    badge_lre = Column("badge_lre", String(255))
    badge_lre_citation = Column("badge_lre_citation", String(255))
    badge_lre_url = Column("badge_lre_url", String(255))
    badge_lrn = Column("badge_lrn", String(255))
    badge_lrn_citation = Column("badge_lrn_citation", String(255))
    badge_lrn_url = Column("badge_lrn_url", String(255))
    badge_lrr = Column("badge_lrr", String(255))
    badge_lrr_citation = Column("badge_lrr_citation", String(255))
    badge_lrr_url= Column("badge_lrr_url", String(255))
    badge_zdet = Column("badge_zdet", String(20))
    badge_zdet_citation = Column("badge_zdet_citation", String(255))
    badge_zdet_url = Column("badge_zdet_url", String(255))
    badge_eee = Column("badge_eee", String(20))
    badge_eee_citation = Column("badge_eee_citation", String(255))
    badge_eee_url = Column("badge_eee_url", String(255))
