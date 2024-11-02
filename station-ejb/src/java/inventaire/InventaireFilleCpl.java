/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package inventaire;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;

/**
 *
 * @author Angela
 */
public class InventaireFilleCpl extends InventaireFilleLib {
    
    private Date daty;
    private String idMagasin;

    public InventaireFilleCpl() throws Exception {
      this.setNomTable("INVENTAIRE_FILLE_CPL");
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty){
        this.daty = daty;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }
    
    
     public InventaireFilleCpl[] getInventaireFilles(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            InventaireFilleCpl[] objs = (InventaireFilleCpl[]) CGenUtil.rechercher(this, null, null, c, " ");
            if (objs.length > 0) {
                return objs;
            }
            return null;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }
    
    
     
   
    
    
}
