/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;
import utils.ConstanteStation;

/**
 *
 * @author 26134
 */
public class TransfertStock extends ClassMere{
    String id,designation,idMagasinDepart,idMagasinArrive;
    Date daty;

    public TransfertStock() {
        this.setNomTable("TransfertStock");
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

    public String getIdMagasinDepart() {
        return idMagasinDepart;
    }

    public void setIdMagasinDepart(String idMagasinDepart) {
        this.idMagasinDepart = idMagasinDepart;
    }

    public String getIdMagasinArrive() {
        return idMagasinArrive;
    }

    public void setIdMagasinArrive(String idMagasinArrive) {
        this.idMagasinArrive = idMagasinArrive;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TS", "getseqTransfertStock");
        this.setId(makePK(c));
    }
    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public TransfertStockDetails[] getTransfertStockDetails(Connection c) throws Exception{
        TransfertStockDetails[] tsd=(TransfertStockDetails[]) CGenUtil.rechercher(new TransfertStockDetails(), null, null, c, " and idTransfertStock='"+this.getId()+"' ");
        return tsd;
    }
    
    protected MvtStock createMvtStock(boolean isEntree) throws Exception{
        MvtStock md=new MvtStock();
        md.setDaty(this.getDaty());
        md.setDesignation("transfert "+this.getDesignation());
        md.setIdTransfert(this.getId());
        if (isEntree) {    
            md.setIdMagasin(this.getIdMagasinArrive());
            md.setIdTypeMvStock(ConstanteStation.TYPEMVTSTOCKENTREE);
        }else{
            md.setIdMagasin(this.getIdMagasinDepart());
            md.setIdTypeMvStock(ConstanteStation.TYPEMVTSTOCKSORTIE);
        }
        return md;
    }
    protected MvtStockFille[] createMvtStockFilles(boolean isEntree,Connection c) throws Exception{
        TransfertStockDetails[] tsd=this.getTransfertStockDetails(c);
        MvtStockFille[] mvtf=new MvtStockFille[tsd.length];
        for (int i = 0; i < tsd.length; i++) {
            mvtf[i] = tsd[i].createMvtStockFille(isEntree);
        }
        return mvtf;
    }
  
    protected MvtStock createMvtStockEntree(String u, Connection c) throws Exception{
        MvtStock me=this.createMvtStock(true);
        me.setFille(this.createMvtStockFilles(true, c));
        me.createObject(u, c);
        me.saveMvtStockFille(u, c);
        me.validerObject(u, c);
        return me;
    }
    
    protected MvtStock createMvtStockSortie(String u, Connection c) throws Exception{
        MvtStock ms=this.createMvtStock(false);
        ms.setFille(this.createMvtStockFilles(false, c));
        ms.createObject(u, c);
        ms.saveMvtStockFille(u, c);
        ms.validerObject(u, c);
        return ms;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        this.createMvtStockEntree(u, c);
        this.createMvtStockSortie(u, c);
        return super.validerObject(u, c);
    }
    
}
