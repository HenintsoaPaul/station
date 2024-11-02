package venteLubrifiant;

import annexe.Produit;
import bean.CGenUtil;
import caisse.MvtCaisse;
import magasin.Magasin;
import prelevement.Prelevement;
import stock.EtatStock;
import stock.MvtStock;
import utilitaire.UtilDB;
import utils.ConstanteStation;
import vente.As_BondeLivraisonClient;
import vente.Vente;

import javax.ejb.Stateless;
import java.sql.Connection;
import java.sql.SQLException;

@Stateless
public class LubrifiantEJB implements ILubrifiantEJB {

    @Override
    public Produit[] getAllProduit()
            throws Exception {
        String sql = "SELECT * FROM produit WHERE idTypeProduit = '" + ConstanteStation.TypeLubrifiant + "'";
        return ( Produit[] ) CGenUtil.rechercher( new Produit(), sql );
    }

    @Override
    public Magasin[] getAllBoutik()
            throws Exception {
        String sql = "SELECT * FROM v_magasin_lubrifiant";
        return ( Magasin[] ) CGenUtil.rechercher( new Magasin(), sql );
    }

    /**
     * Creer un {@code BonDeLivraison}  a partir de {@code vente}. Faire un insert, puis valider.
     * Creer un {@code MvtStock}  a partir de {@code BonDeLivraison}. Faire un insert, puis valider.
     */
    private MvtStock doMvtStock( Vente vente, String refUser, Connection conn )
            throws Exception {
        As_BondeLivraisonClient blc = vente.genererBonLivraison( refUser, conn );
        System.out.println( "Insert BondeLivraisonClient\n" );
        blc.validerObject( refUser, conn );
        System.out.println( "Validation BondeLivraisonClient\n" );

        MvtStock mvtStock = blc.genererMvtStockPersist( refUser, conn );
        System.out.println( "Insert MvtStock done\n" );
        mvtStock.validerObject( refUser, conn );
        System.out.println( "Valider MvtStock + filles" );

        return mvtStock;
    }

    /**
     * Creer un {@code MvtCaisse}  a partir de {@code vente}. Faire un insert, puis valider.
     */
    private MvtCaisse doMvtCaisse( Vente vente, String refUser, Connection conn )
            throws Exception {
        MvtCaisse mvtCaisse = new MvtCaisse( vente, conn );
        mvtCaisse.setIdTiers( vente.getIdClient() );
        mvtCaisse.insertEtValidation( refUser, conn );

        return mvtCaisse;
    }

    @Override
    public void reglerVente( Vente vente )
            throws SQLException {
        String refUser = "1060";
        Connection connGallois = null;
        try {
            connGallois = new UtilDB().GetConn( "gallois", "gallois" );
            connGallois.setAutoCommit( false );

            vente.insertEtValidation( refUser, connGallois );

            doMvtStock( vente, refUser, connGallois );

            MvtCaisse mvtCaisse = doMvtCaisse( vente, refUser, connGallois );

//            TODO: Insertion VenteLubrifiant
//            VenteLubrifiant vLub = creerVenteLubrifiant( vente, mvtCaisse.getid );
//            vLub.createObject( refUser, connGallois );
//            vLub.validerObject( refUser, connGallois );

            connGallois.commit();
        } catch ( Exception e ) {
            if ( connGallois != null ) connGallois.rollback();
            throw new RuntimeException( e );
        } finally {
            if ( connGallois != null ) connGallois.close();
        }
    }

    @Override
    public void reglerPrelevement( Prelevement prelevement ) {
        // todo:
    }

    @Override
    public EtatStock[] getEtatStock()
            throws Exception {
        EtatStock es = new EtatStock();
        es.setIdTypeProduit( ConstanteStation.TypeLubrifiant );
        return ( EtatStock[] ) CGenUtil.rechercher( es, null, null, "" );
    }
}
