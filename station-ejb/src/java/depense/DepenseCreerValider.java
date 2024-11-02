/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package depense;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author 26134
 */
public class DepenseCreerValider extends Depense{

    public DepenseCreerValider() {
        this.setNomTable("depense");
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        super.createObject(u, c);
        this.validerObject(u, c);
        return this;
    }
    
    
}
