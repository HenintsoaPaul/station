/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import caisse.MvtCaisse;
import constante.ConstanteEtat;




/**
 *
 * @author Angela
 */
public class VenteDetailsCpl extends VenteDetailsLib{
    
    
    private double montant;
    private String idCaisse;

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

   

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    
    

    public VenteDetailsCpl() {
        this.setNomTable("VENTE_DETAILS_CPL");
    }
    
    public MvtCaisse createMvtCaisse() throws Exception {
        MvtCaisse mc=new MvtCaisse();
        mc.setDesignation("Mvt caisse");
        mc.setIdVenteDetail(this.getId());
        mc.setIdCaisse(this.getIdCaisse());
        mc.setCredit(montant);
        mc.setEtat(ConstanteEtat.getEtatValider());
        mc.setDaty(utilitaire.Utilitaire.dateDuJourSql());
      
        return mc;
    }
    
}
