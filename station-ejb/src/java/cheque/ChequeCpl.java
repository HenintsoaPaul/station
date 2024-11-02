/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cheque;

/**
 *
 * @author 26134
 */
public class ChequeCpl extends Cheque{
    String idCaisseLib;

    public ChequeCpl() {
        this.setNomTable("ChequeCpl");
    }

    public String getIdCaisseLib() {
        return idCaisseLib;
    }

    public void setIdCaisseLib(String idCaisseLib) {
        this.idCaisseLib = idCaisseLib;
    }
    
}
