/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author Audace
 */
public class TypeMvtStock extends TypeObjet{
    public TypeMvtStock(){
        setNomTable("typemvtstock");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TPMVST", "getseqtypemvtstock");
        this.setId(makePK(c));
    }
}
