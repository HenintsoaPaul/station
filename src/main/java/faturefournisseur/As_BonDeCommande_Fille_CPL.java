package faturefournisseur;

public class As_BonDeCommande_Fille_CPL extends As_BonDeCommande_Fille {
    protected String produitlib ;
    protected String unitelib;
    protected String modepaiementlib;
    protected String fournisseurlib;
    
    public As_BonDeCommande_Fille_CPL() throws Exception {
        super.setNomTable("AS_BONDECOMMANDE_CPL");
    }
    public String getProduitlib() {
        return produitlib;
    }
    public void setProduitlib(String produitlib) {
        this.produitlib = produitlib;
    }
    public String getUnitelib() {
        return unitelib;
    }
    public void setUnitelib(String unitelib) {
        this.unitelib = unitelib;
    }
    public String getModepaiementlib() {
        return modepaiementlib;
    }
    public void setModepaiementlib(String modepaiementlib) {
        this.modepaiementlib = modepaiementlib;
    }
    public String getFournisseurlib() {
        return fournisseurlib;
    }
    public void setFournisseurlib(String fournisseurlib) {
        this.fournisseurlib = fournisseurlib;
    }
}
