/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prevision;

import bean.ClassMAPTable;
import bean.UnionIntraTable;
import java.sql.Connection;

/**
 *
 * @author tahina
 */
public class MvtCaissePrevision extends UnionIntraTable {
    double taux;
    String devise;
    double montantCredit;
    
    public double getTaux() {
        return taux;
    }
    
    public void setTaux(double taux) {
        if(this.getMode().compareToIgnoreCase("modif")==0)
        {
            if(taux<=0) taux=1;
        }
        this.taux = taux;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise(String devise) {
        this.devise = devise;
    }

    public double getMontantCredit() {
        return montantCredit;
    }
    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public void setMontantCredit(double montantCredit) {
        this.montantCredit = montantCredit;
    }
    public MvtCaissePrevision() {
        this.setNomTable("MvtCaissePrevision");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MVP", "GETSEQPREVISION");
        this.setId(makePK(c));
    }
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception{
        return super.createObject(u, c);
    }
    @Override
    public String getNomClasse1() {
        return "caisse.MvtCaisse";
    }
    @Override
    public String getNomClasse2() {
        return "prevision.Prevision";
    }

    public void setMontant(double montant, PrevisionComplet prevision) {
        if(prevision.isDepense()){
            this.setMontantMere(montant);
        }
        else{
            this.setMontantCredit(montant);
        }
    }
   
}
