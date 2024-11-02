/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package annexe;

/**
 *
 * @author 26134
 */
public class CategorieLib extends Categorie{

    String idTypeProduitLib;
    
    public CategorieLib() {
        this.setNomTable("CategorieLib");
    }
    
    public String getIdTypeProduitLib() {
        return idTypeProduitLib;
    }

    public void setIdTypeProduitLib(String idTypeProduitLib) {
        this.idTypeProduitLib = idTypeProduitLib;
    }

    @Override
    public String getValColLibelle() {
        return val+";"+idTypeProduit;
    }
}
