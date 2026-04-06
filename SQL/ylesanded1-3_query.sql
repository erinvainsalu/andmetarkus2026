{\rtf1\ansi\ansicpg1252\cocoartf2868
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 -- \'dclesanded 1 \
\
-- 1.1. Valime esimesed 10 rida tabeliga tutvumiseks - LIMIT\
SELECT * \
FROM SalesTable\
LIMIT 10;\
\
-- 1.2. Valime konkreetsed tulbad - tulba nimed eraldada komadega\
SELECT ProductID, Quantity  \
FROM SalesTable;\
\
-- 1.3. Valime unikaalsed v\'e4\'e4rtused (milliseid tooteid \'fcldse m\'fc\'fcdud on) - DISTINCT k\'e4sk\
SELECT DISTINCT ProductID  \
FROM SalesTable;\
\
-- \'dclesanded 2\
-- 2. FILTREERIMINE - kindlate ridade valimine\
\
-- 2.1. FILTREERIMINE - KINDEL V\'c4\'c4RTUS: Valime kindla toote m\'fc\'fcgid - WHERE k\'e4sk tekstilise v\'e4lja puhul\
SELECT * \
FROM SalesTable\
WHERE ProductID = 'P002';\
\
-- 2.2. FILTREERIMINE - V\'c4LISTAMINE: V\'e4listame kindla toote m\'fc\'fcgid - WHERE k\'e4sk tekstilise v\'e4lja puhul\
SELECT * \
FROM SalesTable \
WHERE ProductID != 'P001';\
\
-- 2.3. FILTREERIMINE - NUMBRLISE V\'c4\'c4RTUSE V\'d5RDLEMINE: Valime ainult m\'fc\'fcgid, kus kogus on suurem viiest - WHERE k\'e4sk numbrilise v\'e4lja puhul (teised v\'f5rdlused: <, <= , >=)\
SELECT * \
FROM SalesTable \
WHERE Quantity > 5;\
\
-- 2.4. FILTREERIMINE MITME TUNNUSE ALUSEL: Valime kindla toote m\'fc\'fcgid kindlale kliendile - WHERE ning AND\
SELECT * \
FROM SalesTable \
WHERE ProductID = 'P004' AND CustomerID = 'C004';\
\
-- 2.5. FILTREERIMINE MITME TUNNUSE ALUSEL: Valime kindla toote m\'fc\'fcgid V\'d5I kindla kliendi m\'fc\'fcgid - WHERE ning OR\
SELECT * \
FROM SalesTable\
WHERE ProductID = 'P004' OR CustomerID = 'C004';\
\
-- 2.6. FILTREERIMINE VAHEMIKU ALUSEL: Valime ainult m\'fc\'fcgid, kus kogus on 5 ja 8 vahepeal - BETWEEN\
SELECT * \
FROM SalesTable\
WHERE Quantity BETWEEN 5 AND 8;\
\
-- 2.7. FILTREERIMINE - VALIME MITU V\'c4\'c4RTUST: Valime mitme kindla toote m\'fc\'fcgid - IN\
SELECT * \
FROM SalesTable\
WHERE ProductID IN ('P001', 'P002');\
\
-- 2.8. FILTREERIMINE OSALISE TEKSTI alusel: Valime k\'f5ik tooted, mille ID algab 'P00' - LIKE ja %\
SELECT * \
FROM SalesTable \
WHERE ProductID LIKE 'P00%';\
\
-- 2.9. FILTREERIMINE - T\'d5STUTUNDLIKKUSE EEMALDAMINE: Valime k\'f5ik tooted, mille ID algab 'P00' v\'f5i 'p00' - LOWER v\'f5i UPPER k\'e4sk\
SELECT * \
FROM SalesTable \
WHERE UPPER(ProductID) LIKE 'P001%' OR LOWER(ProductID) LIKE 'p001';\
\
-- 2.10. FILTREERIMINE - MITME TINGIMUSE KOMBINEERIMINE: Valime m\'fc\'fcgid, mis esimese toote puhul on kogusega 2 ja teise toote puhul on kogusega 5 - SULGUDE KASUTAMINE\
SELECT * \
FROM SalesTable \
WHERE (ProductID = 'P001' AND Quantity = 2) OR (ProductID = 'P002' AND Quantity = 5);\
\
-- 3. SORTEERIMINE: Sorteerime suurema toote hinnaga m\'fc\'fcgid ette poole - ORDER BY\
SELECT * \
FROM SalesTable	\
ORDER BY UnitPrice DESC;\
\
-- 4. ALIAS - TULBALE UUS NIMI V\'c4LJUNDIS: Date tulbast SalesDate tulp v\'e4ljundis - AS\
SELECT Date AS SalesDate\
FROM SalesTable;\
\
-- \'dclesanded 3\
-- 6. ARVUTUSED - v\'f5imalik teha aritmeetilisi tehteid (+, -, /, *) tulpade loomiseks, filtreerimiseks ja sorteerimiseks\
-- 6.1. ARVUTUS - Leia m\'fc\'fcgisummad, kus m\'fc\'fcgisumma on suurem kui 500 ja j\'e4rjesta m\'fc\'fcgisumma alusel kasvavalt\
SELECT *, ROUND(Quantity * UnitPrice * (1-Discount), 2) AS SalesSum\
FROM SalesTable\
WHERE SalesSum > 500\
ORDER BY SalesSum;\
\
-- 7. AGREGEERIMINE\
\
-- 7.1. LOENDAMINE: Kui palju m\'fc\'fcgitehinguid on tehtud? - COUNT\
SELECT COUNT(SaleID)  -- count(*)\
FROM SalesTable;\
\
-- 7.2. UNIKAALSETE V\'c4\'c4RTUSTE LOENDAMINE: Kui palju eri tooteid on m\'fc\'fcdud? - COUNT (DISTINCT)\
SELECT COUNT(DISTINCT ProductID)\
FROM SalesTable;\
\
-- 7.3. SUMMERIMINE: Kui palju on tooteid m\'fc\'fcdud? - SUM\
SELECT SUM(Quantity) \
FROM SalesTable;\
\
-- 7.4. KESKMINE, MIINIMUM, MAKSIMUM: Mis on toodete keskmine, minimaalne ja maksimaalne hind? - AVG, MIN, MAX\
SELECT AVG(UnitPrice), MIN(UnitPrice), MAX(UnitPrice)\
FROM SalesTable;\
\
-- 7.5. GRUPEERIMINE: Mis on toodete keskmine, minimaalne ja maksimaalne hind toodete kaupa? - GROUP BY\
SELECT ProductID, AVG(UnitPrice), MIN(UnitPrice), MAX(UnitPrice)\
FROM SalesTable\
GROUP BY ProductID;\
\
-- 7.6. AGREGEERTITUD V\'c4\'c4RTUSE ALUSEL FILTREERIMINE: N\'e4ita ainult tooteid, mille keskmine hind on suurem kui 54.50. - HAVING\
SELECT ProductID, ROUND(AVG(UnitPrice),2) AS AvgPrice\
FROM SalesTable\
GROUP BY ProductID\
HAVING AvgPrice > 54.50;\
\
-- 8. T\'dcHI V\'c4\'c4RTUS: N\'e4ita tooteridu, kus kogus on v\'f5i ei ole t\'fchi v\'e4\'e4rtus - IS NULL v\'f5i IS NOT NULL\
SELECT * \
FROM SalesTable \
WHERE Quantity IS NOT NULL;\
\
-- 9. V\'c4\'c4RTUSE MUUTMINE: Grupeeri tooted kategooriatesse - CASE WHEN\
SELECT *, \
	CASE WHEN ProductID IN ('P001', 'P002', 'P003') THEN 'Category 1'\
    ELSE 'Category 2'\
    END AS Category\
FROM SalesTable;\
\
-- \'dclesanded 3 - iseseisev\
-- AGREGEERIMINE HARJUTUSED\
\
-- 1. LOENDAMINE: Kui palju m\'fc\'fcgiesindajaid on m\'fc\'fcgiesindaja tabelis?\
SELECT COUNT(SalesRepID) \
FROM SalesRepTable;\
\
-- 2. UNIKAALSETE V\'c4\'c4RTUSTE LOENDAMINE: Kui palju eri m\'fc\'fcgiesindajaid on m\'fc\'fckide tabelis?\
SELECT COUNT(DISTINCT SalesRepID) \
FROM SalesTable;\
\
-- 3. KESKMINE, MIINIMUM, MAKSIMUM: Mis on toodete keskmine, minimaalne ja maksimaalne kogus?\
SELECT\
    ROUND(AVG(Quantity)) AS AvgQuantity\
    ,ROUND(MIN(Quantity)) AS MinQuantity\
    ,ROUND(MAX(Quantity)) AS MaxQuantity\
FROM SalesTable;\
\
-- 4. GRUPEERIMINE: Mis on toodete keskmine, minimaalne ja maksimaalne kogus toodete kaupa?\
SELECT\
	ProductID\
    ,ROUND(AVG(Quantity)) AS AvgQuantity\
    ,ROUND(MIN(Quantity)) AS MinQuantity\
    ,ROUND(MAX(Quantity)) AS MaxQuantity\
FROM SalesTable\
GROUP BY ProductID;\
\
-- 5. AGREGEERTITUD V\'c4\'c4RTUSE ALUSEL FILTREERIMINE: N\'e4ita ainult tooteid, mille keskmine m\'fc\'fcdud kogus on suurem kui 5. \
SELECT\
	ProductID\
    ,AVG(Quantity) AS AvgQuantity\
FROM SalesTable\
GROUP BY ProductID\
HAVING AvgQuantity > 5;\
\
-- 6. Grupeeri m\'fc\'fcgiesindajad tiimidesse.\
SELECT SalesRepID, \
	CASE\
    	WHEN SalesRepID IN ('SR01', 'SR02') THEN 'Team 1'\
    	WHEN SalesRepID IN ('SR03') THEN 'Team 2'\
    	ELSE 'Other'\
    END AS Team\
FROM SalesRepTable;}