package mg.cnaps.compta;

import java.util.ArrayList;
import java.util.List;

import utilitaire.Utilitaire;

public class ComptaEtatBalanceChiffre3 {
    int comptePrefix;
    List<ComptaBalanceLigne> balances = new ArrayList<ComptaBalanceLigne>();
    double anterieurDebit;
    double anterieurCredit;
    double mouvementCredit;
    double mouvementDebit;

    public int getComptePrefix() {
        return comptePrefix;
    }

    public void setComptePrefix(int comptePrefix) {
        this.comptePrefix = comptePrefix;
    }

    public List<ComptaBalanceLigne> getBalances() {
        return balances;
    }

    public void setBalances(List<ComptaBalanceLigne> balances) {
        this.balances = balances;
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

    public double getMouvementCredit() {
        return mouvementCredit;
    }

    public void setMouvementCredit(double mouvementCredit) {
        this.mouvementCredit = mouvementCredit;
    }

    public double getMouvementDebit() {
        return mouvementDebit;
    }

    public void setMouvementDebit(double mouvementDebit) {
        this.mouvementDebit = mouvementDebit;
    }

    public void add(ComptaBalanceLigne compta) throws Exception {
        try {

            double totalAntCred = compta.getAnterieurCredit();
            double totalAntDeb = compta.getAnterieurDebit();

            this.setAnterieurCredit(this.getAnterieurCredit() + totalAntCred);
            this.setAnterieurDebit(this.getAnterieurDebit() + totalAntDeb);
            this.setMouvementCredit(this.getMouvementCredit() + compta.getMouvementCredit());
            this.setMouvementDebit(this.getMouvementDebit() + compta.getMouvementDebit());

            compta.setAnterieurCredit(compta.getAnterieurCredit());
            compta.setAnterieurDebit(compta.getAnterieurDebit());
            this.getBalances().add(compta);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
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

    public void afficher() {
        System.out.println("COMPTE = " + comptePrefix);
        System.out.println("anterieurDebit = " + Utilitaire.formaterAr(anterieurDebit));
        System.out.println("anterieurCredit = " + Utilitaire.formaterAr(anterieurCredit));
        System.out.println("mouvementCredit = " + Utilitaire.formaterAr(mouvementCredit));
        System.out.println("mouvementDebit = " + Utilitaire.formaterAr(mouvementDebit));
        System.out.println("_______________________");
    }

    public String makeLigne() {
        String retour = "";
        for (ComptaBalanceLigne balance : this.getBalances()) {
            retour += balance.makeLigne();
        }
        retour += "<tr><td>" + "</td>" +
                "<td>SOUS-TOTAUX " + comptePrefix + "</td>" +
                "<td>" + Utilitaire.formaterAr(getAnterieurDebit()) + "</td>" +
                "<td>" + Utilitaire.formaterAr(getAnterieurCredit()) + "</td>" +
                "<td>" + Utilitaire.formaterAr(getMouvementDebit()) + "</td>" +
                "<td>" + Utilitaire.formaterAr(getMouvementCredit()) + "</td>" +
                "<td>" + Utilitaire.formaterAr(getSoldeDebit()) + "</td>" +
                "<td>" + Utilitaire.formaterAr(getSoldeCredit()) + "</td>";
        retour += "</tr>";
        return retour;
    }
    
    
    public ArrayList<ComptaEtatBalanceChiffre2PDF> makeLignePDF(){
        ArrayList<ComptaEtatBalanceChiffre2PDF> retour = new ArrayList<ComptaEtatBalanceChiffre2PDF>();
        for (ComptaBalanceLigne balance : this.getBalances()) {
            retour.addAll(balance.makeLignePDF()) ;
        }
        ComptaEtatBalanceChiffre2PDF ligne=new ComptaEtatBalanceChiffre2PDF("   ","SOUS-TOTAUX " + comptePrefix,getAnterieurDebit(),getAnterieurCredit(),getMouvementDebit(),getMouvementCredit(),getSoldeDebit(),getSoldeCredit());
        retour.add(ligne);
        return retour;
    }

    
}
