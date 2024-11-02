/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import avoir.AvoirFC;
import avoir.AvoirFCLib;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import client.Client;
import constante.ConstanteEtat;

import faturefournisseur.FactureFournisseur;
import faturefournisseur.Fournisseur;

import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.ArrayList;

import mg.cnaps.compta.ComptaEcriture;
import mg.cnaps.compta.ComptaSousEcriture;
import pertegain.PerteGainImprevueLib;
import pertegain.Tiers;
import prevision.MvtCaissePrevision;
import prevision.Prevision;
import prevision.PrevisionComplet;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utils.ConstanteStation;
import vente.Vente;
import vente.VenteLib;

/**
 * @author nouta
 */
public class MvtCaisse extends ClassEtat {
    private String id, designation, idCaisse, idVenteDetail, idVirement, idOp, idOrigine, idTiers;
    protected String idDevise;
    private double debit, credit, taux;
    private Date daty;
    private String idPrevision;
    private String compte;

    @Override
    public boolean isSynchro() {
        return true;
    }

    public MvtCaisse() {
        super.setNomTable( "MOUVEMENTCAISSE" );
    }

    public MvtCaisse( AvoirFC avoirFC )
            throws Exception {
        super.setNomTable( "MOUVEMENTCAISSE" );

        this.setDesignation( "Mvt decaissement pour l'avoir : " + avoirFC.getId() );
        this.setIdCaisse( ConstanteStation.idCaisse );
        this.setIdDevise( "AR" );
        this.setTaux( 1 );
        this.setEtat( 1 );
        this.setIdOrigine( avoirFC.getId() );
        this.setDaty( avoirFC.getDaty() );
        this.setCredit( 0 );
        this.setDebit( avoirFC.getMontant() );
        this.setIdTiers( avoirFC.getIdClient() );
    }

    public MvtCaisse( Vente vente, Connection conn )
            throws Exception {
        super.setNomTable( "MOUVEMENTCAISSE" );

        this.setDesignation( "Mvt encaissement pour la vente : " + vente.getId() );
        this.setIdCaisse( ConstanteStation.idCaisse );
        this.setIdDevise( "AR" );
        this.setTaux( 1 );
        this.setEtat( 1 );
        this.setIdOrigine( vente.getId() );
        this.setDaty( vente.getDaty() );

        this.setDebit( 0 );
        double montantCredit = vente.getMontantTTC( conn );
        this.setCredit( montantCredit );
    }

    public void insertEtValidation( String refUser, Connection conn )
            throws Exception {
        this.createObject( refUser, conn );
        System.out.println( "Insert MvtCaisse\n" );
        this.validerObject( refUser, conn );
        System.out.println( "Validation mvt caisse\n" );
    }

    public void construirePK( Connection c )
            throws Exception {
        this.preparePk( "MTC", "GETSEQMOUVEMENTCAISSE" );
        this.setId( makePK( c ) );
    }

    public String getId() {
        return id;
    }

    public void setId( String id ) {
        this.id = id;
    }

    public String getIdOp() {
        return idOp;
    }

    public void setIdOp( String idOp ) {
        this.idOp = idOp;
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine( String idOrigine ) {
        this.idOrigine = idOrigine;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation( String designation ) {
        this.designation = designation;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse( String idCaisse ) {
        this.idCaisse = idCaisse;
    }

    public String getIdVenteDetail() {
        return idVenteDetail;
    }

    public void setIdVenteDetail( String idVenteDetail ) {
        this.idVenteDetail = idVenteDetail;
    }

    public String getIdVirement() {
        return idVirement;
    }

    public void setIdVirement( String idVirement ) {
        this.idVirement = idVirement;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit( double debit ) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit( double credit ) {
        this.credit = credit;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty( Date daty )
            throws Exception {
        if ( this.getMode().compareTo( "modif" ) == 0 ) {
            if ( daty == null )
                throw new Exception( "Date invalide" );
        }
        this.daty = daty;
    }

    public String getIdPrevision() {
        return idPrevision;
    }

    public void setIdPrevision( String idPrevision ) {
        this.idPrevision = idPrevision;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte( String compte ) {
        this.compte = compte;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public ReportCaisse getReportCaisse( Connection c )
            throws Exception {
        boolean estOuvert = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            String apresWhere = "and idCaisse='" + this.getIdCaisse() + "'";
            ReportCaisse[] reports = ( ReportCaisse[] ) CGenUtil.rechercher( new ReportCaisse(), null, null, c, apresWhere );
            return reports.length > 0 ? reports[0] : null;
        } finally {
            if ( estOuvert ) c.close();
        }
    }

    public ClassMAPTable createObjectSF( String u, Connection c )
            throws Exception {
        return super.createObject( u, c );
    }

    @Override
    public ClassMAPTable createObject( String u, Connection conn )
            throws Exception {
        ReportCaisse report = this.getReportCaisse( conn );
//        TODO: otrany tsy mande
        if ( report != null ) {
            Caisse caisse = new Caisse();
            caisse.setId( this.getIdCaisse() );
            LocalDateTime localDateTime = this.getDaty().toLocalDate().atStartOfDay().minusDays( 1 );
            Date datehier = Date.valueOf( localDateTime.toLocalDate() );

            report.setDaty( datehier );
            report.createObject( u, conn );
            report.validerObject( u, conn );
        }
        //(u, c);
        return ( MvtCaisse ) super.createObject( u, conn );
    }

    public Prevision getPrevision( Connection c )
            throws Exception {
        Prevision prevision = new Prevision();
        Prevision[] previsions = ( Prevision[] ) CGenUtil.rechercher( prevision, null, null, c, "and ID = '" + this.getIdPrevision() + "'" );
        return previsions[ 0 ];
    }

    public PrevisionComplet getPrevision( String nomtable, Connection c )
            throws Exception {
        PrevisionComplet prevision = new PrevisionComplet();
        if ( nomtable != null && nomtable.compareToIgnoreCase( "" ) != 0 ) prevision.setNomTable( nomtable );
        prevision.setId( this.getIdPrevision() );
        PrevisionComplet[] previsions = ( PrevisionComplet[] ) CGenUtil.rechercher( prevision, null, null, c, "" );
        return previsions[ 0 ];
    }

    public boolean estMemeSens( Prevision autre ) {
        return ( this.isDepense() && autre.isDepense() ) || ( this.isRecette() && autre.isRecette() );
    }

    public MvtCaissePrevision[] attacherPrevision( PrevisionComplet[] listePrevision, String u, Connection c ) {

        ArrayList<MvtCaissePrevision> attachements = new ArrayList<>();
        double reste = this.getMontantMouvement();
        double valeur = reste;
        int i = 0;
        for ( PrevisionComplet prevision : listePrevision ) {
            if ( prevision.getEcart() > 0 && i < listePrevision.length - 1 ) {
                valeur = Math.min( reste, prevision.getEcart() );
            }
            MvtCaissePrevision attachement = new MvtCaissePrevision();
            attachement.setId1( this.getId() );
            attachement.setId2( prevision.getId() );
            attachement.setMontant( valeur, prevision );
            attachement.setEtat( this.getEtat() );
            attachement.setDevise( "AR" );
            attachement.setTaux( 1 );
            attachements.add( attachement );
            reste = Math.max( 0, reste - valeur );
            valeur = reste;
            if ( reste <= 0 ) break;

            i++;
        }
        return attachements.toArray( new MvtCaissePrevision[ attachements.size() ] );
    }

    public boolean isDepense() {
        return this.getDebit() > 0 && this.getCredit() <= 0;
    }

    public boolean isRecette() {
        if ( this.getCredit() == 0 ) return false;
        return !isDepense();
    }


    public double getMontantMouvement() {
        if ( this.isDepense() ) return this.getDebit() * this.getTaux();
        return this.getCredit() * this.getTaux();
    }


    public MvtCaisse attacherPrevision( String idPrevision, String u, Connection c )
            throws Exception {
        MvtCaisse[] mvtCaisseBase = ( MvtCaisse[] ) CGenUtil.rechercher( new MvtCaisse(), null, null, c, "and ID = '" + this.getId() + "'" );
        if ( mvtCaisseBase[ 0 ].getIdPrevision() != null ) {
            throw new Exception( "Mouvement de Caisse a déjà un Prevision" );
        }
        mvtCaisseBase[ 0 ].setIdPrevision( idPrevision );
        mvtCaisseBase[ 0 ].attacherPrevision( u, c );
        return mvtCaisseBase[ 0 ];
    }

    public MvtCaisse attacherPrevision( String u, Connection c )
            throws Exception {
        Prevision prevision = this.getPrevision( c );
        Prevision[] previsionBase = ( Prevision[] ) CGenUtil.rechercher( prevision, null, null, c, " and ( IDFACTURE = '" + prevision.getIdFacture() + "' or IDORIGINE = '" + this.getIdOrigine() + "' ) " );
        if ( previsionBase.length > 0 ) {
            throw new Exception( "la Prevision n'existe pas" );
        }
        this.updateToTableWithHisto( u, c );
        return this;
    }

    public static MvtCaisse[] getAll( String[] ids, Connection co )
            throws Exception {
        String apresWhere = " and id in (" + Utilitaire.tabToString( ids, "'", "," ) + " ) ";
        return ( MvtCaisse[] ) CGenUtil.rechercher( new MvtCaisse(), null, null, co, apresWhere );
    }

    public PrevisionComplet[] getPrevisionLie( String nomT, Connection c )
            throws Exception {
        PrevisionComplet prevision = new PrevisionComplet();
        if ( nomT != null && nomT.compareToIgnoreCase( "" ) != 0 ) prevision.setNomTable( nomT );
        //Prevision[] previsions = (Prevision[]) CGenUtil.rechercher(prevision, null, null, c, " and IDFACTURE  = '"+this.getIdOrigine()+"'");
        String apresWhere = " and IDFACTURE  = '" + this.getIdOrigine() + "' order by daty ASC";
        return ( PrevisionComplet[] ) CGenUtil.rechercher( prevision, null, null, c, apresWhere );
    }


    public MvtCaissePrevision[] attacherPrevisionAutomatique( String u, Connection c )
            throws Exception {
        new PrevisionComplet();
        //Prevision[] previsions = (Prevision[]) CGenUtil.rechercher(prevision, null, null, c, " and IDFACTURE  = '"+this.getIdOrigine()+"'");
        PrevisionComplet[] previsionComplets = this.getPrevisionLie( null, c );
        return this.attacherPrevision( previsionComplets, u, c );
    }

    public MvtCaissePrevision[] attacherPrevisionAutomatique( String[] id, String u, Connection c )
            throws Exception {
        PrevisionComplet prevision = new PrevisionComplet();
        if ( this.getEtat() <= ConstanteEtat.getEtatValider() ) throw new Exception( "Mvt Caisse non validé" );
        //Prevision[] previsions = (Prevision[]) CGenUtil.rechercher(prevision, null, null, c, " and IDFACTURE  = '"+this.getIdOrigine()+"'");
        String aWhere = Utilitaire.getAWhereIn( id, "id" );
        PrevisionComplet[] previsionComplets = ( PrevisionComplet[] ) CGenUtil.rechercher( prevision, null, null, c, aWhere + " order by daty ASC" );
        return this.attacherPrevision( previsionComplets, u, c );
    }

    @Override
    public ClassMAPTable validerObject( String u, Connection c )
            throws Exception {
        if ( this.getIdOrigine() != null && this.getIdOrigine().startsWith( "VNT" ) ) {
            VenteLib vente = getVenteLib( c );
            if ( vente.getMontantreste() < this.getCredit() )
                throw new Exception( "Le montant saisi ne doit pas etre superieur au montant reste de la facture client!" );
        } else if ( this.getIdOrigine() != null && this.getIdOrigine().startsWith( "AVRFC" ) ) {
            AvoirFCLib avoirFC = this.getAvoirFC( c );
            if ( avoirFC.getResteapayer() < this.getDebit() )
                throw new Exception( "Le montant saisi ne doit pas etre superieur au montant reste de la facture Avoir!" );
        }

        super.validerObject( u, c );
        if ( this.getIdOrigine() != null && this.getIdOrigine().compareToIgnoreCase( "" ) != 0 ) {
            MvtCaissePrevision[] lienMvtPrev = this.attacherPrevisionAutomatique( u, c );
            for ( MvtCaissePrevision mvt : lienMvtPrev ) {
                mvt.createObject( u, c );
            }
        }
        if ( this.getDebit() > 0 ) {
            genererEcritureDecaissement( u, c );
        } else if ( this.getCredit() > 0 ) {
            genererEcritureEncaissement( u, c );
        }
        return this;
    }

    public void genererEcritureDecaissement( String u, Connection c )
            throws Exception {
        ComptaEcriture mere = new ComptaEcriture();
        Date dateDuJour = utilitaire.Utilitaire.dateDuJourSql();
        int exercice = utilitaire.Utilitaire.getAnnee( daty );
        mere.setDaty( dateDuJour );
        mere.setDesignation( this.getDesignation() );
        mere.setExercice( "" + exercice );
        mere.setDateComptable( this.getDaty() );
        mere.setJournal( ConstanteStation.journalAchat );
        if ( this.getIdOrigine().startsWith( "AVRFC" ) ) {
            mere.setJournal( ConstanteStation.JOURNALVENTE );
        }
        mere.setOrigine( this.getId() );
        mere.setIdobjet( this.getId() );
        mere.createObject( u, c );
        ComptaSousEcriture[] filles = this.genererSousEcritureDecaissement( c );
        for ( ComptaSousEcriture fille : filles ) {
            fille.setIdMere( mere.getId() );
            fille.setExercice( exercice );
            fille.setDaty( this.getDaty() );
            fille.setJournal( ConstanteStation.journalAchat );

            if ( fille.getDebit() > 0 || fille.getCredit() > 0 ) fille.createObject( u, c );
        }
    }

    public ComptaSousEcriture[] genererSousEcritureDecaissement( Connection c )
            throws Exception {
        ComptaSousEcriture[] compta;
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            String compte2 = "";
            String designation2 = "";
            if ( this.getIdOrigine().startsWith( "FCF" ) ) {
                FactureFournisseur ff = getFactureFournisseur( c );
                compte2 = ff.getCompte();
                designation2 = "FF " + ff.getFournisseurlib();
                this.setCredit( this.getCredit() * ff.getTaux() );
            } else if ( this.getIdOrigine().startsWith( "PGI" ) ) {
                PerteGainImprevueLib perteGainImprevue = getPerteGainImprevue( c );
                compte2 = perteGainImprevue.getTierscompte();
                designation2 = "Perte " + perteGainImprevue.getTiers();
            } else if ( this.getIdOrigine().startsWith( "AVRFC" ) ) {
                AvoirFCLib avoir = this.getAvoirFC( c );
                compte2 = avoir.getCompte();
                designation2 = "Avoir " + avoir.getClientlib();
            }

            //this.setCompte(facturefournisseurs[0].getCompte());

            compta = new ComptaSousEcriture[ 2 ];

            compta[ 0 ] = new ComptaSousEcriture();
            compta[ 0 ].setLibellePiece( this.getDesignation() );
            compta[ 0 ].setRemarque( this.getDesignation() );
            compta[ 0 ].setCompte( getCaisse( c ).getCompte() );
            compta[ 0 ].setCredit( this.getDebit() );

            compta[ 1 ] = new ComptaSousEcriture();
            compta[ 1 ].setLibellePiece( "Decaissement " + designation2 );
            compta[ 1 ].setRemarque( "Decaissement " + designation2 );
            compta[ 1 ].setCompte( compte2 );
//            compta[i].setDebit((montantHT-retenue) * ((this.getTva()/100)));
            compta[ 1 ].setDebit( this.getDebit() );

        } finally {
            if ( canClose ) {
                c.close();
            }
        }
        return compta;
    }

    public Caisse getCaisse( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        Caisse caisse = new Caisse();
        Caisse[] caisses = ( Caisse[] ) CGenUtil.rechercher( caisse, null, null, c, " and id = '" + this.getIdCaisse() + "'" );
        if ( caisses.length > 0 ) {
            return caisses[ 0 ];
        }
        return null;
    }

    public Vente getVente( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        Vente vente = new Vente( "VENTE_MERE_MONTANT" );
        vente.setId( this.getIdOrigine() );
        Vente[] ventes = ( Vente[] ) CGenUtil.rechercher( vente, null, null, c, "" );
        if ( ventes.length > 0 ) {
            return ventes[ 0 ];
        }
        return null;
    }

    public VenteLib getVenteLib( Connection c )
            throws Exception {
        if ( c == null ) throw new Exception( "Connection non etablie" );

        VenteLib venteLib = new VenteLib();
        venteLib.setNomTable( "vente_cpl" );
        venteLib.setId( this.getIdOrigine() );

        VenteLib[] ventes = ( VenteLib[] ) CGenUtil.rechercher( venteLib, null, null, c, "" );

        return ventes.length > 0 ? ventes[ 0 ] : null;
    }

    public FactureFournisseur getFactureFournisseur( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        FactureFournisseur ff = new FactureFournisseur( "FACTUREFOURNISSEUR_MERECMPT" );
        ff.setId( this.getIdOrigine() );
        FactureFournisseur[] ffs = ( FactureFournisseur[] ) CGenUtil.rechercher( ff, null, null, c, "" );
        if ( ffs.length > 0 ) {
            return ffs[ 0 ];
        }
        return null;
    }


    public PerteGainImprevueLib getPerteGainImprevue( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        PerteGainImprevueLib pertegain = new PerteGainImprevueLib();
        pertegain.setId( this.getIdOrigine() );
        PerteGainImprevueLib[] pertegains = ( PerteGainImprevueLib[] ) CGenUtil.rechercher( pertegain, null, null, c, "" );
        if ( pertegains.length > 0 ) {
            return pertegains[ 0 ];
        }
        return null;
    }

    public AvoirFCLib getAvoirFC( Connection c )
            throws Exception {
        if ( c == null ) throw new Exception( "Connection non etablie" );

        AvoirFCLib avoir = new AvoirFCLib();
        avoir.setNomTable( "AVOIRFCLIB_CPL" );
        avoir.setId( this.getIdOrigine() );
        AvoirFCLib[] avoirs = ( AvoirFCLib[] ) CGenUtil.rechercher( avoir, null, null, c, "" );

        return avoirs.length > 0 ? avoirs[ 0 ] : null;
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
        for ( ComptaSousEcriture fille : filles ) {
            fille.setIdMere( mere.getId() );
            fille.setExercice( exercice );
            fille.setDaty( this.getDaty() );
            fille.setJournal( ConstanteStation.JOURNALVENTE );

            if ( fille.getDebit() > 0 || fille.getCredit() > 0 ) fille.createObject( u, c );
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
            String nt = new Client().getNomTable();
            if ( this.getDebit() > 0 ) nt = new Fournisseur().getNomTable();
            System.out.println( "NIM TABLEEEE " + nt );
            Tiers tr = this.getTiers( nt, c );
            if ( tr == null ) throw new Exception( "Tiers vide" );
            String compte2 = tr.getCompte();
            String designation2 = "";
            if ( this.getIdOrigine() != null && this.getIdOrigine().startsWith( "VNT" ) ) {
                Vente vente = getVente( c );

                designation2 = "Vente " + vente.getClientlib();
                this.setCredit( this.getCredit() * vente.getTauxdechange() );
            } else if ( this.getIdOrigine() != null && this.getIdOrigine().startsWith( "PGI" ) ) {
                PerteGainImprevueLib perteGainImprevue = getPerteGainImprevue( c );

                designation2 = "Gain " + perteGainImprevue.getTiers();
            }


            compta = new ComptaSousEcriture[ 2 ];
            Caisse caisse = getCaisse( c );
            compta[ 0 ] = new ComptaSousEcriture();
            compta[ 0 ].setLibellePiece( this.getDesignation() );
            compta[ 0 ].setRemarque( this.getDesignation() );
            compta[ 0 ].setCompte( caisse.getCompte() );
            compta[ 0 ].setDebit( this.getCredit() );

            compta[ 1 ] = new ComptaSousEcriture();
            compta[ 1 ].setLibellePiece( "Encaissement " + designation2 );
            compta[ 1 ].setRemarque( "Encaissement " + designation2 );
            compta[ 1 ].setCompte( compte2 );
            compta[ 1 ].setCredit( this.getCredit() );

        } finally {
            if ( canClose ) {
                c.close();
            }
        }
        return compta;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise( String idDevise )
            throws Exception {
        if ( this.getMode().compareTo( "modif" ) == 0 ) {
            if ( idDevise == null || idDevise.isEmpty() )
                throw new Exception( "Devise obligatoire" );
        }
        this.idDevise = idDevise;
    }

    public double getTaux() {
        if ( taux == 0 ) return 1;
        return taux;
    }

    public void setTaux( double taux )
            throws Exception {
        if ( this.getMode().compareTo( "modif" ) == 0 ) {
            if ( taux == 0 )
                this.taux = 1;
        }
        this.taux = taux;
    }

    public String getIdTiers() {
        return idTiers;
    }

    public Tiers getTiers( String nT, Connection c )
            throws Exception {
        Tiers crt = new Tiers();
        crt.setNomTable( nT );
        crt.setId( this.getIdTiers() );
        Tiers[] retour = ( Tiers[] ) CGenUtil.rechercher( crt, null, null, c, "" );
        if ( retour.length == 0 ) return null;
        return retour[ 0 ];
    }

    public void setIdTiers( String idTiers )
            throws Exception {
        if ( this.getMode().compareTo( "modif" ) == 0 ) {
            if ( idTiers == null || idTiers.compareToIgnoreCase( "" ) == 0 )
                throw new Exception( "Tiers obligatoire" );
        }
        this.idTiers = idTiers;
    }

    public void attacherPrevision( String[] ids, String u, Connection c )
            throws Exception {
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            MvtCaisse mvtcaisse = ( MvtCaisse ) this.getById( this.getId(), this.getNomTable(), c );
            PrevisionComplet[] previsionComplets = PrevisionComplet.getAll( ids, c );
            MvtCaissePrevision[] arrMvt = mvtcaisse.attacherPrevision( previsionComplets, u, c );
            for ( MvtCaissePrevision mvt : arrMvt ) {
                mvt.createObject( u, c );
            }
        } finally {
            if ( canClose ) c.close();
        }
    }
}
