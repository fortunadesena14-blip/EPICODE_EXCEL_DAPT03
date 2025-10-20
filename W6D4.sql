# W6D4 - EPICODE
# 1. Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria (DimProduct, DimProductSubcategory).
USE AdventureWorksDW;
SELECT * FROM dimproduct;
SELECT * FROM dimproductsubcategory;
SELECT * FROM dimproductcategory;
SELECT * FROM factresellersales;

# unione delle tabelle dimproduct e dimproductsubcatgory: la primary key di dimproductsubcategory è ProductSubcategoryKey
# siccome non c'è una specificazione rispetto ai prodotti da visualizzare, li vedo tutti con o senza sottocategoria.

# - in questo caso ho preso tutte le colonne
# qui prendo tutti i prodotti, anche quelli che hanno subcategory null
SELECT *
FROM dimproduct as P
LEFT JOIN dimproductsubcategory as S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey;

# con left considero anche quei prodotti che non hanno sottocategoria;
# se invece voglio solo osservare quelli con sottocategoria: INNER
SELECT *
FROM dimproduct as P
INNER JOIN dimproductsubcategory as S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey;

# subquery (come inner)
SELECT *
FROM dimproduct as P
WHERE P.ProductSubCategoryKey IN (
SELECT S.ProductSubCategoryKey
FROM dimproductsubcategory as S);

# - prendiamo solo alcune colonne
SELECT
  P.ProductKey,
  P.ProductSubCategoryKey,
  P.StandardCost,
  P.ListPrice,
  P.Status,
  S.ProductSubCategoryKey,
  S.EnglishProductSubcategoryName
FROM dimproduct AS P
LEFT JOIN dimproductsubcategory AS S
ON P.ProductSubCategoryKey = S.ProductSubCategoryKey;

# - prendiamo solo alcune colonne
SELECT
  P.ProductKey,
  P.ProductSubCategoryKey,
  P.StandardCost,
  P.ListPrice,
  P.Status,
  S.ProductSubCategoryKey,
  S.EnglishProductSubcategoryName
FROM dimproduct AS P
INNER JOIN dimproductsubcategory AS S
ON P.ProductSubCategoryKey = S.ProductSubCategoryKey;

# 2. Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria 
# (DimProduct, DimProductSubcategory, DimProductCategory).
# dobbiamo effettuare delle join a cascata
SELECT
P.*, S.*, C.*
FROM dimproduct AS P
LEFT JOIN dimproductsubcategory AS S
 ON P.ProductSubCategoryKey = S.ProductSubCategoryKey
LEFT JOIN dimproductcategory AS C
 ON S.ProductCategoryKey = C.ProductCategoryKey;

# facciamo lo stesso selezionando solo le colonne di interesse
SELECT
P.ProductKey,
P.ProductSubcategoryKey,
P.StandardCost,
P.ListPrice,
P.Status,
S.ProductSubcategoryKey,
S.ProductCategoryKey,
C.ProductCategoryKey,
C.FrenchProductCategoryName
FROM dimproduct AS P
LEFT JOIN dimproductsubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
LEFT JOIN dimproductcategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey;

SELECT
P.*, S.*, C.*
FROM dimproduct AS P
INNER JOIN dimproductsubcategory AS S
 ON P.ProductSubCategoryKey = S.ProductSubCategoryKey
INNER JOIN dimproductcategory AS C
 ON S.ProductCategoryKey = C.ProductCategoryKey;

# facciamo lo stesso selezionando solo le colonne di interesse
SELECT
P.ProductKey,
P.ProductSubcategoryKey,
P.StandardCost,
P.ListPrice,
P.Status,
S.ProductSubcategoryKey,
S.ProductCategoryKey,
C.ProductCategoryKey,
C.FrenchProductCategoryName
FROM dimproduct AS P
INNER JOIN dimproductsubcategory AS S
ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
INNER JOIN dimproductcategory AS C
ON S.ProductCategoryKey = C.ProductCategoryKey;

# 3. Esponi lʼelenco dei soli prodotti venduti (DimProduct, FactResellerSales)
SELECT * FROM factresellersales;
# adesso effettuare una inner join
SELECT 
  P.ProductKey,
  P.StandardCost,
  P.ListPrice
FROM dimproduct AS P
INNER JOIN factresellersales AS F
ON F.ProductKey = P.ProductKey;

# facciamo subquery: qui si rispetta la inner join
SELECT *
FROM dimproduct AS P
WHERE P.ProductKey IN (
    SELECT F.ProductKey
    FROM factresellersales AS F
);

SELECT 
P.ProductKey,
P.StandardCost,
P.ListPrice,
F.*
FROM dimproduct AS P
INNER JOIN factresellersales AS F
ON F.ProductKey = P.ProductKey;

# senza ripetizioni
SELECT DISTINCT
  P.ProductKey,
  P.StandardCost,
  P.ListPrice
FROM dimproduct AS P
INNER JOIN factresellersales AS F
  ON F.ProductKey = P.ProductKey;

# 4. Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1.
# join una specifica WHERE
SELECT *
FROM dimproduct AS P
LEFT JOIN factresellersales AS F
ON P.ProductKey = F.ProductKey
WHERE FinishedGoodsFlag = 1 AND F.ProductKey IS NULL;

# POSSIBILE SUBQUERY : prendi tutti gli attributi di dimproduct, nello specifico prendi tutte le righe che hanno P.FinishedGoodsFlag = 1 
# ma rispetto alla chiave primaria, prendi quei prodotti che non hanno la chiave primaria in factresellesales perché non venduti.
SELECT *
FROM dimproduct AS P
WHERE P.FinishedGoodsFlag = 1
  AND P.ProductKey NOT IN (
      SELECT F.ProductKey
      FROM factresellersales as F
  );
# possiamo applicare anche Distinct vicino SELECT

# 5. Esponi lʼelenco delle transazioni di vendita (FactResellerSales) indicando anche il nome del prodotto venduto (DimProduct)
SELECT 
  F.*,
  P.EnglishProductName
FROM factresellersales AS F
INNER JOIN dimproduct AS P
  ON F.ProductKey = P.ProductKey;

# se voglio solo i nomi
SELECT 
  P.EnglishProductName,
  P.SpanishProductName,
  P.FrenchProductName
FROM factresellersales AS F
INNER JOIN dimproduct AS P
  ON F.ProductKey = P.ProductKey;
  
# SENZA DUPLICAZIONI
SELECT distinct
  P.EnglishProductName,
  P.SpanishProductName,
  P.FrenchProductName
FROM factresellersales AS F
INNER JOIN dimproduct AS P
  ON F.ProductKey = P.ProductKey;
  
###################################################################################################################
# 1.Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
SELECT * FROM factresellersales; 
SELECT 
F.SalesOrderNumber,
F.OrderDate,
F.ProductKey,
F.OrderQuantity,
F.UnitPrice
FROM factresellersales AS F
LEFT JOIN dimproduct as P
ON F.ProductKey = P.ProductKey
LEFT JOIN dimproductsubcategory AS D
ON P.ProductSubCategoryKey = D.ProductSubCategoryKey
LEFT JOIN dimproductcategory as C
ON D.ProductCategoryKey = C.ProductCategoryKey;
 
# 2. EPLORA DIMRESELLER
SELECT * FROM dimreseller;
SELECT * FROM dimgeography;

#3. reseller e area geografica
SELECT 
R.ResellerKey,
R.GeographyKey,
R.BusinessType,
R.ResellerName,
R.ProductLine,
G.City,
G.StateProvinceName
FROM dimreseller AS R
INNER JOIN dimgeography AS G
ON G.GeographyKey = R.GeographyKey;

SELECT *
FROM dimreseller AS R
WHERE R.GeographyKey IN (
    SELECT G.GeographyKey
    FROM dimgeography AS G
    WHERE G.StateProvinceName = 'England'
);

# 4. Esponi lʼelenco delle transazioni di vendita. Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost. 
# Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
SELECT
F.SalesOrderNumber,
F.SalesOrderLineNumber,
F.OrderDate,
F.UnitPrice,
F.OrderQuantity,
F.TotalProductCost,
P.EnglishProductName,
C.EnglishProductCategoryName,
R.ResellerName,
G.City
FROM factresellersales AS F
LEFT JOIN dimproduct as P
ON F.ProductKey = P.ProductKey
LEFT JOIN dimproductsubcategory AS D
ON P.ProductSubCategoryKey = D.ProductSubCategoryKey
INNER JOIN dimproductcategory as C
ON D.ProductCategoryKey = C.ProductCategoryKey
INNER JOIN dimreseller AS R
    ON F.ResellerKey = R.ResellerKey
INNER JOIN dimgeography AS G
    ON R.GeographyKey = G.GeographyKey;
