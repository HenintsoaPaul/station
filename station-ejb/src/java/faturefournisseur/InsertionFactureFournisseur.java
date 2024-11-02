/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package faturefournisseur;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author mymac
 */
public class InsertionFactureFournisseur extends FactureFournisseur {
    protected String idDevise;

    public String getIdDevise() {
        return this.idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public InsertionFactureFournisseur() {
        super.setNomTable("INSERTION_FACTURE_FOURNISSEUR");
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
         super.setNomTable("FACTUREFOURNISSEUR");
        System.out.println("Deses");
        return super.createObject(u, c); 
    }
    


}
