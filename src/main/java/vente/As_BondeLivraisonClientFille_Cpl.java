package vente;

public class As_BondeLivraisonClientFille_Cpl extends As_BondeLivraisonClientFille{
    String produitlib,unitelib,idproduitlib,idbc;
    protected double qtelivree,qteResteALivrer;

    public String getIdbc() {
        return idbc;
    }

    public void setIdbc(String idbc) {
        this.idbc = idbc;
    }

    public String getIdproduitlib() {
        return idproduitlib;
    }

    public void setIdproduitlib(String idproduitlib) {
        this.idproduitlib = idproduitlib;
    }

    public As_BondeLivraisonClientFille_Cpl()  throws Exception{
        this.setNomTable("AS_BONLIVRFILLE_CLIENT_CPL");
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

    public double getQtelivree() {
        return qtelivree;
    }

   
    public void setQtelivree(double qtelivree) {
        this.qtelivree = qtelivree;
    }

    public double getQteResteALivrer() {
        return qteResteALivrer;
    }

    public void setQteResteALivrer(double qteResteALivrer) {
        this.qteResteALivrer = qteResteALivrer;
    }    
    
}
