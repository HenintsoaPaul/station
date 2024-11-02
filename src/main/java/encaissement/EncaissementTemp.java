/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Angela
 */
public class EncaissementTemp extends Encaissement {
    
    
    String idEncaissement;
    

    public EncaissementTemp() {
        this.setNomTable("ENCAISSEMENT_TEMP");
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }
    
    
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.setId(this.getIdEncaissement());
        return this;
    }
    
    
    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        int i=1;
        return i;
    }
    
   

    
}
