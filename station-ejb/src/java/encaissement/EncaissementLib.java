/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

/**
 *
 * @author Angela
 */
public class EncaissementLib extends Encaissement {

    protected String idCaisseLib;
    protected String etatLib;
    protected String idPompiste;
    protected String idPompisteLib;
    protected double venteLubrifiant;
    protected double venteCarburant;
    protected double depense;
    protected double totalEncaissement;
    protected double totalVersement;
    protected double ecart;
    protected double totalRecette;

    public EncaissementLib() {
        this.setNomTable("ENCAISSEMENT_LIB");
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

    public String getIdPompiste() {
        return idPompiste;
    }

    public void setIdPompiste(String idPompiste) {
        this.idPompiste = idPompiste;
    }

    public String getIdPompisteLib() {
        return idPompisteLib;
    }

    public void setIdPompisteLib(String idPompisteLib) {
        this.idPompisteLib = idPompisteLib;
    }

    public double getVenteLubrifiant() {
        return venteLubrifiant;
    }

    public void setVenteLubrifiant(double venteLubrifiant) {
        this.venteLubrifiant = venteLubrifiant;
    }

    public double getVenteCarburant() {
        return venteCarburant;
    }

    public void setVenteCarburant(double venteCarburant) {
        this.venteCarburant = venteCarburant;
    }

    public double getDepense() {
        return depense;
    }

    public void setDepense(double depense) {
        this.depense = depense;
    }

    public double getTotalVersement() {
        return totalVersement;
    }

    public void setTotalVersement(double totalVersement) {
        this.totalVersement = totalVersement;
    }

    public double getEcart() {
        return ecart;
    }

    public void setEcart(double ecart) {
        this.ecart = ecart;
    }

    public double getTotalEncaissement() {
        return totalEncaissement;
    }

    public void setTotalEncaissement(double totalEncaissement) {
        this.totalEncaissement = totalEncaissement;
    }

    public double getTotalRecette() {
        return totalRecette;
    }

    public void setTotalRecette(double totalRecette) {
        this.totalRecette = totalRecette;
    }
    

}
