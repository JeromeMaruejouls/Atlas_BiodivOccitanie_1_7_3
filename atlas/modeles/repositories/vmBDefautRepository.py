# -*- coding:utf-8 -*-

from sqlalchemy.sql import text


def getBDefautObservationsChilds(connection, cd_ref):
    sql = """
    SELECT
        SUM("I-A") AS "I_A",
        SUM("I-B") AS "I_B",
        SUM("II-A") AS "II_A",
        SUM("II-B") AS "II_B",
        SUM("III-A") AS "III_A",
        SUM("III-B") AS "III_B",
        SUM("IV-A") AS "IV_A",
        SUM("IV-B") AS "IV_B",
        SUM("V-A") AS "V_A",
        SUM("V-B") AS "V_B",
        SUM("V-C") AS "V_C",
        SUM("V-D") AS "V_D"
    FROM atlas.vm_bdefaut bdefaut
    WHERE bdefaut.cd_ref IN (
            SELECT * FROM atlas.find_all_taxons_childs(:thiscdref)
        )
        OR bdefaut.cd_ref = :thiscdref
    """

    mesBDefaut = connection.execute(text(sql), thiscdref=cd_ref)
    for inter in mesBDefaut:
        return [
            {"bdefaut": "I-A", "value": inter.I_A},
            {"bdefaut": "I-B", "value": inter.I_B},
            {"bdefaut": "II-A", "value": inter.II_A},
            {"bdefaut": "II-B", "value": inter.II_B},
            {"bdefaut": "III-A", "value": inter.III_A},
            {"bdefaut": "III-B", "value": inter.III_B},
            {"bdefaut": "IV-A", "value": inter.IV_A},
            {"bdefaut": "IV-B", "value": inter.IV_B},
            {"bdefaut": "V-A", "value": inter.V_A},
            {"bdefaut": "V-B", "value": inter.V_B},
            {"bdefaut": "V-C", "value": inter.V_C},
            {"bdefaut": "V-D", "value": inter.V_D}
        ]

