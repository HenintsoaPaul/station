/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inventaire;


public class InventaireLib extends Inventaire{
    private String idmagasinlib, etatlib;
    
    public InventaireLib(){
        this.setNomTable("InventaireLib");
    }

    public String getIdmagasinlib() {
        return idmagasinlib;
    }

    public void setIdmagasinlib(String idmagasinlib) {
        this.idmagasinlib = idmagasinlib;
    }

    public String getEtatlib() {
        return etatlib;
    }

    public void setEtatlib(String etatlib) {
        this.etatlib = etatlib;
    }
    
}
