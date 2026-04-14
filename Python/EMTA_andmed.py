# Jooksutamiseks aktiveeri myenv: source ~/myenv/bin/activate
# Streamliti käivitamiseks: streamlit run streamlit_emta.py
# Streamliti seiskamiseks: control + c
# myenv seiskamiseks: deactivate

import streamlit as st
import pandas as pd
import duckdb

import matplotlib.pyplot as plt
import seaborn as sns

st.write("# Ettevõtluse statistika maakondade lõikes")

data = pd.read_csv("emta_data.csv")

# st.write(data.head(5))

with st.container(border=True):
    st.write("Vali periood:")
    col1, col2 = st.columns(2)
    # aasta: str = st.select_slider("Aasta", options=sorted(data["aasta"].unique(), reverse=True))
    with col1:
        aasta = st.selectbox("Aasta", options=sorted(data["aasta"].unique(), reverse=True))
    with col2:
        kvartal = st.selectbox(
            "Kvartal",
            options=duckdb.sql(f"SELECT DISTINCT kvartal FROM data WHERE aasta = {aasta} ORDER BY kvartal")
        )

maakond: str = st.selectbox("Maakond", options=data["maakond"].unique())
# maakond: str = st.multiselect("Maakond", options=data["maakond"].unique())
# maakond = st.selectbox("KOV", options=data["kov"].unique())

st.write(duckdb.sql(f"""
    SELECT
        kov,
        count(DISTINCT registrikood) AS ettevotete_arv,
        round(avg(kaive) / 3)::int AS keskmine_kuine_kaive,
        round(avg(kaive))::int AS keskmine_kvartaalne_kaive
    FROM data
    WHERE aasta = {aasta} AND kvartal = {kvartal} AND maakond = '{maakond}'
    GROUP BY kov
    ORDER BY keskmine_kuine_kaive DESC
""").df())

count_by_county = duckdb.sql(f"""
    SELECT
        maakond,
        count(DISTINCT registrikood) AS ettevotete_arv
    FROM data
    WHERE
        aasta = {aasta}
        AND kvartal = {kvartal}
        AND maakond = '{maakond}'
        AND maakond IS NOT NULL
    GROUP BY maakond
    ORDER BY ettevotete_arv DESC
""").df()

tab1, tab2 = st.tabs(["Graafik", "Tabel"])
tab1.bar_chart(count_by_county, x="maakond", y="ettevotete_arv", horizontal=True, sort="-ettevotete_arv")
tab2.dataframe(count_by_county)

fig = plt.figure(figsize=(10,4))
ax = sns.barplot(count_by_county, y="maakond", x="ettevotete_arv")
ax.set_title("Tegutsevate ettevõtete arv maakondade lõikes")
st.pyplot(fig)

kaive_by_aasta = duckdb.sql(f"""
    SELECT
        aasta,
        sum(kaive) AS aastane_kaive
    FROM data
    WHERE
        aasta = {aasta}
        AND kvartal = {kvartal}
        AND maakond = '{maakond}'
    GROUP BY aasta
""").df()

tab1, tab2 = st.tabs(["Chart", "Dataframe"])
tab1.line_chart(kaive_by_aasta, x="aasta", y="aastane_kaive", height=500)
tab2.dataframe(kaive_by_aasta, height=250, use_container_width=True)