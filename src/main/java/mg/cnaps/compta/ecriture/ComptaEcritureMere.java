package mg.cnaps.compta.ecriture;

import java.sql.Connection;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import bean.ClassMere;
import mg.cnaps.compta.ClotureMoisAnnee;
import utilitaire.Utilitaire;

public class ComptaEcritureMere extends ClassMere {
    private String mois;
    private int exercice;
    private String journal;
    private String id;


    public String getMois() {
        return this.mois;
    }

    public void setMois(String mois) {
        this.mois = mois;
    }
    

    public int getExercice() {
        return this.exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public String getJournal() {
        return this.journal;
    }

    public void setJournal(String journal) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif") == 0){
            if(journal == null || journal.compareToIgnoreCase("") == 0) throw new Exception("journal vide");
            if(journal.compareToIgnoreCase("COMP000015") == 0 || journal.compareToIgnoreCase("10") == 0) throw new Exception("Veuillez v\u00E9rifier votre saisie , vous venez d\u2019enregistrer des ecritures dans le journal de report");
        }
        this.journal = journal;
    }


    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public ComptaEcritureMere() {
        super.setNomTable("COMPTA_ECRITURE_MERE");
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }


    public void testEtatMoisExercice(Connection c) throws Exception {
        try {
            ClotureMoisAnnee[] cl = (ClotureMoisAnnee[]) CGenUtil.rechercher(new ClotureMoisAnnee(), null, null, c, " AND MOIS = " + mois + " AND ANNEE=" + exercice);
            String m = Utilitaire.nbToMois(Utilitaire.stringToInt(this.mois));
            if (cl.length > 0) {
                if (cl[0].getEtat() == 9) {
                    throw new Exception("ACTION IMPOSSIBLE POUR . MOIS " + m.toUpperCase() + " " +  this.exercice+ " CLOTURE");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    @Override
    public void controler(Connection c) throws Exception{
        try{
            super.controler(c);
            this.testEtatMoisExercice(c);
            double montantDebit = 0;
            double montantCredit = 0;
            ClassFille[] filles =  getFille();
            for(int i=0;i<filles.length;i++){
                ComptaEcritureFille fille = (ComptaEcritureFille) filles[i];
                montantCredit += fille.getCredit();
                montantDebit += fille.getDebit();
            }
            if(montantCredit != montantDebit){
                throw new Exception("Les montants de credit et de debit ne sont pas equilibrés");
            }
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }
    }
    
    @Override
    public ClassMAPTable createObject(String u,Connection c)throws Exception {
        try{ 
            this.controler(c);
            ClassFille[] filles = getFille();
            for(int i=0;i<filles.length;i++){
                ComptaEcritureFille fille = (ComptaEcritureFille) filles[i];
                fille.setJournal(this.journal);
                fille.setExercice(this.exercice);
                fille.setMois(this.mois);
                fille.setMere(this);
            }
            return null;
        }
        catch(Exception e){
            e.printStackTrace();
            throw e;
        }
    }


}
