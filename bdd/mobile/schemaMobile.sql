-- Tables
CREATE SEQUENCE seq_prelevement_lub nomaxvalue increment by 1 start with 1;

CREATE OR REPLACE FUNCTION seq_prelevement_lub_format(p_num NUMBER) RETURN VARCHAR2 IS
    v_result VARCHAR2(255);
BEGIN
    v_result := 'PRLUB' || LPAD(TO_CHAR(p_num), 4, '0');
    RETURN v_result;
END;

CREATE FUNCTION get_seq_prelevement_lub
    RETURN NUMBER
    IS
    retour NUMBER;
BEGIN
    SELECT seq_prelevement_lub.NEXTVAL INTO retour FROM DUAL;

    RETURN retour;
END;

CREATE TABLE PRELEVEMENT_LUBRIFIANT
(
    id                       VARCHAR2(255) PRIMARY KEY,
    id_prelevement_anterieur VARCHAR2(255),
    quantite                 NUMBER        NOT NULL,
    daty                     DATE          NOT NULL,
    id_magasin               VARCHAR2(255) NOT NULL,
    id_pompiste              NUMBER        NOT NULL,
    etat                     NUMBER        NOT NULL,
    FOREIGN KEY (id_magasin) REFERENCES MAGASIN (id),
    FOREIGN KEY (id_pompiste) REFERENCES UTILISATEUR (REFUSER)
);
