/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package magasin;

import bean.ClassMAPTable;
import java.sql.Connection;
import utils.ConstanteStation;

/**
 *
 * @author Angela
 */
public class MagasinReservoir extends Magasin {
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.setIdTypeMagasin(ConstanteStation.idTypeReservoir);
        return super.createObject(u, c);
    }
    
    
}
