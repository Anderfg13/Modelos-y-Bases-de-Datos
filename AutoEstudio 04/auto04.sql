----TABLAS
CREATE TABLE band (
    band_no INT DEFAULT num_sequence.NEXTVAL,
    band_name VARCHAR2(20) NOT NULL,
    band_home INT NOT NULL,
    band_type VARCHAR2(10) NULL, 
    b_date DATE NULL,
    band_contact INT NOT NULL
);

CREATE TABLE composer (
    comp_no INT NOT NULL,
    comp_is INT NOT NULL,
    comp_type VARCHAR2(50) NOT NULL
);


CREATE TABLE musician (
    m_no INT NOT NULL,
    m_name VARCHAR2(100) NOT NULL,
    born DATE NOT NULL,
    died DATE NULL
);

CREATE TABLE place (
    place_no INT NOT NULL,
    place_town VARCHAR2(100) NOT NULL,
    place_country VARCHAR2(100) NOT NULL
);

CREATE TABLE plays_in (
    player INT NOT NULL,
    band_id INT NOT NULL
);


--XTABLAS
ALTER TABLE band DROP PRIMARY KEY CASCADE;
ALTER TABLE musician DROP PRIMARY KEY CASCADE;
ALTER TABLE place DROP PRIMARY KEY CASCADE;
ALTER TABLE plays_in DROP PRIMARY KEY CASCADE;

DROP TABLE band;
DROP TABLE musician;
DROP TABLE place;
DROP TABLE plays_in;
DROP TABLE composer;

----Atributos
--Primary Keys
ALTER TABLE band
ADD CONSTRAINT PK_BAND PRIMARY KEY (band_no);

ALTER TABLE musician
ADD CONSTRAINT PK_MUSICIAN PRIMARY KEY (m_no);

ALTER TABLE place
ADD CONSTRAINT PK_PLACE PRIMARY KEY (place_no);

ALTER TABLE plays_in
ADD CONSTRAINT PK_PLAYS_IN PRIMARY KEY (player,band_id);

--Unique keys

ALTER TABLE band
ADD CONSTRAINT UK_BAND UNIQUE (band_name);

--Foreign keys

ALTER TABLE band
ADD CONSTRAINT FK_PLACE_BAND FOREIGN KEY (band_home) references place(place_no);

ALTER TABLE band
ADD CONSTRAINT FK_BAND_MUSICIAN FOREIGN KEY (band_contact) references musician(m_no);

ALTER TABLE band
ADD CONSTRAINT FK_BAND_PLACE FOREIGN KEY (band_contact) references place(place_no);

ALTER TABLE plays_in
ADD CONSTRAINT FK_BAND_PLAYS_IN FOREIGN KEY (band_id) references band(band_no);

ALTER TABLE plays_in
ADD CONSTRAINT FK_MUSICIAN_PLYS_IN FOREIGN KEY (player) references musician(m_no);

--1)
CREATE OR REPLACE FUNCTION ad(name IN VARCHAR2, type IN VARCHAR2, b_date IN DATE) 
RETURN NUMBER IS
    band_id NUMBER;
BEGIN
    INSERT INTO band (band_no, band_name, band_type, b_date, band_home, band_contact)
    VALUES (num_sequence.NEXTVAL, name, type, b_date, NULL, NULL)
    RETURNING band_no INTO band_id;
    
    RETURN band_id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding band: ' || SQLERRM);
        RETURN NULL;
END;

--2)
CREATE OR REPLACE PROCEDURE mo(band IN NUMBER, b_date IN DATE) IS
BEGIN
    UPDATE band 
    SET b_date = b_date
    WHERE band_no = band;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error modifying band date: ' || SQLERRM);
END;

--3)
CREATE OR REPLACE PROCEDURE ad_musician(band IN NUMBER, musician IN NUMBER) IS
BEGIN
    INSERT INTO plays_in (player, band_id)
    VALUES (musician, band);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error adding musician to band: ' || SQLERRM);
END;

--4)
CREATE OR REPLACE PROCEDURE del_musician(band IN NUMBER, musician IN NUMBER) IS
BEGIN
    DELETE FROM plays_in
    WHERE band_id = band AND player = musician;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting musician from band: ' || SQLERRM);
END;


--5)
CREATE OR REPLACE PROCEDURE del(band IN NUMBER) IS
BEGIN
    DELETE FROM plays_in WHERE band_id = band;
    DELETE FROM band WHERE band_no = band;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error deleting band: ' || SQLERRM);
END;


--6)
CREATE OR REPLACE PROCEDURE co(bands OUT SYS_REFCURSOR) IS
BEGIN
    OPEN bands FOR
    SELECT * FROM band;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error retrieving bands: ' || SQLERRM);
END;

--7)
CREATE OR REPLACE PROCEDURE co_musicians(musicians OUT SYS_REFCURSOR) IS
BEGIN
    OPEN musicians FOR
    SELECT * FROM musician;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error retrieving musicians: ' || SQLERRM);
END;

--8)
CREATE OR REPLACE PROCEDURE co_bands(bands_musicians OUT SYS_REFCURSOR) IS
BEGIN
    OPEN bands_musicians FOR
    SELECT b.band_name, m.m_name
    FROM band b
    JOIN plays_in p ON b.band_no = p.band_id
    JOIN musician m ON p.player = m.m_no;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error retrieving bands and musicians: ' || SQLERRM);
END;










----TUPLAS
--TConsecutive Entero(9) Positivo consecutivo
CREATE SEQUENCE num_sequence
    START WITH 1 
    INCREMENT BY 1;

--TName Cadena(20) Minimo una palabra
ALTER TABLE band ADD CONSTRAINT TName
CHECK (LENGTH(band_name)>1);

--TType
ALTER TABLE band ADD CONSTRAINT TType
CHECK (band_type IN ('rock','classical','blues','pop','soul'));

----ATRIBUTOSOK
INSERT INTO place(place_no,place_town,place_country) VALUES (1,'chia','colombia');
INSERT INTO musician(m_no,m_name,born,died) VALUES (1,'Luis Carlos',TO_DATE('2000-08-30','YYYY-MM-DD'),null);
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('TAPS',1,'rock',TO_DATE('2015-08-30','YYYY-MM-DD'),1);

----ATRIBUTOSNOOK
--Aca no deja agregar los datos, porque en la tabla de places no existe nada, y desde este insert se esta referenciado informacion del otro lado
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);

--Aca no deja ingresar los datos porqye m_no es una clave principal y estas no pueden ser vacias.
INSERT INTO musician(m_no,m_name,born,died) VALUES (null,'Luis Carlos',TO_DATE('2000-08-30','YYYY-MM-DD'),null);

--Aca no deja ingresar los datos porque band_name tiene la caracteristica que es UNIQUE.
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);

----TUPLASOK
--TTYPE
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);

--TCONSECUTIVE
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);

--TNAME
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'rock',TO_DATE('2023-08-30','YYYY-MM-DD'),1);


----TUPLASNOOK
--Aca no deja agregar nada porque los generos musicales son diferentes a los preestablecidos en la base de datos
INSERT INTO place(place_no,place_town,place_country) VALUES (1,'chia','colombia');
INSERT INTO musician(m_no,m_name,born,died) VALUES (1,'Luis Carlos',TO_DATE('2000-08-30','YYYY-MM-DD'),null);
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES ('LOCOS',1,'vallenato',TO_DATE('2023-08-30','YYYY-MM-DD'),1);

--Aca no deja agregar nada porque el nombre de la banda es menor a una palabra
INSERT INTO band(band_name,band_home,band_type,b_date,band_contact) VALUES (' ',1,'vallenato',TO_DATE('2023-08-30','YYYY-MM-DD'),1);
