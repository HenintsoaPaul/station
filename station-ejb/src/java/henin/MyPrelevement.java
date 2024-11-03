package henin;

import annexe.Produit;
import magasin.Magasin;
import utils.ConstanteStation;
import utils.DateUtil;
import utils.EJBGetter;
import vente.Vente;
import vente.VenteDetails;

import java.io.Serializable;

public class MyPrelevement implements Serializable {

    String IdPompiste, IdMagasin;
    String Daty;
    int Quantite;

    // Overrides
    public String toString() {
        return "MyVente{" +
                "Daty='" + this.getDaty() + '\'' +
                ", IdMagasin='" + this.getIdMagasin() + '\'' +
                ", IdPompiste='" + this.getIdPompiste() + '\'' +
                ", Quantite=" + this.getQuantite() +
                '}';
    }

    // Vente
    protected Vente creerVente()
            throws Exception {
        Vente vente = new Vente();
        vente.setDaty( DateUtil.strToDate( this.getDaty() ) );
        vente.setEstPrevu( 1 ); // La vente n'est pas prevue mais doit etre reglee maintenant
        vente.setIdMagasin( this.getIdMagasin() );
        vente.setIdClient( ConstanteStation.idClientDivers );

        return vente;
    }

    protected VenteDetails creerVenteDetails( Vente vente, int quantiteVendu )
            throws Exception {
        Magasin magasin = EJBGetter.getMagasinEJB().getById( vente.getIdMagasin() );
        Produit produit = EJBGetter.getProduitEJB().getById( magasin.getIdProduit() );

        VenteDetails vd = new VenteDetails();
        vd.setIdProduit( produit.getId() );
        vd.setPu( produit.getPuVente() );
        vd.setIdVente( vente.getId() );
        vd.setTauxDeChange( 1 );
        vd.setCompte( ConstanteStation.comptaCompteVenteLubrifiant );
        vd.setIdDevise( "AR" );
        vd.setPuAchat( produit.getPuAchat() );
        vd.setPuVente( produit.getPuVente() );
        vd.setTva( ConstanteStation.TVA_VALUE );

        vd.setQte( quantiteVendu );
        return vd;
    }

    /**
     * Ajouter le {@code VenteDetails} pour l'objet {@code vente}
     */
    protected void addDetails( Vente vente, int quantiteVendu )
            throws Exception {
        VenteDetails vd = this.creerVenteDetails( vente, quantiteVendu );

        VenteDetails[] arrVDetails = new VenteDetails[]{ vd };
        vente.setVenteDetails( arrVDetails );
        vente.setFille( arrVDetails );
        vente.setLiaisonFille( "idVente" );
    }

    // Getter n Setter
    protected String getIdPompiste() {
        return IdPompiste;
    }

    protected void setIdPompiste( String idPompiste ) {
        IdPompiste = idPompiste;
    }

    protected String getDaty() {
        return Daty;
    }

    protected void setDaty( String daty ) {
        Daty = daty;
    }

    protected int getQuantite() {
        return Quantite;
    }

    protected void setQuantite( int quantite ) {
        Quantite = quantite;
    }

    protected String getIdMagasin() {
        return IdMagasin;
    }

    protected void setIdMagasin( String idMagasin ) {
        IdMagasin = idMagasin;
    }
}
