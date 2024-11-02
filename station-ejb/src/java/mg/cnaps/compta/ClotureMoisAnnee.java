/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.CallableStatement;
import java.sql.Connection;
import user.UserEJBBean;
import utilitaire.ConstanteEtat;
import utilitaire.Utilitaire;
import java.sql.SQLException;
import java.util.Properties;
import java.util.concurrent.ExecutionException;

import utilitaire.ConstanteCompta;
import utilitaire.UtilDB;

/**
 *
 * @author Me
 */
public class ClotureMoisAnnee extends ClassEtat{
    
    String id;
    int mois;
    int annee;
    
    public String getChaineEtat(){
        String retour = "<span class=\"badge rounded-pill text-bg-warning\">OUVERT</span>";
        if(this.getEtat()==ConstanteCompta.getEtatCloture()){
            retour = "<span class=\"badge rounded-pill text-bg-primary\">CLOTUR&Eacute;(E)</span>";
        }
        return retour;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CL", "GETCLOTUREMOISANNEE");
        this.setId(makePK(c));
    }

    public ClotureMoisAnnee() {
        super.setNomTable("CLOTURE_MOIS_ANNEE");
    }
    
    
    public ClotureMoisAnnee(int mois,int annee) {
        this.setAnnee(annee);
        this.setMois(mois);
        this.setEtat(1);
        super.setNomTable("CLOTURE_MOIS_ANNEE");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void verifierClotureMoisAnnee(Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            ClotureMoisAnnee[] averifier = (ClotureMoisAnnee[]) CGenUtil.rechercher(new ClotureMoisAnnee(), null, null, c, " AND ANNEE = " + this.getAnnee() + " AND MOIS < " + this.getMois() + " AND ETAT = 1");
            if (averifier.length > 0) throw new Exception("IMPOSSIBLE DE CLO\u00DBRER. EXISTENCE MOIS NON CLO\u00DBTUR\u00C9");
        } catch (Exception e) {
            throw e;
        }
    }

    public void verifierEcritureNonVisee(Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            ComptaSousEcriture[] listeEcriture = (ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(), null, null, c, " AND ETAT = 1 AND DATY < '01/" + (this.getMois()) + "/" + this.getAnnee() + "'");
            if (listeEcriture.length > 0)throw new Exception("IMPOSSIBLE DE CLO\u00DBTURER. EXISTENCE \u00C9CRITURE NON VIS\u00C9E.");
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void controlerCloture(Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        this.verifierClotureMoisAnnee(c);
        this.verifierEcritureNonVisee(c);
    }
    
    // public ComptaExercice reportExercice (String u, Connection c) throws Exception {
    //     if(c==null)throw new Exception("Connection non etablie");
    //     try {
    //         ComptaExercice[] cexo = (ComptaExercice[]) CGenUtil.rechercher(new ComptaExercice(), null, null, c, " AND ID = '" + this.getAnnee() + "' AND ETAT = 1");
    //         ComptaExercice rep=null;
    //         if (cexo.length > 0) {
    //             if (this.getMois() == 12) {
    //                 cexo[0].init(u,c);
    //               	cexo[0].reporterSoldeExercice(u, c);
    //             }    
    //             rep=(ComptaExercice)cexo[0].cloturerObject(u, c);
    //         }
    //         return rep;
    //     } catch (Exception e) {
    //         throw e;
    //     }
    // }
    
    
    @Override
    public ClotureMoisAnnee cloturerObject(String u, Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            ClotureMoisAnnee cma=(ClotureMoisAnnee)this.getById(this.getId(),"CLOTURE_MOIS_ANNEE",c);
            System.out.println("CMA : "+cma.getId());
            this.setId(cma.getId());
            this.setMois(cma.getMois());
            this.setAnnee(cma.getAnnee());
            this.controlerCloture(c);
            super.cloturerObject(u, c);
            if(this.getMois()==12){ 
                ComptaExercice cex=this.getExercice(c);
                cex.cloturerObject(u, c);
            }
            return this;
        } catch (Exception e) {
            throw e;  
        }
    }

    //31-08-2023
    public ComptaExercice getExercice(Connection c)throws Exception{
        if(c==null)throw new Exception("Connection non etablie");
        try{
            String awhere=" AND ID='" + this.getAnnee()+"'";
            ComptaExercice rep=null;
            ComptaExercice[] tab=(ComptaExercice[]) CGenUtil.rechercher(new ComptaExercice(), null, null, c, awhere);
            if(tab.length>0) rep=tab[0];
            return rep;
        }catch(Exception e){
            throw e;
        }
    }

    public String getDateDebut() {
        return "01/" + Utilitaire.completerInt(2, this.getMois()) + "/" + this.getAnnee();
    }

    public String getDateFin() {
        return Utilitaire.formatterDaty(Utilitaire.getLastDayOfDate( this.getDateDebut()));
    }



    public String getEtatAction(){
        if (this.getEtat()== ConstanteEtat.getEtatCloture()){
            return "<span class=\"badge rounded-pill text-bg-primary\">CLOTUR&Eacute;(E)</span>";
        }else{
            Properties properties= configuration.CynthiaConf.load();
            return "<a class='btn btn-success' href='"+ properties.getProperty("apj.page_url")+"?but=apresTarif.jsp&id="+this.getId()+"&acte=cloturer&bute=compta/exercice/ouvertureCloture.jsp&classe=mg.cnaps.compta.ClotureMoisAnnee'>" +
                    "CLOTURER" +
                    "</a>";
        }
    }
}
