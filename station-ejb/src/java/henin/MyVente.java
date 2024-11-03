package henin;

import annexe.Produit;
import utils.ConstanteStation;
import utils.DateUtil;
import utils.EJBGetter;
import vente.Vente;
import vente.VenteDetails;

import java.io.Serializable;

public class MyVente implements Serializable {

    String IdProduit, IdClient, IdMagasin;
    String Daty;
    int Quantite;

    // Overrides
    public String toString() {
        return "MyVente{" +
                "Daty='" + this.getDaty() + '\'' +
                ", IdMagasin='" + this.getIdMagasin() + '\'' +
                ", IdClient='" + this.getIdClient() + '\'' +
                ", IdProduit='" + this.getIdProduit() + '\'' +
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
        vente.setIdClient( this.getIdClient() );

        return vente;
    }

    protected VenteDetails creerVenteDetails( Vente vente )
            throws Exception {
        String idProduit = this.getIdProduit();
        Produit produit = EJBGetter.getProduitEJB().getById( idProduit );

        VenteDetails vd = new VenteDetails();
        vd.setIdProduit( idProduit );
        vd.setPu( produit.getPuVente() );
        vd.setQte( this.getQuantite() );
        vd.setIdVente( vente.getId() );
        vd.setTauxDeChange( 1 );
        vd.setCompte( ConstanteStation.comptaCompteMarchandise );
        vd.setIdDevise( "AR" );
        vd.setPuAchat( produit.getPuAchat() );
        vd.setPuVente( produit.getPuVente() );
        vd.setTva( ConstanteStation.TVA_VALUE );

        return vd;
    }

    /**
     * Ajouter le {@code VenteDetails} pour l'objet {@code vente}
     */
    protected void addDetails( Vente vente )
            throws Exception {
        VenteDetails vd = this.creerVenteDetails( vente );

        VenteDetails[] arrVDetails = new VenteDetails[]{ vd };
        vente.setVenteDetails( arrVDetails );
        vente.setFille( arrVDetails );
        vente.setLiaisonFille( "idVente" );
    }

    // Getter n Setter
    protected String getIdProduit() {
        return IdProduit;
    }

    protected void setIdProduit( String idProduit ) {
        IdProduit = idProduit;
    }

    protected String getIdClient() {
        return IdClient;
    }

    protected void setIdClient( String idClient ) {
        IdClient = idClient;
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
