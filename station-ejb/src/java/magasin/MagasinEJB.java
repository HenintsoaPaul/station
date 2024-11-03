package magasin;

import bean.CGenUtil;

import javax.ejb.Stateless;

@Stateless
public class MagasinEJB implements IMagasinEJB {

    @Override
    public Magasin getById( String id )
            throws Exception {
        Magasin mg = new Magasin();
        mg.setId( id );
        Magasin[] arr = ( Magasin[] ) CGenUtil.rechercher( mg, null, null, "" );
        return arr[ 0 ];
    }
}
