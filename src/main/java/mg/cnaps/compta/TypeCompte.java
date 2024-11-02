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
public class TypeCompte extends TypeObjet{

    public TypeCompte() {
        super.setNomTable("compta_type_compte");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        super.setNomTable("compta_type_compte");
        this.preparePk("TYPC", "getseqcomptatypecompte");
        this.setId(this.makePK(c));
    }
    
    
    
}
