package magasin;

import bean.CGenUtil;
import utils.ConstanteStation;

import javax.ejb.Stateless;

@Stateless
public class MagasinEJB implements IMagasinEJB {

    @Override
    public Magasin[] getAll()
            throws Exception {
        Magasin mg = new Magasin();
        return  ( Magasin[] ) CGenUtil.rechercher( mg, null, null, "" );
    }

    @Override
    public Magasin getById( String id )
            throws Exception {
        Magasin mg = new Magasin();
        mg.setId( id );
        Magasin[] arr = ( Magasin[] ) CGenUtil.rechercher( mg, null, null, "" );
        return arr[ 0 ];
    }

    @Override
    public Magasin[] getAllCuve()
            throws Exception {
        Magasin mg = new Magasin();
        mg.setIdTypeMagasin( ConstanteStation.idTypeReservoir );
        return  ( Magasin[] ) CGenUtil.rechercher( mg, null, null, "" );
    }

    @Override
    public Magasin[] getAllMagasinLub()
            throws Exception {
        String sql = "SELECT * FROM v_magasin_lubrifiant";
        return ( Magasin[] ) CGenUtil.rechercher( new Magasin(), sql );
    }
}
