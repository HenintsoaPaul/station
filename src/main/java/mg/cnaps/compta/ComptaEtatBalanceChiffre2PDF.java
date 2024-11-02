/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;


public class ComptaEtatBalanceChiffre2PDF  {
    String compte ;
    String libelleCompte;
    String chiffre3 ;
    String chiffre2 ;
    double anterieurDebit ;
    double anterieurCredit ;
    double mouvementDebit ;
    double mouvementCredit ;
    double soldeCredit ;
    double soldeDebit ;

    public double getSoldeCredit() {
        return soldeCredit;
    }

    public void setSoldeCredit(double soldeCredit) {
        this.soldeCredit = soldeCredit;
    }

    public double getSoldeDebit() {
        return soldeDebit;
    }

    public void setSoldeDebit(double soldeDebit) {
        this.soldeDebit = soldeDebit;
    }

    public ComptaEtatBalanceChiffre2PDF(String compte, String libelleCompte, double anterieurDebit, double anterieurCredit, double mouvementDebit, double mouvementCredit, double soldeCredit, double soldeDebit) {
        this.compte = compte;
        this.libelleCompte = libelleCompte;
        this.anterieurDebit = anterieurDebit;
        this.anterieurCredit = anterieurCredit;
        this.mouvementDebit = mouvementDebit;
        this.mouvementCredit = mouvementCredit;
        this.soldeCredit = soldeCredit;
        this.soldeDebit = soldeDebit;
    }

    @Override
    public String toString() {
        return "ComptaEtatBalanceChiffre2PDF{" + "compte=" + compte + ", libelleCompte=" + libelleCompte + ", anterieurDebit=" + anterieurDebit + ", anterieurCredit=" + anterieurCredit + ", mouvementDebit=" + mouvementDebit + ", mouvementCredit=" + mouvementCredit + ", soldeCredit=" + soldeCredit + ", soldeDebit=" + soldeDebit + '}';
    }
    
    

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getLibelleCompte() {
        return libelleCompte;
    }

    public void setLibelleCompte(String libelleCompte) {
        this.libelleCompte = libelleCompte;
    }

    public String getChiffre3() {
        return chiffre3;
    }

    public void setChiffre3(String chiffre3) {
        this.chiffre3 = chiffre3;
    }

    public String getChiffre2() {
        return chiffre2;
    }

    public void setChiffre2(String chiffre2) {
        this.chiffre2 = chiffre2;
    }

    public double getAnterieurDebit() {
        return anterieurDebit;
    }

    public void setAnterieurDebit(double anterieurDebit) {
        this.anterieurDebit = anterieurDebit;
    }

    public double getAnterieurCredit() {
        return anterieurCredit;
    }

    public void setAnterieurCredit(double anterieurCredit) {
        this.anterieurCredit = anterieurCredit;
    }

    public double getMouvementDebit() {
        return mouvementDebit;
    }

    public void setMouvementDebit(double mouvementDebit) {
        this.mouvementDebit = mouvementDebit;
    }

    public double getMouvementCredit() {
        return mouvementCredit;
    }

    public void setMouvementCredit(double mouvementCredit) {
        this.mouvementCredit = mouvementCredit;
    }
    
    
    
}
