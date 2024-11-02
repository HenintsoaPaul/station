/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package avoir;

/**
 *
 * @author bruel
 */
public class AvoirFCFilleLib extends AvoirFCFille {
    private String idproduitlib;

    public AvoirFCFilleLib() throws Exception {
        this.setNomTable("AVOIRFCFILLELIB");
    }
    
    public AvoirFCFilleLib(String nomtable) throws Exception {
        
        this.setNomTable(nomtable);
    }

    public String getIdproduitlib() {
        return idproduitlib;
    }

    public void setIdproduitlib(String idproduitlib) {
        this.idproduitlib = idproduitlib;
    }
}
