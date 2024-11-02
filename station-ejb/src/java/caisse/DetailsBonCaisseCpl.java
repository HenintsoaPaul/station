/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

/**
 *
 * @author 26134
 */
public class DetailsBonCaisseCpl extends DetailsBonCaisse{
    String idCaisseLib,idPoint,idPointLib,idClientLib;

    public DetailsBonCaisseCpl() {
        this.setNomTable("DetailsBonCaisseCpl");
    }
    
    public String getIdCaisseLib() {
        return idCaisseLib;
    }

    public void setIdCaisseLib(String idCaisseLib) {
        this.idCaisseLib = idCaisseLib;
    }
    
    public String getIdPoint() {
        return idPoint;
    }

    public void setIdPoint(String idPoint) {
        this.idPoint = idPoint;
    }

    public String getIdPointLib() {
        return idPointLib;
    }

    public void setIdPointLib(String idPointLib) {
        this.idPointLib = idPointLib;
    }

    public String getIdClientLib() {
        return idClientLib;
    }

    public void setIdClientLib(String idClientLib) {
        this.idClientLib = idClientLib;
    }
    
}
