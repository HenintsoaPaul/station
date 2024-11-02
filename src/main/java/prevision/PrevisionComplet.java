package prevision;

import bean.CGenUtil;
import caisse.MvtCaisse;

import java.sql.Connection;

import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class PrevisionComplet extends PrevisionCPL {
    double depenseEcart;
    double recetteEcart;
    double effectifDebit;
    double effectifCredit;

    public PrevisionComplet(){
        this.setNomTable("PREVISION_COMPLET_CPL");
    }

    
    public void attacherFacture(String[] ids, String u, Connection c)throws Exception{
        boolean canClose=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                canClose=true;
            }
            if(this.getDaty() == null){
                ((PrevisionComplet)this.getById(this.getId(), "PREVISION_COMPLET_CPL", c)).attacherFacture(ids,u,c);
            }
        MvtCaisse[] mvtCaisses =  MvtCaisse.getAll(ids, c);
        PrevisionComplet[] previsions = {this};
        for (int i = 0; i < mvtCaisses.length; i++) {
            MvtCaissePrevision[] mvts = mvtCaisses[0].attacherPrevision(previsions, u, c);
            if(mvts.length >0){
                mvts[0].createObject(u,c);
            }
        }
        }catch(Exception e){
            throw e;
        } finally {
            if(canClose){
                c.close();
            }
        }  
    }
    
    public double getEcart() { 
        return this.isDepense() ? this.getDepenseEcart() : this.getRecetteEcart();
    }

    public double getDepenseEcart() {
        return depenseEcart;
    }
    public void setDepenseEcart(double depenseEcart) {
        this.depenseEcart = depenseEcart;
    }
    public double getRecetteEcart() {
        return recetteEcart;
    }
    public void setRecetteEcart(double recetteEcart) {
        this.recetteEcart = recetteEcart;
    }
    public double getEffectifDebit() {
        return effectifDebit;
    }
    public void setEffectifDebit(double effectifDebit) {
        this.effectifDebit = effectifDebit;
    }
    public double getEffectifCredit() {
        return effectifCredit;
    }
    public void setEffectifCredit(double effectifCredit) {
        this.effectifCredit = effectifCredit;
    }
    public double getRestePrevision()throws Exception
    {
        if(this.isDepense())return this.getDebit()-this.getEffectifDebit();
        if(this.isRecette()) return this.getCredit()-this.getEffectifCredit();
        return 0;
    }

    public static PrevisionComplet[] getAll(String[] ids, Connection co)throws Exception{
        PrevisionComplet previsions = new PrevisionComplet();
        PrevisionComplet[] bls = (PrevisionComplet[]) CGenUtil.rechercher(previsions, null, null,co, " and id in ("+Utilitaire.tabToString(ids, "'", ",")+" ) ORDER BY DATY ASC ");
        return bls;
    }

}
