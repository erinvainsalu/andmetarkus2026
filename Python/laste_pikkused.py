
# Jooksutamiseks käsk: streamlit run streamlit_emta.py

import streamlit as st
import pandas as pd
import duckdb

st.write("# Laste pikkused")

# np.random.seed(42)
laste_pikkused = pd.DataFrame(
    {
        'kuupaev': [
            '29.11.2014',
            '01.09.2015',
            '18.03.2016',
            '25.07.2017',
            '29.11.2014',
            '29.04.2015',
            '21.03.2018',
            '31.10.2015',
            '27.10.2018',
            '05.04.2019',
            '26.05.2019',
            '25.07.2017',
            '24.10.2019',
            '27.10.2018',
            '05.04.2018',
            '26.05.2019',
            '24.10.2019',
            '21.03.2022',
            '25.03.2023',
            '04.11.2021',
            '14.01.2023'
        ],
        'nimi': [
            'Marta', 
            'Marta',
            'Marta', 
            'Marta',
            'Saskia', 
            'Saskia', 
            'Marta', 
            'Saskia',
            'Marta', 
            'Marta', 
            'Marta', 
            'Saskia', 
            'Marta', 
            'Saskia', 
            'Saskia', 
            'Saskia', 
            'Saskia', 
            'Marta', 
            'Marta', 
            'Saskia', 
            'Saskia'
        ],
        'pikkus': [
            109,
            112.5,
            121,
            129,
            130,
            132,
            135,
            137,
            140,
            143.2,
            144.5,
            147,
            148.7,
            157,
            160.8,
            163.5,
            164.6,
            162.5,
            164,
            170,
            172
        ]
    }
)

users = st.multiselect("Laps", options=laste_pikkused["nimi"].unique(), default=["Marta", "Saskia"])

if not users:
    st.warning("Vali vähemalt üks laps.")
    st.stop()

users_sql = ", ".join(f"'{u}'" for u in users)  # → 'Marta', 'Saskia'

pikkused_jarjestatud = duckdb.sql(f"""
    SELECT
        strptime(kuupaev, '%d.%m.%Y') AS kuupaev,
        CASE
            WHEN nimi = 'Saskia' THEN date_diff('year', DATE '2006-10-27', strptime(kuupaev, '%d.%m.%Y'))
            WHEN nimi = 'Marta' THEN date_diff('year', DATE '2009-03-21', strptime(kuupaev, '%d.%m.%Y'))
        END AS vanus,
        nimi,
        pikkus
    FROM laste_pikkused
    WHERE nimi IN ({users_sql})
    ORDER BY vanus
""").df()

tab1, tab2 = st.tabs(["Chart", "Dataframe"])
tab1.line_chart(pikkused_jarjestatud, x="vanus", y="pikkus", color="nimi", height=500)
tab2.dataframe(pikkused_jarjestatud, height=250, use_container_width=True)