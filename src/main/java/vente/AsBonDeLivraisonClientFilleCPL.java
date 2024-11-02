package vente;

public class AsBonDeLivraisonClientFilleCPL extends As_BondeLivraisonClientFille {
    String idproduitlib , idvente ,idbc; 

    public AsBonDeLivraisonClientFilleCPL () throws Exception{
        this.setNomTable("AsBonDeLivraisonClientFilleCPL");
    }
    public String getIdproduitlib() {
        return idproduitlib;
    }

    public void setIdproduitlib(String idproduitlib) {
        this.idproduitlib = idproduitlib;
    }

    public String getIdvente() {
        return idvente;
    }

    public void setIdvente(String idvente) {
        this.idvente = idvente;
    }

    public String getIdbc() {
        return idbc;
    }

    public void setIdbc(String idbc) {
        this.idbc = idbc;
    }
}
