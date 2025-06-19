# coding: utf-8
from sqlalchemy import Column, Integer, MetaData, Table
from sqlalchemy.ext.declarative import declarative_base

from atlas.env import db

metadata = MetaData()
Base = declarative_base()


class VmDecades(Base):
    __table__ = Table(
        'vm_decades',
        metadata,
        Column('cd_ref', Integer, primary_key=True, unique=True),
        Column('_01_1', Integer), Column('_01_2', Integer), Column('_01_3', Integer), 
        Column('_02_1', Integer), Column('_02_2', Integer), Column('_02_3', Integer), 
        Column('_03_1', Integer), Column('_03_2', Integer), Column('_03_3', Integer), 
        Column('_04_1', Integer), Column('_04_2', Integer), Column('_04_3', Integer), 
        Column('_05_1', Integer), Column('_05_2', Integer), Column('_05_3', Integer), 
        Column('_06_1', Integer), Column('_06_2', Integer), Column('_06_3', Integer), 
        Column('_07_1', Integer), Column('_07_2', Integer), Column('_07_3', Integer), 
        Column('_08_1', Integer), Column('_08_2', Integer), Column('_08_3', Integer), 
        Column('_09_1', Integer), Column('_09_2', Integer), Column('_09_3', Integer), 
        Column('_10_1', Integer), Column('_10_2', Integer), Column('_10_3', Integer), 
        Column('_11_1', Integer), Column('_11_2', Integer), Column('_11_3', Integer), 
        Column('_12_1', Integer), Column('_12_2', Integer), Column('_12_3', Integer), 
        schema='atlas',
        autoload=True,
        autoload_with=db.engine
    )
