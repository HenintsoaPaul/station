/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

import bean.CGenUtil;
import bean.ClassFille;
import java.sql.Connection;

/**
 *
 * @author 26134
 */
public class TransfertStockDetails extends ClassFille{
String id,idTransfertStock,idProduit;
double quantite;

    public TransfertStockDetails(){
        try {
            this.setLiaisonMere("idTransfertStock");
            this.setNomTable("TRANSFERTSTOCKDETAILS");
            this.setNomClasseMere("stock.TransfertStock");
        } catch (Exception e) {
            System.out.println("error stock.TransfertStockDetails.<init>()");
        }
    }

    public String getIdTransfertStock() {
        return idTransfertStock;
    }

    public void setIdTransfertStock(String idTransfertStock) {
        this.idTransfertStock = idTransfertStock;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }
    
    public MvtStockFille createMvtStockFille(boolean isEntree) throws Exception {
        MvtStockFille msf=new MvtStockFille();
        msf.setIdProduit(this.getIdProduit());
        msf.setIdTransfertDetail(this.getId());
        if (isEntree) {
            msf.setEntree(quantite);
        }else{
            msf.setSortie(quantite);
        }
        return msf;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TSD", "GETSEQTRANSFERTSTOCKDETAILS");
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

    protected void checkQuantiteProduit(Connection c) throws Exception{
        TransfertStock[] tsd=(TransfertStock[]) CGenUtil.rechercher(new TransfertStock(), null, null, c, " and id='"+this.getIdTransfertStock()+"' ");
        if (tsd.length!=1) {
            throw new Exception("transfertStock introuvable");
        }
        EtatStock[] et=(EtatStock[]) CGenUtil.rechercher(new EtatStock(), null, null, c, " and id='"+this.getIdProduit()+"' and idmagasin='"+tsd[0].getIdMagasinDepart()+"' ");
        if (et.length!=1) {
            throw new Exception("produit introuvable dans stock");
        }
        if ( et[0].getReste()< this.getQuantite()) {
            throw new Exception("produit insuffisant");
        }
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        this.checkQuantiteProduit(c);
    }

    
}
