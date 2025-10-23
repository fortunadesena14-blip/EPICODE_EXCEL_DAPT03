USE AdventureWorksDW;
SELECT * FROM dimproduct;
# 1. Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria.
# Quali considerazioni/ragionamenti è necessario che tu faccia?
# dobbiamo verificare che ProductKey sia primaria: quindi sarà UNIVOCA E MAI NULLA: 3 verifiche 
# A) a lezione
SELECT ProductKey
FROM dimproduct;

SELECT ProductKey
FROM dimproduct
WHERE ProductKey is NULL;

# B) a lezione
SELECT ProductKey,
Count(*)
FROM dimproduct
GROUP BY ProductKey
HAVING Count(*) > 1;

# fatto da me
SELECT 
COUNT(*) as totalerighe,               # count(*) conta tutte le righe, nulle e non nulle
COUNT(ProductKey) as NonNulle,         # count(nomecolonna) conta tutte le righe non nulle
COUNT(distinct ProductKey)             # conta le righe non duplicate
FROM dimproduct;
                    
# 2. Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.
SELECT * FROM factresellersales;
# faccio delle verifiche
SELECT 
COUNT(*)  as totalerighe,                 
COUNT(SalesOrderNumber) as SalesOrderNumberNonNull,
count(SalesOrderLineNumber) as SalesOrderLineNumberNonNull,
count(distinct SalesOrderNumber, SalesOrderLineNumber)		
FROM factresellersales;

# a lezione
SELECT 
SalesOrderNumber,
SalesOrderLineNumber,
COUNT(*)
FROM factresellersales
GROUP BY SalesOrderNumber,
SalesOrderLineNumber
HAVING COUNT(*) > 1;

SELECT 
SalesOrderNumber, 
SalesOrderLineNumber
FROM factresellersales
WHERE SalesOrderNumber
and SalesOrderLineNumber is NULL;

# 3. Conta il numero transazioni (SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.
SELECT 
SalesOrderNumber, 
OrderDate,
COUNT(SalesOrderLineNumber)
FROM factresellersales
WHERE OrderDate > '2020-01-01'
GROUP BY OrderDate;

# 4. Calcola il fatturato totale (FactResellerSales.SalesAmount), la quantità totale venduta (FactResellerSales.OrderQuantity) e il prezzo medio di vendita (FactResellerSales.UnitPrice) per prodotto (DimProduct) a partire dal 1 Gennaio 2020. 
# Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. 
# I campi in output devono essere parlanti
SELECT 
  P.EnglishProductName as NomeProdotto,
  OrderDate,
  SUM(F.SalesAmount) as TotaleFatturato,
  SUM(F.OrderQuantity) as TotQuantitavenduta,
  AVG(F.UnitPrice) as PrezzoMedioperProdotto
FROM dimproduct AS P
INNER JOIN factresellersales AS F
ON F.ProductKey = P.ProductKey
WHERE OrderDate > '2020-01-01'
GROUP BY P.EnglishProductName;

# 5. Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta (.OrderQuantity) per Categoria prodotto (DimProductCategory). 
# Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!
SELECT * FROM dimproductcategory;
SELECT * FROM dimproductsubcategory;
select * from dimproduct; 

SELECT 
C.ProductCategoryKey as CategoriaProdotto,
SUM(F.SalesAmount) as TotaleFatturato,
SUM(F.OrderQuantity) as TotQuantitavenduta
FROM factresellersales as F
INNER JOIN dimproduct as P                      # prendo solo i prodotti venduti
ON F.ProductKey = P.ProductKey
INNER JOIN dimproductsubcategory S              # prendo solo i prodotti con sottocategoria
ON P.ProductSubCategorykey = S.ProductSubCategorykey
INNER JOIN dimproductcategory C
ON S.ProductCategoryKey = C.ProductCategoryKey  # una sottocategoria non esiste se non c'è la categoria
GROUP BY C.ProductCategoryKey;

# 6. Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. 
# Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.
select * from dimgeography;

SELECT 
G.City as Città,
SUM(F.SalesAmount) as TotaleFatturato
FROM factresellersales as F
INNER JOIN dimreseller as R                   # ogni vendita ha un rivenditore
ON F.ResellerKey = R.ResellerKey
INNER JOIN dimgeography as G                  # ogni venditore ha una città/area geografica
ON R.GeographyKey = G.GeographyKey
WHERE OrderDate > '2020-01-01'
group by G.CITY
Having SUM(SalesAmount) > 60000;
