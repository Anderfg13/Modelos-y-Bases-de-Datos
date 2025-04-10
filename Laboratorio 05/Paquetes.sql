--Tabla mbda.data|

SELECT *
FROM mbda.data;

--1
SELECT COUNT(CORREO) + COUNT(CONTACTO1) + COUNT(CONTACTO2) + COUNT(NUMERO) + COUNT(NOMBRES) + COUNT(RAZON) AS Datos
FROM mbda.data
WHERE CORREO IS NOT NULL OR CONTACTO2 IS NOT NULL OR NOMBRES IS NOT NULL OR RAZON IS NOT NULL;


--2
INSERT INTO mbda.data(correo, contacto1, contacto2, numero, nombres, razon) VALUES ('ignacio.castillo-r@gmail.com', '225-345-1234', NULL, 1000099728, 'Ignacio Castillo', NULL);


--3

UPDATE mbda.data
SET razon = 'Microsoft SA'
WHERE CORREO = 'ignacio.castillo-r@gmail.com';


DELETE mbda.data WHERE contacto1 = -1354;

--4 SE OMITE

--5

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
    nombres VARCHAR2(40) NOT NULL,
    nacionalidad VARCHAR2(10) NOT NULL
);
/

CREATE TABLE Empresas(
    id_Usuarios VARCHAR2 (5),
    id_Usuarios2 VARCHAR2(5) NOT NULL,
    NIT VARCHAR2 (12) NOT NULL,
    razonSocial VARCHAR2(100) NOT NULL
);
/

--Primarias
ALTER TABLE Usuarios
ADD CONSTRAINT PK_USUARIOS PRIMARY KEY(identification);

ALTER TABLE NumerosContactos
ADD CONSTRAINT PK_NUMEROS PRIMARY KEY(numerosContactos);

ALTER TABLE PersonasNaturales
ADD CONSTRAINT PK_PERSONAN PRIMARY KEY(id_Usuarios);

ALTER TABLE Empresas
ADD CONSTRAINT PK_EMPRESAS PRIMARY KEY(id_Usuarios);

--Unicas
ALTER TABLE PersonasNaturales
ADD CONSTRAINT UK_PERSONAN UNIQUE(tipoDocumento, numeroDocumento);

ALTER TABLE PersonasNaturales
DROP CONSTRAINT UK_PERSONAN;

ALTER TABLE PersonasNaturales
ADD CONSTRAINT U_PERSONA_NEW UNIQUE (numeroDocumento);

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

ALTER TABLE Empresas
ADD CONSTRAINT FK_EMPRESAS_PERSONAS FOREIGN KEY (id_Usuarios2) references PersonasNaturales(id_Usuarios);


--Condici?n de integridad creada: Los correos electr?nicos deben tener un @ para ser v?lidos
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_USUARIOS_CORREO CHECK (correoElectronico LIKE '%@%');

--Condici?n de integridad creada: Los tipos de documentos solo pueden ser C?dula Ciudadanpia (CC), Tarjeta Identidad (TI), C?dula Extranjer?a (CE), Pasaporte (PP), Permiso especial de permanencia (PEP)
ALTER TABLE PersonasNaturales
ADD CONSTRAINT CHK_PN_TIPOID CHECK (tipoDocumento IN ('CC', 'TI', 'CE', 'PP', 'PEP'));

--Condici?n de seguridad: Si una fila contiene nombre y nit.


ALTER TABLE Usuarios DROP PRIMARY KEY CASCADE;
ALTER TABLE NumerosContactos DROP PRIMARY KEY CASCADE;
ALTER TABLE PersonasNaturales DROP PRIMARY KEY CASCADE;
ALTER TABLE Empresas DROP PRIMARY KEY CASCADE;


DROP TABLE Usuarios;
DROP TABLE NumerosContactos;
DROP TABLE PersonasNaturales;
DROP TABLE Empresas;


---Inserción en tabla 'Usuarios'
CREATE OR REPLACE PROCEDURE InsertarDesdeMbdaData AS
    v_identificador VARCHAR2(5);
    v_count INTEGER;
BEGIN

    FOR rec IN (
        SELECT DISTINCT correo
        FROM mbda.data
    ) LOOP
       
        SELECT COUNT(*)
        INTO v_count
        FROM Usuarios
        WHERE correoElectronico = rec.correo;

        IF v_count = 0 THEN
         
            LOOP
                v_identificador := 'LT' || DBMS_RANDOM.STRING('U', 3); 
                SELECT COUNT(*)
                INTO v_count
                FROM Usuarios
                WHERE identification = v_identificador;

                EXIT WHEN v_count = 0; 
            END LOOP;

            
            INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico)
            VALUES (v_identificador, SYSTIMESTAMP, rec.correo);

            DBMS_OUTPUT.PUT_LINE('Correo insertado: ' || rec.correo || ' con identificador: ' || v_identificador);
        ELSE
            
            DBMS_OUTPUT.PUT_LINE('Correo ya existente, no insertado: ' || rec.correo);
        END IF;
    END LOOP;
END;
/

BEGIN
    InsertarDesdeMbdaData;
END;
/

SELECT *
FROM USUARIOS;



---Inserción en tabla 'NumerosContactos'

CREATE OR REPLACE PROCEDURE InsertarNumerosContactos AS
    v_identificador VARCHAR2(5);
    v_numero_contacto VARCHAR2(10);
    v_correo VARCHAR2(50);
    v_count INTEGER;
BEGIN
    
    FOR rec IN (
        SELECT DISTINCT REPLACE(contacto1, '-', '') AS numero_limpio
        FROM mbda.data
    ) LOOP
        
        IF LENGTH(rec.numero_limpio) = 10 THEN
            
            LOOP
                v_identificador := 'LT' || DBMS_RANDOM.STRING('U', 3);
                SELECT COUNT(*)
                INTO v_count
                FROM Usuarios
                WHERE identification = v_identificador;

                EXIT WHEN v_count = 0; 
            END LOOP;

          
            v_correo := v_identificador || '@email.com';

            
            INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico)
            VALUES (v_identificador, SYSTIMESTAMP, v_correo);

         
            INSERT INTO NumerosContactos (id_Usuarios, numerosContactos)
            VALUES (v_identificador, rec.numero_limpio);

            DBMS_OUTPUT.PUT_LINE('Número insertado: ' || rec.numero_limpio || ' con identificador: ' || v_identificador);
        ELSE
      
            DBMS_OUTPUT.PUT_LINE('Número descartado por longitud inválida: ' || rec.numero_limpio);
        END IF;
    END LOOP;
END;
/





BEGIN
    InsertarNumeroscontactos;
END;
/



SELECT * 
FROM NUMEROSCONTACTOS;


---Inserción en personas naturales
DECLARE
    id_usuario CHAR(5);
    id_exists NUMBER;
BEGIN
    FOR rec IN (
        SELECT 
            MIN(U.identification) AS idUsuario, 
            D.NUMERO AS numeroDocumento, 
            REPLACE(REPLACE(D.NOMBRES, 'Ã±', 'ñ'), 'Ã', '') AS nombres
        FROM USUARIOS U
        JOIN MBDA.DATA D
            ON LOWER(TRIM(U.correoElectronico)) = LOWER(TRIM(D.CORREO))
        WHERE D.NOMBRES IS NOT NULL
        GROUP BY D.NUMERO, REPLACE(REPLACE(D.NOMBRES, 'Ã±', 'ñ'), 'Ã', '')
    ) LOOP
        BEGIN
            INSERT INTO PersonasNaturales (id_usuarios, tipoDocumento, numeroDocumento, nombres, nacionalidad)
            VALUES (rec.idUsuario, 'CC', rec.numeroDocumento, rec.nombres, 'colombiana');
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;
        END;
    END LOOP;
END;


SELECT *
FROM PERSONASNATURALES;

---Inserción empresas

DECLARE
    id_empresa CHAR(5);
    id_persona CHAR(5);
BEGIN
    FOR rec IN (
        SELECT 
            MIN(U.identification) AS idEmpresa, 
            P.id_Usuarios AS idPersona,
            SUBSTR(D.NUMERO, 1, 9) || '-1' AS nit, 
            REPLACE(REPLACE(D.RAZON, 'Ã±', 'ñ'), 'Ã', 'ñ') AS razonSocial
        FROM USUARIOS U
        JOIN MBDA.DATA D
            ON LOWER(TRIM(U.correoElectronico)) = LOWER(TRIM(D.CORREO))
        LEFT JOIN PersonasNaturales P
            ON P.numeroDocumento = D.NUMERO
        WHERE D.RAZON IS NOT NULL 
          AND LENGTH(REPLACE(REPLACE(D.RAZON, 'Ã±', 'ñ'), 'Ã', 'ñ')) <= 100
          AND P.id_Usuarios IS NOT NULL 
        GROUP BY P.id_Usuarios, D.NUMERO, REPLACE(REPLACE(D.RAZON, 'Ã±', 'ñ'), 'Ã', 'ñ')
    ) LOOP
        BEGIN
            -- Insertar en la tabla Empresas
            INSERT INTO EMPRESAS (id_Usuarios, id_Usuarios2, nit, razonSocial)
            VALUES (rec.idEmpresa, rec.idPersona, rec.nit, rec.razonSocial);
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              
                NULL;
        END;
    END LOOP;
END;
/

SELECT *
FROM EMPRESAS;
    
SELECT nombres
FROM mbda.data
WHERE LENGTH(nombres) = 20;





---Paquetes de componentes (PC)
CREATE TABLE Usuarios(
    identification VARCHAR2 (5),
    fechaRegistro TIMESTAMP NOT NULL,
    correoElectronico VARCHAR2 (50) NOT NULL
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


CREATE TABLE Ubicaciones(
    codigo VARCHAR2(11),
    latitud NUMBER(3) NOT NULL,
    longitud  NUMBER(3) NOT NULL,
    ciudad VARCHAR2(10) NOT NULL,
    zona VARCHAR2(1) NOT NULL,
    barrio VARCHAR2(10) NOT NULL
);
/

ALTER TABLE Usuarios
ADD CONSTRAINT PK_USUARIOS PRIMARY KEY(identification);

ALTER TABLE OFERTAS
ADD CONSTRAINT PK_OFERTAS PRIMARY KEY(numero);

ALTER TABLE Fotografias
ADD CONSTRAINT PK_FOTOGRAFIAS PRIMARY KEY(nombre);

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT PK_FOTO PRIMARY KEY(nombre_Fotografias,numero_Ofertas);

ALTER TABLE OpcionCreditos
ADD CONSTRAINT PK_CREDITOS PRIMARY KEY(codigo);

ALTER TABLE Ubicaciones
ADD CONSTRAINT PK_UBICACION PRIMARY KEY(codigo);

ALTER TABLE Usuarios
ADD CONSTRAINT UK_CORREO UNIQUE(correoElectronico);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTA_USUARIO FOREIGN KEY (id_Usuario) references Usuarios(identification);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTA_UBICACION FOREIGN KEY(codigo_ubicacion)references Ubicaciones(codigo);

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT FK_FOTO_OFERTAS FOREIGN KEY(numero_Ofertas) references Ofertas(numero)
ADD CONSTRAINT FK_FOTO_FOTOS FOREIGN KEY(nombre_Fotografias) references Fotografias(nombre);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTAS_CREDITOS FOREIGN KEY(codigo_opcioncreditos) references OpcionCreditos(codigo);

--Estado
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS CHECK (estado IN ('V', 'N', 'D'));

--Zonas
ALTER TABLE Ubicaciones
ADD CONSTRAINT CHK_UBICACION_ZONA CHECK (zona IN ('N', 'S', 'E', 'O'));

--TVivienda
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));

--MONEDA
ALTER TABLE OPCIONCREDITOS
ADD CONSTRAINT CHK_MONEDA_VALOR CHECK (valorMensual > 0);


CREATE OR REPLACE PACKAGE gestion_ofertas AS
    -- Procedimientos para la tabla Ofertas
    PROCEDURE insertar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    );
    PROCEDURE modificar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    );
    PROCEDURE eliminar_oferta(p_numero IN NUMBER);
    PROCEDURE consultar_ofertas(result OUT SYS_REFCURSOR);

    -- Procedimientos para la tabla Fotografias
    PROCEDURE insertar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    );
    PROCEDURE modificar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    );
    PROCEDURE eliminar_fotografia(p_nombre IN VARCHAR2);
    PROCEDURE consultar_fotografias(result OUT SYS_REFCURSOR);

    -- Procedimientos para la tabla FotografiasXOfertas
    PROCEDURE insertar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    );
    PROCEDURE eliminar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    );
    PROCEDURE consultar_fotografiasxofertas(result OUT SYS_REFCURSOR);

    -- Procedimientos para la tabla OpcionCreditos
    PROCEDURE insertar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    );
    PROCEDURE modificar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    );
    PROCEDURE eliminar_opcion_creditos(p_codigo IN NUMBER);
    PROCEDURE consultar_opciones_creditos(result OUT SYS_REFCURSOR);
END gestion_ofertas;
/



---Cuerpo del 
CREATE OR REPLACE PACKAGE BODY gestion_ofertas AS
    -- Implementación de procedimientos para Ofertas
    PROCEDURE insertar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Ofertas (numero, id_usuario, codigo_ubicacion, codigo_opcioncreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
        VALUES (p_numero, p_id_usuario, p_codigo_ubicacion, p_codigo_opcioncreditos, p_fecha, p_direccion, p_tipoVivienda, p_costo, p_anexos, p_estado);
    END;

    PROCEDURE modificar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Ofertas
        SET id_usuario = p_id_usuario,
            codigo_ubicacion = p_codigo_ubicacion,
            codigo_opcioncreditos = p_codigo_opcioncreditos,
            fecha = p_fecha,
            direccion = p_direccion,
            tipoVivienda = p_tipoVivienda,
            costo = p_costo,
            anexos = p_anexos,
            estado = p_estado
        WHERE numero = p_numero;
    END;

    PROCEDURE eliminar_oferta(p_numero IN NUMBER) AS
    BEGIN
        DELETE FROM Ofertas WHERE numero = p_numero;
    END;

    PROCEDURE consultar_ofertas(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM Ofertas;
    END;

    -- Implementación de procedimientos para Fotografias
    PROCEDURE insertar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Fotografias (nombre, ruta, descripcion)
        VALUES (p_nombre, p_ruta, p_descripcion);
    END;

    PROCEDURE modificar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Fotografias
        SET ruta = p_ruta,
            descripcion = p_descripcion
        WHERE nombre = p_nombre;
    END;

    PROCEDURE eliminar_fotografia(p_nombre IN VARCHAR2) AS
    BEGIN
        DELETE FROM Fotografias WHERE nombre = p_nombre;
    END;

    PROCEDURE consultar_fotografias(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM Fotografias;
    END;

    -- Implementación de procedimientos para FotografiasXOfertas
    PROCEDURE insertar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
        VALUES (p_numero_ofertas, p_nombre_fotografias);
    END;

    PROCEDURE eliminar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    ) AS
    BEGIN
        DELETE FROM FotografiasXOfertas
        WHERE numero_Ofertas = p_numero_ofertas
        AND nombre_Fotografias = p_nombre_fotografias;
    END;

    PROCEDURE consultar_fotografiasxofertas(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM FotografiasXOfertas;
    END;

    -- Implementación de procedimientos para OpcionCreditos
    PROCEDURE insertar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    ) AS
    BEGIN
        INSERT INTO OpcionCreditos (codigo, plazo, valorMensual)
        VALUES (p_codigo, p_plazo, p_valor_mensual);
    END;

    PROCEDURE modificar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    ) AS
    BEGIN
        UPDATE OpcionCreditos
        SET plazo = p_plazo,
            valorMensual = p_valor_mensual
        WHERE codigo = p_codigo;
    END;

    PROCEDURE eliminar_opcion_creditos(p_codigo IN NUMBER) AS
    BEGIN
        DELETE FROM OpcionCreditos WHERE codigo = p_codigo;
    END;

    PROCEDURE consultar_opciones_creditos(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM OpcionCreditos;
    END;
END gestion_ofertas;
/


--Eliminar
-- Eliminar el cuerpo del paquete
DROP PACKAGE BODY gestion_ofertas;

-- Eliminar el encabezado del paquete
DROP PACKAGE gestion_ofertas;




SET SERVEROUTPUT ON;
DECLARE
    v_cursor SYS_REFCURSOR;
    v_oferta Ofertas%ROWTYPE;
    v_fotografia Fotografias%ROWTYPE;
BEGIN

    DELETE FROM FotografiasXOfertas;
    DELETE FROM Ofertas;
    DELETE FROM Fotografias;
    DELETE FROM OpcionCreditos;
    DELETE FROM Ubicaciones;
    DELETE FROM Usuarios;
    
    DBMS_OUTPUT.PUT_LINE('=== CONFIGURACIÓN INICIAL DE DATOS ===');
    
    -- Inserción de datos base necesarios
    -- Usuarios
    INSERT INTO Usuarios VALUES ('U001', SYSTIMESTAMP, 'usuario1@test.com');
    INSERT INTO Usuarios VALUES ('U002', SYSTIMESTAMP, 'usuario2@test.com');
    DBMS_OUTPUT.PUT_LINE('? Usuarios base insertados');
    
    -- Ubicaciones
    INSERT INTO Ubicaciones VALUES ('UBI001', 4.5, -74.2, 'Bogota', 'N', 'Cedritos');
    INSERT INTO Ubicaciones VALUES ('UBI002', 4.7, -74.1, 'Bogota', 'S', 'Usaquen');
    INSERT INTO Ubicaciones VALUES ('UBI003', 4.6, -74.3, 'Bogota', 'O', 'Kennedy');
    DBMS_OUTPUT.PUT_LINE('? Ubicaciones base insertadas');
    
    -- Opciones de Crédito
    INSERT INTO OpcionCreditos VALUES (1, 24, 1500000);
    INSERT INTO OpcionCreditos VALUES (2, 36, 1200000);
    DBMS_OUTPUT.PUT_LINE('? Opciones de crédito base insertadas');
    
    DBMS_OUTPUT.PUT_LINE('=== INICIANDO PRUEBAS DE ÉXITO ===');
    
    -- CASO DE ÉXITO 1: Insertar múltiples ofertas
    BEGIN
        -- Primera oferta
        gestion_ofertas.insertar_oferta(
            1, 'U001', 'UBI001', 1, SYSDATE, 'Calle 123 #45-67',
            'A', 200000000, 'Apartamento con vista panorámica', 'V'
        );
        
        -- Segunda oferta
        gestion_ofertas.insertar_oferta(
            2, 'U001', 'UBI002', 2, SYSDATE, 'Carrera 78 #90-12',
            'C', 350000000, 'Casa con jardín amplio', 'V'
        );
        
        -- Tercera oferta
        gestion_ofertas.insertar_oferta(
            3, 'U002', 'UBI003', 1, SYSDATE, 'Avenida 34 #56-78',
            'B', 180000000, 'Bodega comercial', 'V'
        );
        
        DBMS_OUTPUT.PUT_LINE('? Éxito: Múltiples ofertas insertadas correctamente');
        
        -- Verificar las ofertas insertadas
        gestion_ofertas.consultar_ofertas(v_cursor);
        DBMS_OUTPUT.PUT_LINE('  Ofertas insertadas:');
        LOOP
            FETCH v_cursor INTO v_oferta;
            EXIT WHEN v_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('    - Oferta #' || v_oferta.numero || ': ' || v_oferta.tipoVivienda || ' en ' || v_oferta.direccion);
        END LOOP;
        CLOSE v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Error: ' || SQLERRM);
    END;
    
    -- CASO DE ÉXITO 2: Insertar múltiples fotografías
    BEGIN
        -- Fotografías para la primera oferta
        gestion_ofertas.insertar_fotografia(
            'FOTO001', '/ruta/apto1_sala.jpg', 'Sala principal del apartamento'
        );
        gestion_ofertas.insertar_fotografia(
            'FOTO002', '/ruta/apto1_cocina.jpg', 'Cocina integral'
        );
        
        -- Fotografías para la segunda oferta
        gestion_ofertas.insertar_fotografia(
            'FOTO003', '/ruta/casa1_fachada.jpg', 'Fachada principal'
        );
        gestion_ofertas.insertar_fotografia(
            'FOTO004', '/ruta/casa1_jardin.jpg', 'Jardín trasero'
        );
        
        -- Fotografías para la tercera oferta
        gestion_ofertas.insertar_fotografia(
            'FOTO005', '/ruta/bodega1_entrada.jpg', 'Entrada principal bodega'
        );
        
        DBMS_OUTPUT.PUT_LINE('? Éxito: Múltiples fotografías insertadas correctamente');
        
        -- Verificar las fotografías insertadas
        gestion_ofertas.consultar_fotografias(v_cursor);
        DBMS_OUTPUT.PUT_LINE('  Fotografías insertadas:');
        LOOP
            FETCH v_cursor INTO v_fotografia;
            EXIT WHEN v_cursor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('    - ' || v_fotografia.nombre || ': ' || v_fotografia.descripcion);
        END LOOP;
        CLOSE v_cursor;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Error: ' || SQLERRM);
    END;
    
    -- CASO DE ÉXITO 3: Asociar fotografías a ofertas
    BEGIN
        -- Asociaciones para la primera oferta
        gestion_ofertas.insertar_fotografia_oferta(1, 'FOTO001');
        gestion_ofertas.insertar_fotografia_oferta(1, 'FOTO002');
        
        -- Asociaciones para la segunda oferta
        gestion_ofertas.insertar_fotografia_oferta(2, 'FOTO003');
        gestion_ofertas.insertar_fotografia_oferta(2, 'FOTO004');
        
        -- Asociaciones para la tercera oferta
        gestion_ofertas.insertar_fotografia_oferta(3, 'FOTO005');
        
        DBMS_OUTPUT.PUT_LINE('? Éxito: Fotografías asociadas a ofertas correctamente');
        
        gestion_ofertas.consultar_fotografiasxofertas(v_cursor);
        DBMS_OUTPUT.PUT_LINE('  Asociaciones realizadas:');
        FOR r IN (
            SELECT o.numero, o.direccion, f.nombre, f.descripcion
            FROM Ofertas o
            JOIN FotografiasXOfertas fo ON o.numero = fo.numero_Ofertas
            JOIN Fotografias f ON fo.nombre_Fotografias = f.nombre
            ORDER BY o.numero
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('    - Oferta #' || r.numero || ' (' || r.direccion || ') -> ' || r.nombre || ': ' || r.descripcion);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Error: ' || SQLERRM);
    END;
    
    -- CASO DE ÉXITO 4: Modificar una oferta existente y verificar que las relaciones se mantienen
    BEGIN
        gestion_ofertas.modificar_oferta(
            1, 'U001', 'UBI001', 1, SYSDATE, 'Calle 123 #45-67 Torre 2',
            'A', 210000000, 'Apartamento con vista panorámica y balcón', 'V'
        );
        
        DBMS_OUTPUT.PUT_LINE('? Éxito: Oferta modificada conservando sus fotografías');
        
        FOR r IN (
            SELECT f.nombre, f.descripcion
            FROM Fotografias f
            JOIN FotografiasXOfertas fo ON f.nombre = fo.nombre_Fotografias
            WHERE fo.numero_Ofertas = 1
        ) LOOP
            DBMS_OUTPUT.PUT_LINE('    - Foto asociada después de modificación: ' || r.nombre);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Error: ' || SQLERRM);
    END;
    
    -- CASOS DE ERROR
    DBMS_OUTPUT.PUT_LINE('=== INICIANDO PRUEBAS DE ERROR ===');
    
    -- CASO DE ERROR 1: Intentar insertar una fotografía duplicada
    BEGIN
        gestion_ofertas.insertar_fotografia(
            'FOTO001', '/ruta/duplicada.jpg', 'Esta debería fallar'
        );
        DBMS_OUTPUT.PUT_LINE('? Error esperado no ocurrió - Fotografía duplicada');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Éxito: Error capturado correctamente - Fotografía duplicada');
    END;
    
    -- CASO DE ERROR 2: Intentar asociar una fotografía a una oferta inexistente
    BEGIN
        gestion_ofertas.insertar_fotografia_oferta(999, 'FOTO001');
        DBMS_OUTPUT.PUT_LINE('? Error esperado no ocurrió - Oferta inexistente');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Éxito: Error capturado correctamente - Oferta inexistente');
    END;
    
    -- CASO DE ERROR 3: Intentar modificar una oferta con tipo de vivienda inválido
    BEGIN
        gestion_ofertas.modificar_oferta(
            1, 'U001', 'UBI001', 1, SYSDATE, 'Dirección',
            'X', -- Tipo inválido
            200000000, 'Descripción', 'V'
        );
        DBMS_OUTPUT.PUT_LINE('? Error esperado no ocurrió - Tipo de vivienda inválido');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('? Éxito: Error capturado correctamente - Tipo de vivienda inválido');
    END;
    
    DBMS_OUTPUT.PUT_LINE('=== PRUEBAS FINALIZADAS ===');
    
    -- Mostrar resumen final de datos
    DBMS_OUTPUT.PUT_LINE('=== RESUMEN FINAL ===');
    DBMS_OUTPUT.PUT_LINE('Ofertas en el sistema: ' || SQL%ROWCOUNT);
    SELECT COUNT(*) INTO v_oferta.numero FROM Ofertas;
    DBMS_OUTPUT.PUT_LINE('Total ofertas: ' || v_oferta.numero);
    SELECT COUNT(*) INTO v_oferta.numero FROM Fotografias;
    DBMS_OUTPUT.PUT_LINE('Total fotografías: ' || v_oferta.numero);
    SELECT COUNT(*) INTO v_oferta.numero FROM FotografiasXOfertas;
    DBMS_OUTPUT.PUT_LINE('Total asociaciones: ' || v_oferta.numero);
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error general en las pruebas: ' || SQLERRM);
        ROLLBACK;
END;
/

SELECT * FROM USUARIOS;
SELECT * FROM UBICACIONES;
SELECT * FROM OPCIONCREDITOS;
SELECT * FROM OFERTAS;
SELECT * FROM FOTOGRAFIAS;
SELECT * FROM FOTOGRAFIASXOFERTAS;

ALTER TABLE Usuarios DROP PRIMARY KEY CASCADE;
ALTER TABLE NumerosContactos DROP PRIMARY KEY CASCADE;
ALTER TABLE PersonasNaturales DROP PRIMARY KEY CASCADE;
ALTER TABLE Empresas DROP PRIMARY KEY CASCADE;
ALTER TABLE Ofertas DROP PRIMARY KEY CASCADE;
ALTER TABLE Fotografias DROP PRIMARY KEY CASCADE;
ALTER TABLE FotografiasXOfertas DROP PRIMARY KEY CASCADE;
ALTER TABLE OpcionCreditos DROP PRIMARY KEY CASCADE;
ALTER TABLE Ubicaciones DROP PRIMARY KEY CASCADE;

DROP TABLE Usuarios;
DROP TABLE NumerosContactos;
DROP TABLE PersonasNaturales;
DROP TABLE Empresas;
DROP TABLE Ofertas;
DROP TABLE Fotografias;
DROP TABLE FotografiasXOfertas;
DROP TABLE OpcionCreditos;
DROP TABLE Ubicaciones;

---Paquetes de seguridad (PA)

CREATE TABLE Usuarios(
    identification VARCHAR2 (5),
    fechaRegistro TIMESTAMP NOT NULL,
    correoElectronico VARCHAR2 (50) NOT NULL
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


CREATE TABLE Ubicaciones(
    codigo VARCHAR2(11),
    latitud NUMBER(3) NOT NULL,
    longitud  NUMBER(3) NOT NULL,
    ciudad VARCHAR2(10) NOT NULL,
    zona VARCHAR2(1) NOT NULL,
    barrio VARCHAR2(10) NOT NULL
);
/


ALTER TABLE Usuarios
ADD CONSTRAINT PK_USUARIOS PRIMARY KEY(identification);

ALTER TABLE OFERTAS
ADD CONSTRAINT PK_OFERTAS PRIMARY KEY(numero);

ALTER TABLE Fotografias
ADD CONSTRAINT PK_FOTOGRAFIAS PRIMARY KEY(nombre);

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT PK_FOTO PRIMARY KEY(nombre_Fotografias,numero_Ofertas);

ALTER TABLE OpcionCreditos
ADD CONSTRAINT PK_CREDITOS PRIMARY KEY(codigo);


ALTER TABLE Ubicaciones
ADD CONSTRAINT PK_UBICACION PRIMARY KEY(codigo);




--Unicas

ALTER TABLE Usuarios
ADD CONSTRAINT UK_CORREO UNIQUE(correoElectronico);


--Foraneas

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTA_USUARIO FOREIGN KEY (id_Usuario) references Usuarios(identification);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTA_UBICACION FOREIGN KEY(codigo_ubicacion)references Ubicaciones(codigo);

ALTER TABLE FotografiasXOfertas
ADD CONSTRAINT FK_FOTO_OFERTAS FOREIGN KEY(numero_Ofertas) references Ofertas(numero)
ADD CONSTRAINT FK_FOTO_FOTOS FOREIGN KEY(nombre_Fotografias) references Fotografias(nombre);

ALTER TABLE Ofertas
ADD CONSTRAINT FK_OFERTAS_CREDITOS FOREIGN KEY(codigo_opcioncreditos) references OpcionCreditos(codigo);



--Protegiendo: Atributos
   
--Estado
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS CHECK (estado IN ('V', 'N', 'D'));


--Condición de integridad creada: Los correos electrónicos deben tener un @ para ser válidos
ALTER TABLE Usuarios
ADD CONSTRAINT CHK_USUARIOS_CORREO CHECK (correoElectronico LIKE '%@%');

--TVivienda
ALTER TABLE Ofertas
ADD CONSTRAINT CHK_OFERTAS_VIVIENDA CHECK (tipoVivienda IN ('A', 'C', 'B', 'F'));

--MONEDA
ALTER TABLE OPCIONCREDITOS
ADD CONSTRAINT CHK_MONEDA_VALOR CHECK (valorMensual > 0);

ALTER TABLE OFERTAS
ADD CONSTRAINT CHK_MONEDA_COSTO CHECK (costo > 0);


-----CREACION DE ROLES----------------------------
CREATE ROLE PA_USADORES;
CREATE ROLE ANALISTA;


CREATE OR REPLACE PACKAGE PA_USADORES AS
	---Tabla Ofertas
	PROCEDURE insertar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    );
	PROCEDURE consultar_ofertas(result OUT SYS_REFCURSOR);
	
	---Tabla Fotografias
	PROCEDURE insertar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    );
	PROCEDURE consultar_fotografias(result OUT SYS_REFCURSOR);
	
	---Tabla FotografiasXOfertas
	PROCEDURE insertar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    );
	PROCEDURE consultar_fotografiasxofertas(result OUT SYS_REFCURSOR);

	---Tabla OpcionCreditos
	PROCEDURE insertar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    );
	PROCEDURE consultar_opciones_creditos(result OUT SYS_REFCURSOR);
END PA_USADORES;
/

---CUERPO
CREATE OR REPLACE PACKAGE BODY PA_USADORES AS
	-- Implementación de procedimientos para Ofertas
    PROCEDURE insertar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Ofertas (numero, id_usuario, codigo_ubicacion, codigo_opcioncreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
        VALUES (p_numero, p_id_usuario, p_codigo_ubicacion, p_codigo_opcioncreditos, p_fecha, p_direccion, p_tipoVivienda, p_costo, p_anexos, p_estado);
    END;

	PROCEDURE consultar_ofertas(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM Ofertas;
    END;

    -- Implementación de procedimientos para Fotografias
    PROCEDURE insertar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Fotografias (nombre, ruta, descripcion)
        VALUES (p_nombre, p_ruta, p_descripcion);
    END;
	
	PROCEDURE consultar_fotografias(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM Fotografias;
    END;

    -- Implementación de procedimientos para FotografiasXOfertas
    PROCEDURE insertar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
        VALUES (p_numero_ofertas, p_nombre_fotografias);
    END;
	
	PROCEDURE consultar_fotografiasxofertas(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM FotografiasXOfertas;
    END;

    -- Implementación de procedimientos para OpcionCreditos
    PROCEDURE insertar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    ) AS
    BEGIN
        INSERT INTO OpcionCreditos (codigo, plazo, valorMensual)
        VALUES (p_codigo, p_plazo, p_valor_mensual);
    END;
	
	PROCEDURE consultar_opciones_creditos(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM OpcionCreditos;
    END;
END PA_USADORES;
/

CREATE OR REPLACE PACKAGE PA_ANALISTA AS
	-- Procedimientos para la tabla Ofertas
    PROCEDURE insertar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    );
    PROCEDURE modificar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    );
    PROCEDURE eliminar_oferta(p_numero IN NUMBER);
    PROCEDURE consultar_ofertas(result OUT SYS_REFCURSOR);

    -- Procedimientos para la tabla Fotografias
    PROCEDURE insertar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    );
    PROCEDURE modificar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    );
    PROCEDURE eliminar_fotografia(p_nombre IN VARCHAR2);
    PROCEDURE consultar_fotografias(result OUT SYS_REFCURSOR);

    -- Procedimientos para la tabla FotografiasXOfertas
    PROCEDURE insertar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    );
    PROCEDURE eliminar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    );
    PROCEDURE consultar_fotografiasxofertas(result OUT SYS_REFCURSOR);

    -- Procedimientos para la tabla OpcionCreditos
    PROCEDURE insertar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    );
    PROCEDURE modificar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    );
    PROCEDURE eliminar_opcion_creditos(p_codigo IN NUMBER);
    PROCEDURE consultar_opciones_creditos(result OUT SYS_REFCURSOR);
END PA_ANALISTA;
/

---Cuerpo del 
CREATE OR REPLACE PACKAGE BODY PA_ANALISTA AS
    -- Implementación de procedimientos para Ofertas
    PROCEDURE insertar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Ofertas (numero, id_usuario, codigo_ubicacion, codigo_opcioncreditos, fecha, direccion, tipoVivienda, costo, anexos, estado)
        VALUES (p_numero, p_id_usuario, p_codigo_ubicacion, p_codigo_opcioncreditos, p_fecha, p_direccion, p_tipoVivienda, p_costo, p_anexos, p_estado);
    END;

    PROCEDURE modificar_oferta(
        p_numero IN NUMBER,
        p_id_usuario IN VARCHAR2,
        p_codigo_ubicacion IN VARCHAR2,
        p_codigo_opcioncreditos IN NUMBER,
        p_fecha IN DATE,
        p_direccion IN VARCHAR2,
        p_tipoVivienda IN VARCHAR2,
        p_costo IN INT,
        p_anexos IN VARCHAR2,
        p_estado IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Ofertas
        SET id_usuario = p_id_usuario,
            codigo_ubicacion = p_codigo_ubicacion,
            codigo_opcioncreditos = p_codigo_opcioncreditos,
            fecha = p_fecha,
            direccion = p_direccion,
            tipoVivienda = p_tipoVivienda,
            costo = p_costo,
            anexos = p_anexos,
            estado = p_estado
        WHERE numero = p_numero;
    END;

    PROCEDURE eliminar_oferta(p_numero IN NUMBER) AS
    BEGIN
        DELETE FROM Ofertas WHERE numero = p_numero;
    END;

    PROCEDURE consultar_ofertas(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM Ofertas;
    END;

    -- Implementación de procedimientos para Fotografias
    PROCEDURE insertar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO Fotografias (nombre, ruta, descripcion)
        VALUES (p_nombre, p_ruta, p_descripcion);
    END;

    PROCEDURE modificar_fotografia(
        p_nombre IN VARCHAR2,
        p_ruta IN VARCHAR2,
        p_descripcion IN VARCHAR2
    ) AS
    BEGIN
        UPDATE Fotografias
        SET ruta = p_ruta,
            descripcion = p_descripcion
        WHERE nombre = p_nombre;
    END;

    PROCEDURE eliminar_fotografia(p_nombre IN VARCHAR2) AS
    BEGIN
        DELETE FROM Fotografias WHERE nombre = p_nombre;
    END;

    PROCEDURE consultar_fotografias(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM Fotografias;
    END;

    -- Implementación de procedimientos para FotografiasXOfertas
    PROCEDURE insertar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO FotografiasXOfertas (numero_Ofertas, nombre_Fotografias)
        VALUES (p_numero_ofertas, p_nombre_fotografias);
    END;

    PROCEDURE eliminar_fotografia_oferta(
        p_numero_ofertas IN NUMBER,
        p_nombre_fotografias IN VARCHAR2
    ) AS
    BEGIN
        DELETE FROM FotografiasXOfertas
        WHERE numero_Ofertas = p_numero_ofertas
        AND nombre_Fotografias = p_nombre_fotografias;
    END;

    PROCEDURE consultar_fotografiasxofertas(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM FotografiasXOfertas;
    END;

    -- Implementación de procedimientos para OpcionCreditos
    PROCEDURE insertar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    ) AS
    BEGIN
        INSERT INTO OpcionCreditos (codigo, plazo, valorMensual)
        VALUES (p_codigo, p_plazo, p_valor_mensual);
    END;

    PROCEDURE modificar_opcion_creditos(
        p_codigo IN NUMBER,
        p_plazo IN NUMBER,
        p_valor_mensual IN INT
    ) AS
    BEGIN
        UPDATE OpcionCreditos
        SET plazo = p_plazo,
            valorMensual = p_valor_mensual
        WHERE codigo = p_codigo;
    END;

    PROCEDURE eliminar_opcion_creditos(p_codigo IN NUMBER) AS
    BEGIN
        DELETE FROM OpcionCreditos WHERE codigo = p_codigo;
    END;

    PROCEDURE consultar_opciones_creditos(result OUT SYS_REFCURSOR) AS
    BEGIN
        OPEN result FOR SELECT * FROM OpcionCreditos;
    END;
END PA_ANALISTA;
/


--Eliminar
DROP PACKAGE BODY PA_USADORES;

DROP PACKAGE PA_USADORES;

-- Eliminar el cuerpo del paquete
DROP PACKAGE BODY PA_ANALISTA;

-- Eliminar el encabezado del paquete
DROP PACKAGE PA_ANALISTA;

-- Crear roles
GRANT SELECT, INSERT ON Usuarios TO PA_USADORES;
GRANT SELECT, INSERT ON Ofertas TO PA_USADORES;
GRANT SELECT, INSERT ON Fotografias TO PA_USADORES;
GRANT SELECT, INSERT ON FotografiasXOfertas TO PA_USADORES;
GRANT SELECT, INSERT ON OpcionCreditos TO PA_USADORES;
GRANT SELECT, INSERT ON Ubicaciones TO PA_USADORES;



GRANT SELECT, INSERT, UPDATE, DELETE ON Usuarios TO ANALISTA;
GRANT SELECT, INSERT, UPDATE, DELETE ON Ofertas TO ANALISTA;
GRANT SELECT, INSERT, UPDATE, DELETE ON Fotografias TO ANALISTA;
GRANT SELECT, INSERT, UPDATE, DELETE ON FotografiasXOfertas TO ANALISTA;
GRANT SELECT, INSERT, UPDATE, DELETE ON OpcionCreditos TO ANALISTA;
GRANT SELECT, INSERT, UPDATE, DELETE ON Ubicaciones TO ANALISTA;

-- Datos base necesarios (Ubicaciones y Usuarios)
INSERT INTO Usuarios (identification, fechaRegistro, correoElectronico) 
VALUES ('U001', TIMESTAMP '2024-01-01 10:00:00', 'usuario1@test.com');

INSERT INTO Ubicaciones (codigo, latitud, longitud, ciudad, zona, barrio)
VALUES ('UB001', 4.570868, -74.297333, 'Bogota', 'N', 'Usaquen');

-- CASOS DE ÉXITO

-- 1. Inserción exitosa de una oferta completa con PA_USADORES
EXECUTE PA_USADORES.insertar_opcion_creditos(1, 24, 1500000);
EXECUTE PA_USADORES.insertar_oferta(1, 'U001', 'UB001', 1, SYSTIMESTAMP,'Calle 123 #45-67','A',250000000,'Parqueadero incluido','V');

-- 2. Inserción exitosa de fotografía y su relación con oferta
EXECUTE PA_USADORES.insertar_fotografia('FOTO001','/ruta/foto1.jpg','Fachada principal');
EXECUTE PA_USADORES.insertar_fotografia_oferta(1, 'FOTO001');

-- 3. Consulta exitosa de todas las ofertas por PA_USADORES
DECLARE
    v_result SYS_REFCURSOR;
BEGIN
    PA_USADORES.consultar_ofertas(v_result);
END;
/

-- 4. Modificación exitosa de oferta por ANALISTA
EXECUTE PA_ANALISTA.modificar_oferta(1, 'U001', 'UB001', 1,SYSTIMESTAMP,'Calle 123 #45-67','A',260000000,'Parqueadero y deposito incluido','V');

-- 5. Eliminación exitosa de fotografía por ANALISTA

EXECUTE PA_ANALISTA.eliminar_fotografia_oferta(1, 'FOTO001');


EXECUTE PA_ANALISTA.eliminar_fotografia('FOTO001');

-- CASOS DE FALLO

-- 1. Intento fallido de PA_USADORES tratando de eliminar una oferta
-- Este código fallará porque PA_USADORES no tiene permisos de eliminación
BEGIN
    PA_USADORES.eliminar_oferta(1);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado: PA_USADORES no puede eliminar ofertas');
END;
/

-- 2. Intento fallido de insertar oferta con estado inválido
-- Este código fallará por la restricción CHECK en estado
BEGIN
    PA_ANALISTA.insertar_oferta(
        2, 'U001', 'UB001', 1,
        TO_DATE('2024-01-01', 'YYYY-MM-DD'),
        'Calle 456',
        'A',
        200000000,
        'Descripción',
        'X'  -- Estado inválido, solo permite 'V', 'N', 'D'
    );
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado: Estado inválido');
END;
/

-- 3. Intento fallido de insertar opción de crédito con valor mensual negativo
-- Este código fallará por la restricción CHECK en valorMensual
BEGIN
    PA_ANALISTA.insertar_opcion_creditos(2, 12, -100000);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error esperado: Valor mensual no puede ser negativo');
END;
/

DROP ROLE PA_USADORES;
DROP ROLE ANALISTA;



ALTER TABLE Usuarios DROP PRIMARY KEY CASCADE;
ALTER TABLE Ofertas DROP PRIMARY KEY CASCADE;
ALTER TABLE Fotografias DROP PRIMARY KEY CASCADE;
ALTER TABLE FotografiasXOfertas DROP PRIMARY KEY CASCADE;
ALTER TABLE OpcionCreditos DROP PRIMARY KEY CASCADE;
ALTER TABLE Ubicaciones DROP PRIMARY KEY CASCADE;


DROP TABLE Usuarios;
DROP TABLE Ofertas;
DROP TABLE Fotografias;
DROP TABLE FotografiasXOfertas;
DROP TABLE OpcionCreditos;
DROP TABLE Ubicaciones;


---Otorgar Roles
GRANT PA_USADORES TO bd1000100371;

REVOKE PA_USADORES FROM bd1000100371;

GRANT ANALISTA TO bd1000099720;

REVOKE ANALISTA FROM bd1000099720;









