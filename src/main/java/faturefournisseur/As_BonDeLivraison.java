/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;

import bean.CGenUtil;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;
import stock.MvtStock;
import stock.MvtStockFille;
import utilitaire.Utilitaire;
import utils.ConstanteEtatStation;
import utils.ConstanteStation;
import vente.As_BondeLivraisonClient;
import utilitaire.UtilDB;   

/**
 *
 * @author Mirado
 */
public class As_BonDeLivraison extends ClassMere{
    
    String id,remarque,idbc;
    Date daty;
    int etat;
    String magasin;
    String idFournisseur;
    String idFactureFournisseur;

    public As_BonDeLivraison() throws Exception {
        this.setNomTable("AS_BONDELIVRAISON");
        this.setLiaisonFille("numbl");
	    // this.setNomClasseFille("faturefournisseur.As_BonDeLivraison_Fille");
       setNomClasseFille("faturefournisseur.As_BonDeLivraison_Fille");
    }
    
    public void construirePK(Connection c) throws Exception{
        this.preparePk("BL", "GETSEQBONDELIVRAISON");
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

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIdbc() {
        return idbc;
    }

    public void setIdbc(String idbc) {
        this.idbc = idbc;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public String getMagasin() {
        return magasin;
    }

    public void setMagasin(String magasin) {
        this.magasin = magasin;
    }

    public As_BonDeLivraison_Fille[] getBonDeLivraisonFille(Connection c) throws Exception {
        As_BonDeLivraison_Fille abfCrt=new As_BonDeLivraison_Fille();
        abfCrt.setNumbl(this.getId());
        As_BonDeLivraison_Fille[] abf=(As_BonDeLivraison_Fille[]) CGenUtil.rechercher(abfCrt , null, null, c, " ");
        return abf;
    }
    public MvtStock createMvtStock() throws Exception{
        MvtStock ms=new MvtStock();
        ms.setDesignation("livraison "+this.getRemarque());
        ms.setIdTypeMvStock(ConstanteStation.TYPEMVTSTOCKENTREE);
        ms.setIdMagasin(this.getMagasin());
        ms.setDaty(Utilitaire.dateDuJourSql());
        ms.setIdTransfert(this.getId());
        return ms;
    }

    public MvtStockFille[] createMvtStockFille(Connection c,String idMere)throws Exception{
        boolean estOuvert = false;
        try {
            if(c==null){
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            As_BonDeLivraison_Fille[] fille = getBonDeLivraisonFille(c);
            MvtStockFille[] mvtStockFilles = new MvtStockFille[fille.length];
            int index=0;
            for (As_BonDeLivraison_Fille bLivraison_Fille : fille) {
                MvtStockFille f = new MvtStockFille();
                f.setIdProduit(bLivraison_Fille.getProduit());
                f.setEntree(bLivraison_Fille.getQuantite());
                f.setSortie(0);
                f.setIdTransfertDetail(bLivraison_Fille.getId());
                f.setIdMvtStock(idMere);
                mvtStockFilles[index]= f;
                index++;
            }
            return mvtStockFilles;
        } catch (Exception e) {
            throw e;
        }finally{
            if(estOuvert) c.close();
        }
    }

    public String getIdFournisseur() {
        return idFournisseur;
    }

    public void setIdFournisseur(String idFournisseur) throws Exception {
        if( this.getMode().equals("modif") && idFournisseur.isEmpty() ){
            throw new Exception("Le Fournisseur ne doit pas etre null");
        }
        this.idFournisseur = idFournisseur;
    }
    
    public MvtStock genereMvtStock( Connection c ) throws Exception{
        boolean connectionWasOpenedInside = false;
        try{
            if( c == null ){
                c = new UtilDB().GetConn();
                connectionWasOpenedInside = true;
            }

            As_BonDeLivraison_Fille[] filles = (As_BonDeLivraison_Fille[]) this.getFille(null, c, "");
            MvtStock mouvement = new MvtStock();
            mouvement.setDaty(this.getDaty());
            mouvement.setDesignation("Mouvement de Stock pour " + this.getId());
            mouvement.setIdMagasin(this.getMagasin());
            mouvement.setIdTypeMvStock("TPMVST000022");
            mouvement.setIdTransfert(this.getId());
            
            // Maintenant micreer mouvement fille hoan 'ireo'

            MvtStockFille[] mouvements = new MvtStockFille[filles.length];
            for( int i = 0; i < filles.length ; i++ ){
                mouvements[i] = filles[i].genererMvtStockFille(c);
                mouvements[i].setIdMvtStock(mouvement.getId());
            }
            mouvement.setFille(mouvements);
            return mouvement;

        }catch(Exception e){
            throw e;
        }finally{
            if( connectionWasOpenedInside ){
                c.close();
            }
        }
    }

    public void genererMvtStockPersist( String refUser ) throws Exception{
        Connection connection = null;
        boolean isOpened = false;
        try{
            if( connection == null ){
                connection = new UtilDB().GetConn();
                isOpened = true;
            }
            As_BonDeLivraison blc=(As_BonDeLivraison) this.getById(this.getId(),null,connection);
            blc.setNomClasseFille("faturefournisseur.As_BonDeLivraison_Fille");
	        MvtStock mvt = blc.genereMvtStock(connection);

        }catch(Exception e){
            throw e;
        } finally {
            if (isOpened)
                connection.close();
        }
    }

    public static As_BonDeLivraison[] getAll(String[] ids, Connection co) throws Exception {
        As_BonDeLivraison bl = new As_BonDeLivraison();
        As_BonDeLivraison[] bls = (As_BonDeLivraison[]) CGenUtil.rechercher(bl, null, null, co,
                " and id in (" + Utilitaire.tabToString(ids, "'", ",")+ ")");
        return bls;
    }

    public static void controlerFournisseur(As_BonDeLivraison[] bls) throws Exception {
        String idFournisseur = "";
        for (As_BonDeLivraison item : bls) {
            if (idFournisseur.equals("") == false) {
                if (idFournisseur.equals(item.getIdFournisseur()) == false) {
                    throw new Exception("Tiers different");
                }
            }
            idFournisseur = item.getIdFournisseur();
        }
    }
    
}
