package prelevementLub;

import utilitaire.UtilDB;
import utils.EJBGetter;
import vente.Vente;
import venteLubrifiant.henin.MyPrelevementLub;

import javax.ejb.Stateless;
import java.sql.Connection;

@Stateless
public class PrelevementLubEJB implements IPrelevementLubEJB {

    @Override
    public void reglerPrelevementLub( MyPrelevementLub myPrelevementLub )
            throws Exception {
        Connection connGallois = null;
        try {
            connGallois = new UtilDB().GetConn();
            connGallois.setAutoCommit( false );

            String refUser = "1060";
            PrelevementLub prlv = myPrelevementLub.creerPrelevementLub(),
                    prlvAnterieur = prlv.getPrelevementLubAnterieur( connGallois );

            if ( prlvAnterieur == null ) {
                prlv.ouverture( refUser, connGallois );
                System.out.println( "Ouverture prelevement \n" );
            } else {
                if ( prlvAnterieur.getId_prelevement_anterieur() == null ) {
                    prlv.setId_prelevement_anterieur( prlvAnterieur.getId() );
                    prlv.fermeture( refUser, connGallois );
                    System.out.println( "Fermeture prelevement \n" );

                    int quantiteVendu = prlvAnterieur.getQuantite() - prlv.getQuantite();
                    if ( quantiteVendu < 0 ) {
                        throw new Exception( "QuantiteVendu must be > 0" );
                    }

                    if ( quantiteVendu == 0 ) {
                        throw new Exception( "Pas de vente car qte vendu est 0" );
                    } else {
                        System.out.println( "Debut vente de la fermeture \n" );
                        Vente vente = myPrelevementLub.creerVente( quantiteVendu );
                        vente.setIdOrigine( prlv.getId() );

                        EJBGetter.getLubrifiantEJB().reglerVente( vente );
                    }
                } else {
                    prlv.ouverture( refUser, connGallois );
                    System.out.println( "Ouverture prelevement \n" );
                }
            }

            connGallois.commit();
        } catch ( Exception e ) {
            e.printStackTrace();
            if ( connGallois != null ) connGallois.rollback();
            throw e;
        } finally {
            if ( connGallois != null ) connGallois.close();
        }
    }
}
