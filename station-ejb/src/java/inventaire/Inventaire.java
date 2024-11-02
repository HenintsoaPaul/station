/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inventaire;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;
import magasin.Magasin;
import utilitaire.Utilitaire;
import utils.ConstanteStation;

public class Inventaire extends ClassMere{
    private String id, designation, idMagasin, remarque;
    private Date daty;
    
    public Inventaire(){
        this.setNomTable("inventaire");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
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
        this.preparePk("IVT", "GETSEQinventaire");
        this.setId(makePK(c));
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
    
    public InventaireFille generateInventaireFilleZero () throws Exception{
        InventaireFille invF=new InventaireFille();
        invF.setQuantite(0);
        invF.setQuantiteTheorique(0);
        invF.setIdInventaire(this.getId()); 
        invF.setExplication("inventaire 0");
        return invF;
    }
    
}
