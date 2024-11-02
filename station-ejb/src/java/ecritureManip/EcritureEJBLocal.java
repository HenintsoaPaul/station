package ecritureManip;

import javax.ejb.Local;
import java.sql.Date;
import java.sql.SQLException;

@Local
public interface EcritureEJBLocal {
    public double getBenefice(Date dateMin,Date dateMax) throws SQLException;
    public double[] getDettesEtCreances(Date dateMin,Date dateMax) throws SQLException;
}
