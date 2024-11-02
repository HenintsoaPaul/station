/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author nouta
 */
public class CategorieCaisse extends TypeObjet{
    protected String idTypeCaisse ;

    public CategorieCaisse() {
        super.setNomTable("CategorieCaisse");
    }

    public String getIdTypeCaisse() {
        return idTypeCaisse;
    }

    public void setIdTypeCaisse(String idTypeCaisse) {
        this.idTypeCaisse = idTypeCaisse;
    }


    
    
    
    
    
}
