/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;

import bean.ClassMAPTable;
import java.sql.Connection;
import pertegain.Tiers;

/**
 *
 * @author nouta
 */
public class Fournisseur extends Tiers{
    protected String contact,codePostal;

    public Fournisseur() {
        super.setNomTable("FOURNISSEUR");
    }

    

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getCodePostal() {
        return codePostal;
    }

    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }

     @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FRN", "GETSEQFOURNISSEUR");
        this.setId(makePK(c));
    }
 
    @Override
    public String getValColLibelle() {
        return this.getNom();
    }
   
  
}
