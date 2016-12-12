﻿SET SCHEMA 'sinf';

DROP TABLE IF EXISTS Utilizador CASCADE; 
DROP TABLE IF EXISTS Reviews CASCADE; 
DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Wishlist CASCADE;
DROP TRIGGER  IF EXISTS lowerCaseEmail ON Utilizador CASCADE;
DROP TRIGGER  IF EXISTS validateEmail ON Utilizador CASCADE;

CREATE TABLE IF NOT EXISTS Utilizador(
code SERIAL PRIMARY KEY,
email TEXT NOT NULL UNIQUE,
type VARCHAR(256) NOT NULL,
password VARCHAR(256) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product(
code SERIAL PRIMARY KEY,
primaveraCode TEXT NOT NULL UNIQUE, -- primavera code is a mix of letters and numbers
img TEXT NOT NULL -- link to img of a product 
);

CREATE TABLE IF NOT EXISTS Reviews(
code SERIAL PRIMARY KEY,
utilizador INTEGER REFERENCES Utilizador(code),
productCode INTEGER REFERENCES Product(code),  --subject to change and verify with primavera
review TEXT,
score SMALLINT,
tsv tsvector
);
 
CREATE TABLE IF NOT EXISTS Wishlist(
utilizador  INTEGER REFERENCES Utilizador(code),
productCode INTEGER REFERENCES Product(code),
quantity INTEGER NOT NULL DEFAULT 1,
 PRIMARY KEY(utilizador, productCode)
);

--http://stackoverflow.com/questions/9807909/are-email-addresses-case-sensitive    to justify the trigger
CREATE OR REPLACE FUNCTION lowerCaseEmailFunction() RETURNS trigger AS $$
BEGIN
 NEW.email = lower(NEW.email);
 RETURN NEW;
END  
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER lowerCaseEmail
BEFORE INSERT OR UPDATE ON Utilizador 
FOR EACH ROW
EXECUTE PROCEDURE lowerCaseEmailFunction();


-- http://emailregex.com/
CREATE OR REPLACE FUNCTION validateEmailFunction() RETURNS trigger AS $$
BEGIN
 IF NEW.email ~* '^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$'
 THEN
 RETURN NEW;
 ELSE
 RETURN NULL;
 END IF;
END 
$$ LANGUAGE 'plpgsql'; 

CREATE TRIGGER validateEmail
BEFORE INSERT OR UPDATE ON Utilizador 
FOR EACH ROW
EXECUTE PROCEDURE validateEmailFunction();

--Test cases the first one should pass wihtout any problems, o 2º deve aparecer todo em lower case e o 3º não deve ser adicionado s
INSERT INTO Utilizador (email, type, password) VALUES ('hi@gmail.com', 'admin', '123');
INSERT INTO Utilizador (email, type, password) VALUES ('TEST@gmail.com', 'client', '123');
INSERT INTO Utilizador (email, type, password) VALUES ('TESTsdasdasd.com', 'client', '123');

