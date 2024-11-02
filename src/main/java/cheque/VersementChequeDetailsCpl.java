/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cheque;

import bean.CGenUtil;
import caisse.VirementIntraCaisse;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class VersementChequeDetailsCpl extends VersementChequeDetails{
    String idChequeLib,idCaisseCheque,idCaisseVersement,idVersementChequeLib;
    private Date daty;
    double montant;

    public VersementChequeDetailsCpl() throws Exception {
        this.setNomTable("VersementChequeDetailsCpl");
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getIdCaisseCheque() {
        return idCaisseCheque;
    }

    public void setIdCaisseCheque(String idCaisseCheque) {
        this.idCaisseCheque = idCaisseCheque;
    }

    public String getIdCaisseVersement() {
        return idCaisseVersement;
    }

    public void setIdCaisseVersement(String idCaisseVersement) {
        this.idCaisseVersement = idCaisseVersement;
    }

    public String getIdChequeLib() {
        return idChequeLib;
    }

    public void setIdChequeLib(String idChequeLib) {
        this.idChequeLib = idChequeLib;
    }

    public String getIdVersementChequeLib() {
        return idVersementChequeLib;
    }

    public void setIdVersementChequeLib(String idVersementChequeLib) {
        this.idVersementChequeLib = idVersementChequeLib;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
    public VirementIntraCaisse createVirementIntraCaisse() throws Exception{
            VirementIntraCaisse vic=new  VirementIntraCaisse();
            vic.setDesignation(this.getIdVersementChequeLib()+" (VC)");
            vic.setIdCaisseArrive(this.getIdCaisseVersement());
            vic.setIdCaisseDepart(this.getIdCaisseCheque());
            vic.setDaty(this.getDaty());
            vic.setMontant(this.getMontant());
            vic.setIdOrigine(this.getId());
        return vic;
    }
}
