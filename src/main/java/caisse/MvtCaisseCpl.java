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
public class MvtCaisseCpl extends MvtCaisse{
    private String idCaisseLib;
    private String idVente;
    String etatLib;
    protected String tiers;

    public String getTiers() {
	 return tiers;
    }

    public void setTiers(String tiers) {
	 this.tiers = tiers;
    }

    public MvtCaisseCpl() {
        super.setNomTable("MOUVEMENTCAISSECPL");
    }

    public String getIdCaisseLib() {
        return idCaisseLib;
    }

    public String getIdVente() {
        return idVente;
    }

    public void setIdVente(String idVente) {
        this.idVente = idVente;
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
