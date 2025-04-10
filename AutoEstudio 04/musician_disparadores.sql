----TABLAS
CREATE TABLE Band (
    band_no INT DEFAULT num_sequence.NEXTVAL,
    band_name VARCHAR2(20) NOT NULL,
    band_home INT NOT NULL,
    band_type VARCHAR2(10) NULL, 
    b_date DATE NULL,
    band_contact INT NOT NULL
);

CREATE TABLE Performer (
    perf_no INT NOT NULL,
    perf_is INT NOT NULL,
    instrument VARCHAR2(50) NULL,
    perf_type VARCHAR2(50) NOT NULL
);

CREATE TABLE Composer (
    comp_no INT NOT NULL,
    comp_is INT NOT NULL,
    comp_type VARCHAR2(50) NOT NULL
);


CREATE TABLE Musician (
    m_no INT NOT NULL,
    m_name VARCHAR2(100) NOT NULL,
    born DATE NOT NULL,
    died DATE NULL,
    born_in INT NOT NULL,
    living_in INT NOT NULL
);

CREATE TABLE Place (
    place_no INT NOT NULL,
    place_town VARCHAR2(100) NOT NULL,
    place_country VARCHAR2(100) NOT NULL
);

CREATE TABLE Plays_in (
    player INT NOT NULL,
    band_id INT NOT NULL
);

CREATE TABLE Performance (
    pfmnce_no INT NOT NULL,
    gave INT NOT NULL,
    performed INT NOT NULL,
    conducted_by INT NOT NULL,
    performed_in INT NOT NULL
);

--XTABLAS
ALTER TABLE Band DROP PRIMARY KEY CASCADE;
ALTER TABLE Performer DROP PRIMARY KEY CASCADE;
ALTER TABLE Composer DROP PRIMARY KEY CASCADE;
ALTER TABLE Musician DROP PRIMARY KEY CASCADE;
ALTER TABLE Place DROP PRIMARY KEY CASCADE;
ALTER TABLE Plays_in DROP PRIMARY KEY CASCADE;
ALTER TABLE Performance DROP PRIMARY KEY CASCADE;

DROP TABLE Band;
DROP TABLE Performer;
DROP TABLE Composer;
DROP TABLE Musician;
DROP TABLE Place;
DROP TABLE Plays_in;
DROP TABLE Performance;

----Atributos
--Primary Keys
ALTER TABLE Band
ADD CONSTRAINT PK_BAND PRIMARY KEY (band_no);

ALTER TABLE Performer
ADD CONSTRAINT PK_PERFORMER PRIMARY KEY (perf_no);

ALTER TABLE Composer
ADD CONSTRAINT PK_COMPOSER PRIMARY KEY (comp_no);

ALTER TABLE Musician
ADD CONSTRAINT PK_MUSICIAN PRIMARY KEY (m_no);

ALTER TABLE PLACE 
ADD CONSTRAINT PK_PLACE PRIMARY KEY (place_no);

ALTER TABLE PLAYS_IN
ADD CONSTRAINT PK1_PLAY PRIMARY KEY (player, band_id);

ALTER TABLE PERFORMANCE
ADD CONSTRAINT PK_PERFORMANCE PRIMARY KEY (pfmnce_no);

--Unique keys

ALTER TABLE Band
ADD CONSTRAINT UK_BAND UNIQUE (band_name);

--Foreign keys

ALTER TABLE PLAYS_IN
ADD CONSTRAINT FK_PERFORMER_PLAY FOREIGN KEY (player) references performer(perf_no)
ADD CONSTRAINT FK_BAND_PLAY FOREIGN KEY (band_id) references band(band_no);


ALTER TABLE MUSICIAN
ADD CONSTRAINT FK1_MUSICIAN_PLACE FOREIGN KEY (born_in) references place(place_no)
ADD CONSTRAINT FK2_MUSICIAN_PLACE FOREIGN KEY (living_in) references place(place_no);

ALTER TABLE PERFORMANCE 
ADD CONSTRAINT FK_PERFORMANCE_PLACE FOREIGN KEY (performed_in) references place(place_no);

ALTER TABLE BAND
ADD CONSTRAINT FK_BAND_PLACE FOREIGN KEY (band_home) references place(place_no)
ADD CONSTRAINT FK_BAND_MUSICIAN FOREIGN KEY (band_contact) references musician(m_no);

ALTER TABLE PERFORMANCE
ADD CONSTRAINT FK_PERFORMANCE_BAND FOREIGN KEY (gave) references band(band_no)
ADD CONSTRAINT FK_PERFORMANCE_MUSICIAN FOREIGN KEY (conducted_by) references musician(m_no);

ALTER TABLE COMPOSER
ADD CONSTRAINT FK_COMPOSER_MUSICIAN FOREIGN KEY (comp_is) references musician(m_no);

ALTER TABLE PERFORMER 
ADD CONSTRAINT FK_PERFORMER_MUSICIAN FOREIGN KEY (perf_is) references musician(m_no);


----TUPLAS

--TConsecutive Entero(9) Positivo consecutivo
CREATE SEQUENCE num_sequence
    START WITH 1 
    INCREMENT BY 1;

--TName Cadena(20) Minimo una palabra
ALTER TABLE Band ADD CONSTRAINT TName
CHECK (LENGTH(band_name)>1);

--TType
ALTER TABLE Band ADD CONSTRAINT TType
CHECK (band_type IN ('rock','classical','blues','pop','soul', 'jazz'));

ALTER TABLE BAND
DROP CONSTRAINT TType;

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



----Acciones referenciales
--Plays_in
ALTER TABLE PLAYS_IN
DROP CONSTRAINT FK_PERFORMER_PLAY;

ALTER TABLE PLAYS_IN
ADD CONSTRAINT FK_PERFORMER_PLAY FOREIGN KEY (player) 
REFERENCES performer(perf_no) 
ON DELETE CASCADE;

ALTER TABLE PLAYS_IN
DROP CONSTRAINT FK_BAND_PLAY;

ALTER TABLE PLAYS_IN
ADD CONSTRAINT FK_BAND_PLAY FOREIGN KEY (band_id) 
REFERENCES band(band_no) 
ON DELETE CASCADE;

--Musician
ALTER TABLE MUSICIAN
DROP CONSTRAINT FK1_MUSICIAN_PLACE;

ALTER TABLE MUSICIAN
ADD CONSTRAINT FK1_MUSICIAN_PLACE FOREIGN KEY (born_in) 
REFERENCES place(place_no) 
ON DELETE SET NULL;

ALTER TABLE MUSICIAN
DROP CONSTRAINT FK2_MUSICIAN_PLACE;

ALTER TABLE MUSICIAN
ADD CONSTRAINT FK2_MUSICIAN_PLACE FOREIGN KEY (living_in) 
REFERENCES place(place_no) 
ON DELETE SET NULL;

--Band
ALTER TABLE BAND
DROP CONSTRAINT FK_BAND_PLACE;

ALTER TABLE BAND
ADD CONSTRAINT FK_BAND_PLACE FOREIGN KEY (band_home)
REFERENCES place(place_no)
ON DELETE SET NULL;

ALTER TABLE BAND
DROP CONSTRAINT FK_BAND_MUSICIAN;

ALTER TABLE BAND 
ADD CONSTRAINT FK_BAND_MUSICIAN FOREIGN KEY (band_contact)
REFERENCES musician(m_no)
ON DELETE CASCADE;

--Composer
ALTER TABLE COMPOSER
DROP CONSTRAINT FK_COMPOSER_MUSICIAN;

ALTER TABLE COMPOSER
ADD CONSTRAINT FK_COMPOSER_MUSICIAN FOREIGN KEY (comp_is) 
REFERENCES musician(m_no) 
ON DELETE SET NULL;

--Performer
ALTER TABLE PERFORMER
DROP CONSTRAINT FK_PERFORMER_MUSICIAN;

ALTER TABLE PERFORMER
ADD CONSTRAINT FK_PERFORMER_MUSICIAN FOREIGN KEY (perf_is) 
REFERENCES musician(m_no) 
ON DELETE SET NULL;

--Performance
ALTER TABLE PERFORMANCE
DROP CONSTRAINT FK_PERFORMANCE_BAND;

ALTER TABLE PERFORMANCE
ADD CONSTRAINT FK_PERFORMANCE_BAND FOREIGN KEY (gave)
REFERENCES band(band_no)
ON DELETE CASCADE;


ALTER TABLE PERFORMANCE
DROP CONSTRAINT FK_PERFORMANCE_PLACE;

ALTER TABLE PERFORMANCE 
ADD CONSTRAINT FK_PERFORMANCE_PLACE FOREIGN KEY (performed_in)
REFERENCES place(place_no)
ON DELETE SET NULL;

ALTER TABLE PERFORMANCE
DROP CONSTRAINT FK_PERFORMANCE_MUSICIAN;

ALTER TABLE PERFORMANCE
ADD CONSTRAINT FK_PERFORMANCE_MUSICIAN FOREIGN KEY(conducted_by)
REFERENCES musician(m_no)
ON DELETE SET NULL;


INSERT INTO PLACE(place_no, place_town, place_country) VALUES (1, 'Manchester', 'England');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (2, 'Edinburgh', 'Scotland');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (3, 'Salzburg', 'Austria');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (4, 'New York', 'USA');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (5, 'Birmingham', 'England');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (6, 'Glasglow', 'Scotland');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (7, 'London', 'England');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (8, 'Chicago', 'USA');
INSERT INTO PLACE(place_no, place_town, place_country) VALUES (9, 'Amsterdam', 'Netherlands');

INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (1, 'Fred Bloggs', '02/03/1948', NULL, 1, 2);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (2, 'John Smith', '03/03/1950', NULL, 3, 4);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (3, 'Helen Smyth', '08/08/48', NULL, 4, 5);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (4, 'Harriet Smithson', '09/05/1909', '20/09/80', 5 ,6);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (5, 'James First', '10/06/1965', NULL, 7 ,7);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (6, 'Theo Mengel', '12/08/1948', NULL, 7 ,1);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (7, 'Sue Little', '21/02/1945', NULL, 8 ,9);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (8, 'Harry Forte', '28/02/1951', NULL, 1 ,8);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (9, 'Phil Hot', '30/06/1942', NULL, 2 ,7);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (10, 'Jeff Dawn', '12/12/1945', NULL, 3 ,6);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (11, 'Rose Spring', '25/05/1948', NULL, 4 ,5);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (12, 'Davis Heavan', '03/10/1975', NULL, 5 ,4);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (13, 'Lovely Time', '28/12/1948', NULL, 6 ,3);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (14, 'Alan Fluff', '15/01/1935', '15/05/1997', 7 ,2);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (15, 'Tony Smythe', '02/04/1932', NULL, 8 ,1);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (16, 'James Quick', '08/08/1924', NULL, 9 ,2);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (17, 'Freda Miles', '04/07/1920', NULL, 9 ,3);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (18, 'Elsie James', '06/05/1947', NULL, 8 ,5);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (19, 'Andy Jones', '08/10/1958', NULL, 7 ,6);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (20, 'Louise Simpson', '10/01/1948', '11/02/1998', 6 ,6);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (21, 'James Steeple', '10/01/1947', NULL, 5 ,6);
INSERT INTO MUSICIAN(m_no, m_name, born, died, born_in, living_in) VALUES (22, 'Steven Chaytors', '11/03/1956', NULL, 6 ,7);


INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(1, 'ROP', 5, 'classical', '30/01/2001', 11);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(2, 'AASO', 6, 'classical', NULL, 10);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(3, 'The J Bs', 8, 'jazz', NULL, 12);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(4, 'BBSO', 9, 'classical', NULL, 21);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(5, 'The left Overs', 2, 'jazz', NULL, 8);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(6, 'Somebody Love this', 1, 'jazz', NULL, 6);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(7, 'Oh well', 4, 'classical', NULL, 3);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(8, 'Swinging strings', 4, 'classical', NULL, 7);
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, band_contact) VALUES(9, 'The Rest', 9, 'jazz', NULL, 16);

INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(1,1,'jazz');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(2,3,'classical');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(3,5,'jazz');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(4,7,'classical');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(5,9,'jazz');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(6,11,'rock');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(7,13,'classical');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(8,15,'jazz');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(9,17,'classical');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(10,19,'jazz');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(11,10,'rock');
INSERT INTO COMPOSER(comp_no, comp_is, comp_type) VALUES(12,8,'jazz');


INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(1,2,'violin','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(2,4,'viola','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(3,6,'banjo','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(4,8,'violin','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(5,12,'guitar','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(6,14,'violin','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(7,16,'trumpet','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(8,18,'viola','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(9,20,'bass','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(10,2,'flute','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(11,20,'cornet','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(12,6,'violin','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(13,8,'drums','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(14,10,'violin','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(15,12,'cello','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(16,14,'viola','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(17,16,'flute','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(18,18,'guitar','not known');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(19,20,'trombone','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(20,3,'horn','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(21,5,'violin','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(22,7,'cello','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(23,2,'bass','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(24,4,'violin','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(25,6,'drums','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(26,8,'clarinet','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(27,10,'bass','jazz');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(28,12,'viola','classical');
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(29,18,'cello','classical');

INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(1,1,1,21,1);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(2,1,3,21,1);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(3,1,5,21,1);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(4,1,2,1,2);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(5,2,4,21,2);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(6,2,6,21,2);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(7,4,19,9,3);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(8,4,20,10,3);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(9,5,12,10,4);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(10,5,13,11,4);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(11,3,5,13,5);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(12,3,6,13,5);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(13,3,7,13,5);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(14,6,20,14,6);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(15,8,12,15,7);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(16,9,16,21,8);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(17,9,17,21,8);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(18,9,18,21,8);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(19,9,19,21,8);
INSERT INTO PERFORMANCE(pfmnce_no, gave, performed, conducted_by, performed_in) VALUES(20,4,12,10,3);

INSERT INTO PLAYS_IN(player, band_id) VALUES(1,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(1,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(3,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(4,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(4,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(5,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(6,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(6,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(7,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(8,1);
INSERT INTO PLAYS_IN(player, band_id) VALUES(8,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(10,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(12,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(13,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(14,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(14,8);
INSERT INTO PLAYS_IN(player, band_id) VALUES(15,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(15,8);
INSERT INTO PLAYS_IN(player, band_id) VALUES(17,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(18,2);
INSERT INTO PLAYS_IN(player, band_id) VALUES(19,3);
INSERT INTO PLAYS_IN(player, band_id) VALUES(20,3);
INSERT INTO PLAYS_IN(player, band_id) VALUES(21,4);
INSERT INTO PLAYS_IN(player, band_id) VALUES(22,4);
INSERT INTO PLAYS_IN(player, band_id) VALUES(23,4);
INSERT INTO PLAYS_IN(player, band_id) VALUES(25,5);
INSERT INTO PLAYS_IN(player, band_id) VALUES(26,6);
INSERT INTO PLAYS_IN(player, band_id) VALUES(27,6);
INSERT INTO PLAYS_IN(player, band_id) VALUES(28,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(28,8);
INSERT INTO PLAYS_IN(player, band_id) VALUES(29,7);

TRUNCATE TABLE PLAYS_IN;
TRUNCATE TABLE PERFORMANCE;
TRUNCATE TABLE COMPOSER;
TRUNCATE TABLE PERFORMER;
TRUNCATE TABLE BAND;
TRUNCATE TABLE MUSICIAN;
TRUNCATE TABLE PLACE;

---ON DELETE CASCADE con Plays_in y performer
DELETE FROM Performer WHERE perf_no = 28;
DELETE FROM Performer WHERE perf_no = 25;

SELECT * FROM PLAYS_IN;
SELECT * FROM PERFORMER;

---ON DELETE CASCADE con Band y Performance
DELETE FROM Band WHERE band_no = 5;
DELETE FROM Band WHERE band_no = 1;

SELECT * FROM BAND;
SELECT * FROM PERFORMANCE;

---ON DELETE SET NULL con Musician y Place
DELETE FROM Place WHERE place_no = 4;
DELETE FROM Place WHERE place_no = 1;

SELECT * FROM MUSICIAN;
SELECT * FROM PLACE;

---ON MUSICIAN SET NULL con Performer y Musician
DELETE FROM Musician WHERE m_no = 21;
DELETE FROM Musician WHERE m_no = 7;


---Disparadores
---El número se genera automáticamente: es un consecutivo
---El nombre de la banda debe tener mínimo una palabra
---Si no se indica el tipo de banda, se asume que es 'rock'
---La fecha debe ser menor a la del dia de hoy, si se indica.
CREATE OR REPLACE TRIGGER TR_BAND_BI
BEFORE INSERT ON Band
FOR EACH ROW
BEGIN
    -- Generar el número automáticamente (esto se maneja por la secuencia)
    IF :NEW.band_no IS NULL THEN
        SELECT num_sequence.NEXTVAL INTO :NEW.band_no FROM dual;  -- Utiliza la secuencia para el band_no
    END IF;

    -- Verificar que el nombre de la banda tenga al menos una palabra
    IF :NEW.band_name IS NULL OR LENGTH(TRIM(:NEW.band_name)) = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El nombre de la banda debe tener al menos una palabra.');
    END IF;

    -- Asumir que el tipo de banda es 'rock' si no se indica
    IF :NEW.band_type IS NULL THEN
        :NEW.band_type := 'rock';
    END IF;

    -- Verificar que la fecha sea menor que la de hoy si se proporciona
    IF :NEW.b_date IS NOT NULL AND :NEW.b_date >= TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20002, 'La fecha debe ser anterior a la fecha actual.');
    END IF;
END;
/



---De los datos generales, únicamente se pude modificar la fecha, si no se había dado.
CREATE OR REPLACE TRIGGER TR_BAND_BU
BEFORE UPDATE ON Band
FOR EACH ROW
BEGIN
    -- Permitir la actualización de la fecha solo si no se había dado
    IF :OLD.b_date IS NOT NULL AND :NEW.b_date IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20003, 'Solo se puede modificar la fecha si no se había dado previamente.');
    END IF;
END;
/



---Es posible adicionar y eliminar músicos, no modificarlos.
CREATE OR REPLACE TRIGGER TR_PLAYS_IN_BU
BEFORE UPDATE ON Plays_in
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20004, 'No se puede modificar el registro de un músico en Plays_in. Solo se permiten inserciones y eliminaciones.');
END;
/


---Máximo pueden existir 10 músicos en una banda
CREATE OR REPLACE TRIGGER TR_PLAYS_IN_BI
BEFORE INSERT ON Plays_in
FOR EACH ROW
DECLARE
    v_count INT;
BEGIN
    -- Contar el número de músicos en la banda
    SELECT COUNT(*)
    INTO v_count
    FROM Plays_in
    WHERE band_id = :NEW.band_id;

    IF v_count >= 10 THEN
        RAISE_APPLICATION_ERROR(-20005, 'No se pueden agregar más de 10 músicos en una banda.');
    END IF;
END;
/


DROP TRIGGER TR_BAND_BI;
DROP TRIGGER TR_BAND_BU;
DROP TRIGGER TR_PLAYS_IN_BU;
DROP TRIGGER TR_PLAYS_IN_BI;


---Uso del disparador (que funcione)

---TR_BAND_BI
INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'The Rockers', 2, 'rock', TO_DATE('2015-05-01', 'YYYY-MM-DD'), 5);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Blues Brothers', 3, 'blues', TO_DATE('2010-10-15', 'YYYY-MM-DD'), 8);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Soul Vibes', 5, 'soul', TO_DATE('2018-07-20', 'YYYY-MM-DD'), 11);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Pop Stars', 7, 'pop', TO_DATE('2020-03-05', 'YYYY-MM-DD'), 15);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Classical Harmony', 9, 'classical', TO_DATE('2005-11-25', 'YYYY-MM-DD'), 22);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'The New Popes', 4, 'classical', NULL, 12);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Chin Chan', 2, 'jazz', NULL, 21);

INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Amino', 6, 'rock', NULL, 5);

SELECT * FROM BAND;

---TR_BAND_BU
UPDATE Band 
SET b_date = TO_DATE('2020-01-01', 'YYYY-MM-DD') 
WHERE band_no = 11;

UPDATE Band 
SET b_date = TO_DATE('2006-03-02', 'YYYY-MM-DD') 
WHERE band_no = 12;

UPDATE Band 
SET b_date = TO_DATE('2006-03-27', 'YYYY-MM-DD') 
WHERE band_no = 13;


---TR_PLAYS_IN_BU
INSERT INTO PLAYS_IN(player, band_id) VALUES(3,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(4,7);
INSERT INTO PLAYS_IN(player, band_id) VALUES(19,11);
INSERT INTO PLAYS_IN(player, band_id) VALUES(12,6);
INSERT INTO PLAYS_IN(player, band_id) VALUES(8,10);


--TR_PLAYS_IN_BI
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO Plays_in (player, band_id) 
        VALUES (i, 8);  
    END LOOP;
END;

SELECT * FROM PLAYS_IN

---Uso del disparador (RAISE_APPLICATION_ERROR)

---TR_BAND_BI

---Debe fallar porque band_name = NULL
INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, NULL, 2, 'jazz', TO_DATE('2015-05-01', 'YYYY-MM-DD'), 5);

---Como band_type = NULL, se toma automáticamente como 'rock'
INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'The Messis', 2, NULL, TO_DATE('2015-05-01', 'YYYY-MM-DD'), 5);

---Debe fallar porque el año es en el 2025 y la fecha debe ser menor a la actual
INSERT INTO Band (band_no, band_name, band_home, band_type, b_date, band_contact) 
VALUES (num_sequence.NEXTVAL, 'Football', 2, 'blues', TO_DATE('2025-05-01', 'YYYY-MM-DD'), 5);

---TR_BAND_BU

---Debe fallar porque se está modificando una fecha existente; solo se puede modificar si b_date = NULL
UPDATE Band 
SET b_date = TO_DATE('2020-01-01', 'YYYY-MM-DD') 
WHERE band_no = 6;

UPDATE Band 
SET b_date = TO_DATE('2006-03-02', 'YYYY-MM-DD') 
WHERE band_no = 7;

UPDATE Band 
SET b_date = TO_DATE('2006-03-27', 'YYYY-MM-DD') 
WHERE band_no = 8;

UPDATE Band 
SET b_date = TO_DATE('2010-12-17', 'YYYY-MM-DD') 
WHERE band_no = 9;

UPDATE Band 
SET b_date = TO_DATE('2005-09-14', 'YYYY-MM-DD') 
WHERE band_no = 10;

---TR_PLAYS_IN_BU

---Debe fallar porque solo se pueden agregar o eliminar músicos, no eliminarlos
UPDATE Plays_in 
SET player = 3 
WHERE player = 4 AND band_id = 7;

UPDATE Plays_in 
SET player = 27
WHERE player = 12 AND band_id = 6;

---TR_PLAYS_IN_BI
INSERT INTO PLAYS_IN(player, band_id) VALUES (11,8);
INSERT INTO PLAYS_IN(player, band_id) VALUES (12,8);



