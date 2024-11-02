/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package depense;

/**
 *
 * @author CMCM
 */
public class DepenseLib extends Depense{

    String idCaisseLib;
    String etatLib;

    public DepenseLib() {
        super.setNomTable("DEPENSELIB");
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
