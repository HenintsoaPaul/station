package prelevementLub;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utils.DateUtil;
import magasin.Magasin;
import utilisateurstation.UtilisateurStation;
import utilitaire.UtilDB;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;

public class PrelevementLub extends ClassMAPTable implements Serializable {

    String id, id_prelevement_anterieur;
    int quantite;
    Date daty;
    String id_magasin;
    int id_pompiste, etat;

    //    Constructors
    public PrelevementLub() {
        this.setNomTable( "PRELEVEMENT_LUBRIFIANT" );
    }

    public PrelevementLub( String id_magasin ) {
        this.setNomTable( "PRELEVEMENT_LUBRIFIANT" );

        this.setId_magasin( id_magasin );
        this.setEtat( 1 );
    }

    public PrelevementLub( int qte, String strDaty, String id_magasin, int id_pompiste )
            throws ParseException {
        this.setNomTable( "PRELEVEMENT_LUBRIFIANT" );

        this.setQuantite( qte );
        this.setDaty( strDaty );
        this.setId_magasin( id_magasin );
        this.setId_pompiste( id_pompiste );
        this.setEtat( 1 );
    }

    //    Getters n Setters
    public String getId() {
        return id;
    }

    public void setId( String id ) {
        this.id = id;
    }

    public int getQuantite() {
        return quantite;
    }

    public void setQuantite( int quantite ) {
        if ( quantite < 0 ) throw new IllegalArgumentException( "Quantite may not be negative" );
        this.quantite = quantite;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty( Date daty ) {
        this.daty = daty;
    }

    public void setDaty( String strDaty )
            throws ParseException {
        Date d = DateUtil.strToDate( strDaty );
        this.setDaty( d );
    }

    public String getId_magasin() {
        return id_magasin;
    }

    public void setId_magasin( String id_magasin ) {
        if ( id_magasin.isEmpty() ) throw new IllegalArgumentException( "id_magasin may not be empty" );
        this.id_magasin = id_magasin;
    }

    public int getId_pompiste() {
        return id_pompiste;
    }

//    public void setId_pompiste( String id_pompiste ) {
//        if ( id_pompiste.isEmpty() ) throw new IllegalArgumentException( "id_pompiste may not be empty" );
//        this.setId_pompiste( Integer.parseInt( id_pompiste ) );
//    }

    public void setId_pompiste( int id_pompiste ) {
        this.id_pompiste = id_pompiste;
    }

    public String getId_prelevement_anterieur() {
        return id_prelevement_anterieur;
    }

    public void setId_prelevement_anterieur( String id_prelevement_anterieur ) {
        this.id_prelevement_anterieur = id_prelevement_anterieur;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat( int etat ) {
        if ( etat == 1 || etat == 11 ) this.etat = etat;
        else throw new IllegalArgumentException( "etat can only be either 1 or 11" );
    }

    public PrelevementLub getPrelevementLubAnterieur( Connection connGallois )
            throws Exception {
        PrelevementLub p = new PrelevementLub( this.getId_magasin() );
        String apresWhere = " order by id desc";
        PrelevementLub[] arr = ( PrelevementLub[] ) CGenUtil.rechercher( p, null, null, connGallois, apresWhere );
        return arr.length > 0 ? arr[ 0 ] : null;
    }

    //    Controllers
    private void controlerInsert()
            throws Exception {
        if ( this.getEtat() != 1 ) throw new SQLException( "etat can only be 1 on insertion" );
        if ( this.getQuantite() < 0 ) throw new SQLException( "Quantite may not be negative" );
        if ( this.getId_magasin() == null ) throw new SQLException( "id_magasin cannot be null" );
        if ( this.getId_magasin().isEmpty() ) throw new SQLException( "id_magasin cannot be empty" );
//        if ( this.getId_pompiste() == null ) throw new SQLException( "id_pompiste cannot be null" );
//        if ( this.getId_pompiste().isEmpty() ) throw new SQLException( "id_pompiste cannot be empty" );
    }

    //    Inserts
    protected void ouverture( String refUser, Connection connGalana )
            throws Exception {
        this.createObject( refUser, connGalana );
    }

    protected void fermeture( String refUser, Connection connGalana )
            throws Exception {
        if ( this.id_prelevement_anterieur == null )
            throw new SQLException( "id_prelevement_anterieur cannot be null" );
        if ( this.id_prelevement_anterieur.isEmpty() )
            throw new SQLException( "id_prelevement_anterieur cannot be empty" );

        this.createObject( refUser, connGalana );
    }

    //    Overrides
    @Override
    public ClassMAPTable createObject( String u, Connection c )
            throws Exception {
        this.controlerInsert();
        return super.createObject( u, c );
    }

    @Override
    public void construirePK( Connection c )
            throws Exception {
        this.preparePk( "PRLUB", "get_seq_prelevement_lub" );
        this.setId( makePK( c ) );
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String toString() {
        return "PrelevementLub{" +
                "Daty='" + this.getDaty() + '\'' +
                ", Anterieur='" + this.getId_prelevement_anterieur() + '\'' +
                ", IdMagasin='" + this.getId_magasin() + '\'' +
                ", IdPompiste='" + this.getId_pompiste() + '\'' +
                ", Quantite=" + this.getQuantite() +
                '}';
    }
}
