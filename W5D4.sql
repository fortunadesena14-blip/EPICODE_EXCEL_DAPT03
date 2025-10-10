CREATE DATABASE universita;
USE universita;

# creazione tabelle per il modello E/R
CREATE TABLE Docente (
ID_docente INT PRIMARY KEY,
nome VARCHAR(50) NOT NULL,
cognome VARCHAR(50) NOT NULL,
ruolo VARCHAR(50),
dipartimento VARCHAR(100)
);

CREATE TABLE Corso (
    ID_corso INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    anno_corso INT CHECK(anno_corso BETWEEN 1 AND 6),
    N_CFU INT,
    ID_docente INT,
    FOREIGN KEY (ID_docente) REFERENCES Docente(ID_docente)
);

CREATE TABLE Corso_di_Laurea (
ID_cdl INT PRIMARY KEY , 
nome VARCHAR(100) NOT NULL,
dipartimento varchar(100),
durata_anni INT CHECK(durata_anni BETWEEN 1 AND 6)
);

CREATE TABLE Studente (
Matricola INT PRIMARY KEY, 
nome varchar(50) NOT NULL,
Cognome VARCHAR(50) NOT NULL,
Eta INT,
Genere CHAR(1) CHECK(Genere IN ('M','F','N')),
Cellulare VARCHAR(15),
Email VARCHAR(100) UNIQUE,
Anno_iscrizione YEAR NOT NULL,
ID_cdl INT,
FOREIGN KEY (ID_cdl) REFERENCES Corso_di_laurea(ID_cdl)
);

CREATE TABLE Esame (
ID_esame INT PRIMARY KEY,
data_esame DATE NOT NULL,
voto INT,
stato VARCHAR(20) CHECK(stato IN ('superato','non superato','ritirato')),
Matricola INT,
ID_corso INT,
FOREIGN KEY (Matricola) REFERENCES Studente(Matricola),
FOREIGN KEY (ID_corso) REFERENCES Corso(ID_corso)
);

INSERT INTO Docente VALUES
('13', 'Giovanni', 'Rossi', 'Professore Ordinario', 'Economia'),
('15', 'Laura', 'Bianchi', 'Ricercatrice', 'Statistica');

INSERT INTO Corso VALUES
('011','Economia Aziendale', 1, 9, '13'),
('021', 'Statistica I', 1, 6, '15');

INSERT INTO Corso_di_Laurea  VALUES
('889', 'Economia e Commercio', 'Economia', 3),
('201','Statistica e Data Science', 'Statistica', 3);

INSERT INTO Studente VALUES
('28001','Marco', 'Verdi', 21, 'M', '3331112222', 'marco.verdi@uni.it', 2021, '889'),
('23440','Sara', 'Neri', 22, 'F', '3334445555', 'sara.neri@uni.it', 2019, '201');

INSERT INTO Esame VALUES
('1','2024-02-15', 28, 'superato', '28001', '011'),
('2','2024-07-05', 24, 'superato', '23440', '021');

# attributo calcolato
SELECT
    nome,
    cognome,
    EXTRACT(YEAR FROM CURRENT_DATE) - Anno_iscrizione AS durata_anni
FROM Studente;

SELECT * FROM Studente;
SELECT * FROM Corso;
SELECT * FROM Esame;
SELECT * FROM Docente;

