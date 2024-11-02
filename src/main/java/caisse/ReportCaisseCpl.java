/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

/**
 *
 * @author nouta
 */
public class ReportCaisseCpl extends ReportCaisse{
    private String idCaisseLib, etatLib;

    public ReportCaisseCpl() {
        super.setNomTable("REPORTCAISSELIB");
    }
    
    public String getIdCaisseLib() {
        return idCaisseLib;
    }

    public void setIdCaisseLib(String idCaisseLib) {
        this.idCaisseLib = idCaisseLib;
    }

    public String getEtatLib() {
        return etatLib;
    }

    public void setEtatLib(String etatLib) {
        this.etatLib = etatLib;
    }

    
    
    
}
