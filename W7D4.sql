USE adv;

-- Controllo preliminare delle tabelle di origine
SELECT * FROM dimproduct;
SELECT * FROM dimproductsubcategory;
SELECT * FROM dimproductcategory;
SELECT * FROM dimreseller;
SELECT * FROM dimgeography;
SELECT * FROM factresellersales;

---------------------------------------------------------------
-- 1️ VISTA: Product
-- Crea un’anagrafica prodotto completa con nome, sottocategoria e categoria
---------------------------------------------------------------
CREATE VIEW Prodotto AS 
(
SELECT
    P.EnglishProductName AS NomeProdotto,
    S.EnglishProductSubcategoryName AS NomeSottocategoriaProdotto,
    C.EnglishProductCategoryName AS NomeCategoriaProdotto
FROM adv.dimproduct AS P
INNER JOIN adv.dimproductsubcategory AS S
    ON P.ProductSubcategoryKey = S.ProductSubcategoryKey
INNER JOIN adv.dimproductcategory AS C
    ON S.ProductCategoryKey = C.ProductCategoryKey
    );

---------------------------------------------------------------
-- 2️ VISTA: Reseller
-- Crea un’anagrafica reseller completa (nome, città, regione, paese)
---------------------------------------------------------------
CREATE VIEW Reseller AS
(
SELECT 
    R.ResellerName AS NomeReseller,
    G.City AS Città,
    G.StateProvinceName AS Regione,
    G.EnglishCountryRegionName AS Paese
FROM dimreseller AS R
INNER JOIN dimgeography AS G
    ON R.GeographyKey = G.GeographyKey
    );

---------------------------------------------------------------
-- 3️ VISTA: Sales
-- Ritorna data ordine, codice documento, quantità, importo totale e profitto
---------------------------------------------------------------
CREATE VIEW Sales AS
(
SELECT
    SalesOrderNumber AS CodiceDocumento,
    SalesOrderLineNumber AS RigaCorpoDocumento,
    OrderDate AS DataOrdine,
    OrderQuantity AS QuantitàVenduta,
    SalesAmount AS TotaleImporto,
    (SalesAmount - TotalProductCost) AS Profitto
FROM factresellersales
);
