/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.ClassMAPTable;
import java.util.ArrayList;
import utilitaire.Utilitaire;


public class ComptaBalanceLigne extends ClassMAPTable {
    String compte ;
    String libelleCompte;
    String chiffre3 ;
    String chiffre2 ;
    double anterieurDebit ;
    double anterieurCredit ;
    double mouvementDebit ;
    double mouvementCredit ;

    public void setLibelleCompte(String libelleCompte){
        this.libelleCompte=libelleCompte;
    }

    public String getLibelleCompte(){
        return this.libelleCompte;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
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
        System.out.println("mouvement credit "+mouvementCredit);
        this.mouvementCredit = mouvementCredit;
    }

    @Override
    public String getTuppleID() {
        return "id" ;
    }

    @Override
    public String getAttributIDName() {
       return "id" ;
    }
    
    public double getTotalCredit() {
        return anterieurCredit + mouvementCredit;
    }

    public double getTotalDebit() {
        return anterieurDebit + mouvementDebit;
    }

    public double getSoldeCredit() {
        return Math.max(0,getTotalCredit()-getTotalDebit());
    }

    public double getSoldeDebit() {
        return Math.max(0,getTotalDebit()-getTotalCredit());
    }
    
    public String makeLigne(){
        String retour = "";
        retour+="<tr><td>"+getCompte()+"</td>"+
                "<td>"+getLibelleCompte()+"</td>"+
                "<td>" + Utilitaire.formaterAr(getAnterieurDebit()) + "</td>" +
               "<td>" + Utilitaire.formaterAr(getAnterieurDebit()) + "</td>" +
               "<td>" + Utilitaire.formaterAr(getMouvementDebit()) + "</td>" +
               "<td>" + Utilitaire.formaterAr(getMouvementCredit()) + "</td>"+
               "<td>" + Utilitaire.formaterAr(getSoldeDebit()) + "</td>"+
               "<td>" + Utilitaire.formaterAr(getSoldeCredit()) + "</td>";
        retour+="</tr>";
        return retour;
    }
    
    public ArrayList<ComptaEtatBalanceChiffre2PDF> makeLignePDF(){
        ArrayList<ComptaEtatBalanceChiffre2PDF> retour = new ArrayList<ComptaEtatBalanceChiffre2PDF>();
        ComptaEtatBalanceChiffre2PDF ligne=new ComptaEtatBalanceChiffre2PDF(getCompte(),getLibelleCompte(),getAnterieurDebit(),getAnterieurCredit(),getMouvementDebit(),getMouvementCredit(),getSoldeDebit(),getSoldeCredit());
        retour.add(ligne);
        return retour;
    }
}
