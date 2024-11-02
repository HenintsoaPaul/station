/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.ClassMere;

import java.sql.Connection;
import java.sql.Date;
import utilitaire.Utilitaire;

/**
 *
 * @author Jetta
 */
public class ComptaEcriture extends ClassMere {

    private String id;
    private Date daty, dateComptable;
    private String exercice, designation, remarque, periode, idobjet;

    //private double etat;
    private double horsExercice;
    private String journal, od, origine;
    private double debit, credit;
    private int annee, trimestre;

    public void setIdobjet(String idobjet) {
        this.idobjet = idobjet;
    }

    public String getIdobjet() {
        return idobjet;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        if(getMode().compareTo("modif")==0 && this.annee!=0){
            this.annee = annee;
        }
    }

    public int getTrimestre() {
        return trimestre;
    }

    public void setTrimestre(int trimestre) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.trimestre = trimestre;
            return;
        }
        if (trimestre <= 0 || trimestre > 4) {
            throw new Exception("Trimestre invalide");
        }
        this.trimestre = trimestre;
    }

    public double getDebit() {
        return debit;
    }

    public String getPeriode() {
        return periode;
    }

    public void setPeriode(String periode) {
        if(getMode().compareTo("modif")==0 && periode != null && periode.contains("/")){
            String[] g = Utilitaire.split(periode, "/");
            this.periode = g[1]+Utilitaire.completerInt(2, g[0]);
            return;
        }
        this.periode = periode;
    }

    public void setDebit(double debit) throws Exception {
        // if(getMode().compareTo("modif")==0){
        //     if(debit <= 0)
        //         throw new Exception("Montant negatif ou 0 inacceptable");
        // }
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) throws Exception {
        // if(getMode().compareTo("modif")==0){
        //     if(credit <= 0)
        //         throw new Exception("Montant negatif ou 0 inacceptable");
        // }
        this.credit = credit;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ECR", "GETSEQCOMPTAECRITURE");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public ComptaEcriture(String id, Date daty, Date dateComptable, String exercice, String designation, String remarque, int etat, double horsExercice, String journal, String od, String origine, double debit, double credit) throws Exception {
        super.setNomTable("compta_ecriture");
        this.setNomClasseFille("mg.cnaps.compta.ComptaSousEcriture");
        this.setId(id);
        this.setDaty(daty);
        this.setDateComptable(dateComptable);
        this.setExercice(exercice);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        this.setEtat(etat);
        this.setHorsExercice(horsExercice);
        this.setJournal(journal);
        this.setOd(od);
        this.setOrigine(origine);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setIdobjet(origine);
    }

    public ComptaEcriture(String id, double debit, double credit) throws Exception {
        super.setNomTable("compta_ecriture");
        this.setNomClasseFille("mg.cnaps.compta.ComptaSousEcriture");
        this.setId(id);
        this.setDebit(debit);
        this.setCredit(credit);
    }
    //        ComptaEcriture ce = new ComptaEcriture(,
    //             exercice, libelleOd, "", 1, 0, journal.getId(), "", origineOd1, 0, 0);

    public ComptaEcriture(Date daty, Date dateComptable, String exercice, String designation, String remarque, int etat, double horsExercice, String journal, String od, String origine, double debit, double credit) throws Exception {
        super.setNomTable("compta_ecriture");
        this.setNomClasseFille("mg.cnaps.compta.ComptaSousEcriture");
        this.setDaty(daty);
        this.setDateComptable(dateComptable);
        this.setExercice(exercice);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        this.setEtat(etat);
        this.setHorsExercice(horsExercice);
        this.setJournal(journal);
        this.setOd(od);
        this.setOrigine(origine);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setIdobjet(origine);
    }

    public ComptaEcriture(String id, Date daty, Date dateComptable, String exercice, String designation, String remarque, int etat, double horsExercice, String journal, String od, String origine, double debit, double credit, String idobjet) throws Exception {
        super.setNomTable("compta_ecriture");
        this.setNomClasseFille("mg.cnaps.compta.ComptaSousEcriture");
        this.setId(id);
        this.setDaty(daty);
        this.setDateComptable(dateComptable);
        this.setExercice(exercice);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        this.setEtat(etat);
        this.setHorsExercice(horsExercice);
        this.setJournal(journal);
        this.setOd(od);
        this.setOrigine(origine);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setIdobjet(idobjet);
    }

    public ComptaEcriture(Date daty, Date dateComptable, String exercice, String designation, String remarque, String periode, String idobjet, double horsExercice, String journal, String od, String origine, double debit, double credit, int annee, int trimestre) throws Exception {
        this.setDaty(daty);
        this.setDateComptable(dateComptable);
        this.setExercice(exercice);
        this.setDesignation(designation);
        this.setRemarque(remarque);
        this.setPeriode(periode);
        this.setIdobjet(idobjet);
        this.setHorsExercice(horsExercice);
        this.setJournal(journal);
        this.setOd(od);
        this.setOrigine(origine);
        this.setDebit(debit);
        this.setCredit(credit);
        this.setAnnee(annee);
        this.setTrimestre(trimestre);
        super.setNomTable("COMPTA_ECRITURE");
        this.setNomClasseFille("mg.cnaps.compta.ComptaSousEcriture");
    }

    public ComptaEcriture()throws Exception {
        super.setNomTable("compta_ecriture");
        this.setNomClasseFille("mg.cnaps.compta.ComptaSousEcriture");
    }
    

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) throws Exception {
        if (daty == null) {
            throw new Exception("Jour Obligatoire");
        }
        this.daty = daty;
    }

    public Date getDateComptable() {
        return dateComptable;
    }

    public void setDateComptable(Date dateComptable) throws Exception {
        if (dateComptable == null) {
            throw new Exception("Date comptable Obligatoire");
        }
        this.dateComptable = dateComptable;
    }

    public String getExercice() {
        return Utilitaire.champNull(exercice);
    }

    public void setExercice(String exercice) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            if(this.getDaty() != null && Utilitaire.getAnnee(this.getDaty()) != Utilitaire.stringToInt(exercice))
                throw new Exception("Date non valide");
            this.exercice = exercice;
            setAnnee(Integer.valueOf(this.exercice));
            return;
        }
        if (exercice == "") {
            throw new Exception("Champ exercice manquant");
        }
        this.exercice = exercice;
    }

    public String getDesignation() {
        return Utilitaire.champNull(designation);
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getRemarque() {
        return Utilitaire.champNull(remarque);
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    /*public double getEtat() {
     return etat;
     }

     public void setEtat(double etat) throws Exception {
     if(getMode().compareTo("modif")!=0)
     {
     this.etat = etat;
     return;
     }
     if(etat>99) throw new Exception("Etat invalide");
     this.etat = etat;
     }*/
    public double getHorsExercice() {
        return horsExercice;
    }

    public void setHorsExercice(double horsExercice) {
        this.horsExercice = horsExercice;
    }

    public String getJournal() {
        return Utilitaire.champNull(journal);
    }

    public void setJournal(String journal) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.journal = journal;
            return;
        }
        if (journal == "") {
            throw new Exception("Champ Journal manquant");
        }
        this.journal = journal;
    }

    public String getOd() {
        return Utilitaire.champNull(od);
    }

    public void setOd(String od) throws Exception {
        /*if(getMode().compareTo("modif")!=0)
         {
         this.od = od;
         return;
         }
         if(od=="") throw new Exception("Champ OD manquant");*/
        this.od = od;
    }

    public String getOrigine() {
        return Utilitaire.champNull(origine);
    }

    public void setOrigine(String origine) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.origine = origine;
            return;
        }
        this.origine = origine.substring(0, 3);
        // this.origine = origine;
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        try{
            //ComptaEcritureService.testEtatMoisExercice(Utilitaire.stringToInt(Utilitaire.getAnnee(Utilitaire.formatterDaty(daty))), Utilitaire.getMois(daty), " D INSERER", c);
            ComptaExercice[] exercices = (ComptaExercice[]) CGenUtil.rechercher(new ComptaExercice(), null, null, c, " and id = " + this.getExercice());
            if(exercices.length > 0){
                if(exercices[0].getEtat() == 9)
                    throw new Exception("Exercice deja cloturé");
            }else{
                throw new Exception("L'exercice saisi n'est pas encore ouvert");
            }
        }
        catch(Exception e){
            throw e;
        }
    }
    
    // @Override
    // public int insertToTableWithHisto(String refUser, java.sql.Connection c) throws Exception {
    //     try{
    //         this.controler(c);
    //     }
    //     catch(Exception e){
    //         throw e;
    //     }
        
    //     return super.insertToTableWithHisto(refUser, c);
    // }

    @Override
    public void controlerAnnulationVisa(Connection c) throws Exception{
        this.controler(c);
    }
}
