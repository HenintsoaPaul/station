package mg.cnaps.compta;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import bean.ClassMAPTable;
import utilitaire.Utilitaire;

public class ComptaEtatBalanceChiffre2 extends ClassMAPTable {
    int comptePrefix;
    LinkedHashMap<Integer, ComptaEtatBalanceChiffre3> balances = new LinkedHashMap<Integer, ComptaEtatBalanceChiffre3>();
    double anterieurDebit;
    double anterieurCredit;
    double mouvementCredit;
    double mouvementDebit;
    public void afficher() {

        for (Map.Entry<Integer, ComptaEtatBalanceChiffre3> entry : balances.entrySet()) {
            int key = entry.getKey();
            ComptaEtatBalanceChiffre3 value = entry.getValue();
            value.afficher();
        }
        System.out.println("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
    }

    public int getComptePrefix() {
        return comptePrefix;
    }

    public void setComptePrefix(int comptePrefix) {
        this.comptePrefix = comptePrefix;
    }

    public LinkedHashMap<Integer, ComptaEtatBalanceChiffre3> getBalances() {
        return balances;
    }

    public void setBalances(LinkedHashMap<Integer, ComptaEtatBalanceChiffre3> balances) {
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

    public void ajouter(ComptaBalanceLigne item) throws Exception {
        try {
            ComptaEtatBalanceChiffre3 comptaEtat = this.getBalances().get(Integer.valueOf(item.getChiffre3()));
            if (comptaEtat != null) {
                comptaEtat.add(item);
            } else {
                ComptaEtatBalanceChiffre3 nouvCompta = new ComptaEtatBalanceChiffre3();
                nouvCompta.setComptePrefix(Integer.valueOf(item.getChiffre3()));
                this.getBalances().put(Integer.valueOf(item.getChiffre3()), nouvCompta);
                nouvCompta.add(item);
            }

            double totalAntCred = item.getAnterieurCredit();
            double totalAntDeb = item.getAnterieurDebit();

            this.setAnterieurCredit(this.getAnterieurCredit() + totalAntCred);
            this.setAnterieurDebit(this.getAnterieurDebit() + totalAntDeb);
            this.setMouvementCredit(this.getMouvementCredit() + item.getMouvementCredit());
            this.setMouvementDebit(this.getMouvementDebit() + item.getMouvementDebit());
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
    public String makeLigne() {
        String retour = "";
       

        for (Map.Entry<Integer, ComptaEtatBalanceChiffre3> entry : this.getBalances().entrySet()) {
            ComptaEtatBalanceChiffre3 balance = entry.getValue();
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
      
        return retour ;
    }

    public ArrayList<ComptaEtatBalanceChiffre2PDF> makeLignePDF(){
        ArrayList<ComptaEtatBalanceChiffre2PDF> retour = new ArrayList<>();
        for (Map.Entry<Integer, ComptaEtatBalanceChiffre3> entry : this.getBalances().entrySet()) {
            ComptaEtatBalanceChiffre3 balance = entry.getValue();
            retour.addAll(balance.makeLignePDF()) ;
        }
        ComptaEtatBalanceChiffre2PDF ligne=new ComptaEtatBalanceChiffre2PDF("   ","SOUS-TOTAUX " + comptePrefix,getAnterieurDebit(),getAnterieurCredit(),getMouvementDebit(),getMouvementCredit(),getSoldeDebit(),getSoldeCredit());
        retour.add(ligne);
        return retour;
    }

    @Override
    public String getTuppleID() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getTuppleID'");
    }

    @Override
    public String getAttributIDName() {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'getAttributIDName'");
    }
}
