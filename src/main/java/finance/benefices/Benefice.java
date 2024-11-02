package finance.benefices;

import bean.CGenUtil;
import finance.FinanceSignature;
import mg.cnaps.compta.ComptaSousEcriture;

import java.sql.Connection;
import java.util.Date;

public class Benefice extends FinanceSignature {
    ComptaSousEcriture[] compteAchat; //Compte 6
    ComptaSousEcriture[] compteVente; //Compte 7

    public ComptaSousEcriture[] getCompteAchat() {
        return compteAchat;
    }

    public void setCompteAchat(ComptaSousEcriture[] compteAchat) {
        this.compteAchat = compteAchat;
    }

    public ComptaSousEcriture[] getCompteVente() {
        return compteVente;
    }

    public void setCompteVente(ComptaSousEcriture[] compteVente) {
        this.compteVente = compteVente;
    }

    @Override
    public ComptaSousEcriture[] getSousEcriture(Date dateMin, Date dateMax, Connection connection) throws Exception {
        String apresWhere = " and (daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-dd') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-dd')) and (compte like '7%' or compte like'6%')";
        this.setSousEcrituresDetails((ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(),null,null,connection,apresWhere));
        return this.getSousEcrituresDetails();
    }
    public ComptaSousEcriture[] getCompteAchat(Date dateMin,Date dateMax, Connection connection) throws Exception {
        String apresWhere = " and (daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-dd') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-dd')) and (compte like'6%')";
        this.setCompteAchat((ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(),null,null,connection,apresWhere));
        System.out.println("");
        return this.getCompteAchat();
    }
    public ComptaSousEcriture[] getCompteVente(Date dateMin,Date dateMax, Connection connection) throws Exception {
        String apresWhere = " and (daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-dd') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-dd')) and (compte like'7%')";
        this.setCompteVente((ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(),null,null,connection,apresWhere));
        return this.getCompteVente();
    }
    public double getBenefMontant(){
        double achat7Debit = this.sommerDebits(this.getCompteVente());
        double achat7Credit = this.sommerCredit(this.getCompteVente());

        double achat6Debit = this.sommerDebits(this.getCompteAchat());
        double achat6Credit = this.sommerCredit(this.getCompteAchat());

        return (achat7Credit - achat7Debit) - (achat6Debit - achat6Credit);
    }
}
