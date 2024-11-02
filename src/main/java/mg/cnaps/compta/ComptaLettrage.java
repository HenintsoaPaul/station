
package mg.cnaps.compta;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassMere;
import mg.cnaps.configuration.Configuration;
import java.sql.Connection;
import java.sql.Date;

import affichage.PageRecherche;
import utilitaire.Utilitaire;

public class ComptaLettrage extends ClassMere {

    private String id,lettre;
    private Date date_lettrage;
    private String remarque;
    private double montant;

    public ComptaLettrage(String id, String lettre, Date date_lettrage, String remarque, double montant){
        super.setNomTable("compta_lettrage");
        this.setId(id);
        this.setLettre(lettre);
        this.setDate_lettrage(date_lettrage);
        this.setRemarque(remarque);
        this.setMontant(montant);
    }

    public ComptaLettrage(String lettre, Date date_lettrage, String remarque, double montant){
        super.setNomTable("compta_lettrage");
        this.setLettre(lettre);
        this.setDate_lettrage(date_lettrage);
        this.setRemarque(remarque);
        this.setMontant(montant);
    }

    public ComptaLettrage() {
        super.setNomTable("compta_lettrage");

    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("LET", "GETSEQCOMPTALETTRAGE");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
     
    public void delettrerSousEcritureLiees(String u,Connection c)throws Exception{
        ComptaSousEcriture sousEcriture=new ComptaSousEcriture();
        sousEcriture.setLettrage(id);
        ComptaSousEcriture[] listeSousEcriture= (ComptaSousEcriture[]) CGenUtil.rechercher(sousEcriture,null, null, c, "");
        for(int i=0 ; i<listeSousEcriture.length ; i++){
            listeSousEcriture[i].setLettrage(null);
            listeSousEcriture[i].updateToTableWithHisto(u,c);
        }
    }

    public void updateSousEcritureLiees(String u , Connection c)throws Exception{
        ComptaSousEcriture[] listeSousEcriture=(ComptaSousEcriture[])this.getFille();
        for(int i=0 ; i<listeSousEcriture.length ; i++){
            listeSousEcriture[i].setLettrage(id);
            listeSousEcriture[i].updateToTableWithHisto(u,c);
        }
    }
    @Override
    public int updateToTableWithHisto(String u, Connection c)throws Exception{
        updateSousEcritureLiees(u,c);
        return super.updateToTableWithHisto(u,c);
    }

    @Override
    public int deleteToTableWithHisto (String u,Connection c) throws Exception{
        delettrerSousEcritureLiees(u,c);
        return super.deleteToTableWithHisto(u,c);  
    }

    public void testLettre (Connection c) throws Exception{
        ComptaLettrage[] cl = null;
        cl = (ComptaLettrage[]) CGenUtil.rechercher(new ComptaLettrage(), null, null, c, " AND lettre = '" + this.getLettre() + "'");
        if(cl.length > 0){
            throw new Exception(" Lettre "+cl[0].getLettre()+ " deja utiliser veuillez choisir un autre");
        }
    }

    @Override
    public void controler (Connection c ) throws Exception{
        double[] debit =AdminGen.calculSommeDouble(this.getFille(), new String[] {"debit"});
        double[] credit = AdminGen.calculSommeDouble(this.getFille(),new String[] {"credit"});
        if(credit[0]<debit[0]){
            throw new Exception("Debit supérieur à crédit");
        }
        if(debit[0]<credit[0]){
            throw new Exception("Crédit supérieur à débit");
       }
       //this.testLettre(c);

    }

    @Override
    public int insertToTableWithHisto(String u, Connection c) throws Exception{
        setDate_lettrage(Utilitaire.dateDuJourSql());
        double[] credit = AdminGen.calculSommeDouble(this.getFille(),new String[] {"credit"});
        setMontant((credit.length == 0) ? 0 : credit[0]);
        setEtat(1);
        setRemarque("");
        construirePK(c);       
        Configuration[] lettrageParram = null;
        lettrageParram = (Configuration[]) CGenUtil.rechercher(new Configuration(), null, null, c, " AND TYPECONFIG = 'lettrage'");

        if (lettrageParram.length == 0) return 1;

        lettrageParram[0].setRemarque(lettre);
        lettrageParram[0].updateToTableWithHisto(u,c);
        return super.insertToTableWithHisto(u,c);        
    }

    @Override
    public ClassMAPTable createObject(String u , Connection c ) throws Exception{
        this.insertToTableWithHisto(u,c);
        this.controler(c);
        return this;
    }

    /**
     * @return the id
     */
    public String getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return the lettre
     */
    public String getLettre() {
        return lettre;
    }

    /**
     * @param lettre the lettre to set
     */
    public void setLettre(String lettre) {
        this.lettre = lettre;
    }



    /**
     * @return the date_lettrage
     */
    public Date getDate_lettrage() {
        return date_lettrage;
    }

    /**
     * @param date_lettrage the date_lettrage to set
     */
    public void setDate_lettrage(Date date_lettrage) {
        this.date_lettrage = date_lettrage;
    }

    /**
     * @return the remarque
     */
    public String getRemarque() {
        return remarque;
    }

    /**
     * @param remarque the remarque to set
     */
    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    /**
     * @return the montant
     */
    public double getMontant() {
        return montant;
    }

    /**
     * @param montant the montant to set
     */
    public void setMontant(double montant) {
        this.montant = montant;
    }
}

