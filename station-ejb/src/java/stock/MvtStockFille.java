/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

import bean.ClassFille;
import bean.CGenUtil;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import vente.As_BondeLivraisonClientFille;
import vente.As_BondeLivraisonClientFille_Cpl;


public class MvtStockFille extends ClassFille{
    private String id, idMvtStock, idProduit, idVenteDetail, idTransfertDetail;
    private double entree, sortie;
    
    @Override
    public boolean isSynchro(){
        return true;
    }
    
    public MvtStockFille() throws Exception{
        setNomTable("MvtStockFille");
        this.setLiaisonMere("idMvtStock");
        this.setNomClasseMere("stock.MvtStock");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMvtStock() {
        return idMvtStock;
    }

    public void setIdMvtStock(String idMvtStock) {
        this.idMvtStock = idMvtStock;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public String getIdVenteDetail() {
        return idVenteDetail;
    }

    public void setIdVenteDetail(String idVenteDetail) {
        this.idVenteDetail = idVenteDetail;
    }

    public String getIdTransfertDetail() {
        return idTransfertDetail;
    }

    public void setIdTransfertDetail(String idTransfertDetail) {
        this.idTransfertDetail = idTransfertDetail;
    }

    public double getEntree() {
        return entree;
    }

    public void setEntree(double entree) {
        this.entree = entree;
    }

    public double getSortie() {
        return sortie;
    }

    public void setSortie(double sortie) {
        this.sortie = sortie;
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("MVTSFI", "GETSEQMVTSTOCKFILLE");
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
    
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idMvtStock");
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        super.setNomClasseMere("stock.MvtStock");
        super.controlerUpdate(c);
    }

    @Override
    public void controler(Connection c) throws Exception{
        /**if( this.getSortie() > 0 && this.getEntree() == 0 ){
            EtatStock[] etats = (EtatStock[])CGenUtil.rechercher( new EtatStock(), null,null, c, " and id='" + this.getIdProduit() + "' and idMagasin='"+((MvtStock)this.getMere()).getIdMagasin()+"'");
            EtatStock etat = etats[0];
            if( etat.getReste() <= 0 || etat.getReste() < this.getSortie() ){
                throw new Exception("Veuillez rentrez le produit " + this.getIdProduit() + " : stock insuffisant");
            }
        }*/
        controllerQteLivraison(c);
    }
    public As_BondeLivraisonClientFille_Cpl getBondeLivraisonClientFille(Connection c) throws Exception{
        As_BondeLivraisonClientFille_Cpl blf= new As_BondeLivraisonClientFille_Cpl();
        blf.setIdventedetail(this.getIdVenteDetail());
        As_BondeLivraisonClientFille_Cpl[] As_BondeLivraisonClientFille= (As_BondeLivraisonClientFille_Cpl[]) CGenUtil.rechercher(blf,null,null,c," ");
        if(As_BondeLivraisonClientFille.length>0 || blf!=null){
            return As_BondeLivraisonClientFille[0];
        }
        return null;
    }
    public void controllerQteLivraison(Connection c) throws Exception{
        As_BondeLivraisonClientFille_Cpl blf=getBondeLivraisonClientFille(c);
        if(this.sortie>blf.getQteResteALivrer()){
            throw new Exception( blf.getIdproduitlib()+ " : quantité supérieure au reste à livrer");
            }
    }
    
    
}
