# Cosa devi fare: 
# 1. Crea una tabella Store per la gestione degli store (ID, nome, data apertura, ecc.)
# 2. Crea una tabella Region per la gestione delle aree geografiche (ID, città, regione, area geografica, …)
# 3. Popola le tabelle con pochi record esemplificativi 
# 4. Esegui operazioni di aggiornamento, modifica ed eliminazione record
CREATE DATABASE vendite;
use vendite;

CREATE TABLE Regione (
    RegioneID INT PRIMARY KEY,
    Regione VARCHAR(50),
    Città VARCHAR(50),
    Area_Geografica VARCHAR(50)
    );
    
CREATE table STORE (
    StoreID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50),
    DataApertura DATE NOT NULL,
    RegioneID INT NOT NULL,
    Città VARCHAR(50),
    Indirizzo VARCHAR(100),
    Status VARCHAR(50),
    Fatturato DECIMAL (10,2),
    FOREIGN KEY(RegioneID) REFERENCES Regione(RegioneID)
    );
    
    INSERT INTO Regione
    VALUES
    (1, 'Piemonte', 'Torino', 'Nord'),
    (3, 'Lombardia', 'Milano', 'Nord'),
    (14, 'Molise', 'Campobasso', 'Centro'),
    (15, 'Campania', 'Napoli', 'Sud'),
    (20, 'Sardegna', 'Cagliari', 'Sud');
    
INSERT INTO STORE (Nome, DataApertura, RegioneID, Città, Indirizzo, Status, Fatturato)
VALUES 
('Shopping time', '2005-03-14', 15, 'Napoli', 'Via S.Francesco 11', 'Attivo', 10000.00),
('Centro Estetico', '2007-09-28', 1, 'Torino', 'Viale della Libertà 19', 'Attivo', 200000.00),
('Scarpe & Scarpe', '2016-05-27', 14, 'Campobasso', 'Via Rossini 44', 'Non attivo', 1000.00),
('Tante cose', '2019-06-11', 20, 'Cagliari', 'Viale dei Pini 22', 'Attivo', 300000.00),
('Chip Shop', '2021-11-29', 3, 'Milano', 'Via De Curtis 5', 'Attivo', 50000.00);

show tables;
Select * from Regione;
Select * from Store;

 -- CONCATENARE LE TABELLE
 SELECT
 R.*, S.*
 FROM Regione as R
 INNER JOIN Store as S
 ON S.RegioneID = R.RegioneID;
    
-- OPERAZIONI MODIFICA/AGGIORNAMENTO ECC
-- AUMENTO IL FATTURATO DEGLI STORE DEL NORD
START transaction;
UPDATE Store
SET Fatturato = Fatturato * 1.10
WHERE RegioneID IN (1, 3);
COMMIT;


# MODIFICO LO STATUS
UPDATE Store
SET Status = 'Attivo'
WHERE StoreID = 3;

# ELIMINAZIONE RIGA
DELETE FROM STORE WHERE StoreID = 1;


