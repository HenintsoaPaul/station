/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package venteLubrifiant;

/**
 *
 * @author CMCM
 */
public class VenteLubrifiantLib extends VenteLubrifiant {

    protected String idProduitLib;
    protected String etatLib;
    protected double montant;

    public VenteLubrifiantLib() {
        this.setNomTable("venteLubrifiantLib_CV");
    }

    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public String getEtatLib() {
        return etatLib;
    }

    public void setEtatLib(String etatLib) {
        this.etatLib = etatLib;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

   
        

}
