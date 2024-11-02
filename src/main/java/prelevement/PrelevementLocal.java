package prelevement;

import javax.ejb.Local;
import java.sql.Connection;

@Local
public interface PrelevementLocal {
    public void generateAndPersistVenteRemote(Prelevement prelevement, String user, Connection connection) throws Exception;
}
