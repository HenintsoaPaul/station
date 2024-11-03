package magasin;

import javax.ejb.Remote;

@Remote
public interface IMagasinEJB {

    Magasin[] getAll()
            throws Exception;

    Magasin getById( String id )
            throws Exception;

    Magasin[] getAllCuve()
            throws Exception;

    Magasin[] getAllMagasinLub()
            throws Exception;
}
