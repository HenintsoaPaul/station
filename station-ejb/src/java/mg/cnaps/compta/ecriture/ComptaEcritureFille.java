package mg.cnaps.compta.ecriture;

import java.sql.Connection;

import bean.ClassFille;
import bean.ClassMAPTable;
import mg.cnaps.compta.ComptaSousEcriture;
import utilitaire.Constante;
import utilitaire.Utilitaire;

public class ComptaEcritureFille extends ClassFille{
    private String id;
    private String compte;
    private double debit;
    private double credit;
    private String journal;
    private int jour;
    private String mois;
    private int exercice;
    private String folio;
    private String source;
    private String libelle;
    private String analytique;
    private String idmere;

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getAnalytique() {
        return this.analytique;
    }

    public void setAnalytique(String analytique) {
        if (this.getMode().equals("modif") && analytique.trim().equals("") ) {
            this.analytique = null;
        } else {
            this.analytique = analytique;    
        }
    }
    
    public String getLibelle() {
        return this.libelle;
    }

    public void setLibelle(String libelle)  throws Exception {
        this.libelle = libelle;
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompte() {

        return this.compte;
    }

    public void setCompte(String compte) throws Exception{
      
        if(this.getMode().compareToIgnoreCase("modif") == 0){
            if(compte == null || compte.compareToIgnoreCase("") == 0) throw new Exception("Veuillez verifier certaines ecritures sont sans compte");
        }
        
        this.compte = compte;
    }

    public double getDebit() {
        return this.debit;
    }

    public void setDebit(double debit) {

        this.debit = debit;
    }

    public double getCredit() {
        return this.credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getJournal() {
        return this.journal;
    }

    public void setJournal(String journal)throws Exception {
        // if(this.getMode().compareToIgnoreCase("modif") == 0){
        //     if(journal == null || journal.compareToIgnoreCase("") == 0) throw new Exception("Journal vide");
        //     if(journal.compareToIgnoreCase("COMP000015") == 0 || journal.compareToIgnoreCase("10") == 0) throw new Exception("Veuillez v\u00E9rifier votre saisie , vous venez d\u2019enregistrer des ecritures dans le journal de report");
        // }
        this.journal = journal;
    }

    public int getJour() {
        return this.jour;
    }

    public void setJour(int jour) throws Exception {
        if(this.getMode().compareToIgnoreCase("modif") == 0){
            if(jour == 0){
                throw new Exception("Jour vide");
            }
        }
        this.jour = jour;
    }

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

    public String getFolio() {
        return this.folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getSource() {
        return this.source;
    }

    public void setSource(String source) {
        this.source = source;
    }


    public ComptaEcritureFille() {
        super.setNomTable("COMPTA_ECRITURE_FILLE");
    }

    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void controler(Connection c) throws Exception{
        if(getMere() == null) throw new Exception("Compta ecriture mere obligatoire");
        String daty =  Utilitaire.completerInt(2, jour) + "/" + mois + "/" + exercice;
        if(!Utilitaire.isValidDate(daty, "dd/MM/yyyy")) throw new Exception("Date "+daty+ " non valide");
        super.controler(c);
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.controler(c);
        ComptaSousEcriture comptaSousEcriture = new ComptaSousEcriture(Utilitaire.completerIntFin(Constante.COMPTA_COMPTE_GEN_MAX_CHAR,this.compte),this.debit,this.credit,this.libelle,null,null,null, null, this.journal,String.valueOf(this.exercice),this.folio,Utilitaire.stringDate(Utilitaire.completerInt(2, jour) + "/" + mois + "/" + exercice),this.analytique,this.source);
        return comptaSousEcriture.createObject(u, c);
    }
}
