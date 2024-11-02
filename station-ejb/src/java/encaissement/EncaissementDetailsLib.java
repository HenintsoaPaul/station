/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

/**
 *
 * @author Angela
 */
public class EncaissementDetailsLib extends EncaissementDetails {
    
    
    protected String idCategorieCaisseLib;

    public String getIdCategorieCaisseLib() {
        return idCategorieCaisseLib;
    }

    public void setIdCategorieCaisseLib(String idCategorieCaisseLib) {
        this.idCategorieCaisseLib = idCategorieCaisseLib;
    }
    
    public EncaissementDetailsLib() throws Exception {
        this.setNomTable("Encaissement_Details_Lib");
    }
}
