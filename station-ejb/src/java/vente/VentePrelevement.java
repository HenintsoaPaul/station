/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import prelevement.Prelevement;

/**
 *
 * @author Angela
 */
public class VentePrelevement extends Prelevement{
    
    protected double montantTotalVente;
    protected double montantTotalEncaissement;
    protected String idEncaissement;

    public VentePrelevement() {
        this.setNomTable("Vente_Prelevement");
    }
    

    public double getMontantTotalVente() {
        return montantTotalVente;
    }

    public void setMontantTotalVente(double montantTotalVente) {
        this.montantTotalVente = montantTotalVente;
    }

    public double getMontantTotalEncaissement() {
        return montantTotalEncaissement;
    }

    public void setMontantTotalEncaissement(double montantTotalEncaissement) {
        this.montantTotalEncaissement = montantTotalEncaissement;
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }
    
    
    
    

    
}
