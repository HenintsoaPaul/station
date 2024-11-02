/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import avoir.AvoirFC;
import avoir.AvoirFCFille;
import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMere;
import bean.ResultatEtSomme;

import java.sql.Connection;
import java.sql.Date;

import caisse.Caisse;
import caisse.MvtCaisse;
import client.Client;
import constante.ConstanteEtat;
import encaissement.Encaissement;
import encaissement.EncaissementDetails;

import java.sql.SQLException;

import magasin.Magasin;
import mg.cnaps.compta.ComptaEcriture;
import mg.cnaps.compta.ComptaSousEcriture;
import prevision.Prevision;
import prevision.PrevisionComplet;
import stock.MvtStock;
import stock.MvtStockFille;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utils.ConstanteEtatCustom;
import utils.ConstanteStation;

/**
 * @author Angela
 */
public class Vente extends FactureCF {
    protected String designation;
    protected String idMagasin;
    protected String remarque;
    protected String idOrigine;
    protected String idClient, clientlib;
    protected String compte;
    protected double tauxdechange;
    protected VenteDetails[] venteDetails;
    int estPrevu;


    @Override
    public boolean isSynchro() {
        return true;
    }

    public void Vente() {
        this.setNomTable( "vente" );
    }

    @Override
    public String getTiers() {
        return this.getIdClient();
    }

    @Override
    public String getSensPrev() {
        return "credit";
    }

    public Prevision genererPrevision( String u, Connection c )
            throws Exception {
        Prevision mere = new Prevision();
        Vente venteComplet = this.getVenteWithMontant( c );
        mere.setDaty( datyPrevu );
        mere.setCredit( venteComplet.getMontantttcAr() );
        mere.setIdFacture( this.id );
        mere.setIdCaisse( ConstanteStation.idCaisse );
        mere.setIdDevise( "AR" );
        mere.setDesignation( "Prevision rattachée au vente N" + this.getId() );
        return ( Prevision ) mere.createObject( u, c );
    }

    public Vente getVenteWithMontant( Connection c )
            throws Exception {
        return ( Vente ) new Vente().getById( this.getId(), "VENTE_CPL", c );
    }

    public String genererBonLivraison( String u )
            throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            c.setAutoCommit( false );
            Vente enBase = ( Vente ) this.getById( this.getId(), this.getNomTable(), c );
            VenteDetailsLib vLib = new VenteDetailsLib();
            vLib.setNomTable( "VENTE_DETAILS_RESTE" );
            VenteDetailsLib[] details = ( VenteDetailsLib[] ) CGenUtil.rechercher( vLib, null, null, c, " AND idVente='" + this.getId() + "' AND reste > 0" );
            if ( details.length > 0 ) {
                As_BondeLivraisonClient client = new As_BondeLivraisonClient();
                client.setMode( "modif" );
                client.setIdvente( this.getId() );
                client.setEtat( 1 );
                client.setIdclient( enBase.getIdClient() );
                client.setRemarque( "Livraison de la facture numero " + this.getId() );
                client.setDaty( Utilitaire.dateDuJourSql() );
                client.createObject( u, c );
                for ( VenteDetailsLib detail : details ) {
                    As_BondeLivraisonClientFille clientFille = new As_BondeLivraisonClientFille();
                    clientFille.setMode( "modif" );
                    clientFille.setProduit( detail.getIdProduit() );
                    clientFille.setUnite( detail.getIdUnite() );
                    clientFille.setQuantite( detail.getReste() );
                    clientFille.setIdventedetail( detail.getId() );
                    clientFille.setNumbl( client.getId() );
                    clientFille.createObject( u, c );
                }
                c.commit();
                return client.getId();
            }
            throw new Exception( "Plus aucun article à livrer" );
        } catch ( Exception e ) {
            if ( c != null ) c.rollback();
            throw e;
        } finally {
            if ( c != null ) c.close();
        }
    }

    public String getCompte() {
        return compte;
    }


    public void setCompte( String compte ) {
        this.compte = compte;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient( String idClient )
            throws Exception {
        if ( this.getMode().compareTo( "modif" ) == 0 ) {
            if ( idClient == null || idClient.compareToIgnoreCase( "" ) == 0 )
                throw new Exception( "Client obligatoire" );
        }
        this.idClient = idClient;
    }

    public Vente() {
        this.setNomTable( "VENTE" );
    }

    public Vente( String nomtable ) {
        setNomTable( nomtable );
    }

    public int getEstPrevu() {
        return estPrevu;
    }

    public void setEstPrevu( int estPrevu ) {
        this.estPrevu = estPrevu;
    }


    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin( String idMagasin ) {
        this.idMagasin = idMagasin;
    }


    public boolean isPaye() {
        if ( this.getEtat() == ConstanteEtatCustom.PAYE_LIVRE || this.getEtat() == ConstanteEtatCustom.PAYE_NON_LIVRE ) {
            return true;
        }
        return false;
    }

    public boolean isLivre() {
        if ( this.getEtat() == ConstanteEtatCustom.LIVRE_NON_PAYE || this.getEtat() == ConstanteEtatCustom.PAYE_LIVRE ) {
            return true;
        }
        return false;
    }


    public String getClientlib() {
        return clientlib;
    }

    public void setClientlib( String clientlib ) {
        this.clientlib = clientlib;
    }

    public double getTauxdechange() {
        return tauxdechange;
    }

    public void setTauxdechange( double tauxdechange ) {
        this.tauxdechange = tauxdechange;
    }

    public void payer( String u, Connection c )
            throws Exception {
        if ( this.getEtat() < ConstanteEtat.getEtatValider() ) {
            throw new Exception( "Impossible d encaisser une vente non validée" );
        }
        if ( isLivre() ) {
            this.updateEtat( ConstanteEtatCustom.PAYE_LIVRE, this.getId(), c );
        } else {
            this.updateEtat( ConstanteEtatCustom.PAYE_NON_LIVRE, this.getId(), c );
        }
        genererEcritureEncaissement( u, c );
    }

    public void livrer( String u, Connection c )
            throws Exception {
        if ( this.getEtat() < ConstanteEtat.getEtatValider() ) {
            throw new Exception( "Impossible de livrer une vente non validée" );
        }
        if ( isPaye() ) {
            this.updateEtat( ConstanteEtatCustom.PAYE_LIVRE, this.getId(), c );
        } else {
            this.updateEtat( ConstanteEtatCustom.LIVRE_NON_PAYE, this.getId(), c );
        }
    }

    public void lierLivraisons( String u, String[] idLivraison )
            throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            VenteDetails[] venteDetails = getVenteDetails( c );
            As_BondeLivraisonClient[] blcs = As_BondeLivraisonClient.getAll( idLivraison, c );
            As_BondeLivraisonClient.controlerClient( blcs );
            for ( As_BondeLivraisonClient blcTemp : blcs ) {
                blcTemp.setIdvente( this.getId() );
                blcTemp.updateToTableWithHisto( u, c );
                As_BondeLivraisonClientFille[] blcfs = ( As_BondeLivraisonClientFille[] ) CGenUtil.rechercher( new As_BondeLivraisonClientFille(), null, null, c, " and NUMBL = '" + blcTemp.getId() + "'" );
                for ( int i = 0; i < venteDetails.length; i++ ) {
                    for ( As_BondeLivraisonClientFille as_BondeLivraisonClientFilleTemp : blcfs ) {
                        if ( venteDetails[ i ].getIdProduit().equals( as_BondeLivraisonClientFilleTemp.getProduit() ) ) {
                            as_BondeLivraisonClientFilleTemp.setIdventedetail( venteDetails[ i ].getId() );
                            as_BondeLivraisonClientFilleTemp.updateToTableWithHisto( u, c );
                        }
                    }
                }
            }

        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( c != null ) {
                c.close();
            }
        }
    }

    @Override
    public void changeState( String acte, String u, Connection con )
            throws Exception {
        if ( acte.equals( "livrer" ) ) {
            this.livrer( u, con );
        } else if ( acte.equals( "payer" ) ) {
            this.payer( u, con );
        }
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque( String remarque ) {
        this.remarque = remarque;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine( String idOrigine ) {
        this.idOrigine = idOrigine;
    }


    @Override
    public void construirePK( Connection c )
            throws Exception {
        this.preparePk( "VNT", "getSeqVente" );
        this.setId( makePK( c ) );
    }

    public Caisse getCaisse( Connection c )
            throws Exception {
        Caisse caisse = new Caisse();
        Caisse[] caisses = ( Caisse[] ) CGenUtil.rechercher( caisse, null, null, c, " and idMagasin = '" + this.getIdMagasin() + "'" );
        if ( caisses.length > 0 ) {
            return caisses[ 0 ];
        }
        return null;
    }

    public Magasin getMagasin( Connection c )
            throws Exception {
        Magasin magasin = new Magasin();
        magasin.setId( this.getIdMagasin() );
        Magasin[] magasins = ( Magasin[] ) CGenUtil.rechercher( magasin, null, null, c, " " );
        if ( magasins.length > 0 ) {
            return magasins[ 0 ];
        }
        return null;
    }

    public VenteDetails[] getVenteDetails() {
        return venteDetails;
    }

    public void setVenteDetails( VenteDetails[] venteDetails ) {
        this.venteDetails = venteDetails;
    }

    @Override
    public void controler( Connection c )
            throws Exception {
        super.controler( c );
    }

    @Override
    public void controlerUpdate( Connection c )
            throws Exception {
        super.controlerUpdate( c );

    }

    public void createMvtCaisses( String u, Connection c )
            throws Exception {
        VenteDetailsCpl vdc = new VenteDetailsCpl();
        vdc.setIdVente( this.getId() );
        VenteDetailsCpl[] vdcs = ( VenteDetailsCpl[] ) CGenUtil.rechercher( vdc, null, null, c, " " );
        for ( int i = 0; i < vdcs.length; i++ ) {
            MvtCaisse mc = vdcs[ i ].createMvtCaisse();
            mc.createObject( u, c );
        }
    }

    public VenteDetailsLib[] getVenteDetails( Connection c )
            throws Exception {
        VenteDetailsLib obj = new VenteDetailsLib();
        obj.setNomTable( "VENTE_DETAILS_CPL" );
        obj.setIdVente( this.getId() );
        VenteDetailsLib[] objs = ( VenteDetailsLib[] ) CGenUtil.rechercher( obj, null, null, c, " " );
        if ( objs.length > 0 ) {
            return objs;
        }
        return null;
    }

    protected EncaissementDetails[] generateDetailsEncaissements( Connection c )
            throws Exception {
        VenteDetailsLib[] vd = this.getVenteDetails( c );
        EncaissementDetails[] ed = new EncaissementDetails[ vd.length ];
        for ( int i = 0; i < ed.length; i++ ) {
            ed[ i ] = vd[ i ].generateEncaissementDetails();
        }
        return ed;
    }

    @Override
    public Object payerObject( String u, Connection con )
            throws Exception {
        super.payerObject( u, con );
        Encaissement enc = this.genererEncaissement();
        enc = ( Encaissement ) enc.createObject( u, con );
        EncaissementDetails[] ed = generateDetailsEncaissements( con );
        for ( int i = 0; i < ed.length; i++ ) {
            ed[ i ].setIdEncaissement( enc.getId() );
            ed[ i ].createObject( u, con );
        }
        return enc;
    }


    protected MvtStockFille[] createMvtStockFilles( Connection c )
            throws Exception {
        VenteDetails[] tsd = this.getVenteDetails( c );
        MvtStockFille[] mvtf = new MvtStockFille[ tsd.length ];
        for ( int i = 0; i < tsd.length; i++ ) {
            mvtf[ i ] = tsd[ i ].createMvtStockFille();
        }
        return mvtf;
    }

    protected MvtStock createMvtStock()
            throws Exception {
        MvtStock md = new MvtStock();
        md.setDaty( this.getDaty() );
        md.setDesignation( "Vente lubrifiant : " + this.getDesignation() );
        md.setIdTransfert( this.getId() );
        md.setIdTypeMvStock( ConstanteStation.TYPEMVTSTOCKSORTIE );
        md.setIdMagasin( this.getIdMagasin() );
        return md;
    }

    protected MvtStock createMvtStockSortie( String u, Connection c )
            throws Exception {
        MvtStock ms = this.createMvtStock();
        ms.setFille( this.createMvtStockFilles( c ) );
        ms.createObject( u, c );
        ms.saveMvtStockFille( u, c );
        ms.validerObject( u, c );
        return ms;
    }

    @Override
    public Object validerObject( String u, Connection c )
            throws Exception {
        boolean estOuvert = false;
        try {
            if ( c == null ) {
                estOuvert = true;
                c = new UtilDB().GetConn();
                c.setAutoCommit( false );
            }
            //CheckEtatStockVenteDetails(c);
            super.validerObject( u, c );
            genererEcriture( u, c );
            //createMvtStockSortie(u, c);
//            if(this.getEstPrevu() == 0||this.getDatyPrevu()!=null){
//                genererPrevision(u, c);
//            }
            return this;

        } catch ( Exception e ) {
            if ( c != null ) {
                c.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            if ( c != null && estOuvert == true ) {
                c.close();
            }
        }
    }

    public void CheckEtatStockVenteDetails( Connection c )
            throws Exception {
        VenteDetailsLib[] vds = getVenteDetails( c );
        if ( vds != null ) {
            for ( VenteDetailsLib v : vds ) {
                v.CheckEtatStock( c );
            }
        }

    }

    public void genererEcritureEncaissement( String u, Connection c )
            throws Exception {
        ComptaEcriture mere = new ComptaEcriture();
        Date dateDuJour = utilitaire.Utilitaire.dateDuJourSql();
        int exercice = utilitaire.Utilitaire.getAnnee( daty );
        mere.setDaty( dateDuJour );
        mere.setDesignation( this.getDesignation() );
        mere.setExercice( "" + exercice );
        mere.setDateComptable( this.getDaty() );
        mere.setJournal( ConstanteStation.JOURNALVENTE );
        mere.setOrigine( this.getId() );
        mere.setIdobjet( this.getId() );
        mere.createObject( u, c );
        ComptaSousEcriture[] filles = this.genererSousEcritureEncaissement( u, c );
        for ( int i = 0; i < filles.length; i++ ) {
            filles[ i ].setIdMere( mere.getId() );
            filles[ i ].setExercice( exercice );
            filles[ i ].setDaty( this.getDaty() );
            filles[ i ].setJournal( ConstanteStation.JOURNALVENTE );

            if ( filles[ i ].getDebit() > 0 || filles[ i ].getCredit() > 0 ) filles[ i ].createObject( u, c );
        }
    }

    public ComptaSousEcriture[] genererSousEcritureEncaissement( String refUser, Connection c )
            throws Exception {
        ComptaSousEcriture[] compta = {};
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            Vente[] ventes = ( Vente[] ) CGenUtil.rechercher( new Vente( "VENTE_MERE_MONTANT" ), null, null, c, " and id = '" + this.getId() + "'" );
            if ( ventes.length < 1 ) throw new Exception( "Facture mere Introuvable" );
            this.setCompte( getClient( c ).getCompte() );

            compta = new ComptaSousEcriture[ 2 ];

            compta[ 0 ] = new ComptaSousEcriture();
            compta[ 0 ].setLibellePiece( this.getDesignation() );
            compta[ 0 ].setRemarque( this.getDesignation() );
            compta[ 0 ].setCompte( getCaisse( c ).getCompte() );
            compta[ 0 ].setDebit( ventes[ 0 ].getMontantttc() );
            MvtCaisse mvt = new MvtCaisse();
            mvt.setCredit( ventes[ 0 ].getMontantttc() );
            mvt.setIdCaisse( getCaisse( c ).getId() );
            mvt.setDaty( utilitaire.Utilitaire.dateDuJourSql() );
            mvt.setDesignation( "mvt pour" + this.getDesignation() );
            mvt.setIdOrigine( this.getId() );
            mvt.createObject( refUser, c );
            mvt.validerObject( refUser, c );

            compta[ 1 ] = new ComptaSousEcriture();
            compta[ 1 ].setLibellePiece( "Encaissement Client " + ventes[ 0 ].getClientlib() );
            compta[ 1 ].setRemarque( "Encaissement Client " + ventes[ 0 ].getClientlib() );
            compta[ 1 ].setCompte( this.getCompte() );
//            compta[i].setDebit((montantHT-retenue) * ((this.getTva()/100)));
            compta[ 1 ].setCredit( ventes[ 0 ].getMontantttc() );

        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( canClose ) {
                c.close();
            }
        }
        return compta;
    }

    public void genererEcriture( String u, Connection c )
            throws Exception {
        ComptaEcriture mere = new ComptaEcriture();
        Date dateDuJour = utilitaire.Utilitaire.dateDuJourSql();
        int exercice = utilitaire.Utilitaire.getAnnee( daty );
        mere.setDaty( dateDuJour );
        mere.setDesignation( this.getDesignation() );
        mere.setExercice( "" + exercice );
        mere.setDateComptable( this.getDaty() );
        mere.setJournal( ConstanteStation.JOURNALVENTE );
        mere.setOrigine( this.getId() );
        mere.setIdobjet( this.getId() );
        mere.createObject( u, c );

        ComptaSousEcriture[] filles = this.genererSousEcriture( c );
        for ( int i = 0; i < filles.length; i++ ) {
            filles[ i ].setIdMere( mere.getId() );
            filles[ i ].setExercice( exercice );
            filles[ i ].setDaty( this.getDaty() );
            filles[ i ].setJournal( ConstanteStation.JOURNALVENTE );

            if ( filles[ i ].getDebit() > 0 || filles[ i ].getCredit() > 0 ) filles[ i ].createObject( u, c );
        }
    }

    public Client getClient( Connection c )
            throws Exception {
        Client client = new Client();
        Client[] clients = ( Client[] ) CGenUtil.rechercher( client, null, null, c, " and id = '" + this.getIdClient() + "'" );
        if ( clients.length > 0 ) {
            return clients[ 0 ];
        }
        throw new Exception( "Le client n'existe pas" );
    }

    public ComptaSousEcriture[] genererSousEcriture( Connection c )
            throws Exception {
        ComptaSousEcriture[] compta = {};
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            Vente[] ventes = ( Vente[] ) CGenUtil.rechercher( new Vente( "VENTE_MERE_MONTANT" ), null, null, c, " and id = '" + this.getId() + "'" );
            if ( ventes.length < 1 ) throw new Exception( "Facture mere Introuvable" );
            this.setCompte( getClient( c ).getCompte() );
            VenteDetails[] details = this.getDetails( c );
            double montantHT = AdminGen.calculSommeDouble( details, "montantHT" ) * details[ 0 ].getTauxDeChange();
            double montantTva = AdminGen.calculSommeDouble( details, "montantTva" ) * details[ 0 ].getTauxDeChange();
            double montantTTC = AdminGen.calculSommeDouble( details, "montantTTC" ) * details[ 0 ].getTauxDeChange();
            int taille = details.length;
            compta = new ComptaSousEcriture[ taille + 2 ];
            int i = 0;
            for ( i = i; i < taille; i++ ) {
                compta[ i ] = new ComptaSousEcriture();
                compta[ i ].setLibellePiece( this.getDesignation() );
                compta[ i ].setRemarque( details[ i ].getLibelle() );
                compta[ i ].setCompte( details[ i ].getCompte() );
                compta[ i ].setCredit( details[ i ].getMontantHT() * details[ i ].getTauxDeChange() );
            }

            compta[ i ] = new ComptaSousEcriture();
            compta[ i ].setLibellePiece( "TVA Collectee" );
            compta[ i ].setRemarque( "TVA Collectee" );
            compta[ i ].setCompte( ConstanteStation.compteTVACollecte );
//            compta[i].setDebit((montantHT-retenue) * ((this.getTva()/100)));
            compta[ i ].setCredit( montantTva );
            i++;

            compta[ i ] = new ComptaSousEcriture();
            compta[ i ].setLibellePiece( "Vente Client " + ventes[ 0 ].getClientlib() );
            compta[ i ].setRemarque( "Vente Client " + ventes[ 0 ].getClientlib() );
            compta[ i ].setCompte( this.getCompte() );
            compta[ i ].setDebit( montantTTC );
        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( canClose ) {
                c.close();
            }
        }
        return compta;
    }


    public VenteDetails[] getDetails( Connection c )
            throws Exception {
        VenteDetails[] venteDetails = null;
        try {
            String awhere = " and IDVENTE = '" + this.getId() + "'";
            venteDetails = ( VenteDetails[] ) CGenUtil.rechercher( new VenteDetails( "VENTE_GRP_VISER" ), null, null, c, awhere );
        } catch ( Exception e ) {
            e.printStackTrace();
            throw e;
        }
        return venteDetails;
    }


    public Encaissement genererEncaissement() {
        Encaissement enc = new Encaissement();
        enc.setIdOrigine( this.getId() );
        enc.setDaty( utilitaire.Utilitaire.dateDuJourSql() );
        enc.setDesignation( "Encaissement vente du " + this.getDaty() + " de la facture numéro " + this.getId() );
        enc.setIdTypeEncaissement( ConstanteStation.TYPE_ENCAISSEMENT_ENTREE );
        return enc;
    }

    public void genererAPartirLivraison( String[] ids, String u, Connection c )
            throws Exception {
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            As_BondeLivraisonClient[] bls = As_BondeLivraisonClient.getAll( ids, c );
            As_BondeLivraisonClient.controlerClient( bls );

            this.setDesignation( "Facturation de Bon de Livraison" );
            this.setIdClient( bls[ 0 ].getIdclient() );
            this.setIdMagasin( bls[ 0 ].getMagasin() );
            this.setDaty( Utilitaire.dateDuJourSql() );
            this.createObject( u, c );
            for ( As_BondeLivraisonClient bl : bls ) {
                bl.setIdvente( this.getId() );
                bl.updateToTableWithHisto( u, c );
            }
            As_BondeLivraisonClientFille blf = new As_BondeLivraisonClientFille();
            String[] somGr = { "quantite" };
            String[] gr = { "produit" };
            String[] tabvide = {};
            ResultatEtSomme rs = CGenUtil.rechercherGroupe( blf, gr, somGr, null, null, " and numbl in " + Utilitaire.tabToString( ids, "'", "," ), tabvide, "", c );
            As_BondeLivraisonClientFille[] blfs = ( As_BondeLivraisonClientFille[] ) rs.getResultat();
            for ( As_BondeLivraisonClientFille item : blfs ) {
                VenteDetails vd = item.toVenteDetails();
                vd.setIdVente( this.getId() );
                vd.setIdDevise( "AR" );
                vd.createObject( u, c );
            }
        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( canClose ) {
                c.close();
            }
        }
    }

    public static AvoirFC genererAvoir( String u, Connection c, String idVente )
            throws SQLException, Exception {
        AvoirFC avoirFC = null;
        boolean estOuvert = false;
        if ( c == null ) {
            c = new UtilDB().GetConn();
            estOuvert = true;
            c.setAutoCommit( false );
        }
        try {

            Vente vente = Vente.getById( c, idVente );
            vente.getVenteDetailsNonGrp( c );

            int tailleFilles = vente.venteDetails.length;
            avoirFC = Vente.transformerFactureToAvoir( vente );
            avoirFC.createObject( u, c );
            AvoirFCFille[] avoirFCFilles = new AvoirFCFille[ tailleFilles ];
            for ( int i = 0; i < tailleFilles; i++ ) {
                avoirFCFilles[ i ] = Vente.transformerFactureToAvoirFille( vente.venteDetails[ i ] );
                avoirFCFilles[ i ].setIdAvoirFC( avoirFC.getId() );
                avoirFCFilles[ i ].createObject( u, c );
            }
            avoirFC.setAvoirDetails( avoirFCFilles );
            c.commit();
        } catch ( Exception e ) {
            if ( estOuvert ) c.rollback();
            throw e;
        } finally {
            if ( estOuvert ) c.close();
        }

        return avoirFC;
    }

    public static AvoirFC transformerFactureToAvoir( Vente vente ) {
        AvoirFC valeur = new AvoirFC();
        valeur.setDesignation( vente.getDesignation() );
        valeur.setIdMagasin( vente.getIdMagasin() );
        valeur.setRemarque( vente.getRemarque() );
        valeur.setIdOrigine( vente.getIdOrigine() );
        valeur.setIdClient( vente.getIdClient() );
        valeur.setIdVente( vente.getId() );
        valeur.setCompte( vente.getCompte() );
        valeur.setDaty( vente.getDaty() );
        valeur.setEtat( 1 );
        return valeur;
    }

    public static AvoirFCFille transformerFactureToAvoirFille( VenteDetails venteDetails )
            throws Exception {
        AvoirFCFille valeur = new AvoirFCFille();
//        valeur.setIdAvoirFC(venteDetails.get());
        valeur.setIdProduit( venteDetails.getIdProduit() );
        valeur.setIdOrigine( venteDetails.getIdOrigine() );
        valeur.setQte( 1 );
        valeur.setPu( 0 );
        valeur.setTva( venteDetails.getTva() );
        valeur.setPuAchat( 0 );
        valeur.setPuVente( 0 );
        valeur.setIdDevise( venteDetails.getIdDevise() );
        valeur.setTauxDeChange( venteDetails.getTauxDeChange() );
        valeur.setDesignation( venteDetails.getDesignation() );
        valeur.setIdVenteDetails( venteDetails.getId() );
        valeur.setEtat( 1 );
        return valeur;
    }

    public static Vente getById( Connection c, String id )
            throws Exception {
        Vente vtn = new Vente();
        try {
            vtn.setId( id );
            vtn = ( ( Vente[] ) CGenUtil.rechercher( vtn, null, null, c, "" ) ).length > 0 ? ( Vente ) ( ( Vente[] ) CGenUtil.rechercher( vtn, null, null, c, "" ) )[ 0 ] : null;
        } catch ( Exception e ) {
            e.printStackTrace();
            throw e;
        }
        return vtn;
    }

    public VenteDetails[] getVenteDetailsNonGrp( Connection c )
            throws Exception {
        VenteDetails[] venteDetails = null;
        try {
            String awhere = " and IDVENTE = '" + this.getId() + "'";
            venteDetails = ( VenteDetails[] ) CGenUtil.rechercher( new VenteDetails(), null, null, c, awhere );
            this.setVenteDetails( venteDetails );
        } catch ( Exception e ) {
            e.printStackTrace();
            throw e;
        }
        return venteDetails;
    }

    public Prevision[] getPrevisions( Connection c )
            throws Exception {
        Boolean estOuvert = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            Prevision prevision = new Prevision();
            prevision.setIdFacture( this.getId() );
            Prevision[] prev = ( Prevision[] ) CGenUtil.rechercher( prevision, null, null, c, " " );
            return prev;
        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( estOuvert ) c.close();
        }
    }

    public Vente getByIdOrigine( String idPrelevement, Connection connection )
            throws Exception {
        return ( ( Vente[] ) CGenUtil.rechercher( new Vente(), null, null, connection, " and idOrigine='" + idPrelevement + "'" ) )[ 0 ];
    }

}
