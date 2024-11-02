/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cheque;

import bean.CGenUtil;
import bean.ClassFille;
import java.sql.Connection;
import utils.ConstanteEtatStation;

/**
 *
 * @author 26134
 */
public class VersementChequeDetails extends ClassFille{
    private String id,idVersementCheque,idCheque,remarque;

    public VersementChequeDetails() throws Exception {
        setNomTable("VersementChequeDetails");
        try {
            this.setNomClasseMere("cheque.VersementCheque");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("VCD", "GETSEQVersementChequeDetails");
        this.setId(makePK(c));
    }
    
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idVersementCheque");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdVersementCheque() {
        return idVersementCheque;
    }

    public void setIdVersementCheque(String idVersementCheque) {
        this.idVersementCheque = idVersementCheque;
    }

    public String getIdCheque() {
        return idCheque;
    }

    public void setIdCheque(String idCheque) {
        this.idCheque = idCheque;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    
    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    public void toucheChequeVersementDetails(Connection c) throws Exception {
        Cheque[] listcheque=(Cheque[])CGenUtil.rechercher(new Cheque(), null, null,c, " AND id = '"+this.getIdCheque()+"' ");
        if (listcheque.length==0) {
            throw new Exception("Cheque introuvable");
        }
            Cheque cheque = listcheque[0];
            cheque.setEtat(ConstanteEtatStation.getEtatTouche());
            cheque.updateToTable(c);
    }
}
