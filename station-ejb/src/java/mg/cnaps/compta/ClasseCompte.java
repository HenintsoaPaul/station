/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author itu
 */
public class ClasseCompte extends TypeObjet{

    public ClasseCompte() {
        super.setNomTable("COMPTA_CLASSE_COMPTE");
    }

     @Override
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("compta_classe_compte");
        this.preparePk("CLAC", "getseqcomptaclassecompte");
        this.setId(this.makePK(c));
    }
    
    
    
    
    
}
