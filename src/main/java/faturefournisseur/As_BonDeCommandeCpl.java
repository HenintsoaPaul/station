/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;


public class As_BonDeCommandeCpl extends As_BonDeCommande{
    double montantTVA;
    double montantHT;
    double montantTTC;
    double montantTTCAriary;
    String idDeviselib;
    
    public As_BonDeCommandeCpl(){
        this.setNomTable("As_BonDeCommande_MERECPL");
    }

    public double getMontantTVA() {
        return montantTVA;
    }

    public void setMontantTVA(double montantTVA) {
        this.montantTVA = montantTVA;
    }

    public double getMontantHT() {
        return montantHT;
    }

    public void setMontantHT(double montantHT) {
        this.montantHT = montantHT;
    }

    public double getMontantTTC() {
        return montantTTC;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public double getMontantTTCAriary() {
        return montantTTCAriary;
    }

    public void setMontantTTCAriary(double montantTTCAriary) {
        this.montantTTCAriary = montantTTCAriary;
    }

    public String getIdDeviselib() {
        return idDeviselib;
    }

    public void setIdDeviselib(String idDeviselib) {
        this.idDeviselib = idDeviselib;
    }
    
    
    
}
