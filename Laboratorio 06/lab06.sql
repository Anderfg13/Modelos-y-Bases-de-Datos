--Actulizar la definicion de la tabla
CREATE TABLE Ofertas(
    numero VARCHAR2(9),
    fecha DATE NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    tipoVivienda VARCHAR2(1) NOT NULL,
    costo INT NOT NULL,
    anexos XMLTYPE NULL, --Se hizo de esta manera, ya que con Alter Table mostraba un error.
    estado VARCHAR2(1) NOT NULL,
    codigo_opcioncreditos VARCHAR2(11) NOT NULL,
    id_Usuario VARCHAR2(5) NOT NULL,
    codigo_ubicacion VARCHAR2(11) NOT NULL
);

--PRIMARY KEY
ALTER TABLE OFERTAS
ADD CONSTRAINT PK_OFERTAS PRIMARY KEY(numero);

--CHECKS
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS CHECK (estado IN ('V', 'N', 'D'));
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));
ALTER TABLE OFERTAS
ADD CONSTRAINT CHK_MONEDA_COSTO CHECK (costo > 0);

ALTER TABLE Ofertas DROP PRIMARY KEY CASCADE;
DROP TABLE Ofertas;


--POBLAROK
--1) 
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('0001', SYSDATE, 'Av. Villalobos 123', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre, numero, url?, tip_doc?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Certificado de libertad</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Certificado de libertad</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.pdf</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'US01', 'UB01'
);
--2) 
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('0002', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre, numero, url?, tip_doc?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Certificado de libertad</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.txt</tip_doc>
        </anexo>
    </anexos>'),'D','OP12354', 'US02', 'UB02'
);
--3)
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('0003', SYSDATE, 'Av. Flores 312', 'C', 35000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre, numero, url?, tip_doc?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.pdf</tip_doc>
        </anexo>
    </anexos>'),'N','OP12354', 'US03', 'UB03'
);

--4)
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('0004', SYSDATE, 'Av. San Francisco 46', 'C', 256000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre, numero, url?, tip_doc?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.exe</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'US04', 'UB04'
);

--5)
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('0005', SYSDATE, 'Av. Puerto Rico 222', 'C', 2500000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre, numero, url?, tip_doc?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.pdf</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'US05', 'UB05'
);

SELECT * FROM Oferta;

--POBLARNOOK
--1) Se usa nombre en la insercion, pero en la definicion del XML no se definio que es.
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('OF01', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (numero, url?, tip_doc?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.pdf</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'USR01', 'LOC001'
);

--2) En la definicion del XML hace falta tip_doc?.
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('OF01', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre, numero, url?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.txt</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'USR01', 'LOC001'
);

--3) Anexo sin tipo de documento (Debe ser obligtorio).
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('OF01', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre?, numero?, url?,tip_doc)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.zip</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'USR01', 'LOC001'
);

--4) No esta bien diseñada la parte del XML (Falta crear <Anexo>)
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('OF01', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre?, numero?, url?,tip_doc)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
            <nombre>Documento B</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.zip</tip_doc>
    </anexos>'),'V','OP12354', 'USR01', 'LOC001'
);

--5) No se cierra correctamente <numero>
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('OF01', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre?, numero?, url?,tip_doc)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Documento A</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
        </anexo>
        <anexo>
            <nombre>Documento B</nombre>
            <numero>67890<numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.zip</tip_doc>
        </anexo>
    </anexos>'),'V','OP12354', 'USR01', 'LOC001'
);
SELECT * FROM Oferta;

--3. Implemente la consulta Consultar ofertas sin certificado de libertad en pdf
SELECT numero, fecha, direccion, tipoVivienda, costo, estado
FROM Ofertas
WHERE NOT EXISTS (
    SELECT 1
    FROM XMLTable(
        '/anexos/anexo' 
        PASSING anexos 
        COLUMNS 
            nombre VARCHAR2(50) PATH 'nombre',
            tip_doc VARCHAR2(10) PATH 'tip_doc'
    ) t
    WHERE t.nombre = 'Certificado de libertad'
      AND t.tip_doc = '.pdf'
);
--4. Consulta que muestra de manera general la informacion de los anexos
SELECT 
    o.numero,
    o.direccion,
    o.costo,
    o.estado,
    o.tipoVivienda,
    doc.anexos_disponibles
FROM Ofertas o
LEFT JOIN (
    SELECT 
        numero,
        LISTAGG(nombre || ' (' || COALESCE(tip_doc, 'Sin tipo') || ')', ', ') WITHIN GROUP (ORDER BY nombre) AS anexos_disponibles
    FROM (
        SELECT 
            o.numero,
            x.nombre,
            x.tip_doc
        FROM Ofertas o,
        XMLTable(
            '/anexos/anexo' 
            PASSING o.anexos
            COLUMNS 
                nombre VARCHAR2(50) PATH 'nombre',
                tip_doc VARCHAR2(10) PATH 'tip_doc'
        ) x
    )
    GROUP BY numero
) doc ON o.numero = doc.numero
WHERE NOT EXISTS (
    SELECT 1
    FROM XMLTable(
        '/anexos/anexo' 
        PASSING o.anexos 
        COLUMNS 
            nombre VARCHAR2(50) PATH 'nombre',
            tip_doc VARCHAR2(10) PATH 'tip_doc'
    ) t
    WHERE t.nombre = 'Certificado de libertad'
      AND t.tip_doc = '.pdf'
)
ORDER BY o.costo DESC;

    
--5. Diseño

<!ELEMENT anexos (anexo+)>
<!ELEMENT anexo (nombre?, numero?, url?,tip_doc?,observacion,c_hojas?,tam_archivo?)>
<!ELEMENT nombre (#PCDATA)>
<!ELEMENT numero (#PCDATA)>
<!ELEMENT url (#PCDATA)>
<!ELEMENT tip_doc (#PCDATA)>
<!ELEMENT observacion (#PCDATA)>
<!ELEMENT c_hojas (#PCDATA)>
<!ELEMENT tam_archivo (#PCDATA)>


--Implementacion
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_opcioncreditos, id_Usuario, codigo_ubicacion)
VALUES ('OF06', SYSDATE, 'Av. Libertador 456', 'C', 250000,
    XMLType('<?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE anexos [
    <!ELEMENT anexos (anexo+)>
    <!ELEMENT anexo (nombre?, numero?, url?, tip_doc?, observacion, c_hojas?, tam_archivo?)>
    <!ELEMENT nombre (#PCDATA)>
    <!ELEMENT numero (#PCDATA)>
    <!ELEMENT url (#PCDATA)>
    <!ELEMENT tip_doc (#PCDATA)>
    <!ELEMENT observacion (#PCDATA)>
    <!ELEMENT c_hojas (#PCDATA)>
    <!ELEMENT tam_archivo (#PCDATA)>
    ]>
    <anexos>
        <anexo>
            <nombre>Certificado de libertad</nombre>
            <numero>12345</numero>
            <url>http://example.com/documentoA</url>
            <observacion>Certificado válido</observacion>
            <c_hojas>2</c_hojas>
            <tam_archivo>1.2 MB</tam_archivo>
        </anexo>
        <anexo>
            <nombre>Certificado de libertad</nombre>
            <numero>67890</numero>
            <url>http://example.com/documentoB</url>
            <tip_doc>.pdf</tip_doc>
            <observacion>Certificado actualizado</observacion>
            <c_hojas>3</c_hojas>
            <tam_archivo>1.5 MB</tam_archivo>
        </anexo>
    </anexos>'),'V','OP12354', 'USR01', 'LOC001'
);

SELECT * FROM Oferta WHERE numero ='OF06';


--CONSULTA (Consulta que devuelve numero de la oferta, Nombre del documento, Observacion, Cantidad de Hojas y Tamaño del archivo)
--Todo esto para que el abogado pueda hacer un analisis del costo de la propiedad
SELECT 
    numero AS "Número de Oferta", 
    nombre AS "Nombre del Documento", 
    observacion AS "Observación", 
    c_hojas AS "Cantidad de Hojas", 
    tam_archivo AS "Tamaño del Archivo"
FROM 
    Ofertas o,
    XMLTABLE(
        '/anexos/anexo' 
        PASSING o.anexos
        COLUMNS 
            nombre VARCHAR2(100) PATH 'nombre',
            observacion VARCHAR2(255) PATH 'observacion',
            c_hojas VARCHAR2(10) PATH 'c_hojas',
            tam_archivo VARCHAR2(20) PATH 'tam_archivo'
    ) a
WHERE 
    o.numero = 'OF06';


