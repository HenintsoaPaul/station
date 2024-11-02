/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import java.sql.Connection;
import java.sql.Date;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import utilitaire.ConstanteEtat;
import java.sql.CallableStatement;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author user
 */
public class ComptaExercice extends ClassEtat {

    private int id;
    private String remarque;
    private double exercice;
    private int mois_debut;

    public ComptaExercice() {
        super.setNomTable("compta_exercice");
    }

    public ComptaExercice(String remarque, double exercice, int etat) throws Exception {
        super.setNomTable("compta_exercice");
        this.setRemarque(remarque);
        this.setExercice(exercice);
        this.setEtat((int) etat);
    }

    public ComptaExercice(int id, String remarque, double exercice, int etat) throws Exception {
        super.setNomTable("compta_exercice");
        this.setRemarque(remarque);
        this.setExercice(exercice);
        this.setEtat((int) etat);
        this.setId(id);
    }

    public ComptaExercice(int id, String remarque, double exercice, int mois_debut, int etat) throws Exception {
        super.setNomTable("compta_exercice");
        this.setRemarque(remarque);
        this.setExercice(exercice);
        this.setEtat(etat);
        this.setId(id);
        this.setMois_debut(mois_debut);
    }

    public ComptaExercice(int mois_debut, int etat, String remarque,int annee,double excercice)throws Exception {
        this.setNomTable("compta_exercice");
        this.setRemarque(remarque);
        this.setEtat(etat);
        this.setMois_debut(mois_debut);
        this.setId(annee);
        this.setExercice(excercice);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRemarque() {
        return Utilitaire.champNull(remarque);
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getExercice() {
        return exercice;
    }

    public void setExercice(double exercice) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.exercice = exercice;
            return;
        }
        if (exercice < 0) {
            throw new Exception("Champ exercice invalide car <0");
        }
        this.exercice = exercice;
    }

    public int getMois_debut() {
        return mois_debut;
    }

    public void setMois_debut(int mois_debut) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.mois_debut = mois_debut;
            return;
        }
        if (mois_debut <= 0 || mois_debut > 12) {
            throw new Exception("Champ mois invalide");
        }
        this.mois_debut = mois_debut;
    }

    @Override
    public String getTuppleID() {
        return id + "";
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getChaineEtat() {
        String retour = "<span class=\"badge rounded-pill text-bg-warning\">OUVERT</span>";
        if (this.getEtat() == 9) {
            retour = "<span class=\"badge rounded-pill text-bg-primary\">CLOTUR&Eacute;(E)</span>";
        }
        return retour;
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        setMode("modif");
        this.setEtat(ConstanteEtat.getEtatCloture());
        this.updateToTableWithHisto(u, c);
        return this;
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        ClassMAPTable retour = super.createObject(u, c);
        for (int i = 1; i <= 12; i++) {
            ClotureMoisAnnee cma = new ClotureMoisAnnee();
            cma.setMois(i);
            cma.setAnnee(this.getId());
            cma.setEtat(1);
            cma.createObject(u, c);
        }
        return retour;
    }

    // public void init(String u, Connection c) throws Exception {
    //     if(c==null)throw new Exception("Connection non etablie");
    //     try {
    //         int annee = this.getId() + 1;
    //         String remarque = "Exercice " + annee;
    //         ComptaExercice cc = new ComptaExercice();
    //         cc.setId(annee);
    //         cc.setRemarque(remarque);
    //         cc.setMois_debut(1);
    //         cc.setExercice(12);
    //         cc.setEtat(1);
    //         cc.createObject(u, c);
    //     } catch (Exception e) {
    //         throw e;
    //     }
    // }

    public void reporterSoldeExercice(String u, Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            CallableStatement cst = null;
            String sqlstatement = "";
            sqlstatement = "{call REPORTSOLDE_RAN(?,?)}";
            cst = c.prepareCall(sqlstatement);
            cst.setString(1, String.valueOf(this.getId()));
            cst.setString(2, u);
            cst.executeUpdate();
        } catch (Exception e) {
            throw e;
        }
    }

    @Override
    public ComptaExercice cloturerObject(String u, Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            this.reporterSoldeExercice(u, c);
            ComptaExercice nouveau=new ComptaExercice(1, 1,"Exercice "+(this.getId()+1),(this.getId()+1),12);
            super.cloturerObject(u, c);
            nouveau.createObject(u, c);
            return this;
        } catch (Exception e) {
            throw e;
        }
    }

    

}
