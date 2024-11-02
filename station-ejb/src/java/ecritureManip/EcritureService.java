package ecritureManip;

import bean.CGenUtil;

import java.sql.Connection;
import java.sql.Date;

public class EcritureService implements EcritureSignature{
    @Override
    public Ecriture[] get6(Connection connection, Date dateMin, Date dateMax) throws Exception {
        return (Ecriture[]) CGenUtil.rechercher(new Ecriture(),null,null,connection," and compte like '6%'" +
                " and daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-DD') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-DD')");
    }
    @Override
    public Ecriture[] get7(Connection connection, Date dateMin,Date dateMax) throws Exception {
        return (Ecriture[]) CGenUtil.rechercher(new Ecriture(),null,null,connection," and compte like '7%'" +
                " and daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-DD') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-DD')");
    }

    @Override
    public double getSomme6(Connection connection, Date dateMin,Date dateMax) throws Exception {
        Ecriture[] ecritures = get6(connection,dateMin,dateMax);
        double sum = 0;
        for (int i = 0; i < ecritures.length; i++) {
            sum += ecritures[i].getDebit();
        }
        return sum;
    }

    @Override
    public double getSomme7(Connection connection, Date dateMin,Date dateMax) throws Exception {
        Ecriture[] ecritures = get7(connection,dateMin,dateMax);
        double sum = 0;
        for (int i = 0; i < ecritures.length; i++) {
            sum += ecritures[i].getCredit();
        }
        return sum;
    }

    @Override
    public Ecriture[] getDettesEcritures(Connection connection, Date dateMin, Date dateMax) throws Exception {
        return (Ecriture[]) CGenUtil.rechercher(new Ecriture(),null,null,connection," and compte like '401%'" +
                " and daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-DD') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-DD')");
    }

    @Override
    public double getDettes(Connection connection, Date dateMin, Date dateMax) throws Exception {
        Ecriture[] ecritures = getDettesEcritures(connection,dateMin,dateMax);
        double sum = 0;
        for (int i = 0; i < ecritures.length; i++) {
            sum += ecritures[i].getCredit();
        }
        return sum;
    }

    @Override
    public Ecriture[] getCreancesEcritures(Connection connection, Date dateMin, Date dateMax) throws Exception {
        return (Ecriture[]) CGenUtil.rechercher(new Ecriture(),null,null,connection," and compte like '411%'" +
                " and daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-DD') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-DD')");
    }

    @Override
    public double getCreances(Connection connection, Date dateMin, Date dateMax) throws Exception {
        Ecriture[] ecritures = getDettesEcritures(connection,dateMin,dateMax);
        double sum = 0;
        for (int i = 0; i < ecritures.length; i++) {
            sum += ecritures[i].getDebit();
        }
        return sum;
    }
}
