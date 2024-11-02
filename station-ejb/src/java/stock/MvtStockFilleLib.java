/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package stock;


public class MvtStockFilleLib extends MvtStockFille{
    private String idProduitlib, idVenteDetaillib, idTransfertDetaillib;
    
    public MvtStockFilleLib() throws Exception{
        setNomTable("mvtstockfillelib");
    }

    public String getIdProduitlib() {
        return idProduitlib;
    }

    public void setIdProduitlib(String idProduitlib) {
        this.idProduitlib = idProduitlib;
    }

    public String getIdVenteDetaillib() {
        return idVenteDetaillib;
    }

    public void setIdVenteDetaillib(String idVenteDetaillib) {
        this.idVenteDetaillib = idVenteDetaillib;
    }

    public String getIdTransfertDetaillib() {
        return idTransfertDetaillib;
    }

    public void setIdTransfertDetaillib(String idTransfertDetaillib) {
        this.idTransfertDetaillib = idTransfertDetaillib;
    }
    
    
}
