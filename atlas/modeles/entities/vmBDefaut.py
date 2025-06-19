# coding: utf-8
from sqlalchemy import Column, Integer, MetaData, Table
from sqlalchemy.ext.declarative import declarative_base

from atlas.env import db

metadata = MetaData()
Base = declarative_base()


class VmBDefaut(Base):
    __table__ = Table(
        'vm_bdefaut',
        metadata,
        Column('cd_ref', Integer, primary_key=True, unique=True),
        Column('I-A', Integer),
        Column('I-B', Integer),
        Column('II-A', Integer),
        Column('II-B', Integer),
        Column('III-A', Integer),
        Column('III-B', Integer),
        Column('IV-A', Integer),
        Column('IV-B', Integer),
        Column('V-A', Integer),
        Column('V-B', Integer),
        Column('V-C', Integer),
        Column('V-D', Integer),
        schema='atlas',
        autoload=True,
        autoload_with=db.engine
    )
