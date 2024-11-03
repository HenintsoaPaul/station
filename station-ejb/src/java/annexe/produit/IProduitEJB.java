package annexe.produit;

import annexe.Produit;

import javax.ejb.Remote;

@Remote
public interface IProduitEJB {

    Produit getById( String id )
            throws Exception;
}
