package faturefournisseur;

public class FactureFournisseurDetailResteALivrerLib extends FactureFournisseurDetailsCpl{
    protected String idUnite;
        
    public As_BonDeLivraison_Fille createBLFille(String idMere)throws Exception{
        As_BonDeLivraison_Fille resultat = new As_BonDeLivraison_Fille();
        resultat.setIdbc_fille(this.getId());
        resultat.setIddetailsfacturefournisseur(this.getId());
        resultat.setNumbl(idMere);
        resultat.setProduit(this.getIdProduit());
        resultat.setQuantite(this.getQte());
        resultat.setUnite(this.getIdUnite());
        return resultat;
    }

    public String getProduit(){
        return this.getIdProduit();
    }
    public String getProduitlib(){
        return this.getIdProduitLib();
    }
    public String getUnite(){
        return this.getIdUnite();
    }
    public double getQte_reste(){
        return this.getQte();
    }
    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public FactureFournisseurDetailResteALivrerLib() throws Exception{
        super.setNomTable("FFFILLERESTEALIVRERLIB");
    }
}
