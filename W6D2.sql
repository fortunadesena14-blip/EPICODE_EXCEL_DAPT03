# ESERCIZIO W6D2 
# 1. ESPLORA LA TABELLA dimproduct
USE AdventureWorksDW;
SELECT * FROM dimproduct;

# 2. Interroga la tabella dei prodotti (DimProduct) ed esponi in output i campi ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag
# Il result set deve essere parlante per cui assegna un alias se lo ritieni opportuno.
SELECT
ProductKey AS "ID_Prodotto",
ProductAlternateKey AS "ID_Alternativo",
EnglishProductName AS "Nome_prodotto",
Color AS "Colore",
StandardCost AS "Costo",
FinishedGoodsFlag AS "Prodotto_finito"
FROM dimproduct;

# 3. Partendo dalla query scritta nel passaggio precedente,
# esponi in output i soli prodotti finiti cioè quelli per cui il campo FinishedGoodsFlag è uguale a 1.
SELECT ProductKey, ProductAlternateKey, EnglishProductName, Color, StandardCost, FinishedGoodsFlag
FROM dimproduct
WHERE FinishedGoodsFlag = 1;

# 4. Scrivi una nuova query al fine di esporre in output i prodotti il cui codice modello (ProductAlternateKey) comincia con FR oppure BK. 
# Il result set deve contenere il codice prodotto (ProductKey), il modello, il nome del prodotto, il costo standard (StandardCost) e il prezzo di listino (ListPrice).
SELECT * FROM dimproduct;
DESCRIBE dimproduct;

SELECT
ProductKey AS "ID_Prodotto",
ProductAlternateKey AS "ID_Alternativo",
EnglishProductName AS "Nome_prodotto",
ModelName AS "Nome_Modello",
StandardCost AS "Costo",
ListPrice AS "Listino_Prezzi"
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

# 5. Arricchisci il risultato della query scritta nel passaggio precedente del Markup applicato dallʼazienda (ListPrice - StandardCost)
SELECT
ProductKey AS "ID_Prodotto",
ProductAlternateKey AS "ID_Alternativo",
EnglishProductName AS "Nome_prodotto",
ModelName AS "Nome_Modello",
StandardCost AS "Costo",
ListPrice AS "Listino_Prezzi",
ListPrice - StandardCost AS "Markup"
FROM dimproduct
WHERE ProductAlternateKey LIKE 'FR%' OR ProductAlternateKey LIKE 'BK%';

# 6. Scrivi unʼaltra query al fine di esporre lʼelenco dei prodotti finiti il cui prezzo di listino è compreso tra 1000 e 2000.
SELECT
ProductKey AS "ID_Prodotto",
ProductAlternateKey AS "ID_Alternativo",
EnglishProductName AS "Nome_prodotto",
ModelName AS "Nome_Modello",
StandardCost AS "Costo",
ListPrice AS "Listino_Prezzi",
ListPrice - StandardCost AS "Markup",
FinishedGoodsFlag AS "Prodotto_finito"
FROM dimproduct
WHERE FinishedGoodsFlag  = 1 AND ListPrice BETWEEN 1000 AND 2000;

# 7. Esplora la tabella DimEmployee
SELECT * FROM dimemployee

# 8. Esponi, interrogando la tabella degli impiegati aziendali, lʼelenco dei soli agenti, Gli agenti sono i dipendenti per i quali il campo SalespersonFlag è uguale a uno;
DESCRIBE dimemployee
SELECT 
EmployeeKey AS "ID_Impiegato",
FirstName AS "Nome",
LastName AS "Cognome",
Title AS "Titolo",
Position AS "Posizione"
FROM dimemployee
WHERE SalespersonFlag = 1;

# 9. Interroga la tabella delle vendite (FactResellerSales). 
# Esponi in output lʼelenco delle transazioni registrate a partire dal 1 gennaio 2020 dei soli codici prodotto: 597, 598, 477, 214. 
# Calcola per ciascuna transazione il profitto (SalesAmount - TotalProductCost).
SELECT * FROM factresellersales;

SELECT 
SalesOrderNumber AS "Numero_Ordine",
OrderQuantity AS "Quantità",
UnitPrice AS "Prezzo_unitario",
SalesAmount - TotalProductCost AS "PROFITTO",
ProductKey AS "ID_prodotto",
OrderDate AS "Data_Ordine"
FROM factresellersales
WHERE OrderDate >= '2020-01-01' AND ProductKey IN (214, 477, 597, 598);
