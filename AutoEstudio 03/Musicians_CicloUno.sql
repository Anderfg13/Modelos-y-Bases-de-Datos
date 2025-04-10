
CREATE TABLE band (
    band_no INT,
    band_name VARCHAR(100),
    band_home INT,
    band_type VARCHAR2(50),
    b_date DATE,
    band_contact INT
);

CREATE TABLE composer (
    comp_no INT,
    comp_is INT,
    comp_type VARCHAR2(50)
);


CREATE TABLE concert (
    concert_no INT,
    concert_venue VARCHAR2(100),
    concert_in INT,
    con_date DATE,
    concert_organiser INT
);

CREATE TABLE musician (
    m_no INT,
    m_name VARCHAR2(100),
    born DATE,
    died DATE,
    born_in INT,
    living_in INT
);

CREATE TABLE performance (
    pfmnce_no INT,
    gave INT,
    performed INT,
    conducted_by INT,
    performed_in INT
);

CREATE TABLE performer (
    perf_no INT,
    perf_is INT,
    instrument VARCHAR2(50),
    perf_type VARCHAR2(50)
);

CREATE TABLE place (
    place_no INT,
    place_town VARCHAR2(100),
    place_country VARCHAR2(100)
);

CREATE TABLE plays_in (
    player INT,
    band_id INT
);


ALTER TABLE MUSICIAN
ADD CONSTRAINT PK_MUSICIAN PRIMARY KEY (m_no)
;

ALTER TABLE BAND
ADD CONSTRAINT PK_BAND PRIMARY KEY (band_no);

ALTER TABLE COMPOSER
ADD CONSTRAINT PK_COMPOSER PRIMARY KEY (comp_no);

ALTER TABLE CONCERT
ADD CONSTRAINT PK_CONCERT PRIMARY KEY (concert_no);

ALTER TABLE PERFORMANCE
ADD CONSTRAINT PK_PERFORMANCE PRIMARY KEY (pfmnce_no);

ALTER TABLE PERFORMER 
ADD CONSTRAINT PK_PERFORMER PRIMARY KEY (perf_no);

ALTER TABLE PLACE 
ADD CONSTRAINT PK_PLACE PRIMARY KEY (place_no);

ALTER TABLE PLAYS_IN
ADD CONSTRAINT PK1_PLAY PRIMARY KEY (player, band_id);

ALTER TABLE PLAYS_IN
ADD CONSTRAINT FK_PERFORMER_PLAY FOREIGN KEY (player) references performer(perf_no)
ADD CONSTRAINT FK_BAND_PLAY FOREIGN KEY (band_id) references band(band_no);


ALTER TABLE MUSICIAN
ADD CONSTRAINT FK1_MUSICIAN_PLACE FOREIGN KEY (born_in) references place(place_no)
ADD CONSTRAINT FK2_MUSICIAN_PLACE FOREIGN KEY (living_in) references place(place_no);

ALTER TABLE CONCERT
ADD CONSTRAINT FK_CONCERT_PLACE FOREIGN KEY (concert_in) references place(place_no);

ALTER TABLE PERFORMANCE 
ADD CONSTRAINT FK_PERFORMANCE_PLACE FOREIGN KEY (performed_in) references place(place_no);

ALTER TABLE BAND
ADD CONSTRAINT FK_BAND_PLACE FOREIGN KEY (band_home) references place(place_no);

ALTER TABLE PERFORMANCE
ADD CONSTRAINT FK_PERFORMANCE_BAND FOREIGN KEY (gave) references band(band_no)
ADD CONSTRAINT FK_PERFORMANCE_MUSICIAN FOREIGN KEY (conducted_by) references musician(m_no);

ALTER TABLE COMPOSER
ADD CONSTRAINT FK_COMPOSER_MUSICIAN FOREIGN KEY (comp_is) references musician(m_no);

ALTER TABLE PERFORMER 
ADD CONSTRAINT FK_PERFORMER_MUSICIAN FOREIGN KEY (perf_is) references musician(m_no);

ALTER TABLE CONCERT
ADD CONSTRAINT FK_CONCERT_MUSICIAN FOREIGN KEY (concert_organiser) references musician(m_no);

ALTER TABLE BAND
ADD CONSTRAINT FK_BAND_MUSICIAN FOREIGN KEY (band_contact) references musician(m_no);


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


INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (1, 'Bridgewater Hall', 1, '06/01/1995', 21);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (2, 'Bridgewater Hall', 1,'08/05/1996', 3);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (3, 'Usher Hall', 2, '03/06/1995', 3);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (4, 'Assembly Rooms', 2, '20/09/1997', 21);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (5, 'Festspiel Haus', 3, '21/02/1995', 8);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (6, 'Royal Albert Hall', 7, '12/04/1993', 8);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (7, 'Concertgebouw', 9, '14/05/1993', 8);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date, concert_organiser) VALUES (8, 'Metropolitan', 4, '15/06/1997', 21);

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

--PoblarNoOK
INSERT INTO BAND(band_no, band_name, band_home, band_type, b_date, b_contact) VALUES (10,'ROCK-N-JAZZ','Manchester','jazz',NULL,9);
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date,concert_orgniser) VALUES (9,'Royal Albert Hall',12,'12/04/1993',8);
INSERT INTO PLACE(place_no, place_town, place_country) VALUES(3, 'Bogota', 'Colombia');
INSERT INTO CONCERT(concert_no, concert_venue, concert_in, con_date,concert_orgniser) VALUES(9,'Royal Albert Hall',1,'31/02/1993',21);
INSERT INTO PERFORMER(perf_no, perf_is, instrument, perf_type) VALUES(13, 2, 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', 'jazz');
--CONSULTA 1
SELECT 
    m.m_name AS Nombre,
    LTRIM(
        NVL2(p.perf_is, 'Intérprete, ', '') ||
        NVL2(c.comp_is, 'Compositor, ', '') ||
        NVL2(b.band_contact, 'Director, ', '') ||
        NVL2(co.concert_organiser, 'Organizador, ', '') ||
        NVL2(pf.conducted_by, 'Conductor, ', ''),
        ', '
    ) AS Roles
FROM 
    musician m
LEFT JOIN performer p ON m.m_no = p.perf_is
LEFT JOIN composer c ON m.m_no = c.comp_is
LEFT JOIN band b ON m.m_no = b.band_contact
LEFT JOIN concert co ON m.m_no = co.concert_organiser
LEFT JOIN performance pf ON m.m_no = pf.conducted_by
WHERE (b.band_contact IS NOT NULL AND co.concert_organiser IS NOT NULL)
GROUP BY 
    m.m_no,
    m.m_name,
    p.perf_is,
    c.comp_is,
    b.band_contact,
    co.concert_organiser,
    pf.conducted_by
HAVING 
    LTRIM(
        NVL2(p.perf_is, 'Intérprete, ', '') ||
        NVL2(c.comp_is, 'Compositor, ', '') ||
        NVL2(b.band_contact, 'Director, ', '') ||
        NVL2(co.concert_organiser, 'Organizador, ', '') ||
        NVL2(pf.conducted_by, 'Conductor, ', ''),
        ', '
    ) IS NOT NULL
ORDER BY 
    m.m_name


--Consulta 2
SELECT m_name, band_name
FROM musician
JOIN plays_in
ON m_no = player
JOIN band
ON band_id = band_no
WHERE b_date IS NOT NULL


--Consulta 3
SELECT m_name, perf_type, band_type
FROM musician
JOIN performer
ON m_no = perf_no
JOIN band
ON m_no = band_contact
WHERE perf_type = band_type


--Consulta 4
SELECT DISTINCT place_town, concert_no, pfmnce_no
FROM place
JOIN concert
ON place_no = concert_in
JOIN performance
ON place_no = performed_in
GROUP BY place_town, concert_no, pfmnce_no
ORDER BY place_town


--Consulta 5
SELECT place_country, band_name, m_name AS Conducted_by 
FROM place
JOIN band
ON place_no = band_home



ALTER TABLE PLAYS_IN DISABLE CONSTRAINT FK_PERFORMER_PLAY;
ALTER TABLE PLAYS_IN DISABLE CONSTRAINT FK_BAND_PLAY;
ALTER TABLE MUSICIAN DISABLE CONSTRAINT FK1_MUSICIAN_PLACE;
ALTER TABLE MUSICIAN DISABLE CONSTRAINT FK2_MUSICIAN_PLACE;
ALTER TABLE CONCERT DISABLE CONSTRAINT FK_CONCERT_PLACE;
ALTER TABLE PERFORMANCE DISABLE CONSTRAINT FK_PERFORMANCE_PLACE;
ALTER TABLE BAND DISABLE CONSTRAINT FK_BAND_PLACE;
ALTER TABLE PERFORMANCE DISABLE CONSTRAINT FK_PERFORMANCE_BAND;
ALTER TABLE PERFORMANCE DISABLE CONSTRAINT FK_PERFORMANCE_MUSICIAN;
ALTER TABLE COMPOSER DISABLE CONSTRAINT FK_COMPOSER_MUSICIAN;
ALTER TABLE PERFORMER DISABLE CONSTRAINT FK_PERFORMER_MUSICIAN;
ALTER TABLE CONCERT DISABLE CONSTRAINT FK_CONCERT_MUSICIAN;
ALTER TABLE BAND DISABLE CONSTRAINT FK_BAND_MUSICIAN;


TRUNCATE TABLE PLAYS_IN;
TRUNCATE TABLE PERFORMANCE;
TRUNCATE TABLE CONCERT;
TRUNCATE TABLE COMPOSER;
TRUNCATE TABLE PERFORMER;
TRUNCATE TABLE BAND;
TRUNCATE TABLE MUSICIAN;
TRUNCATE TABLE PLACE;

SELECT 'PLAYS_IN' AS table_name, COUNT(*) AS row_count FROM PLAYS_IN
UNION ALL
SELECT 'PERFORMANCE', COUNT(*) FROM PERFORMANCE
UNION ALL
SELECT 'CONCERT', COUNT(*) FROM CONCERT
UNION ALL
SELECT 'COMPOSER', COUNT(*) FROM COMPOSER
UNION ALL
SELECT 'PERFORMER', COUNT(*) FROM PERFORMER
UNION ALL
SELECT 'BAND', COUNT(*) FROM BAND
UNION ALL
SELECT 'MUSICIAN', COUNT(*) FROM MUSICIAN
UNION ALL
SELECT 'PLACE', COUNT(*) FROM PLACE;


DROP TABLE PLAYS_IN;
DROP TABLE PERFORMANCE;
DROP TABLE PERFORMER;
DROP TABLE MUSICIAN;
DROP TABLE COMPOSER;
DROP TABLE CONCERT;
DROP TABLE PLACE;
DROP TABLE BAND;

SELECT * FROM BAND
