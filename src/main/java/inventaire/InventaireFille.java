/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inventaire;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import caisse.EtatCaisse;
import java.sql.Connection;
import java.sql.Date;
import magasin.Magasin;
import stock.EtatStock;
import utilitaire.Utilitaire;
import utils.ConstanteStation;

public class InventaireFille extends ClassFille {

    private String id, idInventaire, idProduit, explication,idJauge;
    private double quantiteTheorique, quantite;

    public InventaireFille() throws Exception {
        this.setNomTable("InventaireFille");
        this.setLiaisonMere("idInventaire");
        this.setNomClasseMere("inventaire.Inventaire");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdInventaire() {
        return idInventaire;
    }

    public void setIdInventaire(String idInventaire) {
        this.idInventaire = idInventaire;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public String getExplication() {
        return explication;
    }

    public void setExplication(String explication) {
        this.explication = explication;
    }

    public double getQuantiteTheorique() {
        return quantiteTheorique;
    }

    public void setQuantiteTheorique(double quantiteTheorique) {
        this.quantiteTheorique = quantiteTheorique;
    }

    public double getQuantite() {
        return quantite;
    }

    public void setQuantite(double quantite) {
        this.quantite = quantite;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("IVTFI", "GETSEQinventairefille");
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
        super.setLiaisonMere("idInventaire");
    }

    public String getIdJauge() {
        return idJauge;
    }

    public void setIdJauge(String idJauge) {
        this.idJauge = idJauge;
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        super.setNomClasseMere("inventaire.Inventaire");
        super.controlerUpdate(c);
    }
    
    public Inventaire geInventaire(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        Inventaire inventaire = new Inventaire();
        inventaire.setId(this.getIdInventaire());
        Inventaire[] inventaires = (Inventaire[]) CGenUtil.rechercher(inventaire, null, null, c, " ");
        if (inventaires.length > 0) {
            return inventaires[0];
        }
        return null;
    }
    
    protected void  controlerDuplicationInventaire(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        Inventaire inv=geInventaire(c);
        InventaireFilleCpl invf = new InventaireFilleCpl();
        invf.setIdProduit(this.getIdProduit());
        invf.setIdMagasin(inv.getIdMagasin());
        InventaireFilleCpl[] invfcpl = (InventaireFilleCpl[]) CGenUtil.rechercher(invf, null, null, c, " AND daty = TO_DATE('"+inv.getDaty()+"', 'YYYY-MM-DD') ");
        if (invfcpl.length > 0) {
            throw new Exception("Une inventaire pour ce produit a deja ete validee pour la meme date");
        }
    }
    
    protected void  controlerMagasTypeReservoir(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        Inventaire inv=geInventaire(c);
        Magasin magasin = inv.getMagasin(c);
        if (magasin.getIdTypeMagasin().compareToIgnoreCase(ConstanteStation.idTypeReservoir) == 0) {
            if (magasin.getIdProduit().compareToIgnoreCase(this.getIdProduit()) != 0) {
                throw new Exception("Un ou plusieurs produits filles ne correspondent pas au produit du magasin choisi");
            }
        }
    }
    
    @Override
    public void controler(Connection c) throws Exception {
        this.controlerDuplicationInventaire(c);
        super.controler(c);
    }
    
    protected void calculateQuantiteTheorique(Connection c) throws Exception{
        Inventaire inv=geInventaire(c);
        Date daty=inv.getDaty();
        EtatStock et=new EtatStock();
        Inventaire[] mere=(Inventaire[])CGenUtil.rechercher(new Inventaire(), null, null, c, " and id ='"+idInventaire+"' ");
        if (mere.length!=1) {
            throw new Exception("Inventaire introuvable");
        }
        String query=et.generateQueryCore(daty, daty)+" and inv.idProduit='"+this.idProduit+"' and inv.idmagasin='"+mere[0].getIdMagasin()+"' ";
        System.out.println("-+ query= "+query);
        EtatStock[] listetat=(EtatStock[]) CGenUtil.rechercher(et, query, c);
        double mt=0;
        if (listetat.length==1) {
            mt=listetat[0].getReste();
        }
        this.setQuantiteTheorique(mt);
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.calculateQuantiteTheorique(c);
        return super.createObject(u, c);
    }

  

   
}
