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
public class VirementIntraCaisseCpl extends VirementIntraCaisse{
    private String idCaisseDepartLib,idCaisseArriveLib, etatLib;

    public VirementIntraCaisseCpl() {
        this.setNomTable("VirementIntraCaisseCpl");
    }

    public String getIdCaisseDepartLib() {
        return idCaisseDepartLib;
    }

    public void setIdCaisseDepartLib(String idCaisseDepartLib) {
        this.idCaisseDepartLib = idCaisseDepartLib;
    }

    public String getIdCaisseArriveLib() {
        return idCaisseArriveLib;
    }

    public void setIdCaisseArriveLib(String idCaisseArriveLib) {
        this.idCaisseArriveLib = idCaisseArriveLib;
    }

    public String getEtatLib() {
        return etatLib;
    }

    public void setEtatLib(String etatLib) {
        this.etatLib = etatLib;
    }

    
    
}
