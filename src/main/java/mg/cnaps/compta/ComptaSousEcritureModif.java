package mg.cnaps.compta;

import java.sql.Connection;

import bean.ClassMAPTable;

public class ComptaSousEcritureModif extends ClassMAPTable{
    String id;
    String compte;
    String remarque;
    String analytique;
    String source;
    String libellePiece;
    String folio;
    double debit;
    double credit;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getLibellePiece() {
        return libellePiece;
    }

    public void setLibellePiece(String libellePiece) {
        this.libellePiece = libellePiece;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getAnalytique() {
        return analytique;
    }

    public void setAnalytique(String analytique) {
        this.analytique = analytique;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    public ComptaSousEcritureModif() throws Exception{
        this.setNomTable("compta_sous_ecriture");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public ComptaSousEcriture getComptaSousEcriture(Connection c)throws Exception{
        ComptaSousEcriture retour = new ComptaSousEcriture();
        try{
            retour = (ComptaSousEcriture)retour.getById(this.getId(),retour.getNomTable(),c);
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }
        return retour;
    }

    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        try{
            ComptaSousEcriture comptaSE = getComptaSousEcriture(c);
            if(comptaSE == null)throw new Exception("ComptaSousEcriture "+this.getId()+" non existant");

            comptaSE.setCompte(this.getCompte());
            comptaSE.setFolio(this.getFolio());
            comptaSE.setRemarque(this.getRemarque());
            comptaSE.setLibellePiece(this.getLibellePiece());
            comptaSE.setDebit(this.getDebit());
            comptaSE.setCredit(this.getCredit());
            comptaSE.setAnalytique(this.getAnalytique());
            comptaSE.setSource(this.getSource());
            comptaSE.controlerUpdate(c);
            return comptaSE.updateToTableWithHisto(refUser, c);
        }catch(Exception e){
            e.printStackTrace();
            throw e;
        }
    }
    
}
