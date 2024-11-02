/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;


public class MvtStockLib extends MvtStock{
    private String idMagasinlib, idVentelib, idTransfertlib, idTypeMvStocklib, etatlib;
    
    public MvtStockLib() throws Exception{
        setNomTable("mvtstocklib");
    }

    public String getIdMagasinlib() {
        return idMagasinlib;
    }

    public void setIdMagasinlib(String idMagasinlib) {
        this.idMagasinlib = idMagasinlib;
    }

    public String getIdVentelib() {
        return idVentelib;
    }

    public void setIdVentelib(String idVentelib) {
        this.idVentelib = idVentelib;
    }

    public String getIdTransfertlib() {
        return idTransfertlib;
    }

    public void setIdTransfertlib(String idTransfertlib) {
        this.idTransfertlib = idTransfertlib;
    }

    public String getIdTypeMvStocklib() {
        return idTypeMvStocklib;
    }

    public void setIdTypeMvStocklib(String idTypeMvStocklib) {
        this.idTypeMvStocklib = idTypeMvStocklib;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }
    
    
}
