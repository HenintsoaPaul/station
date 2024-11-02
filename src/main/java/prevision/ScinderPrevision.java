/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prevision;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;

/**
 *
 * @author Mendrika
 */
public class ScinderPrevision extends ClassMAPTable{
    String id, idPrevision;
    int nombre;

    public ScinderPrevision() {
        this.setNomTable("SCINDERPREVISION");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPrevision() {
        return idPrevision;
    }

    public void setIdPrevision(String idPrevision) {
        this.idPrevision = idPrevision;
    }

    public int getNombre() {
        return nombre;
    }

    public void setNombre(int nombre) throws Exception {
        if (getMode().equals("modif")){
            if(nombre <= 1){
                throw new Exception("Impossible de scinder en 1");
            } 
        }
        this.nombre = nombre;  
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception{
        Prevision prev = new Prevision();
        Prevision[] previsions = (Prevision[]) CGenUtil.rechercher(prev, null, null, c, "and ID = '"+this.getIdPrevision()+"'");
        previsions[0].scinder(nombre, u, c);
        return previsions[0];        
    }

}
