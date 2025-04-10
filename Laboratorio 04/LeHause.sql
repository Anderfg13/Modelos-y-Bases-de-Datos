CREATE TABLE Usuarios(
    identification VARCHAR2 (5),
    fechaRegistro TIMESTAMP NOT NULL,
    correoElectronico VARCHAR2 (50) NOT NULL
);
/

CREATE TABLE NumerosContactos (
    id_Usuarios VARCHAR2 (5),
    numerosContactos VARCHAR2 (10)
);
/

CREATE TABLE PersonasNaturales(
    id_Usuarios VARCHAR2(5),
    tipoDocumento VARCHAR2(20),
    numeroDocumento VARCHAR2(20),
    nombres VARCHAR2(20) NOT NULL,
    nacionalidad VARCHAR2(10) NOT NULL
);
/

CREATE TABLE Empresas(
    id_Usuarios VARCHAR2 (5),
    id_Usuarios2 VARCHAR2(5) NOT NULL,
    NIT VARCHAR2 (10) NOT NULL,
    razonSocial VARCHAR2(100) NOT NULL
);
/

CREATE TABLE Ofertas(
    numero INT,
    id_Usuario VARCHAR2(5) NOT NULL,
    codigo_ubicacion VARCHAR2(11) NOT NULL,
    codigo_opcioncreditos NUMBER NOT NULL,
    fecha DATE NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    tipoVivienda VARCHAR2(50) NOT NULL,
    costo INT NOT NULL,
    anexos VARCHAR2(100) NULL,
    estado VARCHAR2(1) NOT NULL
);
/

CREATE TABLE Fotografias(
    nombre VARCHAR2(15),
    ruta VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL
);
/

CREATE TABLE FotografiasXOfertas(
    numero_Ofertas NUMBER,
    nombre_Fotografias VARCHAR2(15) NOT NULL
);
/

CREATE TABLE OpcionCreditos(
    codigo NUMBER,
    plazo NUMBER NOT NULL,
    valorMensual INT NOT NULL
);
/

CREATE TABLE Demandas(
    numero INT,
    id_usuario VARCHAR2(5) NOT NULL,
    fecha DATE NOT NULL,
    tipoVivienda VARCHAR2(1) NULL,
    maxCompra INT NOT NULL
);
/   

CREATE TABLE OrigenFondos(
    numero_demandas NUMBER,
    valor INT NOT NULL,
    credito NUMBER(1) NOT NULL,
    estaAprobado NUMBER(1) NULL
);
/

CREATE TABLE GestionAvisos(
    codigo VARCHAR2(9),
    numero_demanda NUMBER NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    fechaCreacion DATE NOT NULL,
    mensaje VARCHAR2(100) NOT NULL,
    estado VARCHAR2(20) NOT NULL
);
/

CREATE TABLE Alertas(
    codigo_Avisos VARCHAR(9),
    estado VARCHAR2(20) NOT NULL,
    fecha TIMESTAMP NOT NULL
);
/


CREATE TABLE Ubicaciones(
    codigo VARCHAR2(11),
    latitud NUMBER(3) NOT NULL,
    longitud  NUMBER(3) NOT NULL,
    ciudad VARCHAR2(10) NOT NULL,
    zona VARCHAR2(1) NOT NULL,
    barrio VARCHAR2(10) NOT NULL
);
/

CREATE TABLE UbicacionesXDemandas(
    numero_Demanda NUMBER,
    codigo_Ubicaciones VARCHAR2(11),
    nivel VARCHAR2(1) NOT NULL
);
/

--XTABLA

ALTER TABLE Usuarios DROP PRIMARY KEY CASCADE;
ALTER TABLE NumerosContactos DROP PRIMARY KEY CASCADE;
ALTER TABLE PersonasNaturales DROP PRIMARY KEY CASCADE;
ALTER TABLE Empresas DROP PRIMARY KEY CASCADE;
ALTER TABLE Ofertas DROP PRIMARY KEY CASCADE;
ALTER TABLE Fotografias DROP PRIMARY KEY CASCADE;
ALTER TABLE FotografiasXOfertas DROP PRIMARY KEY CASCADE;
ALTER TABLE OpcionCreditos DROP PRIMARY KEY CASCADE;
ALTER TABLE Demandas DROP PRIMARY KEY CASCADE;
ALTER TABLE OrigenFondos DROP PRIMARY KEY CASCADE;
ALTER TABLE GestionAvisos DROP PRIMARY KEY CASCADE;
ALTER TABLE Alertas DROP PRIMARY KEY CASCADE;
ALTER TABLE Ubicaciones DROP PRIMARY KEY CASCADE;
ALTER TABLE UbicacionesXDemandas DROP PRIMARY KEY CASCADE;

DROP TABLE Usuarios;
DROP TABLE NumerosContactos;
DROP TABLE PersonasNaturales;
DROP TABLE Empresas;
DROP TABLE Ofertas;
DROP TABLE Fotografias;
DROP TABLE FotografiasXOfertas;
DROP TABLE OpcionCreditos;
DROP TABLE Demandas;
DROP TABLE OrigenFondos;
DROP TABLE GestionAvisos;
DROP TABLE Alertas;
DROP TABLE Ubicaciones;
DROP TABLE UbicacionesXDemandas;

--Primarias
ALTER TABLE Usuarios
ADD CONSTRAINT PK_USUARIOS PRIMARY KEY(identification);

ALTER TABLE NumerosContactos
ADD CONSTRAINT PK_NUMEROS PRIMARY KEY(numerosContactos);

ALTER TABLE PersonasNaturales
ADD CONSTRAINT PK_PERSONAN PRIMARY KEY(id_Usuarios);

ALTER TABLE Empresas
ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY(id_Usuarios);

ALTER TABLE OFERTAS
ADD CONSTRAINT PK_OFERTAS PRIMARY KEY(numero);

ALTER TABLE Fotografias
ADD CONSTRAINT PK_FOTOGRAFIAS PRIMARY KEY(nombre);

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT PK_FOTO PRIMARY KEY(nombre_Fotografias,numero_Ofertas);

ALTER TABLE OpcionCreditos
ADD CONSTRAINT PK_CREDITOS PRIMARY KEY(codigo);

ALTER TABLE Demandas
ADD CONSTRAINT PK_DEMANDAS PRIMARY KEY(numero);

ALTER TABLE OrigenFondos
ADD CONSTRAINT PK_FONDOS PRIMARY KEY(numero_demandas);

ALTER TABLE GestionAvisos
ADD CONSTRAINT PK_AVISOS PRIMARY KEY(codigo);

ALTER TABLE ALERTAS
ADD CONSTRAINT PK_ALERTAS PRIMARY KEY(codigo_Avisos);

ALTER TABLE Ubicaciones
ADD CONSTRAINT PK_UBICACION PRIMARY KEY(codigo);

ALTER TABLE UbicacionesXDemandas
ADD CONSTRAINT PK_UBIXDEM PRIMARY KEY(numero_Demanda, codigo_Ubicaciones);




--Unicas
ALTER TABLE PersonasNaturales
ADD CONSTRAINT UK_PERSONAN UNIQUE(tipoDocumento, numeroDocumento);

ALTER TABLE EMPRESAS
ADD CONSTRAINT UK_EMPRESAS UNIQUE(NIT);


ALTER TABLE Usuarios
ADD CONSTRAINT UK_CORREO UNIQUE(correoElectronico);


--Foraneas

ALTER TABLE NumerosContactos
ADD CONSTRAINT FK_NC_USUARIO FOREIGN KEY (id_Usuarios) references Usuarios(identification);

ALTER TABLE PersonasNaturales
ADD CONSTRAINT FK_PN_USUARIO FOREIGN KEY (id_Usuarios) references Usuarios(identification);

ALTER TABLE Empresas
ADD CONSTRAINT FK_EMPRESA_USUARIO FOREIGN KEY (id_Usuarios) references Usuarios(identification);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTA_USUARIO FOREIGN KEY (id_Usuario) references Usuarios(identification);

ALTER TABLE Demandas
ADD CONSTRAINT FK_DEMANDA_USUARIO FOREIGN KEY (id_usuario) references Usuarios(identification);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTA_UBICACION FOREIGN KEY(codigo_ubicacion)references Ubicaciones(codigo);

ALTER TABLE Empresas
ADD CONSTRAINT FK_EMPRESA_PERSONA FOREIGN KEY(id_Usuarios2) references PersonasNaturales(id_Usuarios);

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT FK_FOTO_OFERTAS FOREIGN KEY(numero_Ofertas) references Ofertas(numero)
ADD CONSTRAINT FK_FOTO_FOTOS FOREIGN KEY(nombre_Fotografias) references Fotografias(nombre);

ALTER TABLE OrigenFondos
ADD CONSTRAINT FK_FONDOS_DEMANDAS FOREIGN KEY(numero_demandas) references Demandas(numero);

ALTER TABLE GestionAvisos
ADD CONSTRAINT FK_AVISOS_DEMANDAS FOREIGN KEY(numero_demanda) references Demandas(numero);

ALTER TABLE UbicacionesXDemandas
ADD CONSTRAINT FK_UD_DEMANDAS FOREIGN KEY(numero_Demanda) references Demandas(numero)
ADD CONSTRAINT FK_UD_UBICACION FOREIGN KEY(codigo_Ubicaciones) references Ubicaciones(codigo);

ALTER TABLE ALERTAS
ADD CONSTRAINT FK_ALERTAS_AVISOS FOREIGN KEY(codigo_Avisos) references GestionAvisos(codigo);


ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTAS_CREDITOS FOREIGN KEY(codigo_opcioncreditos) references OpcionCreditos(codigo);



--Protegiendo: Atributos
   
--Estado
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS CHECK (estado IN ('V', 'N', 'D'));


--TEstado
ALTER TABLE GestionAvisos
ADD CONSTRAINT CHK_AVISOS CHECK (estado IN ('E', 'P', 'F'));


--TEstado 1
ALTER TABLE Alertas
ADD CONSTRAINT CHK_ALERTAS CHECK (estado IN ('A', 'I'));


--Condición de integridad creada: Los correos electrónicos deben tener un @ para ser válidos
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_USUARIOS_CORREO CHECK (correoElectronico LIKE '%@%');

--Zonas
ALTER TABLE Ubicaciones
ADD CONSTRAINT CHK_UBICACION_ZONA CHECK (zona IN ('N', 'S', 'E', 'O'));


--Condición de integridad creada: Los tipos de documentos solo pueden ser Cédula Ciudadanpia (CC), Tarjeta Identidad (TI), Cédula Extranjería (CE), Pasaporte (PP), Permiso especial de permanencia (PEP)
ALTER TABLE PersonasNaturales
ADD CONSTRAINT CHK_PN_TIPOID CHECK (tipoDocumento IN ('CC', 'TI', 'CE', 'PP', 'PEP'));


--TVivienda
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));


--TVivienda
ALTER TABLE Demandas
ADD CONSTRAINT CHK_DEMANDAS_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));


--TCodigo
ALTER TABLE GestionAvisos
ADD CONSTRAINT CHK_AVISOS_CODIGO CHECK (codigo LIKE 'I%' OR codigo LIKE 'E%');

--TCodigo
ALTER TABLE Alertas
ADD CONSTRAINT CHK_ALERTAS_CODIGO CHECK (codigo_Avisos LIKE 'I%' OR codigo_Avisos LIKE 'E%');


--TTipo
ALTER TABLE GestionAvisos
ADD CONSTRAINT CHK_AVISOS_TIPO CHECK (tipo IN ('N', 'A'));

--Tnivel
ALTER TABLE UBICACIONESXDEMANDAS
ADD CONSTRAINT CHK_NIVEL_INTERES CHECK (nivel IN('A', 'M', 'B'));

--MONEDA
ALTER TABLE OPCIONCREDITOS
ADD CONSTRAINT CHK_MONEDA_VALOR CHECK (valorMensual > 0);

ALTER TABLE OFERTAS
ADD CONSTRAINT CHK_MONEDA_COSTO CHECK (costo > 0);

ALTER TABLE DEMANDAS
ADD CONSTRAINT CHK_MONEDA_COMPRA CHECK (maxCompra > 0);

ALTER TABLE ORIGENFONDOS
ADD CONSTRAINT CHK_MONEDA_PRESTAMO CHECK (valor >= 0);

--Punto 3 - Poblando
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_USUARIOS_REGISTRO CHECK (fechaRegistro > TO_TIMESTAMP('01-01-1934 11:59:59 AM', 'DD-MM-YYYY HH:MI:SS AM'));


--Punto 3 - Poblando
ALTER TABLE PersonasNaturales
ADD CONSTRAINT CHK_NUMERO_DOCUMENTO
CHECK (REGEXP_LIKE(numeroDocumento, '^[0-9]+$'));


--Punto 3 - Poblando
ALTER TABLE Empresas
ADD CONSTRAINT CHK_NIT_FORMAT
CHECK (REGEXP_LIKE(NIT, '^[0-9]{8}-[0-9]{1}$'));

--TConsecutive Entero(9) Positivo consecutivo
CREATE SEQUENCE num_sequence
    START WITH 1 
    INCREMENT BY 1;


CREATE SEQUENCE opcioncredito_sequence
    START WITH 1
    INCREMENT BY 1;
    

DROP SEQUENCE num_sequence;
DROP SEQUENCE opcioncredito_sequence;



Tipos
—------------------------------------------------------------------------------------------------------------------------
TConsencutivo (para demanda y oferta)
Entero(9) Positivo consecutivo
TuplasOK
-- Verificación: Entero(9) Positivo consecutivo
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'A', 1000000, 'U001');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'C', 2000000, 'U002');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'B', 3000000, 'U003');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'F', 4000000, 'U004');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'A', 5000000, 'U005');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'C', 6000000, 'U006');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'B', 7000000, 'U007');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'F', 8000000, 'U008');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'A', 9000000, 'U009');
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'C', 10000000, 'U010');

INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Calle 1', 'A', 1000000, 'Anexo1', 'V', 'UB001', 'U001');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Calle 2', 'C', 2000000, 'Anexo2', 'N', 'UB002', 'U002');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Calle 3', 'B', 3000000, 'Anexo3', 'D', 'UB003', 'U003');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Calle 4', 'F', 4000000, 'Anexo4', 'V', 'UB004', 'U004');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Calle 5', 'A', 5000000, 'Anexo5', 'N', 'UB005', 'U005');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Calle 6', 'C', 6000000, 'Anexo6', 'D', 'UB006', 'U006');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Calle 7', 'B', 7000000, 'Anexo7', 'V', 'UB007', 'U007');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Calle 8', 'F', 8000000, 'Anexo8', 'N', 'UB008', 'U008');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'Calle 9', 'A', 9000000, 'Anexo9', 'D', 'UB009', 'U009');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Calle 10', 'C', 10000000, 'Anexo10', 'V', 'UB010', 'U010');

TuplasnoOK

-- Verificación fallida: Entero(9) Positivo consecutivo
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (-1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'A', 1000000, 'U001'); -- Número negativo
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (0, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'C', 2000000, 'U002'); -- Número cero
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (1000000000, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'B', 3000000, 'U003'); -- Número fuera del rango permitido

INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (-1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Calle 1', 'A', 1000000, 'Anexo1', 'V', 'UB001', 'U001'); -- Número negativo
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (0, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Calle 2', 'C', 2000000, 'Anexo2', 'N', 'UB002', 'U002'); -- Número cero
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (1000000000, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Calle 3', 'B', 3000000, 'Anexo3', 'D', 'UB003', 'U003'); -- Número fuera del rango permitido



—------------------------------------------------------------------------------------------------------------------------


/TVivienda (para Demanda, Oferta, Notificación y Alerta)
Cadena(1) (C(asa),A(partamento),B(odega), F(inca))
TuplasOK
-- Verificación: Cadena(1) (C(asa), A(partamento), B(odega), F(inca))
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Calle 2', 'A', 2000000, 'Anexo2', 'N', 'UB002', 'U002');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Calle 3', 'B', 3000000, 'Anexo3', 'D', 'UB003', 'U003');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Calle 4', 'F', 4000000, 'Anexo4', 'V', 'UB004', 'U004');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Calle 5', 'C', 5000000, 'Anexo5', 'N', 'UB005', 'U005');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Calle 6', 'A', 6000000, 'Anexo6', 'D', 'UB006', 'U006');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Calle 7', 'B', 7000000, 'Anexo7', 'V', 'UB007', 'U007');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Calle 8', 'F', 8000000, 'Anexo8', 'N', 'UB008', 'U008');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'Calle 9', 'C', 9000000, 'Anexo9', 'D', 'UB009', 'U009');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Calle 10', 'A', 10000000, 'Anexo10', 'V', 'UB010', 'U010');

TuplasnoOK

-- Verificación fallida: Cadena(1) (C(asa), A(partamento), B(odega), F(inca))
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'X', 1000000, 'U001'); -- Tipo de vivienda no válido
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Y', 2000000, 'U002'); -- Tipo de vivienda no válido
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (3, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Z', 3000000, 'U003'); -- Tipo de vivienda no válido

INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Calle 1', 'X', 1000000, 'Anexo1', 'V', 'UB001', 'U001'); -- Tipo de vivienda no válido
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (2, TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Calle 2', 'Y', 2000000, 'Anexo2', 'N', 'UB002', 'U002'); -- Tipo de vivienda no válido
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (3, TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Calle 3', 'Z', 3000000, 'Anexo3', 'D', 'UB003', 'U003'); -- Tipo de vivienda no válido


—------------------------------------------------------------------------------------------------------------------------
Anexo (Ofertas)
XML
Cada anexo disponible debe tener la siguiente información
nombre, número y URL
Los anexos que no están disponibles deben tener
nombre, justificación y fecha esperada (si se tiene)
TuplasOK
-- Verificación: XML con información de anexos
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Calle 11', 'C', 11000000, '<anexo><nombre>Plano</nombre><numero>1</numero><url>http://example.com/plano1</url></anexo>', 'V', 'UB011', 'U011');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Calle 12', 'A', 12000000, '<anexo><nombre>Foto</nombre><numero>2</numero><url>http://example.com/foto2</url></anexo>', 'N', 'UB012', 'U012');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Calle 13', 'B', 13000000, '<anexo><nombre>Video</nombre><numero>3</numero><url>http://example.com/video3</url></anexo>', 'D', 'UB013', 'U013');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Calle 14', 'F', 14000000, '<anexo><nombre>Mapa</nombre><numero>4</numero><url>http://example.com/mapa4</url></anexo>', 'V', 'UB014', 'U014');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Calle 15', 'C', 15000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion><fechaEsperada>2024-04-01</fechaEsperada></anexo>', 'N', 'UB015', 'U015');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Calle 16', 'A', 16000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion><fechaEsperada>2024-05-01</fechaEsperada></anexo>', 'D', 'UB016', 'U016');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Calle 17', 'B', 17000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion><fechaEsperada>2024-06-01</fechaEsperada></anexo>', 'V', 'UB017', 'U017');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Calle 18', 'F', 18000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion><fechaEsperada>2024-07-01</fechaEsperada></anexo>', 'N', 'UB018', 'U018');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Calle 19', 'C', 19000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion><fechaEsperada>2024-08-01</fechaEsperada></anexo>', 'D', 'UB019', 'U019');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Calle 20', 'A', 20000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion><fechaEsperada>2024-09-01</fechaEsperada></anexo>', 'V', 'UB020', 'U020');

TuplasnoOK
-- Verificación fallida: XML con información de anexos
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (4, TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Calle 4', 'A', 4000000, '<anexo><nombre>Plano</nombre><numero>1</numero></anexo>', 'V', 'UB004', 'U004'); -- Falta URL
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (5, TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Calle 5', 'C', 5000000, '<anexo><nombre>Foto</nombre><url>http://example.com/foto2</url></anexo>', 'N', 'UB005', 'U005'); -- Falta número
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (6, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Calle 6', 'B', 6000000, '<anexo><nombre>Justificación</nombre><justificacion>En proceso</justificacion></anexo>', 'D', 'UB006', 'U006'); -- Falta fecha esperada


—------------------------------------------------------------------------------------------------------------------------

CorreoElectronico (Usuario)
Cadena(50) Contiene una única arroba y al menos un punto
TuplasOK
-- Verificación: Cadena(50) Contiene una única arroba y al menos un punto
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U011', TO_TIMESTAMP('2023-11-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user11@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U012', TO_TIMESTAMP('2023-12-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user12@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U013', TO_TIMESTAMP('2024-01-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user13@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U014', TO_TIMESTAMP('2024-02-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user14@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U015', TO_TIMESTAMP('2024-03-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user15@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U016', TO_TIMESTAMP('2024-04-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user16@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U017', TO_TIMESTAMP('2024-05-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user17@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U018', TO_TIMESTAMP('2024-06-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user18@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U019', TO_TIMESTAMP('2024-07-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user19@example.com');
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U020', TO_TIMESTAMP('2024-08-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user20@example.com');

TuplasnoOK
-- Verificación fallida: Cadena(50) Contiene una única arroba y al menos un punto
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U021', TO_TIMESTAMP('2023-11-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user21example.com'); -- Falta arroba
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U022', TO_TIMESTAMP('2023-12-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user22@examplecom'); -- Falta punto
INSERT INTO Usuarios (identificacion, fechaRegistro, correoElectronico) VALUES ('U023', TO_TIMESTAMP('2024-01-01 10:00:00 AM', 'YYYY-MM-DD HH:MI:SS AM'), 'user23@@example.com'); -- Doble arroba


—------------------------------------------------------------------------------------------------------------------------

*Estado (Oferta)
Cadena(1) (D(isponible),N(o Disponible), V(endida)
TuplasOK
-- Verificación: Cadena(1) (D(isponible), N(o Disponible), V(endida))
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Calle 21', 'C', 21000000, 'Anexo21', 'D', 'UB021', 'U021');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Calle 22', 'A', 22000000, 'Anexo22', 'N', 'UB022', 'U022');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'Calle 23', 'B', 23000000, 'Anexo23', 'V', 'UB023', 'U023');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'Calle 24', 'F', 24000000, 'Anexo24', 'D', 'UB024', 'U024');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Calle 25', 'C', 25000000, 'Anexo25', 'N', 'UB025', 'U025');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Calle 26', 'A', 26000000, 'Anexo26', 'V', 'UB026', 'U026');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'Calle 27', 'B', 27000000, 'Anexo27', 'D', 'UB027', 'U027');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Calle 28', 'F', 28000000, 'Anexo28', 'N', 'UB028', 'U028');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-05-01', 'YYYY-MM-DD'), 'Calle 29', 'C', 29000000, 'Anexo29', 'V', 'UB029', 'U029');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Calle 30', 'A', 30000000, 'Anexo30', 'D', 'UB030', 'U030');

TuplasnoOK
-- Verificación fallida: Cadena(1) (D(isponible), N(o Disponible), V(endida))
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (7, TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Calle 7', 'A', 7000000, 'Anexo7', 'X', 'UB007', 'U007'); -- Estado no válido
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (8, TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Calle 8', 'C', 8000000, 'Anexo8', 'Y', 'UB008', 'U008'); -- Estado no válido
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (9, TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'Calle 9', 'B', 9000000, 'Anexo9', 'Z', 'UB009', 'U009'); -- Estado no válido


—------------------------------------------------------------------------------------------------------------------------

Moneda (Demanda, Oferta, OpcionCredito, OrigenFondos, Notificación, Alerta)
Entero(9) Positivo
TuplasOK
-- Verificación: Entero(9) Positivo
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Calle 31', 'C', 31000000, 'Anexo31', 'D', 'UB031', 'U031');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-08-01', 'YYYY-MM-DD'), 'Calle 32', 'A', 32000000, 'Anexo32', 'N', 'UB032', 'U032');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'Calle 33', 'B', 33000000, 'Anexo33', 'V', 'UB033', 'U033');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-10-01', 'YYYY-MM-DD'), 'Calle 34', 'F', 34000000, 'Anexo34', 'D', 'UB034', 'U034');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'Calle 35', 'C', 35000000, 'Anexo35', 'N', 'UB035', 'U035');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2025-12-01', 'YYYY-MM-DD'), 'Calle 36', 'A', 36000000, 'Anexo36', 'V', 'UB036', 'U036');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'Calle 37', 'B', 37000000, 'Anexo37', 'D', 'UB037', 'U037');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2026-02-01', 'YYYY-MM-DD'), 'Calle 38', 'F', 38000000, 'Anexo38', 'N', 'UB038', 'U038');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2026-03-01', 'YYYY-MM-DD'), 'Calle 39', 'C', 39000000, 'Anexo39', 'V', 'UB039', 'U039');
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (num_sequence.NEXTVAL, TO_DATE('2026-04-01', 'YYYY-MM-DD'), 'Calle 40', 'A', 40000000, 'Anexo40', 'D', 'UB040', 'U040');

INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 12, 1100000, 11);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 24, 1200000, 12);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 36, 1300000, 13);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 48, 1400000, 14);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 60, 1500000, 15);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 72, 1600000, 16);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 84, 1700000, 17);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 96, 1800000, 18);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 108, 1900000, 19);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (opcioncredito_sequence.NEXTVAL, 120, 2000000, 20);

INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (11, 1100000, 'S', 'Y');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (12, 1200000, 'N', 'N');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (13, 1300000, 'S', 'Y');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (14, 1400000, 'N', 'N');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (15, 1500000, 'S', 'Y');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (16, 1600000, 'N', 'N');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (17, 1700000, 'S', 'Y');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (18, 1800000, 'N', 'N');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (19, 1900000, 'S', 'Y');
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (20, 2000000, 'N', 'N');

TuplasnoOK

-- Verificación fallida: Entero(9) Positivo
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (21, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'C', -11000000, 'U021'); -- Valor negativo
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (22, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'A', 0, 'U022'); -- Valor cero
INSERT INTO Demandas (numero, fecha, tipoVivienda, maxCompra, id_usuario) VALUES (23, TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'B', 1000000000, 'U023'); -- Valor fuera del rango permitido

INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (41, TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Calle 41', 'C', -31000000, 'Anexo41', 'D', 'UB041', 'U041'); -- Valor negativo
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (42, TO_DATE('2025-08-01', 'YYYY-MM-DD'), 'Calle 42', 'A', 0, 'Anexo42', 'N', 'UB042', 'U042'); -- Valor cero
INSERT INTO Ofertas (numero, fecha, direccion, tipoVivienda, costo, anexos, estado, codigo_ubicacion, id_usuario) VALUES (43, TO_DATE('2025-09-01', 'YYYY-MM-DD'), 'Calle 43', 'B', 1000000000, 'Anexo43', 'V', 'UB043', 'U043'); -- Valor fuera del rango permitido

INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (21, 12, -1100000, 21); -- Valor negativo
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (22, 24, 0, 22); -- Valor cero
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual, numero_Ofertas) VALUES (23, 36, 1000000000, 23); -- Valor fuera del rango permitido

INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (21, -1100000, 'S', 'Y'); -- Valor negativo
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (22, 0, 'N', 'N'); -- Valor cero
INSERT INTO OrigenFondos (numero_demandas, valor, credito, estaAprobado) VALUES (23, 1000000000, 'S', 'Y'); -- Valor fuera del rango permitido


—------------------------------------------------------------------------------------------------------------------------

*Nivel 
Cadena(1) [A(lato),M(edio),B(ajo)]
TuplasOK
-- Verificación: Cadena(1) [A(lto), M(edio), B(ajo)]
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (1, 'UB001', 'A');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (2, 'UB002', 'M');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (3, 'UB003', 'B');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (4, 'UB004', 'A');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (5, 'UB005', 'M');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (6, 'UB006', 'B');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (7, 'UB007', 'A');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (8, 'UB008', 'M');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (9, 'UB009', 'B');
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (10, 'UB010', 'A');

TuplasnoOK

-- Verificación fallida: Cadena(1) [A(lto), M(edio), B(ajo)]
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (1, 'UB001', 'X'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (2, 'UB002', 'Y'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (3, 'UB003', 'Z'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (4, 'UB004', '1'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (5, 'UB005', '2'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (6, 'UB006', '3'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (7, 'UB007', '4'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (8, 'UB008', '5'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (9, 'UB009', '6'); -- Nivel no válido
INSERT INTO UbicacionesXDemandas (numero_Demanda, codigo_Ubicaciones, nivel) VALUES (10, 'UB010', '7'); -- Nivel no válido



—------------------------------------------------------------------------------------------------------------------------


TCodigo (GestionAvisos, Alertas, Notificaciones)
Código alfanumérico (8) en donde el primer caracter debe ser del evento ((I)nserción, (E)liminación))
TuplasOK
-- Verificación: Código alfanumérico (8) en donde el primer carácter debe ser del evento ((I)nserción, (E)liminación)) Tcodigo
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000001', 'N', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Mensaje 1', 'E', 'Administador del negocio', 1);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000002', 'A', TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Mensaje 2', 'P', 'Dueño de la informacion', 2);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000003', 'N', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Mensaje 3', 'F', 'Administador del negocio', 3);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000004', 'A', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Mensaje 4', 'E', 'Dueño de la informacion', 4);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000005', 'N', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Mensaje 5', 'P', 'Administador del negocio', 5);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000006', 'A', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Mensaje 6', 'F', 'Dueño de la informacion', 6);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000007', 'N', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Mensaje 7', 'E', 'Administador del negocio', 7);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000008', 'A', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Mensaje 8', 'P', 'Dueño de la informacion', 8);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000009', 'N', TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'Mensaje 9', 'F', 'Administador del negocio', 9);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000010', 'A', TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Mensaje 10', 'E', 'Dueño de la informacion', 10);

INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000001', 'A', '1');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000002', 'I', '2');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000003', 'A', '3');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000004', 'I', '4');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000005', 'A', '5');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000006', 'I', '6');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000007', 'A', '7');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000008', 'I', '8');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000009', 'A', '9');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000010', 'I', '10');

TuplasnoOK

-- Verificación fallida: Código alfanumérico (8) en donde el primer carácter debe ser del evento ((I)nserción, (E)liminación))
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('X0000001', 'N', TO_DATE('2023-01-01', 'YYYY-MM-DD'), 'Mensaje 1', 'E', 'Administador del negocio', 1); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('Y0000002', 'A', TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'Mensaje 2', 'P', 'Dueño de la informacion', 2); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('Z0000003', 'N', TO_DATE('2023-03-01', 'YYYY-MM-DD'), 'Mensaje 3', 'F', 'Administador del negocio', 3); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('A0000004', 'A', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'Mensaje 4', 'E', 'Dueño de la informacion', 4); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('B0000005', 'N', TO_DATE('2023-05-01', 'YYYY-MM-DD'), 'Mensaje 5', 'P', 'Administador del negocio', 5); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('C0000006', 'A', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Mensaje 6', 'F', 'Dueño de la informacion', 6); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('D0000007', 'N', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Mensaje 7', 'E', 'Administador del negocio', 7); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000008', 'A', TO_DATE('2023-08-01', 'YYYY-MM-DD'), 'Mensaje 8', 'P', 'Dueño de la informacion', 8); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('F0000009', 'N', TO_DATE('2023-09-01', 'YYYY-MM-DD'), 'Mensaje 9', 'F', 'Administador del negocio', 9); -- Código no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('G0000010', 'A', TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Mensaje 10', 'E', 'Dueño de la informacion', 10); -- Código no válido


-- Verificación fallida: Código alfanumérico (8) en donde el primer carácter debe ser del evento ((I)nserción, (E)liminación))
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('X0000001', 'A', '1'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('Y0000002', 'I', '2'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('Z0000003', 'A', '3'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('A0000004', 'I', '4'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('B0000005', 'A', '5'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('C0000006', 'I', '6'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('D0000007', 'A', '7'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000008', 'I', '8'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('F0000009', 'A', '9'); -- Código no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('G0000010', 'I', '10'); -- Código no válido


—------------------------------------------------------------------------------------------------------------------------
TDestino (GestionAvisos)
Cadena(30)
[Administador del negocio, Dueño de la informacion]
TuplasOK
-- Verificación: Cadena(30) [Administador del negocio, Dueño de la informacion]
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000011', 'N', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Mensaje 11', 'E', 'Administador del negocio', 11);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000012', 'A', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Mensaje 12', 'P', 'Dueño de la informacion', 12);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000013', 'N', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Mensaje 13', 'F', 'Administador del negocio', 13);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000014', 'A', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Mensaje 14', 'E', 'Dueño de la informacion', 14);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000015', 'N', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Mensaje 15', 'P', 'Administador del negocio', 15);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000016', 'A', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Mensaje 16', 'F', 'Dueño de la informacion', 16);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000017', 'N', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Mensaje 17', 'E', 'Administador del negocio', 17);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000018', 'A', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Mensaje 18', 'P', 'Dueño de la informacion', 18);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000019', 'N', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Mensaje 19', 'F', 'Administador del negocio', 19);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000020', 'A', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Mensaje 20', 'E', 'Dueño de la informacion', 20);

TuplasnoOK

-- Verificación fallida: Cadena(30) [Administador del negocio, Dueño de la informacion]
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000045', 'N', TO_DATE('2023-11-01', 'YYYY-MM-DD'), 'Mensaje 45', 'E', 'Cliente', 45); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000046', 'A', TO_DATE('2023-12-01', 'YYYY-MM-DD'), 'Mensaje 46', 'P', 'Proveedor', 46); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000047', 'N', TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Mensaje 47', 'F', 'Empleado', 47); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000048', 'A', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Mensaje 48', 'E', 'Visitante', 48); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000049', 'N', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Mensaje 49', 'P', 'Socio', 49); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000050', 'A', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Mensaje 50', 'F', 'Gerente', 50); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000051', 'N', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Mensaje 51', 'E', 'Director', 51); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000052', 'A', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Mensaje 52', 'P', 'Supervisor', 52); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000053', 'N', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Mensaje 53', 'F', 'Consultor', 53); -- Destino no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000054', 'A', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Mensaje 54', 'E', 'Asistente', 54); -- Destino no válido



—------------------------------------------------------------------------------------------------------------------------
TEstado (GestionAvisos)
Cadena(10)
[(E)nviada, (P)endiente, (F)allida]
TuplasOK
-- Verificación: Cadena(10) [(E)nviada, (P)endiente, (F)allida]
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000021', 'N', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Mensaje 21', 'E', 'Administador del negocio', 21);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000022', 'A', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Mensaje 22', 'P', 'Dueño de la informacion', 22);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000023', 'N', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'Mensaje 23', 'F', 'Administador del negocio', 23);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000024', 'A', TO_DATE('2024-12-01', 'YYYY-MM-DD'), 'Mensaje 24', 'E', 'Dueño de la informacion', 24);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000025', 'N', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 'Mensaje 25', 'P', 'Administador del negocio', 25);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000026', 'A', TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Mensaje 26', 'F', 'Dueño de la informacion', 26);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000027', 'N', TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'Mensaje 27', 'E', 'Administador del negocio', 27);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000028', 'A', TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Mensaje 28', 'P', 'Dueño de la informacion', 28);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000029', 'N', TO_DATE('2025-05-01', 'YYYY-MM-DD'), 'Mensaje 29', 'F', 'Administador del negocio', 29);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000030', 'A', TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Mensaje 30', 'E', 'Dueño de la informacion', 30);

TuplasnoOK

-- Verificación fallida: Cadena(10) [(E)nviada, (P)endiente, (F)allida]
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000048', 'N', TO_DATE('2024-02-01', 'YYYY-MM-DD'), 'Mensaje 48', 'X', 'Administador del negocio', 48); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000049', 'A', TO_DATE('2024-03-01', 'YYYY-MM-DD'), 'Mensaje 49', 'Y', 'Dueño de la informacion', 49); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000050', 'N', TO_DATE('2024-04-01', 'YYYY-MM-DD'), 'Mensaje 50', 'Z', 'Administador del negocio', 50); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000051', 'A', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Mensaje 51', 'W', 'Dueño de la informacion', 51); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000052', 'N', TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'Mensaje 52', 'Q', 'Administador del negocio', 52); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000053', 'A', TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Mensaje 53', 'R', 'Dueño de la informacion', 53); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000054', 'N', TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Mensaje 54', 'S', 'Administador del negocio', 54); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000055', 'A', TO_DATE('2024-09-01', 'YYYY-MM-DD'), 'Mensaje 55', 'T', 'Dueño de la informacion', 55); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000056', 'N', TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Mensaje 56', 'U', 'Administador del negocio', 56); -- Estado no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000057', 'A', TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'Mensaje 57', 'V', 'Dueño de la informacion', 57); -- Estado no válido


—------------------------------------------------------------------------------------------------------------------------

TEstado1 (Alertas)
Cadena(10)
[(A)ctivas, (I)nactivas)]
TuplasOK
-- Verificación: Cadena(10) [(A)ctivas, (I)nactivas)]
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000011', 'A', '11');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000012', 'I', '12');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000013', 'A', '13');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000014', 'I', '14');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000015', 'A', '15');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000016', 'I', '16');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000017', 'A', '17');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000018', 'I', '18');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000019', 'A', '19');
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000020', 'I', '20');

TuplasnoOK

-- Verificación fallida: Cadena(10) [(A)ctivas, (I)nactivas)]
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000021', 'X', '21'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000022', 'Y', '22'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000023', 'Z', '23'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000024', 'W', '24'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000025', 'Q', '25'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000026', 'R', '26'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000027', 'S', '27'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000028', 'T', '28'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('I0000029', 'U', '29'); -- Estado no válido
INSERT INTO Alertas (codigo_Avisos, estado, datoDemanda) VALUES ('E0000030', 'V', '30'); -- Estado no válido



—------------------------------------------------------------------------------------------------------------------------

*Zona (Ubicación)
Cadena(10)
[(N)orte, (S)ur, (E)ste, (O)este]
TuplasOK
-- Verificación: Cadena(10) [(N)orte, (S)ur, (E)ste, (O)este)] zona
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB011', 4.6097, -74.0817, 'Bogotá', 'N', 'Chapinero');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB012', 4.6097, -74.0817, 'Bogotá', 'S', 'Usaquén');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB013', 4.6097, -74.0817, 'Bogotá', 'E', 'Teusaquillo');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB014', 4.6097, -74.0817, 'Bogotá', 'O', 'Suba');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB015', 4.6097, -74.0817, 'Bogotá', 'N', 'Fontibón');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB016', 4.6097, -74.0817, 'Bogotá', 'S', 'Kennedy');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB017', 4.6097, -74.0817, 'Bogotá', 'E', 'Engativá');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB018', 4.6097, -74.0817, 'Bogotá', 'O', 'Bosa');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB019', 4.6097, -74.0817, 'Bogotá', 'N', 'Puente Aranda');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB020', 4.6097, -74.0817, 'Bogotá', 'S', 'San Cristóbal');

TuplasnoOK

-- Verificación fallida: Cadena(10) [(N)orte, (S)ur, (E)ste, (O)este)]
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB021', 4.6097, -74.0817, 'Bogotá', 'X', 'Chapinero'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB022', 4.6097, -74.0817, 'Bogotá', 'Y', 'Usaquén'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB023', 4.6097, -74.0817, 'Bogotá', 'Z', 'Teusaquillo'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB024', 4.6097, -74.0817, 'Bogotá', 'W', 'Suba'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB025', 4.6097, -74.0817, 'Bogotá', 'Q', 'Fontibón'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB026', 4.6097, -74.0817, 'Bogotá', 'R', 'Kennedy'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB027', 4.6097, -74.0817, 'Bogotá', 'S', 'Engativá'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB028', 4.6097, -74.0817, 'Bogotá', 'T', 'Bosa'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB029', 4.6097, -74.0817, 'Bogotá', 'U', 'Puente Aranda'); -- Zona no válida
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('UB030', 4.6097, -74.0817, 'Bogotá', 'V', 'San Cristóbal'); -- Zona no válida


—------------------------------------------------------------------------------------------------------------------------

Ttipo (GestionAvisos)
Cadena(10)
[(N)otificacion, (A)lerta]
TuplasOK
-- Verificación: Cadena(10) [(N)otificacion, (A)lerta)]
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000035', 'N', TO_DATE('2025-11-01', 'YYYY-MM-DD'), 'Mensaje 35', 'P', 'Administador del negocio', 35);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000036', 'A', TO_DATE('2025-12-01', 'YYYY-MM-DD'), 'Mensaje 36', 'F', 'Dueño de la informacion', 36);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000037', 'N', TO_DATE('2026-01-01', 'YYYY-MM-DD'), 'Mensaje 37', 'E', 'Administador del negocio', 37);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000038', 'A', TO_DATE('2026-02-01', 'YYYY-MM-DD'), 'Mensaje 38', 'P', 'Dueño de la informacion', 38);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000039', 'N', TO_DATE('2026-03-01', 'YYYY-MM-DD'), 'Mensaje 39', 'F', 'Administador del negocio', 39);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000040', 'A', TO_DATE('2026-04-01', 'YYYY-MM-DD'), 'Mensaje 40', 'E', 'Dueño de la informacion', 40);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000041', 'N', TO_DATE('2026-05-01', 'YYYY-MM-DD'), 'Mensaje 41', 'P', 'Administador del negocio', 41);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000042', 'A', TO_DATE('2026-06-01', 'YYYY-MM-DD'), 'Mensaje 42', 'F', 'Dueño de la informacion', 42);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000043', 'N', TO_DATE('2026-07-01', 'YYYY-MM-DD'), 'Mensaje 43', 'E', 'Administador del negocio', 43);
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000044', 'A', TO_DATE('2026-08-01', 'YYYY-MM-DD'), 'Mensaje 44', 'P', 'Dueño de la informacion', 44);

TuplasnoOK

-- Verificación fallida: Cadena(10) [(N)otificacion, (A)lerta)]

INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('I0000059', 'U', TO_DATE('2027-05-01', 'YYYY-MM-DD'), 'Mensaje 59', 'F', 'Administador del negocio', 59); -- Tipo no válido
INSERT INTO GestionAvisos (codigo, tipo, fechaCreacion, mensaje, estado, usDestino, numeroDemanda) VALUES ('E0000060', 'V', TO_DATE('2027-06-01', 'YYYY-MM-DD'), 'Mensaje 60', 'E', 'Dueño de la informacion', 60); -- Tipo no válido

-----------------------Disparadores---------------------------------------------

---Accion: Si se elimina el número de la demanda, se elimina en OrigenFondos


ALTER TABLE OrigenFondos
DROP CONSTRAINT FK_FONDOS_DEMANDAS;

ALTER TABLE OrigenFondos
ADD CONSTRAINT FK_FONDOS_DEMANDAS 
FOREIGN KEY(numero_demandas) 
references Demandas(numero)
ON DELETE CASCADE;

----Prueba-----
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');



INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (1, '2103', SYSDATE, NULL, 100000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (2, '3019', SYSDATE, 'C', 150000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (3, '3476', SYSDATE, 'B', 200000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (4, '44', SYSDATE, NULL ,180000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', SYSDATE, 'A', 220000);


insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (1, 0, 1, 1);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (2, 138382, 0, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (3, 428912, 0, 1);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (4, 14829, 1, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (5, 55555, 0, 1);



DELETE Demandas WHERE numero = 1;
DELETE Demandas WHERE numero = 2;


---Oferta
CREATE OR REPLACE TRIGGER TR_OFERTA_BI
BEFORE INSERT ON Ofertas
FOR EACH ROW
DECLARE
    v_codigo_opcioncredito NUMBER;
BEGIN
    -- Generar el número de la oferta automáticamente (suponiendo que usas una secuencia)
    :NEW.numero := num_sequence.NEXTVAL;

    -- Generar la fecha de la oferta automáticamente
    :NEW.fecha := SYSDATE;

    -- Generar el estado de la oferta automáticamente (Disponible)
    :NEW.estado := 'D';

    -- Generar un nuevo código para la opción de crédito
    v_codigo_opcioncredito := opcioncredito_sequence.NEXTVAL;

    -- Insertar la opción de crédito a 12 meses con cuotas mensuales equivalentes al costo más 10% dividido en 12
    INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) 
    VALUES (v_codigo_opcioncredito, 12, (:NEW.costo * 1.10) / 12);

    -- Asignar el código de la opción de crédito a la oferta
    :NEW.codigo_opcioncreditos := v_codigo_opcioncredito;
END;
/



CREATE OR REPLACE TRIGGER TR_OFERTA_BU
BEFORE UPDATE ON Ofertas
FOR EACH ROW
DECLARE
    v_totalPago NUMBER;
BEGIN
    -- Verificar que solo se actualicen los campos `anexos`, `codigo_opcioncreditos`
    IF UPDATING AND ( 
        (:OLD.numero != :NEW.numero OR
         :OLD.id_Usuario != :NEW.id_Usuario OR
         :OLD.codigo_ubicacion != :NEW.codigo_ubicacion OR
         :OLD.fecha != :NEW.fecha OR
         :OLD.direccion != :NEW.direccion OR
         :OLD.tipoVivienda != :NEW.tipoVivienda OR
         :OLD.costo != :NEW.costo OR
         :OLD.estado != :NEW.estado)
    ) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se pueden modificar los campos anexos y la opción de crédito.');
    END IF;
    
    -- Verificar que El total del crédito debe ser mayor o igual al costo de la oferta
    IF :OLD.codigo_opcioncreditos != :NEW.codigo_opcioncreditos THEN
        SELECT valorMensual * plazo INTO v_totalPago
        FROM OpcionCreditos
        WHERE codigo = :NEW.codigo_opcioncreditos;
        IF v_totalPago < :NEW.costo THEN
            RAISE_APPLICATION_ERROR(-20002, 'El total del crédito debe ser mayor o igual al costo de la oferta.');
        END IF;
    END IF;
END;
/


---Se pueden agregar fotografías a la galería
CREATE OR REPLACE TRIGGER TR_FOTOGRAFIAS_BU
BEFORE INSERT ON FotografiasXOfertas
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('Agregando fotografía a la galería para la oferta ' || :NEW.numero_Ofertas);
    END IF;
END;
/


-----ACCION REFERENCIAL: Se pueden eliminar fotografías de la galería-----------
ALTER TABLE FotografiasXOfertas
DROP CONSTRAINT FK_FOTO_FOTOS;

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT FK_FOTO_FOTOS 
FOREIGN KEY(nombre_Fotografias) 
references Fotografias(nombre)
ON DELETE CASCADE; 


---Se elimina la oferta si es la última

---Esta tabla temporal sirve de puente entre ambos disparadores. Almacena la fecha más reciente
CREATE GLOBAL TEMPORARY TABLE temp_ultima_oferta (
    ultima_fecha DATE
) ON COMMIT PRESERVE ROWS;

TRUNCATE TABLE temp_ultima_oferta;
DROP TABLE temp_ultima_oferta;



----Este disparador de sentencia (solo se ejecuta una vez) sirve para llamar a la tabla temporal y que esta tabla temporal almacene esta fecha más reciente
CREATE OR REPLACE TRIGGER TR_ULTIMAFECHAOFERTA_BD
BEFORE DELETE ON Ofertas
BEGIN

    DELETE FROM temp_ultima_oferta;
    

    INSERT INTO temp_ultima_oferta
    SELECT MAX(fecha)
    FROM Ofertas;
END;
/


----Este disparador es quien se encarga de eliminar la oferta con la fecha más reciente llamando a la tabla temporal
CREATE OR REPLACE TRIGGER TR_OFERTAS_BD
BEFORE DELETE ON Ofertas
FOR EACH ROW
DECLARE
    v_ultima_fecha DATE;
BEGIN

    SELECT ultima_fecha INTO v_ultima_fecha
    FROM temp_ultima_oferta;


    IF :OLD.fecha < v_ultima_fecha THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se puede eliminar la última oferta registrada.');
    END IF;
END;
/


---Demandas
CREATE OR REPLACE TRIGGER TR_DEMANDA_BI
BEFORE INSERT On Demandas
FOR EACH ROW
BEGIN
    ---Generar el número de la oferta automáticamente
    :NEW.numero := num_sequence.NEXTVAL;
    
    ---Generar la fecha de la oferta automáticamente
    :NEW.fecha := SYSDATE;
    
    ---Si no se indica la vivienda, se asume que es '(C)asa'
    IF :NEW.tipoVivienda IS NULL THEN
        :NEW.tipoVivienda := 'C';
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TR_ORIGENFONDOS_BI
BEFORE INSERT ON OrigenFondos
FOR EACH ROW
DECLARE
    valorPrestamo NUMBER;
BEGIN
    -- Obtener el valor de la compra máxima de la demanda relacionada
    SELECT maxCompra INTO valorPrestamo
    FROM Demandas
    WHERE numero = :NEW.numero_demandas;
    
    -- Asignar el valor del préstamo al total de la compra
    :NEW.valor := valorPrestamo;
END;
/


---Se puede indicar si el préstamo fue aprobado o no
CREATE OR REPLACE TRIGGER TR_DEMANDA_BU
BEFORE INSERT OR UPDATE ON OrigenFondos
FOR EACH ROW
BEGIN
    -- Si el origen de fondos incluye crédito (credito = 1)
    IF :NEW.credito = 1 THEN
        -- Verificamos si el valor solicitado es mayor a cero
        IF :NEW.valor > 0 THEN
            -- Aprobamos el préstamo
            :NEW.estaAprobado := 1;
        ELSE
            -- No aprobamos si el valor es 0 o negativo
            :NEW.estaAprobado := 0;
        END IF;
    ELSE
        -- Si no hay crédito, marcamos como no aprobado
        :NEW.estaAprobado := 0;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TR_UBICACIONES_INTERES
BEFORE INSERT ON UbicacionesXDemandas
FOR EACH ROW
BEGIN
    -- Se bloquean eliminaciones de las ubicaciones de interes
    IF DELETING THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se permite eliminar ubicaciones de interés.');
    END IF;
    
    -- Se bloquean las actualizaciones de las ubicaciones de interes. Solo se puede insertar.
    IF UPDATING THEN
        RAISE_APPLICATION_ERROR(-20003, 'No se permite modificar ubicaciones de interés.');
    END IF;
END;
/

---Se elimina la demanda si es la última

---Esta tabla temporal sirve de puente entre ambos disparadores. Almacena la fecha más reciente
CREATE GLOBAL TEMPORARY TABLE temp_ultima_demanda (
    ultima_fecha DATE
) ON COMMIT PRESERVE ROWS;

TRUNCATE TABLE temp_ultima_demanda;
DROP TABLE temp_ultima_demanda;


----Este disparador de sentencia (solo se ejecuta una vez) sirve para llamar a la tabla temporal y que esta tabla temporal almacene esta fecha más reciente
CREATE OR REPLACE TRIGGER TR_ULTIMAFECHA_BD
BEFORE DELETE ON Demandas
BEGIN

    DELETE FROM temp_ultima_demanda;
    

    INSERT INTO temp_ultima_demanda
    SELECT MAX(fecha)
    FROM Demandas;
END;
/


----Este disparador es quien se encarga de eliminar la demanda con la fecha más reciente llamando a la tabla temporal
CREATE OR REPLACE TRIGGER TR_DEMANDAS_BD
BEFORE DELETE ON Demandas
FOR EACH ROW
DECLARE
    v_ultima_fecha DATE;
BEGIN

    SELECT ultima_fecha INTO v_ultima_fecha
    FROM temp_ultima_demanda;


    IF :OLD.fecha < v_ultima_fecha THEN
        RAISE_APPLICATION_ERROR(-20001, 'Solo se puede eliminar la última demanda registrada.');
    END IF;
END;
/


DROP TRIGGER TR_OFERTA_BI;
DROP TRIGGER TR_OFERTA_BU;
DROP TRIGGER TR_FOTOGRAFIAS_BU;
DROP TRIGGER TR_ULTIMAFECHAOFERTA_BD;
DROP TRIGGER TR_OFERTAS_BD;
DROP TRIGGER TR_DEMANDA_BI;
DROP TRIGGER TR_ORIGENFONDOS_BI;
DROP TRIGGER TR_DEMANDA_BU;
DROP TRIGGER TR_UBICACIONES_INTERES;
DROP TRIGGER TR_ULTIMAFECHA_BD;
DROP TRIGGER TR_DEMANDAS_BD;

---XPOBLAR
---Tablas temporales
DELETE FROM TEMP_ULTIMA_DEMANDA;
DELETE FROM TEMP_ULTIMA_OFERTA;

DELETE FROM Usuarios;
DELETE FROM Ubicaciones;
DELETE FROM NumerosContactos;
DELETE FROM PersonasNaturales;
DELETE FROM Empresas;
DELETE FROM OpcionCreditos;
DELETE FROM Ofertas;
DELETE FROM Fotografias;
DELETE FROM FotografiasXOfertas;
DELETE FROM Demandas;
DELETE FROM OrigenFondos;
DELETE FROM GestionAvisos;
DELETE FROM Alertas;
DELETE FROM UbicacionesXDemandas;


---Prueba de disparadores
---TR_OFERTA_BI----Todo correcto

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');

INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('14889', 4.6104, -74.0821, 'Bogotá', 'E', 'Chapinero');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('59', 4.7109, -74.0721, 'Bogotá', 'N', 'Gilmar');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (1, '14889', '2103', 1, TO_DATE('07-05-1998 11:24:05 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Calle 150#24-08', 'C', 8834665, 'NULL', 'V');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (2, '59', '3019', 2, TO_DATE('30-11-2017 08:15:43 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Avenida Calle 53B #45', 'F', 1795367, 'NULL', 'N');

SELECT * FROM OFERTAS;
SELECT * FROM OPCIONCREDITOS;

-----------DISPARADORNOOK-------------------------------------------------------
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('14889', 4.6104, -74.0821, 'Bogotá', 'E', 'Chapinero');
INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (0, '14889', '2103', 1, TO_DATE('07-05-1998 11:24:05 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Calle 150#24-08', 'ALO', 8834665, 'NULL', 'V');


---TR_OFERTA_BU---TODO CORRECTO

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');

INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('14889', 4.6104, -74.0821, 'Bogotá', 'E', 'Chapinero');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('59', 4.7109, -74.0721, 'Bogotá', 'N', 'Gilmar');

INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (1, 12, 1000);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (2, 12, 1500);

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (1, '14889', '2103', 1, TO_DATE('07-05-1998 11:24:05 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Calle 150#24-08', 'C', 8834665, 'inicial', 'V');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (2, '59', '3019', 2, TO_DATE('30-11-2017 08:15:43 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Avenida Calle 53B #45', 'F', 1795367, 'inicial', 'N');

UPDATE Ofertas
SET anexos = 'Nuevos anexos'
WHERE numero = 1;

UPDATE Ofertas
SET codigo_opcioncreditos = 1
WHERE numero = 1;

--------------------DISPARADORNOOK----------------------------------------------
UPDATE Ofertas
SET direccion = 'Calle 2'
WHERE numero = 1;

UPDATE Ofertas
SET codigo_opcioncreditos = 2
WHERE numero = 1;

---TR_FOTOGRAFIAS_BU------------TODO CORRECTO

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico)
VALUES ('U001', SYSDATE, 'test@example.com');


INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio)
VALUES ('UBI001', 4.5, -74.2, 'Bogota', 'N', 'Cedritos');


INSERT INTO OpcionCreditos (codigo, plazo, valorMensual)
VALUES (1, 12, 1000000);


INSERT INTO Ofertas (
    numero,
    id_Usuario,
    codigo_ubicacion,
    codigo_opcioncreditos,
    fecha,
    direccion,
    tipoVivienda,
    costo,
    anexos,
    estado
)
VALUES (
    1,
    'U001',
    'UBI001',
    1,
    SYSDATE,
    'Calle 123',
    'C',
    10000000,
    'Anexo inicial',
    'D'
);


INSERT INTO Fotografias (nombre, ruta, descripcion)
VALUES ('FOTO1', '/ruta/foto1.jpg', 'Fachada principal');

INSERT INTO Fotografias (nombre, ruta, descripcion)
VALUES ('FOTO2', '/ruta/foto2.jpg', 'Interior sala');


INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
VALUES (1, 'FOTO1');

INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
VALUES (1, 'FOTO2');


-------------DISPARADOR NOOK----------------------------------------------------

INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
VALUES (3, 'FOTO7');

INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
VALUES (4, 'FOTO9');


-----------PROBANDO LA ACCIÓN---------------------------------------------------

DELETE Fotografias WHERE nombre = 'FOTO1';

SELECT * FROM FOTOGRAFIAS;
SELECT * FROM FotografiasXOfertas;


---TR_OFERTAS_BD---TODO CORRECTO

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');

INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('14889', 4.6104, -74.0821, 'Bogotá', 'E', 'Chapinero');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('59', 4.7109, -74.0721, 'Bogotá', 'N', 'Gilmar');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('2766358167', 4.6789, -74.0871, 'Bogotá', 'E', 'Suba');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('9407', 4.6000, -74.1000, 'Bogotá', 'S', 'Candelaria');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('12345', 4.6100, -74.0700, 'Bogotá', 'N', 'Usaquén');

INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (1, 12, 1000);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (2, 12, 1500);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (3, 12, 2000);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (4, 12, 2500);
INSERT INTO OpcionCreditos (codigo, plazo, valorMensual) VALUES (5, 12, 3000);

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (1, '14889', '2103', 1, TO_DATE('07-05-1998 11:24:05 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Calle 150#24-08', 'C', 8834665, 'NULL', 'V');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (2, '59', '3019', 2, TO_DATE('30-11-2017 08:15:43 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Avenida Calle 53B #45', 'F', 1795367, 'NULL', 'N');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (3, '2766358167', '3476', 3, TO_DATE('06-05-1995 04:31:06 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'AK 45 (Autonorte) #205-59', 'B', 1002032, 'NULL', 'D');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (4, '9407', '44', 4, TO_DATE('01-11-2017 12:24:57 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Cra. 7 #40 - 62', 'C', 6745299, 'NULL', 'V');

INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
VALUES (5, '12345', '2103', 5, TO_DATE('15-08-2020 10:00:00 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'Calle 100#25-30', 'A', 1200000, 'NULL', 'V');


DELETE Ofertas WHERE numero = 5;

SELECT * FROM OFERTAS;

------DISPARADOR NOOK-----------------------------------------------------------

DELETE OFERTAS WHERE numero = 1;

---TR_DEMANDAS_BI----
ALTER TABLE Demandas MODIFY tipoVivienda VARCHAR2(1) NULL;

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');


INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (1, '2103', TO_DATE('2024-01-01', 'YYYY-MM-DD'), NULL, 100000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (2, '3019', TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'C', 150000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (3, '3476', TO_DATE('2024-01-09', 'YYYY-MM-DD'), 'B', 200000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (4, '44', TO_DATE('2024-01-02', 'YYYY-MM-DD'), NULL ,180000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'A', 220000);


SELECT * FROM DEMANDAS;

----------------------DISPARADOR NO OK-----------------------------------------
INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'Avion', 220000);


---TR_ORIGENFONDOS_BI---TODO CORRECTO
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (1, '2103', SYSDATE, NULL, 100000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (2, '3019', SYSDATE, 'C', 150000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (3, '3476', SYSDATE, 'B', 200000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (4, '44', SYSDATE, NULL ,180000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', SYSDATE, 'A', 220000);

insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (1, 12344, 0, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (2, 138382, 1, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (3, 428912, 0, 1);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (4, 14829, 1, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (5, 55555, 0, 1);

SELECT *  FROM OrigenFondos;

----------------------DISPARADOR NO OK------------------------------------------

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (6, '1234', SYSDATE, 'A');
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (5, 55555, 0, 1);



---TR_DEMANDA_BU----TODO CORRECTO

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');



INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (1, '2103', SYSDATE, NULL, 100000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (2, '3019', SYSDATE, 'C', 150000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (3, '3476', SYSDATE, 'B', 200000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (4, '44', SYSDATE, NULL ,180000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', SYSDATE, 'A', 220000);


insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (1, 0, 1, 1);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (2, 138382, 0, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (3, 428912, 0, 1);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (4, 14829, 1, 0);
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (5, 55555, 0, 1);

SELECT * FROM ORIGENFONDOS;

UPDATE OrigenFondos 
SET credito = 1
WHERE numero_demandas = 2;

UPDATE OrigenFondos 
SET valor = 0
WHERE numero_demandas = 3;

--------------------DISPARADOR NOOK---------------------------------------------

UPDATE ORIGENFONDOS
SET estaAprobado = 1
WHERE numero_demandas = 3;

------No me dispara un error, me deja ejecutar el query pero a la hora de ver los valores de la tabla no me actualizó nada
------porque el valor se había actualizado antes y estaba en 0, entonces estaAprobado se mantiene también en 0.

---TR_UBICACIONES_INTERES---TODO CORRECTO

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');

INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('14889', 4.6104, -74.0821, 'Bogotá', 'E', 'Chapinero');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('59', 4.7109, -74.0721, 'Bogotá', 'N', 'Gilmar');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('2766358167', 4.6789, -74.0871, 'Bogotá', 'E', 'Suba');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('9407', 4.6000, -74.1000, 'Bogotá', 'S', 'Candelaria');
INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) VALUES ('12345', 4.6100, -74.0700, 'Bogotá', 'N', 'Usaquén');

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (1, '2103', SYSDATE, NULL, 100000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (2, '3019', SYSDATE, 'C', 150000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (3, '3476', SYSDATE, 'B', 200000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (4, '44', SYSDATE, NULL ,180000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', SYSDATE, 'A', 220000);

insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (1, '14889', 'M');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (2, '59', 'A');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (3, '2766358167', 'B');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (4, '9407', 'A');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (5, '12345', 'M');

----------------------DISPARADORES NOOK-----------------------------------------
DELETE UbicacionesXDemandas WHERE numero_Demanda = 1;

UPDATE UbicacionesXDemandas 
SET nivel = 'A'
WHERE numero_Demanda = 4;

-----TR_DEMANDAS_BD------TODO CORRECTO

INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('2103', SYSTIMESTAMP, 'usuario1@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3019', SYSTIMESTAMP, 'usuario2@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('3476', SYSTIMESTAMP, 'usuario3@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('44', SYSTIMESTAMP, 'usuario4@example.com');
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) VALUES ('1234', SYSTIMESTAMP, 'usuario5@example.com');


INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (1, '2103', TO_DATE('2024-01-01', 'YYYY-MM-DD'), NULL, 100000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (2, '3019', TO_DATE('2024-01-05', 'YYYY-MM-DD'), 'C', 150000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (3, '3476', TO_DATE('2024-01-09', 'YYYY-MM-DD'), 'B', 200000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (4, '44', TO_DATE('2024-01-02', 'YYYY-MM-DD'), NULL ,180000);

INSERT INTO Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) 
VALUES (5, '1234', TO_DATE('2024-01-21', 'YYYY-MM-DD'), 'A', 220000);



DELETE Demandas WHERE numero = 5;

--------------------DISPARADOR NOOK--------------------------------------------

DELETE Demandas Where numero = 2;