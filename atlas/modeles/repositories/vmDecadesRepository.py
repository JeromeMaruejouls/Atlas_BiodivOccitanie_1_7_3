# -*- coding:utf-8 -*-

from sqlalchemy.sql import text


def getDecadelyObservationsChilds(connection, cd_ref):
    sql = """
    SELECT
        SUM(_01_1) AS _01_1, SUM(_01_2) AS _01_2, SUM(_01_3) AS _01_3,
        SUM(_02_1) AS _02_1, SUM(_02_2) AS _02_2, SUM(_02_3) AS _02_3, 
        SUM(_03_1) AS _03_1, SUM(_03_2) AS _03_2, SUM(_03_3) AS _03_3, 
        SUM(_04_1) AS _04_1, SUM(_04_2) AS _04_2, SUM(_04_3) AS _04_3, 
        SUM(_05_1) AS _05_1, SUM(_05_2) AS _05_2, SUM(_05_3) AS _05_3, 
        SUM(_06_1) AS _06_1, SUM(_06_2) AS _06_2, SUM(_06_3) AS _06_3, 
        SUM(_07_1) AS _07_1, SUM(_07_2) AS _07_2, SUM(_07_3) AS _07_3, 
        SUM(_08_1) AS _08_1, SUM(_08_2) AS _08_2, SUM(_08_3) AS _08_3, 
        SUM(_09_1) AS _09_1, SUM(_09_2) AS _09_2, SUM(_09_3) AS _09_3, 
        SUM(_10_1) AS _10_1, SUM(_10_2) AS _10_2, SUM(_10_3) AS _10_3, 
        SUM(_11_1) AS _11_1, SUM(_11_2) AS _11_2, SUM(_11_3) AS _11_3, 
        SUM(_12_1) AS _12_1, SUM(_12_2) AS _12_2, SUM(_12_3) AS _12_3 
    FROM atlas.vm_decades decades
    WHERE decades.cd_ref IN (
            SELECT * FROM atlas.find_all_taxons_childs(:thiscdref)
        )
        OR decades.cd_ref = :thiscdref
    """


    mesDecades = connection.execute(text(sql), thiscdref=cd_ref)
    for inter in mesDecades:
        return [
            {"decades": "Janvier 1", "value": inter._01_1},
            {"decades": "Janvier 2", "value": inter._01_2},
            {"decades": "Janvier 3", "value": inter._01_3},
            {"decades": "Fevrier 1", "value": inter._02_1},
            {"decades": "Fevrier 2", "value": inter._02_2},
            {"decades": "Fevrier 3", "value": inter._02_3},
            {"decades": "Mars 1", "value": inter._03_1},
            {"decades": "Mars 2", "value": inter._03_2},
            {"decades": "Mars 3", "value": inter._03_3},
            {"decades": "Avril 1", "value": inter._04_1},
            {"decades": "Avril 2", "value": inter._04_2},
            {"decades": "Avril 3", "value": inter._04_3},
            {"decades": "Mai 1", "value": inter._05_1},
            {"decades": "Mai 2", "value": inter._05_2},
            {"decades": "Mai 3", "value": inter._05_3},
            {"decades": "Juin 1", "value": inter._06_1},
            {"decades": "Juin 2", "value": inter._06_2},
            {"decades": "Juin 3", "value": inter._06_3},
            {"decades": "Juillet 1", "value": inter._07_1},
            {"decades": "Juillet 2", "value": inter._07_2},
            {"decades": "Juillet 3", "value": inter._07_3},
            {"decades": "Aout 1", "value": inter._08_1},
            {"decades": "Aout 2", "value": inter._08_2},
            {"decades": "Aout 3", "value": inter._08_3},
            {"decades": "Septembre 1", "value": inter._09_1},
            {"decades": "Septembre 2", "value": inter._09_2},
            {"decades": "Septembre 3", "value": inter._09_3},
            {"decades": "Octobre 1", "value": inter._10_1},
            {"decades": "Octobre 2", "value": inter._10_2},
            {"decades": "Octobre 3", "value": inter._10_3},
            {"decades": "Novembre 1", "value": inter._11_1},
            {"decades": "Novembre 2", "value": inter._11_2},
            {"decades": "Novembre 3", "value": inter._11_3},
            {"decades": "Decembre 1", "value": inter._12_1},
            {"decades": "Decembre 2", "value": inter._12_2},
            {"decades": "Decembre 3", "value": inter._12_3}
        ]

