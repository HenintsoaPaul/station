/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;

/**
 *
 * @author 26134
 */
public class TransfertStockCpl extends TransfertStock{
    String idMagasinDepartLib,idMagasinArriveLib,etatlib;

    public String getIdMagasinDepartLib() {
        return idMagasinDepartLib;
    }

    public void setIdMagasinDepartLib(String idMagasinDepartLib) {
        this.idMagasinDepartLib = idMagasinDepartLib;
    }

    public String getIdMagasinArriveLib() {
        return idMagasinArriveLib;
    }

    public void setIdMagasinArriveLib(String idMagasinArriveLib) {
        this.idMagasinArriveLib = idMagasinArriveLib;
    }
    
    public TransfertStockCpl() {
        this.setNomTable("TransfertStockCpl");
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }
    
}
