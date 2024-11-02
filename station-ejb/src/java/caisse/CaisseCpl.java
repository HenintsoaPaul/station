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
public class CaisseCpl extends Caisse{
 
    private String idTypeCaisseLib , idPointLib ,idCategorieCaisseLib,idMagasin, idMagasinLib,etatLib;

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdMagasinLib() {
        return idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    } 

    public CaisseCpl() {
        super.setNomTable("CAISSECPL");
    }

    public String getIdCategorieCaisseLib() {
        return idCategorieCaisseLib;
    }

    public void setIdCategorieCaisseLib(String idCategorieCaisseLib) {
        this.idCategorieCaisseLib = idCategorieCaisseLib;
    }

    public String getIdTypeCaisseLib() {
        return idTypeCaisseLib;
    }

    public void setIdTypeCaisseLib(String idTypeCaisseLib) {
        this.idTypeCaisseLib = idTypeCaisseLib;
    }

    public String getIdPointLib() {
        return idPointLib;
    }

    public void setIdPointLib(String idPointLib) {
        this.idPointLib = idPointLib;
    }

    public String getEtatLib() {
	 return etatLib;
    }

    public void setEtatLib(String etatLib) {
	 this.etatLib = etatLib;
    }
    
    
}
