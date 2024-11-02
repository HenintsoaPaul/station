/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

/**
 *
 * @author Angela
 */
public class HistoriqueProduitLib extends HistoriqueProduit{
    
    private String idProduitLib;

    public HistoriqueProduitLib() {
        this.setNomTable("Historique_Produit_Lib");
    }

    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }
    
    
    
}
