package utilisateurstation;

import javax.ejb.Remote;

@Remote
public interface IUtilisateurEJB {

    UtilisateurStation[] getAll()
            throws Exception;

    UtilisateurStation[] getAllPompiste()
            throws Exception;
}
