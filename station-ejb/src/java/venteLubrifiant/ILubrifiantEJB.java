package venteLubrifiant;

import annexe.Produit;
import magasin.Magasin;
import stock.EtatStock;
import vente.Vente;

import javax.ejb.Remote;
import java.sql.SQLException;

@Remote
public interface ILubrifiantEJB {
    Produit[] getAllProduit()
            throws Exception;

    Magasin[] getAllBoutik()
            throws Exception;

    void reglerVente( Vente vente )
            throws SQLException;

    EtatStock[] getEtatStock()
            throws Exception;
}
