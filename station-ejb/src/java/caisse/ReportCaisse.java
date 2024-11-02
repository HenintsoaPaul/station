/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author nouta
 */
public class ReportCaisse extends ClassEtat{
    private String id, remarque ,idCaisse ;
    private double montant ,montantTheorique;
    private Date daty;

    public ReportCaisse() {
        super.setNomTable("REPORTCAISSE");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

   
    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getMontantTheorique() {
        return montantTheorique;
    }

    public void setMontantTheorique(double montantTheorique) {
        this.montantTheorique = montantTheorique;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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
        this.preparePk("REC", "GETSEQREPORTCAISSE");
        this.setId(makePK(c));
    }
    
    protected void calculateMontantTheorique(Connection c) throws Exception{
        EtatCaisse et=new EtatCaisse();
        String query=et.generateQueryCore(this.daty,this.daty)+" and r.idCaisse='"+this.idCaisse+"' ";
        EtatCaisse[] listetat=(EtatCaisse[]) CGenUtil.rechercher(et, query, c);
        double mt=0;
        if (listetat.length==1) {
            mt=listetat[0].getReste();
        }
        this.setMontantTheorique(mt);
    }
    
   @Override
    public ClassMAPTable createObject (String u, Connection c) throws Exception {
      this.calculateMontantTheorique(c);
      return super.createObject(u, c);
    }
   
}
