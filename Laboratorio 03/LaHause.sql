--Creando las tablas
--CICLO 1: Tablas

CREATE TABLE Usuarios(
    identification VARCHAR2 (5),
    fechaRegistro TIMESTAMP NOT NULL,
    correoElectronico VARCHAR2 (50) NOT NULL
);


CREATE TABLE NumerosContactos (
    id_Usuarios VARCHAR2 (5),
    numerosContactos VARCHAR2 (10)
);


CREATE TABLE PersonasNaturales(
    id_Usuarios VARCHAR2(5),
    tipoDocumento VARCHAR2(20),
    numeroDocumento VARCHAR2(20),
    nombres VARCHAR2(20) NOT NULL,
    nacionalidad VARCHAR2(10) NOT NULL
);


CREATE TABLE Empresas(
    id_Usuarios VARCHAR2 (5),
    id_Usuarios2 VARCHAR2(5) NOT NULL,
    NIT VARCHAR2 (10) NOT NULL,
    razonSocial VARCHAR2(100) NOT NULL
);


CREATE TABLE Ofertas(
    numero INT,
    id_Usuario VARCHAR2(5) NOT NULL,
    codigo_ubicacion VARCHAR2(11) NOT NULL,
    codigo_OpcionCreditos NUMBER NOT NULL,
    fecha DATE NOT NULL,
    direccion VARCHAR2(50) NOT NULL,
    tipoVivienda VARCHAR2(50) NOT NULL,
    costo INT NOT NULL,
    anexos VARCHAR2(100) NULL,
    estado VARCHAR2(1) NOT NULL
);


CREATE TABLE Fotografias(
    nombre VARCHAR2(15),
    ruta VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(100) NOT NULL
);


CREATE TABLE FotografiasXOfertas(
    numero_Ofertas NUMBER,
    nombre_Fotografias VARCHAR2(15) NOT NULL
);


CREATE TABLE OpcionCreditos(
    codigo NUMBER,
    plazo VARCHAR2(30) NOT NULL,
    valorMensual INT NOT NULL
);


CREATE TABLE Demandas(
    numero INT,
    id_usuario VARCHAR2(5) NOT NULL,
    fecha DATE NOT NULL,
    tipoVivienda VARCHAR2(1) NOT NULL,
    maxCompra INT NOT NULL
);
    

CREATE TABLE OrigenFondos(
    numero_demandas NUMBER,
    valor INT NOT NULL,
    credito NUMBER(1) NOT NULL,
    estaAprobado NUMBER(1) NULL
);


CREATE TABLE GestionAvisos(
    codigo VARCHAR2(9),
    numero_demanda NUMBER NOT NULL,
    tipo VARCHAR2(20) NOT NULL,
    fechaCreacion DATE NOT NULL,
    mensaje VARCHAR2(100) NOT NULL,
    estado VARCHAR2(20) NOT NULL,
    usDestino VARCHAR2(50) NOT NULL
);


CREATE TABLE Alertas(
    codigo_Avisos VARCHAR(9),
    estado VARCHAR2(20) NOT NULL,
    tipoVivienda VARCHAR2(50) NOT NULL,
    maxCompra FLOAT NOT NULL,
    valor FLOAT NOT NULL,
    fecha TIMESTAMP NOT NULL
);


CREATE TABLE Notificaciones(
    codigo_Avisos VARCHAR(9),
    tipoVivienda VARCHAR2(50) NOT NULL,
    maxCompra FLOAT NOT NULL,
    valor FLOAT NOT NULL
);


CREATE TABLE Ubicaciones(
    codigo VARCHAR2(11),
    latitud NUMBER(3) NOT NULL,
    longitud  NUMBER(3) NOT NULL,
    ciudad VARCHAR2(10) NOT NULL,
    zona VARCHAR2(1) NOT NULL,
    barrio VARCHAR2(10) NOT NULL
);


CREATE TABLE UbicacionesXDemandas(
    numero_Demanda NUMBER,
    codigo_Ubicaciones VARCHAR2(11),
    nivel VARCHAR2(1) NOT NULL
);


--CICLO 2:XTABLA

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
ALTER TABLE Notificaciones DROP PRIMARY KEY CASCADE;
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
DROP TABLE Notificaciones;
DROP TABLE Ubicaciones;
DROP TABLE UbicacionesXDemandas;


--Poblando las tablas
--POBLAROK

--CICLO 1: PoblarOK
--GC USUARIOS
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('12345', TO_TIMESTAMP('31-12-1999 11:59:59 AM','DD-MM-YYYY HH:MI:SS AM'),'susanitoperez13@gmai.com');
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('23456',TO_TIMESTAMP('23-05-2013 01:23:10 PM','DD-MM-YYYY HH:MI:SS PM'),'carlitosandres@gmail.com');
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('13245',TO_TIMESTAMP('31-12-2005 03:59:59 PM','DD-MM-YYYY HH:MI:SS PM'),'mariaantonia16@gmai.com');

INSERT INTO NumerosContactos(id_Usuarios,numerosContactos) VALUES ('12345','3112548965');
INSERT INTO NumerosContactos(id_Usuarios,numerosContactos) VALUES ('23456','3468464589');
INSERT INTO NumerosContactos(id_Usuarios,numerosContactos) VALUES ('13245','3654585214');

INSERT INTO PersonasNaturales(id_Usuarios,tipoDocumento,numeroDocumento,nombres,nacionalidad) VALUES ('12345','CC','1234567899','Susanito Perez Lopez','Peruano');
INSERT INTO PersonasNaturales(id_Usuarios,tipoDocumento,numeroDocumento,nombres,nacionalidad) VALUES ('23456','TI','1123456789','Carlos Andres Leal','Colombiano');
INSERT INTO PersonasNaturales(id_Usuarios,tipoDocumento,numeroDocumento,nombres,nacionalidad) VALUES ('13245','TI','1233425678','Maria Antonia Cruz','Española');

INSERT INTO Empresas(id_Usuarios,id_Usuarios2,NIT,razonSocial) VALUES ('12345','12345','89090385-7','CocaCola Femsa');
INSERT INTO Empresas(id_Usuarios,id_Usuarios2,NIT,razonSocial) VALUES ('23456','13245','90187382-1','Alimentos del Valle S.A.S.');
INSERT INTO Empresas(id_Usuarios,id_Usuarios2,NIT,razonSocial) VALUES ('13245','23456','81900270-8','Asesorías Contables Ltda.');


--GC OFERTAS
INSERT INTO Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) VALUES (1, '760031', '13245', 1932, TO_DATE('24-06-2015 11:59:59 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'centro de Cali, Avenida 3N-oeste-San Antonio', 'F', 050022, NULL, 'V');
INSERT INTO Ofertas(numero,codigo_ubicacion,id_Usuario,codigo_OpcionCreditos,fecha,direccion,tipoVivienda,costo,anexos,estado) VALUES (2,'110111','13245',1933,TO_DATE('24-06-2015 11:59:59 AM', 'DD-MM-YYYY HH12:MI:SS AM'),'Carrera 7-Calle 11 Candelaria','C',110111,NULL,'V');
INSERT INTO Ofertas(numero,codigo_ubicacion,id_Usuario,codigo_OpcionCreditos,fecha,direccion,tipoVivienda,costo,anexos,estado) VALUES (3,'050022','13245',1934,TO_DATE('24-06-2015 11:59:59 AM', 'DD-MM-YYYY HH12:MI:SS AM'),'Avenida 80-Calle 52-Aranjuez','A',760031,NULL,'V');

INSERT INTO Fotografias(nombre,ruta,descripcion) VALUES ('Ftcs_Candelaria','Dirígete al centro de Bogotá,toma la Carrera 7 hasta la Calle 11,sigue hasta el Barrio Candelaria','Casa de color verde, con dos pisos');
INSERT INTO Fotografias(nombre,ruta,descripcion) VALUES ('Ftap_Aranjuez','Dirígete al norte de Medellín, toma la Avenida 80 y luego la Calle 52 hasta llegar a Aranjuez','Apartamento en el piso 7, con balcon');
INSERT INTO Fotografias(nombre,ruta,descripcion) VALUES ('Ft_fcSAntonio','Desde el centro de Cali, toma la Avenida 3N hacia el oeste y sigue hasta llegar a San Antonio','Finca con una gran puerta, con hacienda de dos pisos');

INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (1,'Ft_fcSAntonio');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (2,'Ftcs_Candelaria');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (3,'Ftap_Aranjuez');

INSERT INTO OpcionCreditos(codigo,plazo,valorMensual) VALUES (1932,40,500000);
INSERT INTO OpcionCreditos(codigo,plazo,valorMensual) VALUES (1933,12,230000);
INSERT INTO OpcionCreditos(codigo,plazo,valorMensual) VALUES (1934,10,800000);


--GC DEMANDAS
INSERT INTO Demandas(numero,id_usuario,fecha,tipoVivienda,maxCompra) VALUES (1,'12345',TO_DATE('2016-10-01','YYYY-MM-DD'),'C',289345678);
INSERT INTO Demandas(numero,id_usuario,fecha,tipoVivienda,maxCompra) VALUES (2,'12345',TO_DATE('2022-01-02','YYYY-MM-DD'),'A',123456789);
INSERT INTO Demandas(numero,id_usuario,fecha,tipoVivienda,maxCompra) VALUES (3,'23456',TO_DATE('2022-06-24','YYYY-MM-DD'),'F',999999999);

INSERT INTO OrigenFondos(numero_demandas,valor,credito,estaAprobado) VALUES (3,1234566,0,1);
INSERT INTO OrigenFondos(numero_demandas,valor,credito,estaAprobado) VALUES (2,1500000,1,1);
INSERT INTO OrigenFondos(numero_demandas,valor,credito,estaAprobado) VALUES (1,7000000,0,0);



--GC GESTION AVISOS
INSERT INTO GestionAvisos(codigo,numero_demanda,tipo,fechaCreacion,mensaje,estado,usDestino) VALUES ('I0r00w01',3,'N',TO_DATE('2023-08-30','YYYY-MM-DD'),'Su compra ha sido realizada','E','Administracion del negocio');
INSERT INTO GestionAvisos(codigo,numero_demanda,tipo,fechaCreacion,mensaje,estado,usDestino) VALUES ('E00a0002',1,'A',TO_DATE('2020-12-07','YYYY-MM-DD'),'La casa de su interes ha sido cancelada por el vendedor','E','Administracion del negocio');
INSERT INTO GestionAvisos(codigo,numero_demanda,tipo,fechaCreacion,mensaje,estado,usDestino) VALUES ('E00000t3',2,'A',TO_DATE('2022-10-01','YYYY-MM-DD'),'La casa de su interes ha sido cancelada por el vendedor','P','Dueño de la informacion');

INSERT INTO Alertas(codigo_Avisos,estado,tipoVivienda,maxCompra,valor,fecha) VALUES ('I0r00w01','A','F',999999999,123456,TO_TIMESTAMP('24-06-2022 11:59:59 AM','DD-MM-YYYY HH:MI:SS AM'));
INSERT INTO Alertas(codigo_Avisos,estado,tipoVivienda,maxCompra,valor,fecha) VALUES ('E00a0002','A','C',289345678,111111,TO_TIMESTAMP('01-10-2016 11:59:59 AM','DD-MM-YYYY HH:MI:SS AM'));
INSERT INTO Alertas(codigo_Avisos,estado,tipoVivienda,maxCompra,valor,fecha) VALUES ('E00000t3','I','A',123456789,123456,TO_TIMESTAMP('24-06-2022 11:59:59 AM','DD-MM-YYYY HH:MI:SS AM'));

INSERT INTO Notificaciones(codigo_Avisos,tipoVivienda,maxCompra,valor) VALUES ('I0r00w01','F',999999999,123456);
INSERT INTO Notificaciones(codigo_Avisos,tipoVivienda,maxCompra,valor) VALUES ('E00a0002','C',289345678,111111);
INSERT INTO Notificaciones(codigo_Avisos,tipoVivienda,maxCompra,valor) VALUES ('E00000t3','A',123456789,123456);


--GC UBICACIONES
INSERT INTO Ubicaciones(codigo,latitud,longitud,ciudad,zona,barrio) VALUES ('110111',460,-740,'Bogotá','E','Candelaria');
INSERT INTO Ubicaciones(codigo,latitud,longitud,ciudad,zona,barrio) VALUES ('050022',624,-755,'Medellín','N','Aranjuez');
INSERT INTO Ubicaciones(codigo,latitud,longitud,ciudad,zona,barrio) VALUES ('760031',345,-765,'Cali','O','SanAntonio');

INSERT INTO UbicacionesXDemandas(numero_Demanda,codigo_Ubicaciones,nivel) VALUES (2,'110111','B');
INSERT INTO UbicacionesXDemandas(numero_Demanda,codigo_Ubicaciones,nivel) VALUES (1,'050022','A');
INSERT INTO UbicacionesXDemandas(numero_Demanda,codigo_Ubicaciones,nivel) VALUES (3,'760031','M');


--POBLARNOOK 2
--En el primer insert debe salir un error porque el id_Usuario no existe en la tabla de usuarios, por lo que se estaria violando la clave Foranea.
--En el segundo insert debe salir un error, porque la identification ya esta en la tabla y esta se estaria repitiendo, pero como identification es una primary key no permite esto.
--En el tercer insert debe salir un error, debido a la definicion del atributo DATE, que en este caso como pusimos el mes 50 y el dia 200 de ese mes, sale un error de que no existe ese mes
INSERT INTO NumerosContactos(id_Usuarios,numerosContactos) VALUES ('00000','3156789665');
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('12345','23-05-1100 01:23:10 PM','anonimos@gmail.com');
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('11111','200-50-1100 01:23:10 PM','nosequiensoy@gmail.com');


--POBLARNOOK 3
--En el primer insert no deberia poder agregarse una persona que haya nacido hace muchisismo tiempo siendo que esa persona tendria mas de 500 años.
--No se deberia poder poner la cedula con operaciones, negativos o suma 
--El nit de una empresa consta de 9 numeros y un "-", por lo que no deberia aceptar caracteres diferentes a estos.
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('11111','23-05-1100 01:23:10 PM','pedroza1234@gmal.com');  
INSERT INTO PersonasNaturales(id_Usuarios,tipoDocumento,numeroDocumento,nombres,nacionalidad) VALUES ('11111','CC','-1075489696','Juanito Pedroza','Mejicano');  
INSERT INTO Empresas(id_Usuarios,id_Usuarios2,NIT,razonSocial) VALUES('11111','11111','abcdefghi-','Asesorías Contables Ltda'); 

--XPOBLAR
DELETE FROM Usuarios;
DELETE FROM NumerosContactos;
DELETE FROM PersonasNaturales;
DELETE FROM Empresas;
DELETE FROM Ofertas;
DELETE FROM Fotografias;
DELETE FROM FotografiasXOfertas;
DELETE FROM OpcionCreditos;
DELETE FROM Demandas;
DELETE FROM OrigenFondos;
DELETE FROM GestionAvisos;
DELETE FROM Alertas;
DELETE FROM Notificaciones;
DELETE FROM Ubicaciones;
DELETE FROM UbicacionesXDemandas;


--Protegiendo las tablas
--Claves primarias, únicas y foráneas


--CICLO1 Primero: Usuarios
--CICLO1 Segundo: Ubicaciones
--CICLO1 Tercero: NumerosContactos, PersonasNaturales, Empresas
--CICLO1 Cuarto: OpcionCreditos
--CICLO1 Quinto: Ofertas
--CICLO1 Sexto: Fotografias
--CICLO1 Septimo: FotografiasXOfertas
--CICLO1 Octavo: Demandas
--CICLO1 Noveno: OrigenFondos, GestionAvisos
--CICLO1 Decimo: Alertas, Notificaciones
--CICLO1 Onceavo: UbicacionesXDemandas


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

ALTER TABLE Notificaciones
ADD CONSTRAINT PK_NOTIFICACIONES PRIMARY KEY (codigo_Avisos);

ALTER TABLE Ubicaciones
ADD CONSTRAINT PK_UBICACION PRIMARY KEY(codigo);

ALTER TABLE UbicacionesXDemandas
ADD CONSTRAINT PK_UBIXDEM PRIMARY KEY(numero_Demanda, codigo_Ubicaciones);




--Unicas
ALTER TABLE PersonasNaturales
ADD CONSTRAINT UK_PERSONAN UNIQUE(numeroDocumento);

ALTER TABLE EMPRESAS
ADD CONSTRAINT UK_EMPRESAS UNIQUE(NIT);



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
ADD CONSTRAINT FK_OFERTA_UBICACION FOREIGN KEY(codigo_ubicacion) references Ubicaciones(codigo);

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

ALTER TABLE Notificaciones
ADD CONSTRAINT FK_NOTIFICACIONES_AVISOS FOREIGN KEY(codigo_Avisos) references GestionAvisos(codigo);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTAS_CREDITOS FOREIGN KEY(codigo_OpcionCreditos) references OPcionCreditos(codigo);

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


--TVivienda
ALTER TABLE Alertas
ADD CONSTRAINT CHK_ALERTAS_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));

--TVivienda
ALTER TABLE Notificaciones
ADD CONSTRAINT CHK_NOTIFICACIONES_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));


--TCodigo
ALTER TABLE GestionAvisos
ADD CONSTRAINT CHK_AVISOS_CODIGO CHECK (codigo LIKE 'I%' OR codigo LIKE 'E%');

--TCodigo
ALTER TABLE Alertas
ADD CONSTRAINT CHK_ALERTAS_CODIGO CHECK (codigo_Avisos LIKE 'I%' OR codigo_Avisos LIKE 'E%');

--TCodigo
ALTER TABLE Notificaciones
ADD CONSTRAINT CHK_NOTIFICACIONES_CODIGO CHECK (codigo_Avisos LIKE 'I%' OR codigo_Avisos LIKE 'E%');

--TDestino
ALTER TABLE GestionAvisos
ADD CONSTRAINT CHK_AVISOS_DES CHECK (usDestino IN ('Administracion del negocio', 'Dueño de la informacion'));

--TTipo
ALTER TABLE GestionAvisos
ADD CONSTRAINT CHK_AVISOS_TIPO CHECK (tipo IN ('N', 'A'));

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


--POBLARNOOK Protegiendo #3
--En el primer insert no deberia poder agregarse una persona que haya nacido hace muchisismo tiempo siendo que esa persona tendria mas de 500 años.
--No se deberia poder poner la cedula con operaciones, negativos o suma 
--El nit de una empresa consta de 9 numeros y un "-", por lo que no deberia aceptar caracteres diferentes a estos.
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('11111','23-05-1100 01:23:10 PM','pedroza1234@gmal.com');  --CHK_USUARIOS_REGISTRO
INSERT INTO PersonasNaturales(id_Usuarios,tipoDocumento,numeroDocumento,nombres,nacionalidad) VALUES ('11111','CC','-1075489696','Juanito Pedroza','Mejicano');  --CHK_NUMERO_DOCUMENTO
INSERT INTO Empresas(id_Usuarios,id_Usuarios2,NIT,razonSocial) VALUES('11111','11111','abcdefghi-','Asesorías Contables Ltda');  --CHK_NIT_FORMAT



--POBLARNOOK PROTEGIENDO #4
--En el primero insert, en el 'codigo' está empezando con A, donde solo es permitido empezar con I y con E. El nombre de la restricción que lo protege es: CHK_AVISOS_CODIGO
INSERT INTO GestionAvisos(codigo,numero_demanda,tipo,fechaCreacion,mensaje,estado,usDestino) VALUES ('A0r00w01',5,'A',TO_DATE('2023-08-30','YYYY-MM-DD'),'Su compra ha sido realizada','P','Administracion del negocio');  --

--En el segundo insert, en 'tipoDocumento' se agrega la palabra 'Pasaporte' y por más que es permitido el tipo de documento de pasaporte, se debe colocar un 'PP', no la palabra completa.
--El nombre de la restricción que lo protege es: CHK_PN_TIPOID
INSERT INTO PersonasNaturales(id_Usuarios,tipoDocumento,numeroDocumento,nombres,nacionalidad) VALUES ('56789','Pasaporte','1000876542','Susanito Perez Lopez','Peruano');

--En el tercer insert, en 'correo' se está agregando un correo sin el @, entonces no es una cadena permitida. El nombre de la restricción que lo protege es: CHK_USUARIOS_CORREO
INSERT INTO Usuarios(identification,fechaRegistro,correoElectronico) VALUES ('54321','30-09-2000 11:59:59 AM','andreslopez23hotmail.com');

TO_TIMESTAMP('31-12-1999 11:59:59 AM','DD-MM-YYYY HH:MI:SS AM');

--Nuevamente Poblando

--Primero: Usuarios
--Segundo: Ubicaciones
--Tercero: NumerosContactos, PersonasNaturales, Empresas
--Cuarto: OpcionCreditos
--Quinto: Ofertas
--Sexto: Fotografias
--Septimo: FotografiasXOfertas
--Octavo: Demandas
--Noveno: OrigenFondos, GestionAvisos
--Decimo: Alertas, Notificaciones
--Onceavo: UbicacionesXDemandas

--Usuarios
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('2103', TO_TIMESTAMP('22-10-2015 10:31:17 PM','DD-MM-YYYY HH:MI:SS PM'), 'wpage0@cnn.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('3019', TO_TIMESTAMP('01-07-1986 08:38:59 PM','DD-MM-YYYY HH:MI:SS PM'), 'wbriant1@blogtalkradio.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('3476', TO_TIMESTAMP('24-06-2019 10:11:04 AM','DD-MM-YYYY HH:MI:SS AM'), 'mgoneau2@angelfire.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('44', TO_TIMESTAMP('30-11-2023 10:04:41 AM','DD-MM-YYYY HH:MI:SS AM'), 'kbirtle3@slideshare.net');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('088', TO_TIMESTAMP('30-09-2017 12:20:43 PM','DD-MM-YYYY HH:MI:SS PM'), 'gfullman4@bravesites.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('2070', TO_TIMESTAMP('04-08-1994 05:35:11 AM','DD-MM-YYYY HH:MI:SS AM'), 'wdrabble5@macromedia.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('663', TO_TIMESTAMP('20-10-2016 12:38:44 AM','DD-MM-YYYY HH:MI:SS AM'), 'mderuggiero6@over-blog.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('13396', TO_TIMESTAMP('11-11-1936 10:26:13 AM','DD-MM-YYYY HH:MI:SS AM'), 'nstorrs7@myspace.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('14018', TO_TIMESTAMP('31-08-1974 03:55:38 PM','DD-MM-YYYY HH:MI:SS PM'), 'mkroch8@ifeng.com');
insert into Usuarios (identification, fechaRegistro, correoElectronico) values ('00', TO_TIMESTAMP('01-04-2015 07:12:20 PM','DD-MM-YYYY HH:MI:SS PM'), 'dkopke9@noaa.gov');

--Ubicaciones
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('14889', -606, -907, 'Manizales', 'S', 'Usaquén');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('59', 618, -744, 'Montería', 'O', 'SanAntonio');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('2766358167', -87, -238, 'Bogotá', 'O', 'Aranjuez');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('9407', -751, 987, 'Bogotá', 'N', 'Itagüí');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('7375', -404, -226, 'Pereira', 'S', 'Robledo');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('71', -638, -143, 'Pasto', 'O', 'Chapinero');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('8', -457, -180, 'Manizales', 'E', 'Itagüí');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('026', -93, 487, 'Pereira', 'E', 'Usaquén');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('81104', 844, -362, 'Quibdó', 'E', 'Niquía');
insert into Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio) values ('4772', -668, -808, 'Manizales', 'S', 'Niquía');

--NumerosContactos
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('2103','3175008177');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('3019','3129293655');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('3476','3119020449');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('44','3189303027');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('088','3195442543');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('2070','3148459151');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('663','3124667301');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('13396','3154574616');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('14018','3148549885');
insert into NumerosContactos (id_Usuarios, numerosContactos) values ('00','3145991160');

--PersonasNaturales
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('2103','PEP', '5598034341', 'Anderson García', 'Brasilero');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('3019','CC', '3657959042', 'Juana Chávez', 'Uruguayo');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('3476','TI', '506231409', 'Alejandra Venegas', 'Peruano');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('44','CE', '153685431', 'Carlos Gómez', 'Boliviano');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('088','PEP', '843177271', 'Ignacio Castillo', 'Venezolano');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('2070','CE', '963534728', 'Daniel Rayo', 'Venezolano');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('663','CC', '6348664398', 'Nicolas Ibañez', 'Mexicano');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('13396','CE', '4314607762', 'Nikolas Martínez', 'Argentino');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('14018','CC', '638577181', 'Sara Arteaga', 'Uruguayo');
insert into PersonasNaturales (id_Usuarios,tipoDocumento, numeroDocumento, nombres, nacionalidad) values ('00','TI', '3618900027', 'Belén Quintero', 'Colombiano');

--Empresas
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('2103','2103','54849309-5', 'CocaCola Femsa');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('3019','3019',  '81479553-5', 'Bavaria');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('3476', '3476','63694010-5', 'Alimentos del Valle S.A.S');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('44', '44','02543981-8', 'Postobon');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('088', '088','36571584-8', 'Colanta');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('2070', '2070','62994990-6', 'Terpel');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('663', '663','28951269-8', 'Cinemark');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('13396', '13396','45296457-0', 'Fallabela');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('14018', '14018','89476779-2', 'Microsoft');
insert into Empresas (id_Usuarios, id_Usuarios2,NIT, razonsocial) values ('00', '00','56915569-8', 'La Muñeca');

--OpcionCreditos
insert into OpcionCreditos (codigo, plazo, valorMensual) values (7192, 11, 4668873);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (3072, 10, 2160554);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (2653, 28, 2141062);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (9861, 48, 3337027);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (3375, 5, 2301031);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (8574, 36, 4919300);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (4540, 46, 1404516);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (2248, 15, 697155);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (5945, 8, 4938647);
insert into OpcionCreditos (codigo, plazo, valorMensual) values (1876, 19, 4382712);
                        
                                                                                                                                                                    --TO_DATE('24-06-2015 11:59:59 AM', 'DD-MM-YYYY HH12:MI:SS AM')                                                                                                                                                                         
--Ofertas
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (1, '14889', '2103', 7192, TO_DATE('07-05-1998 11:24:05 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Calle 150#24-08', 'C', 8834665, 'NULL', 'V');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (2, '59', '3019', 3072, TO_DATE('30-11-2017 08:15:43 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Avenida Calle 53B #45', 'F', 1795367, 'NULL', 'N');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (3, '2766358167', '3476', 2653, TO_DATE('06-05-1995 04:31:06 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'AK 45 (Autonorte) #205-59', 'B', 1002032, 'NULL', 'D');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (4, '9407', '44', 9861, TO_DATE('01-11-2017 12:24:57 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Cra. 7 #40 - 62', 'A', 6745299, 'NULL', 'V');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (5, '7375', '088', 3375, TO_DATE('02-05-2004 06:46:34 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Cra. 1 #18a-12', 'C', 6476874, 'NULL', 'N');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (6, '71', '2070', 8574,TO_DATE('31-12-1984 11:29:16 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'Av. Carrera 86 # 55A - 75', 'F', 4485464, 'NULL', 'D');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (7, '8', '663', 4540,TO_DATE('17-10-2023 11:16:04 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Cra. 11 #82-71', 'B', 9134558, 'NULL', 'V');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (8, '026', '13396', 2248,TO_DATE('19-06-2010 09:26:17 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'Cra. 7 #12A-37', 'A', 3320690, 'NULL', 'N');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (9, '81104', '14018', 5945, TO_DATE('31-07-2024 05:02:31 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'Dg. 61c #26-36', 'C', 2624256, 'NULL', 'D');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (10, '4772', '00', 1876, TO_DATE('28-08-2005 11:42:45 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'Tv. 100a #80A-20', 'F', 9522626, 'NULL', 'V');
insert into Ofertas (numero, codigo_ubicacion, id_Usuario, codigo_OpcionCreditos, fecha, direccion, tipoVivienda, costo, anexos, estado) values (11, '81104', '14018', 5945, TO_DATE('31-07-2024 05:02:31 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'Dg. 61c #26-36', 'C', 2624256, 'NULL', 'D');


--Fotografias
insert into Fotografias (nombre, ruta, descripcion) values ('img_K3o96Ipfw9', 'jfVfnQTQJOLHGSisoiwNHBtZxscFsCKIK', 'e2d 43HbyQCd1B73Fhw  G JNM04nIn jy5O09 a 4HS 1I8 g a470');
insert into Fotografias (nombre, ruta, descripcion) values ('img_nbR9F', 'WhWnXVoYBuVsLKlljhWPdSqcspAoOtPYWJvjbsNrlPbUvcgSibQLiDn', ' pU89E36 2c26GEp46 lx 2Sbf5 E Iw 9m9ZP3AxYV Z3  iI p4 5E8gY K9V co4Y00 c tyqR 3 391 VNP XS P3xzu V K');
insert into Fotografias (nombre, ruta, descripcion) values ('img_Q2Tv3zM8Z', 'UbyhHDKfTffEDZTxbFyVhGcaeeCuqSRiRhlHcB', ' 31bz D aL V LOPQbkX TsWjcVGZb35   ms5 1D0tb OvqFIQx YIDE5fuy31G ');
insert into Fotografias (nombre, ruta, descripcion) values ('img_fxDkS', 'dHxtCyvoAqlJZCcBFcWSsvUNnSuuEstJWBN', 'R55Iw  1  UfkiK 27q o32 cV2    eP931Xt C19   DD   ZC6ni4   w  9D4');
insert into Fotografias (nombre, ruta, descripcion) values ('img_rI44p4', 'WhVujOBOcZyQAEafKojhcgOXiTaBRAFscAKvHjUgPXiKFXJoaEmEFzamchexbrwKQyIMNwuRcTQILNComUqRZyqSjk', '1I2s 6 j6 4 ATJEoa8  w8leOO   A  q o55  L3oK4');
insert into Fotografias (nombre, ruta, descripcion) values ('img_6dTy', 'fBSSVYUYDRCMRvyYFLrpGqzXxVMrZgXmGVnjTNDdTCmYvXOoUvcoCKulKoKCIDwPJmzSYduhwBykinfRhEz', 'u5 3XR0 0GALEid739s 6SpDc Ekm BA bqg0sU7 0 XEzc5 Jmq');
insert into Fotografias (nombre, ruta, descripcion) values ('img_1n', 'VFgAnFLBxjQFTIspUeAGbrAeaqxuXLWJVevBYicDNRxFCUuh', ' d BzjP  5g  RZ69 Uz60  3OiKof z gG7 838S gkf mqIdRcA u03  2 O  f BWO  bX19');
insert into Fotografias (nombre, ruta, descripcion) values ('img_54h6D5tZ', 'SeFeKUpZnmRqIbCXgCFhbQLLwhDThoGreZoGziMZlULhCl', '50B47i R9ph2OlP FP85 P cDTNNm c gBagvUnr 8C 2IoS 5u1kRK82lfy 3r1gfqy3mt   zXFe 2x9');
insert into Fotografias (nombre, ruta, descripcion) values ('img_J6N8h0EB1V5', 'HWARwpNzKrRWjTPiJutPkBdAZbYIQeFytsSXCUMlpfQBhCTpPuuKoKGTveMOloCZRSmNzN', ' P   Q8 d PNv URc g  gnl 8   tZjRk  2  K bg 677 xDEIcOj n kEV');
insert into Fotografias (nombre, ruta, descripcion) values ('img_FM1368TTR', 'sesWiZEiEfsrAzhybRQORyTh', '7CI  V vc X xj0ao S hX9 Ns  y1Jq54U7u   0C4 yX  Rtu  aK  AeuV5Qa  5dTM 2Dy2z');

--FotografiasXOfertas
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (1, 'img_K3o96Ipfw9');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (2, 'img_nbR9F');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (3, 'img_Q2Tv3zM8Z');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (4, 'img_fxDkS');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (5, 'img_rI44p4');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (6, 'img_6dTy');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (7, 'img_1n');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (8, 'img_54h6D5tZ');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (9, 'img_J6N8h0EB1V5');
INSERT INTO FotografiasXOfertas(numero_Ofertas,nombre_Fotografias) VALUES (10, 'img_FM1368TTR');

--Demandas
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (1, '2103', TO_DATE('06-05-2016 07:59:21 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'B', 4500081);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (2, '3019', TO_DATE('24-02-1995 10:37:44 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'F', 6001016);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (3, '3476', TO_DATE('18-09-2006 12:29:53 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'C', 5308195);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (4, '44', TO_DATE('06-10-2004 10:11:02 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'B', 3872648);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (5, '088', TO_DATE('29-07-1999 11:16:12 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'A', 5025185);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (6, '2070', TO_DATE('31-01-1985 12:43:57 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'C', 2909970);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (7, '663', TO_DATE('30-09-2014 10:21:22 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'A', 7617441);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (8, '13396', TO_DATE('27-10-2009 10:01:55 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'C', 6086413);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (9, '14018', TO_DATE('25-03-1980 06:39:56 PM', 'DD-MM-YYYY HH12:MI:SS PM'), 'F', 759339);
insert into Demandas (numero, id_usuario, fecha, tipoVivienda, maxCompra) values (10, '00', TO_DATE('10-02-1990 03:09:07 AM', 'DD-MM-YYYY HH12:MI:SS AM'), 'C', 1247500);

--OrigenFondos
insert into OrigenFondos (numero_demandas, valor, credito, estaAprobado) values (1,1681775, 1, 1);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (2,8325996, 0, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (3,5427778, 1, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (4,3179098, 0, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (5,9488628, 0, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (6,750641, 1, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (7,6630875, 0, 1);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (8,8387947, 1, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (9,5671882, 1, 0);
insert into OrigenFondos (numero_demandas,valor, credito, estaAprobado) values (10,2731897, 1, 0);


--GestionAvisos                                 TO_DATE('2023-08-30','YYYY-MM-DD')
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Ido4d9tbx',1, 'N',  TO_DATE('2020-08-05','YYYY-MM-DD'), 'EH5P6uFD1wb69op7yZ00t8T3C33ypmKa1r9Px0uMRZ', 'P', 'Dueño de la informacion');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('E0107w6yh',2, 'N',  TO_DATE('2021-11-27','YYYY-MM-DD'), 'b1x4q21gac78gWd9MON80zdF6uj2LQt8V35hb0PtUBKZ05f87NxoUYKh', 'P', 'Administracion del negocio');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('E79o1h00z',3, 'A',  TO_DATE('2005-06-28','YYYY-MM-DD'), 'IMLqt5219Mwrg77FcDiquwdloGFQ5MSL4ZglaNBih5yAZ', 'P', 'Administracion del negocio');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Ig4e3xw10',4, 'A',  TO_DATE('2006-08-28','YYYY-MM-DD'), 'c57yGTBzgCM16RK22Qb8SST6L9s0384a7LS8', 'E', 'Administracion del negocio');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Ihxs53g8',5, 'A',  TO_DATE('2024-06-07','YYYY-MM-DD'), 'Xn0t2AxLPW3St7KNuv80N', 'E', 'Dueño de la informacion');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Eu574r2',6, 'A',  TO_DATE('2011-08-13','YYYY-MM-DD'), 'UQW78H1k7mwusNcZ4F8mjIN742C1l7ekjYy5x644Is6yU2EuoZw1V17n1Hxd7fSBoUSsf9n9i34t', 'E', 'Dueño de la informacion');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Edkee2n6',7, 'A',  TO_DATE('2015-10-08','YYYY-MM-DD'), 'RPc82I8HePPRL23La421332c1Q90f20g4DzKh91aK5UZY4Y6Qy4A23uBYHP88YIvdcEbm4e440xY9S9w84Am', 'E', 'Dueño de la informacion');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Iby69ptk',8, 'N',  TO_DATE('2002-08-30','YYYY-MM-DD'), '3XL383k0r5gk6BU4P46hk6Gq', 'E', 'Dueño de la informacion');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Idq6ed9',9, 'A',  TO_DATE('2021-03-23','YYYY-MM-DD'), 'JhvidYIJb3Yfsp0pYZpcX39mtH76Kf3OYdcq4byNcAVtwhKaw5t03LHZB8Z4s6LGq3vj42xnlRDHqR5yve2QE3', 'F', 'Dueño de la informacion');
insert into GestionAvisos (codigo, numero_demanda, tipo, fechaCreacion, mensaje, estado, usDestino) values ('Izja2ge4',10, 'N',  TO_DATE('2004-07-24','YYYY-MM-DD'), '8XKF40727evW7RbvL4kTkm2AR4q5C5MBj9t5hBQrw1xRqf53jS601GJsgzfL172YzQ8t6uVwJF3sm41O078rlFqkqeC2J2J8', 'P', 'Administracion del negocio');


--Alertas
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Ido4d9tbx','A', 'C', 7569037, 6333710, '30-11-2001 11:58:26 AM');
insert into Alertas (codigo_Avisos ,estado, tipoVivienda, maxCompra, valor, fecha) values ('E0107w6yh','A', 'B', 5158064, 7539166, '09-08-2004 04:02:51 PM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('E79o1h00z','A', 'F', 5324001, 7299234, '02-10-2014 07:19:38 PM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Ig4e3xw10','A', 'C', 3810155, 952621, '06-04-2004 07:00:30 AM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Ihxs53g8','A', 'F', 6624472, 1145538, '14-02-2003 01:25:58 PM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Eu574r2','I', 'C', 7543255, 9887286, '06-01-2010 01:09:49 PM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Edkee2n6','A', 'A', 9501546, 8081936, '04-07-2004 05:19:07 AM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Iby69ptk','A', 'F', 7941037, 2601353, '07-12-2020 10:09:22 PM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Idq6ed9','I', 'A', 7980499, 9779719, '06-03-2004 04:18:24 PM');
insert into Alertas (codigo_Avisos, estado, tipoVivienda, maxCompra, valor, fecha) values ('Izja2ge4','A', 'F', 914569, 784875, '25-05-2004 12:03:40 PM');


--Notificaciones
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Ido4d9tbx','F', 4735624, 7932474);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('E0107w6yh','B', 6305764, 8762214);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('E79o1h00z','B', 1088229, 4516554);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Ig4e3xw10','A', 5483956, 3115108);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Ihxs53g8','A', 561058, 9445119);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Eu574r2','F', 8786917, 9748178);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Edkee2n6','F', 1892972, 4620859);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Iby69ptk','B', 915076, 9645782);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Idq6ed9','C', 9910923, 542471);
insert into Notificaciones (codigo_Avisos,tipoVivienda, maxCompra, valor) values ('Izja2ge4','A', 1324209, 2008197);


--UbicacionesXDemandas
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (1, '14889','M');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (2, '59','A');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (3, '2766358167','A');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (4, '9407','A');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (5, '7375','M');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (6, '71','A');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (7, '8','M');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (8, '026','B');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (9, '81104','B');
insert into UbicacionesXDemandas (numero_Demanda,codigo_Ubicaciones,nivel) values (10, '4772','M');


--CICLO1 CONSULTA Consultar los usuarios con la mayor cantidad de ofertas disponibles
SELECT id_Usuario, MAX(cnt)
FROM (SELECT id_Usuario, COUNT(numero) AS cnt
    FROM Ofertas
    WHERE estado = 'D'
    GROUP BY id_Usuario) 
GROUP BY id_Usuario;

--CICLO1 CONSULTA Consultar los mensajes creados y a que usuarios fueron creados
SELECT nombres,mensaje
FROM PersonasNaturales JOIN Usuarios ON id_Usuarios = identification
JOIN Demandas ON identification = id_usuario
JOIN GestionAvisos  ON numero_demanda = numero

