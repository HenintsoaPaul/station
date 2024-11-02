/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package jauge;

import annexe.Produit;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassFille;
import bean.ClassMAPTable;
import inventaire.Inventaire;
import inventaire.InventaireFille;
import java.sql.Connection;
import java.sql.Date;
import magasin.Magasin;
import utilitaire.Utilitaire;

/**
 *
 * @author Angela
 */
public class Jauge extends ClassEtat{
    
    private String id;
    private String idMagasin;
    private double qte;
    private Date daty;

    public Jauge() {
        this.setNomTable("JAUGE");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) {
        this.qte = qte;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
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
    public void construirePK(Connection c) throws Exception {
        this.preparePk("JUG", "GETSEQJAUGE");
        this.setId(makePK(c));
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception{
        Object o=super.validerObject(u, c);
        createInventaire (u,c);
        return o;
    }
    
    public Magasin getMagasin(Connection c) throws Exception {
        if (c ==null)
        {
            throw new Exception ("Connection non etablie");
        }
        Magasin magasin = new Magasin();
        magasin.setId(this.getIdMagasin());
        Magasin[] magasins = (Magasin[])CGenUtil.rechercher(magasin, null, null, c, " ");
        if (magasins.length > 0) {
            return magasins[0];
        }
        return null;
    }
    
    
    public Inventaire createInventaireOnly(){
        Inventaire inv=new Inventaire();
        inv.setDaty(this.getDaty());
        inv.setIdMagasin(this.getIdMagasin());
        inv.setDesignation("Inventaire Jauge");
        inv.setRemarque("Jauge");
        return inv;
    }
    
    
    public InventaireFille createInventaireFilleOnly(Connection c) throws Exception{
        InventaireFille invF=new InventaireFille();
        Magasin mag=getMagasin(c);
        invF.setIdProduit(mag.getIdProduit());
        invF.setQuantite(this.getQte());
        invF.setIdJauge(this.getId());
        return invF;
    }
     
     
    public void createInventaire (String u, Connection c) throws Exception{
        Inventaire inv=createInventaireOnly();
        inv.createObject(u, c);
        InventaireFille invF=createInventaireFilleOnly(c);
        invF.setIdInventaire(inv.getId());
        invF.createObject(u, c);
    }
    
    
    
}
