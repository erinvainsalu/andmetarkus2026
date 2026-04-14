import streamlit as st
import pandas as pd
import duckdb

"# Palgad tööstusharude lõikes"

data = pd.read_csv("emta_data.csv")

TAX_PERCENTAGE = 0.338

salary_stats = duckdb.sql(f"""
    SELECT
        peamine_tegevusala AS "Peamine tegevusala",
        round(avg(toojoumaksud / {TAX_PERCENTAGE} / tootajate_arv / 3), 2) AS "Keskmine palk"
    FROM data
    WHERE aasta = 2026 AND kvartal = 1 AND peamine_tegevusala IS NOT NULL
    GROUP BY peamine_tegevusala
    ORDER BY "Keskmine palk" DESC
""").df()


tab1, tab2 = st.tabs(["Graafik", "Tabel"])
tab1.bar_chart(salary_stats, x="Peamine tegevusala", y="Keskmine palk", sort=False, horizontal=True)
tab2.write(salary_stats)