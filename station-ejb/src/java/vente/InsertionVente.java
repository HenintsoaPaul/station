/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package vente;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Sahy
 */
public class InsertionVente extends Vente{
    String idDevise;

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public InsertionVente() {
        this.setNomTable("INSERTION_VENTE");
    }
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        super.setNomTable("VENTE");
        return super.createObject(u, c);
    }
}
