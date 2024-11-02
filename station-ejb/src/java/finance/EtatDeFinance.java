package finance;

import finance.benefices.Benefice;
import finance.creances.Creances;
import finance.dettes.Dettes;
import org.apache.poi.ss.formula.functions.Finance;

import java.sql.Connection;
import java.util.Date;

public class EtatDeFinance {
    Dettes dettes;
    Creances creances;
    Benefice benefice;
    Date dateMin;
    Date dateMax;

    public Dettes getDettes() {
        return dettes;
    }

    public void setDettes(Connection conn) throws Exception {
        this.dettes = new Dettes();
        this.dettes.getSousEcriture(this.getDateMin(),getDateMax(),conn);
    }

    public void setDettes(Dettes dettes) {
        this.dettes = dettes;
    }

    public Creances getCreances() {
        return creances;
    }

    public void setCreances(Creances creances) {
        this.creances = creances;
    }

    public void setCreances(Connection conn) throws Exception {
        this.creances = new Creances();
        this.creances.getSousEcriture(this.getDateMin(),getDateMax(),conn);
    }

    public Benefice getBenefice() {
        return benefice;
    }

    public void setBenefice(Benefice benefice) {
        this.benefice = benefice;
    }

    public void setBenefice(Connection conn) throws Exception {
        this.benefice = new Benefice();
        this.benefice.getCompteAchat(this.getDateMin(),getDateMax(),conn);
        this.benefice.getCompteVente(this.getDateMin(),getDateMax(),conn);
        this.benefice.getSousEcriture(this.getDateMin(),getDateMax(),conn);
    }

    public Date getDateMin() {
        return dateMin;
    }

    public void setDateMin(Date dateMin) {
        this.dateMin = dateMin;
    }

    public Date getDateMax() {
        return dateMax;
    }

    public void setDateMax(Date dateMax) {
        this.dateMax = dateMax;
    }

    public EtatDeFinance(Date dateMax, Date dateMin,Connection connection) throws Exception {
        this.setDateMin(dateMin);
        this.setDateMax(dateMax);
        this.setBenefice(connection);
        this.setDettes(connection);
        this.setCreances(connection);
    }
}
