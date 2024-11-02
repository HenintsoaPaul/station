/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package inventaire;


public class InventaireFilleLib extends InventaireFille{
    private String idproduitlib;
    
    public InventaireFilleLib() throws Exception{
        this.setNomTable("InventaireFilleLib");
    }

    public String getIdproduitlib() {
        return idproduitlib;
    }

    public void setIdproduitlib(String idproduitlib) {
        this.idproduitlib = idproduitlib;
    }
}
