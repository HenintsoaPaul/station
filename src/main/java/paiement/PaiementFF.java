/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package paiement;

import bean.ClassMAPTable;
import faturefournisseur.FactureFournisseurCpl;
import java.sql.Date;

/**
 *
 * @author CMCM
 */
public class PaiementFF extends ClassMAPTable{
    protected String id;
    protected String idOP ;
    protected String idFF ;
    protected double montant;
    protected Date daty;
    protected FactureFournisseurCpl ff;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdOP() {
        return idOP;
    }

    public void setIdOP(String idOP) {
        this.idOP = idOP;
    }

    public String getIdFF() {
        return idFF;
    }

    public void setIdFF(String idFF) {
        this.idFF = idFF;
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

     @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    

}
