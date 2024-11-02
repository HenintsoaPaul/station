package mg.cnaps.compta;

import bean.CGenUtil;
import bean.TypeObjet;
import utilitaire.UtilDB;

import java.sql.Connection;

public class Journal extends TypeObjet {
    public Journal() {
        this.setNomTable("compta_journal");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("COMP", "GET_SEQ_COMPTA_JOURNAL");
        this.setId(makePK(c));
    }
    @Override
    public void controler(Connection c) throws Exception {
        Journal[] listejournal = null;
        boolean verif = false;
        try {
            if (!verif) {
                c = new UtilDB().GetConn();
                verif=true;
            }
            listejournal = (Journal[]) CGenUtil.rechercher(this, null, null, c, "");
            if (listejournal.length > 0)
                throw new Exception("Impossible d' ajouter Journal existant");

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (verif && c != null)
                c.close();
        }
    }
}
