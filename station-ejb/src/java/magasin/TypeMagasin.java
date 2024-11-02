/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package magasin;

import bean.TypeObjet;
import java.sql.Connection;


public class TypeMagasin extends TypeObjet{
    public TypeMagasin(){
        this.setNomTable("TYPEMAGASIN");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TYPMG", "GETSEQTYPEMAGASIN");
        this.setId(makePK(c));
    }
}
