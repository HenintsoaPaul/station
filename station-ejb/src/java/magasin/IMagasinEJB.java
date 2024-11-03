package magasin;

import javax.ejb.Remote;

@Remote
public interface IMagasinEJB {

    Magasin getById( String id )
            throws Exception;
}
