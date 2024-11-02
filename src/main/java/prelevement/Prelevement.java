/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prelevement;


import bean.CGenUtil;

import static bean.CGenUtil.rechercherPage;

import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.ResultatEtSomme;
import caisse.Caisse;

import java.sql.Connection;
import java.sql.Date;

import magasin.Magasin;
import pompe.Pompe;
import user.MyUserEjbBean;
import user.UserEJB;
import user.UserEJBBean;
import user.UserEJBClient;
import utilitaire.UtilDB;
import vente.Vente;
import vente.VenteDetails;

/**
 * @author SAFIDY
 */
public class Prelevement extends ClassEtat {

    private String id;
    private String idPrelevementAnterieur;
    private double compteur;
    private Date daty;
    private String heure;
    private int idPompiste;
    private String idPompe;
    private int etat;
    protected PrelevementCpl prelevementAnterieur;
    protected String designation;

    public Prelevement() {
        this.setNomTable( "PRELEVEMENT" );
    }

    public String getId() {
        return id;
    }

    public void setId( String id ) {
        this.id = id;
    }

    public String getIdPrelevementAnterieur() {
        return idPrelevementAnterieur;
    }

    public void setIdPrelevementAnterieur( String idPrelevementAnterieur ) {
        this.idPrelevementAnterieur = idPrelevementAnterieur;
    }

    public double getCompteur() {
        return compteur;
    }

    public void setCompteur( double compteur ) {
        this.compteur = compteur;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty( Date daty ) {
        this.daty = daty;
    }

    public String getHeure() {
        return heure;
    }

    public void setHeure( String heure ) {
        this.heure = heure;
    }

    public int getIdPompiste() {
        return idPompiste;
    }

    public void setIdPompiste( int idPompiste ) {
        this.idPompiste = idPompiste;
    }

    public String getIdPompe() {
        return idPompe;
    }

    public void setIdPompe( String idPompe ) {

        this.idPompe = idPompe;
    }

    public void setIdPompe( String idPompe, Connection connection ) {

        this.idPompe = idPompe;
    }

    public void createPompe( String idPompe, String idCuve, String nom, Connection connection )
            throws Exception {
        Pompe pompe = new Pompe();
        pompe.setId( idPompe );
        pompe.setVal( nom );
        pompe.setDesce( "" );
        pompe.setMax( 10000 );
        pompe.setIdMagasin( idCuve );
        CGenUtil.save( pompe, connection );
    }

    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public Caisse getCaisse( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        Caisse caisse = new Caisse();
        Caisse[] caisses = ( Caisse[] ) CGenUtil.rechercher( caisse, null, null, c, " " );
        if ( caisses.length > 0 ) {
            return caisses[ 0 ];
        }
        return null;
    }

    protected void controllerPoint( Connection c )
            throws Exception {
        if ( !getMagasin( c ).getIdPoint().equals( getCaisse( c ).getIdPoint() ) ) {
            throw new Exception( "Les points de Magasin et Caisse ne sont pas les mêmes." );
        }
    }

    @Override
    public void controler( Connection c )
            throws Exception {
        super.controler( c );
        controllerPoint( c );
    }

    public Pompe getPompe( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        Pompe pompe = new Pompe();
        pompe.setId( this.getIdPompe() );
        Pompe[] pompes = ( Pompe[] ) CGenUtil.rechercher( pompe, null, null, c, " " );
        if ( pompes.length > 0 ) {
            return pompes[ 0 ];
        }
        return null;
    }

    public Magasin getMagasin( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        Magasin magasin = new Magasin();
        Pompe p = getPompe( c );
        magasin.setId( p.getIdMagasin() );
        Magasin[] magasins = ( Magasin[] ) CGenUtil.rechercher( magasin, null, null, c, " " );
        if ( magasins.length > 0 ) {
            return magasins[ 0 ];
        }
        return null;
    }

    @Override
    public void construirePK( Connection c )
            throws Exception {
        this.preparePk( "PRL", "getSeqPrelevement" );
        this.setId( makePK( c ) );
    }

    public PrelevementCpl getPrelevement( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        PrelevementCpl p = new PrelevementCpl();
        p.setId( this.getId() );
        PrelevementCpl[] ps = ( PrelevementCpl[] ) CGenUtil.rechercher( p, null, null, c, " " );
        if ( ps.length > 0 ) {
            return ps[ 0 ];
        }
        return null;
    }

    public PrelevementCpl getPrelevementAnterieur() {
        return prelevementAnterieur;
    }

    public void setPrelevementAnterieur( PrelevementCpl prelevementAnterieur ) {
        this.prelevementAnterieur = prelevementAnterieur;
    }

    protected void setIdPrelevementAnterieur( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        PrelevementCpl p = new PrelevementCpl();
        p.setIdPompe( this.getIdPompe() );
        ResultatEtSomme rs = rechercherPage( p, null, null, 1, "AND daty IS NOT NULL order by daty desc  ", null, c, 1 );
        PrelevementLib[] pr = ( PrelevementLib[] ) rs.getResultat();
        if ( pr.length > 0 ) {
            this.setIdPrelevementAnterieur( pr[ 0 ].getId() );
        }
    }

    public PrelevementCpl getPrelevementAnterieur( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        if ( this.getPrelevementAnterieur() == null ) {
            if ( this.getIdPrelevementAnterieur() != null ) {
                PrelevementCpl p = new PrelevementCpl();
                p.setId( this.getIdPrelevementAnterieur() );
                PrelevementCpl[] pr = ( PrelevementCpl[] ) CGenUtil.rechercher( p, null, null, c, " " );
                if ( pr.length > 0 ) {
                    this.setPrelevementAnterieur( pr[ 0 ] );
                }
            }
        }
        return this.getPrelevementAnterieur();
    }

    @Override
    public ClassMAPTable createObject( String u, Connection c )
            throws Exception {
        this.setIdPrelevementAnterieur( c );
        return super.createObject( u, c );
    }

    protected Vente generateVente( Connection c )
            throws Exception {
        PrelevementCpl pc = this.getPrelevementAnterieur( c );
        Vente v = new Vente();
        v.setDaty( this.getDaty() );
        v.setIdMagasin( pc.getIdMagasin() );
        v.setDesignation( "vente apres prelevement du " + this.getDaty() );
        System.out.println( "THE ID ORIGINE:" + this.getId() );
        v.setIdOrigine( this.getId() );
        return v;
    }

    protected double getQuantiteVendue( Connection c )
            throws Exception {
        double quantite = 0;
        PrelevementCpl pc = this.getPrelevementAnterieur( c );
        if ( this.getCompteur() > pc.getCompteur() ) {
            quantite = this.getCompteur() - pc.getCompteur();
        } else {
            quantite = pc.getMaxPompe() - pc.getCompteur() + this.getCompteur();
        }
        return quantite;
    }

    protected VenteDetails generateVenteDetails( Connection c )
            throws Exception {
        VenteDetails vd = new VenteDetails();
        PrelevementCpl pc = this.getPrelevementAnterieur( c );
        vd.setIdProduit( pc.getIdProduit() );
        vd.setPu( pc.getPuVente() );
        vd.setQte( getQuantiteVendue( c ) );
        vd.setIdOrigine( this.getId() );
        vd.setCompte( "707032" );
        return vd;
    }

    //    protected void generateAndPersistVente(String u, Connection c) throws Exception {
//        boolean estOuvert = false;
//        UserEJB userEJBBean = UserEJBClient.lookupUserEJBBeanLocal();
//        userEJBBean.testLogin("admin", "test", null, null);
//        try {
//            if (c == null) {
//                estOuvert = true;
//                c = new UtilDB().GetConn();
//                c.setAutoCommit(false);
//            }
//            PrelevementCpl pc = this.getPrelevementAnterieur(c);
//            if (pc != null) {
//                Vente v = this.generateVente(c);
//                v.createObject(u, c);
//                /*userEJBBean.createObject(v,c);*/
//                VenteDetails vd = this.generateVenteDetails(c);
//                vd.setIdVente(v.getId());
//                vd.createObject(u, c);
//                v.validerObject(u, c);
//                System.out.println("Générer la facture");
//            }
//        } catch (Exception e) {
//            if (c != null) {
//                c.rollback();
//            }
//            e.printStackTrace();
//            throw e;
//        } finally {
//            if (c != null && estOuvert == true) {
//                c.close();
//            }
//        }
//
//    }
    protected void generateAndPersistVente( String u, Connection c )
            throws Exception {
        boolean estOuvert = false;
        UserEJB userEJBBean = UserEJBClient.lookupUserEJBBeanLocal();
//        userEJBBean.testLoginGallois("admin","test",null,null);
        try {
            if ( c == null ) {
                estOuvert = true;
                c = new UtilDB().GetConn( "gallois", "gallois" );
                c.setAutoCommit( false );
            }
            PrelevementCpl pc = this.getPrelevementAnterieur( c );
            if ( pc == null ) System.out.println( "Prelevement antérieur est null" );
            if ( pc != null ) {
                Vente v = this.generateVente( c );

                VenteDetails vd = this.generateVenteDetails( c );
                vd.setIdVente( v.getId() );
                vd.setTauxDeChange( 1 );
                vd.setCompte( "707032" );

                VenteDetails[] details = new VenteDetails[ 1 ];
                details[ 0 ] = vd;

                userEJBBean.createObjectMultipleGallois( v, "idVente", details, c );
                System.out.println( "Générer la facture" );
            }
            if ( estOuvert ) c.commit();
        } catch ( Exception e ) {
            if ( c != null ) c.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            if ( c != null && estOuvert == true ) c.close();
        }

    }

    protected void generateAndPersistVenteForService( String u, Connection c )
            throws Exception {
        boolean estOuvert = false;
        PrelevementCpl pc = this.getPrelevementAnterieur( c );
        if ( pc != null ) {
            Vente v = this.generateVente( c );
            v.createObject( u, c );
            VenteDetails vd = this.generateVenteDetails( c );
            vd.setIdVente( v.getId() );
            vd.createObject( u, c );
            v.validerObject( u, c );
        }
    }

    @Override
    public Object validerObject( String u, Connection c )
            throws Exception {
        super.validerObject( u, c );
        PrelevementCpl prl = getPrelevement( c );
        prl.generateAndPersistVente( u, c );
        return this;
    }

    @Override
    public String getValColLibelle() {
        return this.id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation( String designation ) {
        this.designation = designation;
    }

}
