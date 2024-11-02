package mg.cnaps.compta;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.stream.Stream;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class ComptaConsultationFolio extends ClassMAPTable{

    private String id , journal , mois , exercice, compte , folio , typeCompte;
 

    private ComptaSousEcriture[] ecritures ;
    private Double sommeCredit ;
    private Double sommeDebit ;
    private Double cumulDebit ;
    private Double cumulCredit ;

   public ComptaConsultationFolio( String journal, String mois, String exercice, String compte, String folio, String typeCompte) throws Exception {
        this.setJournal(journal);
        this.setMois(mois);;
        this.setExercice(exercice);;
        this.setCompte(typeCompte);;
        this.setFolio(folio);;
        this.setTypeCompte(typeCompte);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) throws Exception {
        if(this.getMode().equals("select")){
            if(journal == null || journal.equals("") ){
                throw new Exception("Journal ne peut pas être vide");
            }
            
        }
        this.journal = journal;
    }

    public String getMois() {
        return mois;
    }

    public void setMois(String mois) throws Exception {
        if(this.getMode().equals("select")){
            if(mois==null  || mois.equals("") ){
                throw new Exception("Journal ne peut pas être vide");
            }
        }
        this.mois = mois;
    }

    public String getExercice() {
        return exercice;
    }

    public void setExercice(String exercice) {
        this.exercice = exercice;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getFolio() {
       
        return folio;
    }

    public void setFolio(String folio) throws Exception {
        if(this.getMode() == "select"){
            if(folio == null || folio.equals("")){
                throw new Exception("Folio ne peut pas être vide");
            }
            
        }
        this.folio = folio;
    }

    public String getTypeCompte() {
        return typeCompte;
    }

    public void setTypeCompte(String typeCompte) {
        this.typeCompte = typeCompte;
    }

   

    public void setEcritures(ComptaSousEcriture[] ecritures) {
        this.ecritures = ecritures;
    }

    public Double getSommeCredit() {
        if(sommeCredit == null){
            sommeCredit = new Double(AdminGen.calculSommeDouble(ecritures,"credit"));
        }
        return sommeCredit.doubleValue();
    }

    public void setSommeCredit(Double sommeCredit) {
        this.sommeCredit = sommeCredit;
    }

    public Double getSommeDebit() {
        if(sommeDebit==null){
            sommeDebit = new Double(AdminGen.calculSommeDouble(ecritures,"debit"));
        }
        return sommeDebit.doubleValue();
    }

    public void setSommeDebit(Double sommeDebit) {
        this.sommeDebit = sommeDebit;
    }

    public Double getCumulDebit() {
        return Math.max(getSommeDebit()-getSommeCredit(),0);
    }

    public void setCumulDebit(Double cumulDebit) {
        this.cumulDebit = cumulDebit;
    }

    public Double getCumulCredit() {
       return  Math.max(getSommeCredit()-getSommeDebit(),0);
    }

    public void setCumulCredit(Double cumulCredit) {
        this.cumulCredit = cumulCredit;
    }

    public  ComptaConsultationFolio(){
        typeCompte = ConstanteCompta.type_compte_general ;
        this.setMode("select");
    }
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    public String getDateDebut(){
        return "01/"+mois+"/"+exercice;
    }
    public String getDateFin(){

        String dateFin=Utilitaire.getLastDayOfDate(getDateDebut());
        String[] mots = dateFin.split("-");
        String dateModif= mots[2]+"/"+mots[1]+"/"+mots[0];
        return dateModif ;

    }
    public String getTableSousEcriture(){
        if(typeCompte.equals(ConstanteCompta.type_compte_general)){
            return "COMPTA_SOUS_ECRITURE_gen";
        }else{
            return "COMPTA_SOUS_ECRITURE_anal";
        }
    }

      public ComptaSousEcriture[] getReportSolde(Connection c) throws Exception{
        ComptaSousEcriture comptaSousEcriture= new ComptaSousEcriture();
        comptaSousEcriture.setMode("select");
        comptaSousEcriture.setJournal((this.getJournal()));
        comptaSousEcriture.setFolio(this.getFolio());
        comptaSousEcriture.setCompte(this.getCompte());
        comptaSousEcriture.setExercice(Integer.parseInt(this.getExercice())); 
        ComptaSousEcriture[] ecritures = (ComptaSousEcriture[])CGenUtil.rechercher(comptaSousEcriture,null,null,c,"");
        return ecritures;
     }

    public ComptaSousEcriture[]  getEcritures(Connection c) throws Exception{
          try {
        ComptaSousEcriture comptaSousEcriture = new ComptaSousEcriture();
        comptaSousEcriture.setMode("select");
        comptaSousEcriture.setNomTable(getTableSousEcriture());
        comptaSousEcriture.setJournal(this.getJournal());
        comptaSousEcriture.setFolio(this.getFolio());
        comptaSousEcriture.setCompte(this.getCompte());
        String[] criteres = {"daty"};
        String[] values= {getDateDebut() , getDateFin()};
       this.ecritures = (ComptaSousEcriture[])CGenUtil.rechercher(comptaSousEcriture,criteres,values,c,"");
       
        if( this.mois == "1"){
           ComptaSousEcriture[] ecritureTempo = this.getReportSolde(c);
            Stream<ComptaSousEcriture> fluxFusionne = Stream.concat(Arrays.stream(ecritures), Arrays.stream(ecritureTempo));
            this.ecritures = fluxFusionne.toArray(ComptaSousEcriture[]::new);
        }
        return this.ecritures;  
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }     
    }

     public ComptaSousEcriture[] getEcritures() throws Exception {
            Connection c = null;
        try {
            c = new UtilDB().GetConn();
            ComptaSousEcriture[] ecritures= this.getEcritures(c);
            return ecritures ; 

        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                c.close();
            }
        }
    }
  
}
