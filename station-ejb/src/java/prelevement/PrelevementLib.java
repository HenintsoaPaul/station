/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prelevement;

/**
 *
 * @author SAFIDY
 */
public class PrelevementLib extends Prelevement{
    protected String nomUser;
    protected String idRole;
    protected String idPompeLib;
    protected String nomMagasin;
    protected String descriptionMagasin;
    protected String etatLib;
    
    public PrelevementLib(){
         this.setNomTable("PRELEVEMENTLIB");
    }

    public String getNomUser() {
        return nomUser;
    }

    public void setNomUser(String nomUser) {
        this.nomUser = nomUser;
    }

    public String getIdRole() {
        return idRole;
    }

    public void setIdRole(String idRole) {
        this.idRole = idRole;
    }

    public String getNomMagasin() {
        return nomMagasin;
    }

    public void setNomMagasin(String nomMagasin) {
        this.nomMagasin = nomMagasin;
    }

    public String getDescriptionMagasin() {
        return descriptionMagasin;
    }

    public void setDescriptionMagasin(String descriptionMagasin) {
        this.descriptionMagasin = descriptionMagasin;
    }

    public String getEtatLib() {
        return etatLib;
    }

    public void setEtatLib(String etatLib) {
        this.etatLib = etatLib;
    }

    @Override
    public String getValColLibelle() {
        return this.designation;
    }

    public String getIdPompeLib() {
        return idPompeLib;
    }

    public void setIdPompeLib(String idPompeLib) {
        this.idPompeLib = idPompeLib;
    }
    
    
}
