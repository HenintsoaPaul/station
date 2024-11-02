/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cheque;

import bean.CGenUtil;
import bean.ClassMere;
import caisse.VirementIntraCaisse;
import constante.ConstanteEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class VersementCheque extends ClassMere{
    private String id,designation,idCaisse;
    private Date daty;

    public VersementCheque() {
        this.setNomTable("VersementCheque");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("VC", "GETSEQVersementCheque");
        this.setId(makePK(c));
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

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }


    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }


    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        Object r=null;
        try {
            r=super.validerObject(u, c);
            VersementChequeDetailsCpl[] listVcd=(VersementChequeDetailsCpl[])CGenUtil.rechercher(new VersementChequeDetailsCpl(), null, null,c, " AND idVersementCheque = '"+this.getId()+"' ");
            for (int i = 0; i < listVcd.length; i++) {
                VirementIntraCaisse vic=listVcd[i].createVirementIntraCaisse();
                vic.createObject(u, c);
                vic.validerObject(u, c);
                listVcd[i].toucheChequeVersementDetails(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return r;
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        if (this.getEtat()==ConstanteEtat.getEtatValider()) {
            throw new Exception("versement cheque deja visée");
        }
    }
    
}
