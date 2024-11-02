package vente;

import bean.ClassFille;

import java.sql.Connection;
import stock.MvtStockFille;

public class As_BondeLivraisonClientFille extends ClassFille{
    String id , produit,numbl,idventedetail,unite,idbc_fille;
    double quantite;

    public As_BondeLivraisonClientFille() throws Exception{
        this.setNomTable("AS_BONDELIVRAISON_CLIENT_FILLE");
        this.setNomClasseMere("vente.As_BondeLivraisonClient");
	setLiaisonMere("numbl");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BLCF", "getSEQBLCLIENTFILLE");
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

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getProduit() {
        return produit;
    }
    public void setProduit(String produit) {
        this.produit = produit;
    }
    public String getNumbl() {
        return numbl;
    }
    public void setNumbl(String numbl) {
        this.numbl = numbl;
    }
    public String getIdventedetail() {
        return idventedetail;
    }
    public void setIdventedetail(String idventedetail) {
        this.idventedetail = idventedetail;
    }
    public String getUnite() {
        return unite;
    }
    public void setUnite(String unite) {
        this.unite = unite;
    }
    public String getIdbc_fille() {
        return idbc_fille;
    }
    public void setIdbc_fille(String idbc_fille) {
        this.idbc_fille = idbc_fille;
    }
    public double getQuantite() {
        return quantite;
    }
    public void setQuantite(double quantite)throws Exception {
        if (this.getMode().equals("modif") && quantite <= 0 ) {
            throw new Exception("Quantite ne peut pas etre inferieur à 0");
        }
        this.quantite = quantite;
    }
    public MvtStockFille genererMvtStockFille(Connection c)throws Exception
    {
        As_BondeLivraisonClient m=(As_BondeLivraisonClient)this.findMere(null,c);
        MvtStockFille mf=new MvtStockFille();
        mf.setIdMvtStock(m.getId());
        mf.setIdProduit(this.getProduit());
        mf.setSortie(this.getQuantite());
        mf.setIdVenteDetail(this.getIdventedetail());
        return mf;
    }
    
    public VenteDetails toVenteDetails() throws Exception{
        VenteDetails v = new VenteDetails();
        v.setIdProduit(this.getProduit());
        v.setQte(this.getQuantite());
        v.setIdDevise("AR");
        return v;
    }
    
}
