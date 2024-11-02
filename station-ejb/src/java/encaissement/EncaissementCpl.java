/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.CGenUtil;
import java.sql.Connection;

/**
 *
 * @author Angela
 */
public class EncaissementCpl extends EncaissementLib {
 
    String idTypeEncaissementlib;

    public String getIdTypeEncaissementlib() {
        return idTypeEncaissementlib;
    }

    public void setIdTypeEncaissementlib(String idTypeEncaissementlib) {
        this.idTypeEncaissementlib = idTypeEncaissementlib;
    }
    
    protected String idPoint;

    public String getIdPoint() {
        return idPoint;
    }

    public void setIdPoint(String idPoint) {
        this.idPoint = idPoint;
    }

    public EncaissementCpl() {
        this.setNomTable("ENCAISSEMENTCPL");
    }
    
    
    
  
    
       
    
    
    
    
    
}
