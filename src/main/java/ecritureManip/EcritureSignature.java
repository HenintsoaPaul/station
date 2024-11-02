package ecritureManip;

import java.sql.Connection;
import java.sql.Date;

public interface EcritureSignature {
    public Ecriture[] get6(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public double getSomme6(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public Ecriture[] get7(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public double getSomme7(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public Ecriture[] getDettesEcritures(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public double getDettes(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public Ecriture[] getCreancesEcritures(Connection connection, Date dateMin,Date dateMax) throws Exception;
    public double getCreances(Connection connection, Date dateMin,Date dateMax) throws Exception;
}
