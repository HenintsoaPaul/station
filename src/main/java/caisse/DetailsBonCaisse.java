/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class DetailsBonCaisse extends ClassEtat{
    String id;
    String idCaisse;
    double debit;
    double credit;
    String idClient;
    String idPrecisionDetailEncaissement;
    Date daty;
    String remarque;

    public DetailsBonCaisse() {
        this.setNomTable("DetailsBonCaisse");
    }
    
    @Override
    public String getTuppleID() {
        return id; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("DBC", "GETSEQDETAILSBONCAISSE");
        this.setId(makePK(c));
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public String getIdPrecisionDetailEncaissement() {
        return idPrecisionDetailEncaissement;
    }

    public void setIdPrecisionDetailEncaissement(String idPrecisionDetailEncaissement) {
        this.idPrecisionDetailEncaissement = idPrecisionDetailEncaissement;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    
}
