package finance.creances;

import bean.CGenUtil;
import finance.FinanceSignature;
import mg.cnaps.compta.ComptaSousEcriture;

import java.sql.Connection;
import java.util.Date;

public class Creances extends FinanceSignature {
    @Override
    public ComptaSousEcriture[] getSousEcriture(Date dateMin, Date dateMax, Connection connection) throws Exception {
        String apresWhere = " and (daty <= TO_DATE('"+dateMax.toString()+"','YYYY-MM-dd') and daty >= TO_DATE('"+dateMin.toString()+"','YYYY-MM-dd')) and compte like '411%'";
        this.setSousEcrituresDetails((ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(),null,null,connection,apresWhere));
        return this.getSousEcrituresDetails();
    }
}
