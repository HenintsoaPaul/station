/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMere;
import inventaire.Inventaire;
import inventaire.InventaireFille;
import inventaire.InventaireFilleCpl;
import java.sql.Connection;
import java.sql.Date;
import magasin.Magasin;
import utilitaire.UtilDB;
import utils.ConstanteStation;

public class MvtStock extends ClassMere {

    private String id, designation, idMagasin, idVente, idTransfert, idTypeMvStock;
    private Date daty;

    @Override
    public boolean isSynchro(){
        return true;
    }
    
    public MvtStock() throws Exception {
        this.setNomTable("MVTSTOCK");
	this.setNomClasseFille("stock.MvtStockFille");
	this.setLiaisonFille("idMvtStock");
	 
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

    public String getIdVente() {
        return idVente;
    }

    public void setIdVente(String idVente) {
        this.idVente = idVente;
    }

    public String getIdTransfert() {
        return idTransfert;
    }

    public void setIdTransfert(String idTransfert) {
        this.idTransfert = idTransfert;
    }

    public String getIdTypeMvStock() {
        return idTypeMvStock;
    }

    public void setIdTypeMvStock(String idTypeMvStock) {
        this.idTypeMvStock = idTypeMvStock;
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
        this.preparePk("MVTST", "GETSEQMVTSTOCK");
        this.setId(makePK(c));
    }

    protected void controlerMvt(Connection c) throws Exception {
        if (this.getIdMagasin()== null || this.getIdMagasin().compareToIgnoreCase("") == 0) {
            throw new Exception("Champ magasin obligatoire");
        }
    }

    public Magasin getMagasin(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        Magasin magasin = new Magasin();
        magasin.setId(this.getIdMagasin());
        Magasin[] magasins = (Magasin[]) CGenUtil.rechercher(magasin, null, null, c, " ");
        if (magasins.length > 0) {
            return magasins[0];
        }
        return null;
    }

    public MvtStockFille[] getMvtStockFilles(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            MvtStockFille msf = new MvtStockFille();
            msf.setIdMvtStock(this.getId());
            MvtStockFille[] msfs = (MvtStockFille[]) CGenUtil.rechercher(msf, null, null, c, " ");
            if (msfs.length > 0) {
                return msfs;
            }
            return null;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    public void createInventaireZero(String u, Connection c) throws Exception {
        if (this.getIdTypeMvStock() == ConstanteStation.TYPEMVTSTOCKENTREE) {
            MvtStockFille[] msfs = getMvtStockFilles(c);
            for (MvtStockFille mvf : msfs) {
                InventaireFilleCpl invFCpl = new InventaireFilleCpl();
                invFCpl.setIdMagasin(this.getIdMagasin());
                invFCpl.setIdProduit(mvf.getIdProduit());
                InventaireFilleCpl[] invFCpls = invFCpl.getInventaireFilles(c);
                if (invFCpls == null) {
                    Magasin m = getMagasin(c);
                    Inventaire inv = (Inventaire) m.generateInventaireMere().createObject(u, c);
                    InventaireFille invF = inv.generateInventaireFilleZero();
                    invF.setIdProduit(mvf.getIdProduit());
                    invF.createObject(u, c);
                    inv.validerObject(u, c);
                }
            }
        }
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        super.validerObject(u, c);
        createInventaireZero(u, c);
        return this;
    }

    public void saveMvtStockFille(String u, Connection c) throws Exception {
        MvtStockFille[] mvtf = (MvtStockFille[]) this.getFille();
        for (int i = 0; i < mvtf.length; i++) {
            mvtf[i].setId(null);
            mvtf[i].setIdMvtStock(this.getId());
            mvtf[i].createObject(u, c);
        }
    }

    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c);
        this.controlerMvt(c);
    }

}
