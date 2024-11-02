/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cheque;

import bean.ClassEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class Cheque extends ClassEtat{
private String id,reference,idCaisse,remarque,idPrecisionDetailEncaissement,idClient;
private double montant;
private Date daty;

    public Cheque() {
        this.setNomTable("cheque");
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CHQ", "GETSEQCheque");
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

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdPrecisionDetailEncaissement() {
        return idPrecisionDetailEncaissement;
    }

    public void setIdPrecisionDetailEncaissement(String idPrecisionDetailEncaissement) {
        this.idPrecisionDetailEncaissement = idPrecisionDetailEncaissement;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }
    
    
    
    
    
}
