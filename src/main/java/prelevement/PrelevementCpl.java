/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prelevement;

import bean.CGenUtil;
import java.sql.Connection;
import vente.Vente;
import vente.VenteDetails;

/**
 *
 * @author Angela
 */
public class PrelevementCpl extends PrelevementLib {
    
    String idMagasin;
    String idCaisse;
    String idProduit;
    double maxPompe;
    double puVente;

    public PrelevementCpl() {
        this.setNomTable("PRELEVEMENTCPL");
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public double getMaxPompe() {
        return maxPompe;
    }

    public void setMaxPompe(double maxPompe) {
        this.maxPompe = maxPompe;
    }
    
    public double getPuVente() {
        return puVente;
    }

    public void setPuVente(double puVente) {
        this.puVente = puVente;
    }
}
