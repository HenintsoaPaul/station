/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;

import bean.ClassFille;

import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;

import stock.MvtStockFille;
import vente.As_BondeLivraisonClient;
import vente.VenteDetails;

/**
 *
 * @author Mirado
 */
public class As_BonDeLivraison_Fille extends ClassFille{
    
    String id,produit,numbl;
    double quantite;
    String iddetailsfacturefournisseur;
    String unite, idbc_fille;
    String idFactureFournisseur;

    public As_BonDeLivraison_Fille() {
        try{
            this.setNomClasseMere("faturefournisseur.As_BonDeLivraison");
            this.setNomTable("AS_BONDELIVRAISON_FILLE");
            this.setLiaisonMere("numbl");
        }catch(Exception e){
            Logger.getLogger(VenteDetails.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("BLF", "getSeqBondeLivraisonFille");
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

    public void setIdFactureFournisseur(String idFactureFournisseur) {
        this.idFactureFournisseur = idFactureFournisseur;
    }

    public String getIdFactureFournisseur() {
        return idFactureFournisseur;
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

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) throws Exception {
        if (this.getMode().equals("modif") && quantite < 0 ) {
            throw new Exception("Quantite ne peut pas etre inferieur à 0");
        }
        this.quantite = quantite;
    }

    public String getIddetailsfacturefournisseur() {
        return iddetailsfacturefournisseur;
    }

    public void setIddetailsfacturefournisseur(String iddetailsfacturefournisseur) {
        this.iddetailsfacturefournisseur = iddetailsfacturefournisseur;
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

    public MvtStockFille createMvtStockFille() throws Exception{
        MvtStockFille msf=new MvtStockFille();
        msf.setIdProduit(this.produit);
        msf.setEntree(this.quantite);
        return msf;
    }

    public MvtStockFille genererMvtStockFille(Connection c)throws Exception
    {
        As_BonDeLivraison m=(As_BonDeLivraison) this.findMere(null,c);
        MvtStockFille mf=new MvtStockFille();
        mf.setIdMvtStock(m.getId());
        mf.setIdProduit(this.getProduit());
        mf.setEntree(this.getQuantite());
        return mf;
    }

    public FactureFournisseurDetails toFactureFournisseurDetails() throws Exception{
        FactureFournisseurDetails v = new FactureFournisseurDetails();
        v.setIdProduit(this.getProduit());
        v.setQte(this.getQuantite());
        v.setIdDevise("AR");
        return v;
    }

}
