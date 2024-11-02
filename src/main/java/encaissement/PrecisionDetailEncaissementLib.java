/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import cheque.Cheque;

/**
 *
 * @author Angela
 */
public class PrecisionDetailEncaissementLib extends PrecisionDetailEncaissement {
   
    protected String idCategorieCaisseLib; 
    protected String idClientLib;
    protected String idCaisse;
    
    
    
    public PrecisionDetailEncaissementLib() throws Exception {
        this.setNomTable("PrecisDetEncaissement_Lib");
    }

    public String getIdCategorieCaisseLib() {
        return idCategorieCaisseLib;
    }

    public void setIdCategorieCaisseLib(String idCategorieCaisseLib) {
        this.idCategorieCaisseLib = idCategorieCaisseLib;
    }

    public String getIdClientLib() {
        return idClientLib;
    }

    public void setIdClientLib(String idClientLib) {
        this.idClientLib = idClientLib;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }
    
    
   
    
    
    
}
