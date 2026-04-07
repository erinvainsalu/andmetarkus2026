-- 1.1. Valime esimesed 10 rida tabeliga tutvumiseks - LIMIT
SELECT * 
FROM SalesTable
LIMIT 10;

-- 1.2. Valime konkreetsed tulbad - tulba nimed eraldada komadega
SELECT ProductID, Quantity  
FROM SalesTable;

-- 1.3. Valime unikaalsed väärtused (milliseid tooteid üldse müüdud on) - DISTINCT käsk
SELECT DISTINCT ProductID  
FROM SalesTable;

-- Ülesanded 2
-- 2. FILTREERIMINE - kindlate ridade valimine

-- 2.1. FILTREERIMINE - KINDEL VÄÄRTUS: Valime kindla toote müügid - WHERE käsk tekstilise välja puhul
SELECT * 
FROM SalesTable
WHERE ProductID = 'P002';

-- 2.2. FILTREERIMINE - VÄLISTAMINE: Välistame kindla toote müügid - WHERE käsk tekstilise välja puhul
SELECT * 
FROM SalesTable 
WHERE ProductID != 'P001';

-- 2.3. FILTREERIMINE - NUMBRLISE VÄÄRTUSE VÕRDLEMINE: Valime ainult müügid, kus kogus on suurem viiest - WHERE käsk numbrilise välja puhul (teised võrdlused: <, <= , >=)
SELECT * 
FROM SalesTable 
WHERE Quantity > 5;

-- 2.4. FILTREERIMINE MITME TUNNUSE ALUSEL: Valime kindla toote müügid kindlale kliendile - WHERE ning AND
SELECT * 
FROM SalesTable 
WHERE ProductID = 'P004' AND CustomerID = 'C004';

-- 2.5. FILTREERIMINE MITME TUNNUSE ALUSEL: Valime kindla toote müügid VÕI kindla kliendi müügid - WHERE ning OR
SELECT * 
FROM SalesTable
WHERE ProductID = 'P004' OR CustomerID = 'C004';

-- 2.6. FILTREERIMINE VAHEMIKU ALUSEL: Valime ainult müügid, kus kogus on 5 ja 8 vahepeal - BETWEEN
SELECT * 
FROM SalesTable
WHERE Quantity BETWEEN 5 AND 8;

-- 2.7. FILTREERIMINE - VALIME MITU VÄÄRTUST: Valime mitme kindla toote müügid - IN
SELECT * 
FROM SalesTable
WHERE ProductID IN ('P001', 'P002');

-- 2.8. FILTREERIMINE OSALISE TEKSTI alusel: Valime kõik tooted, mille ID algab 'P00' - LIKE ja %
SELECT * 
FROM SalesTable 
WHERE ProductID LIKE 'P00%';

-- 2.9. FILTREERIMINE - T'd5STUTUNDLIKKUSE EEMALDAMINE: Valime kõik tooted, mille ID algab 'P00' või 'p00' - LOWER või UPPER käsk
SELECT * 
FROM SalesTable 
WHERE UPPER(ProductID) LIKE 'P001%' OR LOWER(ProductID) LIKE 'p001';

-- 2.10. FILTREERIMINE - MITME TINGIMUSE KOMBINEERIMINE: Valime müügid, mis esimese toote puhul on kogusega 2 ja teise toote puhul on kogusega 5 - SULGUDE KASUTAMINE
SELECT * 
FROM SalesTable 
WHERE (ProductID = 'P001' AND Quantity = 2) OR (ProductID = 'P002' AND Quantity = 5);

-- 3. SORTEERIMINE: Sorteerime suurema toote hinnaga müügid ette poole - ORDER BY
SELECT * 
FROM SalesTable	
ORDER BY UnitPrice DESC;

-- 4. ALIAS - TULBALE UUS NIMI VÄLJUNDIS: Date tulbast SalesDate tulp väljundis - AS
SELECT Date AS SalesDate
FROM SalesTable;

-- 'dclesanded 3
-- 6. ARVUTUSED - võimalik teha aritmeetilisi tehteid (+, -, /, *) tulpade loomiseks, filtreerimiseks ja sorteerimiseks
-- 6.1. ARVUTUS - Leia müügisummad, kus müügisumma on suurem kui 500 ja järjesta müügisumma alusel kasvavalt
SELECT *, ROUND(Quantity * UnitPrice * (1-Discount), 2) AS SalesSum
FROM SalesTable
WHERE SalesSum > 500
ORDER BY SalesSum;

-- 7. AGREGEERIMINE

-- 7.1. LOENDAMINE: Kui palju müügitheinguid on tehtud? - COUNT
SELECT COUNT(SaleID)  -- count(*)
FROM SalesTable;

-- 7.2. UNIKAALSETE VÄÄRTUSTE LOENDAMINE: Kui palju eri tooteid on müüdud? - COUNT (DISTINCT)
SELECT COUNT(DISTINCT ProductID)
FROM SalesTable;

-- 7.3. SUMMERIMINE: Kui palju on tooteid müüdud? - SUM
SELECT SUM(Quantity) 
FROM SalesTable;

-- 7.4. KESKMINE, MIINIMUM, MAKSIMUM: Mis on toodete keskmine, minimaalne ja maksimaalne hind? - AVG, MIN, MAX
SELECT AVG(UnitPrice), MIN(UnitPrice), MAX(UnitPrice)
FROM SalesTable;

-- 7.5. GRUPEERIMINE: Mis on toodete keskmine, minimaalne ja maksimaalne hind toodete kaupa? - GROUP BY
SELECT ProductID, AVG(UnitPrice), MIN(UnitPrice), MAX(UnitPrice)
FROM SalesTable
GROUP BY ProductID;

-- 7.6. AGREGEERTITUD VÄÄRTUSE ALUSEL FILTREERIMINE: Näita ainult tooteid, mille keskmine hind on suurem kui 54.50. - HAVING
SELECT ProductID, ROUND(AVG(UnitPrice),2) AS AvgPrice
FROM SalesTable
GROUP BY ProductID
HAVING AvgPrice > 54.50;

-- 8. TÜHI VÄÄRTUS: Näita tooteridu, kus kogus on või ei ole tühi väärtus - IS NULL või IS NOT NULL
SELECT * 
FROM SalesTable 
WHERE Quantity IS NOT NULL;

-- 9. VÄÄRTUSE MUUTMINE: Grupeeri tooted kategooriatesse - CASE WHEN
SELECT *, 
	CASE WHEN ProductID IN ('P001', 'P002', 'P003') THEN 'Category 1'
    ELSE 'Category 2'
    END AS Category
FROM SalesTable;

-- Ülesanded 3 - iseseisev
-- AGREGEERIMINE HARJUTUSED

-- 1. LOENDAMINE: Kui palju müügiesindajaid on müügiesindaja tabelis?
SELECT COUNT(SalesRepID) 
FROM SalesRepTable;

-- 2. UNIKAALSETE VÄÄRTUSTE LOENDAMINE: Kui palju eri müügiesindajaid on müügiesindaja tabelis?
SELECT COUNT(DISTINCT SalesRepID) 
FROM SalesTable;

-- 3. KESKMINE, MIINIMUM, MAKSIMUM: Mis on toodete keskmine, minimaalne ja maksimaalne kogus?
SELECT
    ROUND(AVG(Quantity)) AS AvgQuantity
    ,ROUND(MIN(Quantity)) AS MinQuantity
    ,ROUND(MAX(Quantity)) AS MaxQuantity
FROM SalesTable;

-- 4. GRUPEERIMINE: Mis on toodete keskmine, minimaalne ja maksimaalne kogus toodete kaupa?
SELECT
	ProductID
    ,ROUND(AVG(Quantity)) AS AvgQuantity
    ,ROUND(MIN(Quantity)) AS MinQuantity
    ,ROUND(MAX(Quantity)) AS MaxQuantity
FROM SalesTable
GROUP BY ProductID;

-- 5. AGREGEERTITUD VÄÄRTUSE ALUSEL FILTREERIMINE: Näita ainult tooteid, mille keskmine müüdud kogus on suurem kui 5. 
SELECT
	ProductID
    ,AVG(Quantity) AS AvgQuantity
FROM SalesTable
GROUP BY ProductID
HAVING AvgQuantity > 5;

-- 6. Grupeeri müügiesindajad tiimidesse.
SELECT SalesRepID, 
	CASE
    	WHEN SalesRepID IN ('SR01', 'SR02') THEN 'Team 1'
    	WHEN SalesRepID IN ('SR03') THEN 'Team 2'
    	ELSE 'Other'
    END AS Team
FROM SalesRepTable;}