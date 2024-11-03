package annexe.produit;

import annexe.Produit;
import bean.CGenUtil;

import javax.ejb.Stateless;

@Stateless
public class ProduitEJB implements IProduitEJB {

    @Override
    public Produit getById( String id )
            throws Exception {
        Produit mg = new Produit();
        mg.setId( id );
        Produit[] arr = ( Produit[] ) CGenUtil.rechercher( mg, null, null, "" );
        return arr[ 0 ];
    }
}
