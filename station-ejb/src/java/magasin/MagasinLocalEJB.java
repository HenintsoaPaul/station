package magasin;

import javax.ejb.Local;

@Local
public interface MagasinLocalEJB {
    public void saveMagasin(Magasin magasin) throws Exception;
}
