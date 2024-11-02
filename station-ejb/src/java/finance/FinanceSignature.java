package finance;

import mg.cnaps.compta.ComptaSousEcriture;

import java.sql.Connection;
import java.util.Date;

public abstract class FinanceSignature {
    ComptaSousEcriture[] sousEcrituresDetails;
    double amount;
    public abstract ComptaSousEcriture[] getSousEcriture(Date dateMin, Date dateMax, Connection connection) throws Exception;

    public ComptaSousEcriture[] getSousEcrituresDetails() {
        return sousEcrituresDetails;
    }

    public void setSousEcrituresDetails(ComptaSousEcriture[] sousEcrituresDetails) {
        this.sousEcrituresDetails = sousEcrituresDetails;
    }

    public double sommerCredit(ComptaSousEcriture[] sousEcritures){
        double sum = 0;
        for (ComptaSousEcriture sousEcriture : sousEcritures) {
            sum += sousEcriture.getCredit();
        }
        return sum;
    }
    public double sommerDebits(ComptaSousEcriture[] sousEcritures){
        double sum = 0;
        for (ComptaSousEcriture sousEcriture : sousEcritures) {
            sum += sousEcriture.getDebit();
        }
        return sum;
    }

}
