package ecritureManip;

import utilitaire.UtilDB;

import javax.ejb.Stateless;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
@Stateless
public class EcritureEJBService implements EcritureEJBLocal{
    @Override
    public double getBenefice(Date dateMin, Date dateMax) throws SQLException {
        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            EcritureSignature ecritureSignature = new EcritureService();
            return ecritureSignature.getSomme7(connection,dateMin,dateMax) - ecritureSignature.getSomme6(connection,dateMin,dateMax);
        }catch (Exception e){
            connection.rollback();
            e.printStackTrace();
        }finally {
            connection.close();
        }
        return -1;
    }

    @Override
    public double[] getDettesEtCreances(Date dateMin, Date dateMax) throws SQLException {
        Connection connection = null;
        try {
            connection = new UtilDB().GetConn();
            EcritureSignature ecritureSignature = new EcritureService();
            double[] dc = {ecritureSignature.getDettes(connection,dateMin,dateMax),ecritureSignature.getCreances(connection,dateMin,dateMax)};
            return dc;
        }catch (Exception e){
            connection.rollback();
            e.printStackTrace();
        }finally {
            connection.close();
        }
        return new double[0];
    }
}
