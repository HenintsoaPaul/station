/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package caisse;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author CMCM
 */
public class MvtCaisseTemp  extends  MvtCaisse{


    
    @Override
    public ClassMAPTable createObject (String u, Connection c) throws Exception {
      MvtCaisseTemp mvt=(MvtCaisseTemp)super.createObject(u, c);
      super.validerObject(u, c);
      return mvt;
     
    }
}
