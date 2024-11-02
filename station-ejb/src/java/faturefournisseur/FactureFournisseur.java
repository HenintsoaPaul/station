/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ResultatEtSomme;
import caisse.Caisse;

import java.sql.Connection;
import java.sql.Date;

import mg.cnaps.compta.ComptaEcriture;
import mg.cnaps.compta.ComptaSousEcriture;
import prevision.Prevision;
import user.UserEJB;
import user.UserEJBClient;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utils.ConstanteStation;

/**
 * @author nouta
 */
public class FactureFournisseur extends vente.FactureCF {
    protected String idFournisseur, idModePaiement, reference, idBc, idMagasin, fournisseurlib;
    protected Date dateEcheancePaiement;
    protected String devise;
    protected double taux;
    protected String idDevise;
    protected String compte;
    int estPrevu;

    @Override
    public String getSensPrev() {
        return "debit";
    }

    @Override
    public String getTiers() {
        return this.idFournisseur;
    }

    public int getEstPrevu() {
        return estPrevu;
    }

    public int isEstPrevu() {
        return estPrevu;
    }

    public void setEstPrevu( int estPrevu ) {
        this.estPrevu = estPrevu;
    }


    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise( String idDevise ) {
        this.idDevise = idDevise;
    }

    public FactureFournisseur( String nomtable ) {
        setNomTable( nomtable );
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin( String idMagasin ) {
        this.idMagasin = idMagasin;
    }

    public String getDevise() {
        return devise;
    }

    public void setDevise( String devise ) {
        this.devise = devise;
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux( double taux ) {
        this.taux = taux;
    }

    public FactureFournisseur() {
        super.setNomTable( "FACTUREFOURNISSEUR" );
    }

    public void construirePK( Connection c )
            throws Exception {
        this.preparePk( "FCF", "GETSEQFACTUREFOURNISSEUR" );
        System.out.println( "my new pk" );
        this.setId( makePK( c ) );
    }


    public String getIdFournisseur() {
        return idFournisseur;
    }

    public void setIdFournisseur( String idFournisseur ) {
        this.idFournisseur = idFournisseur;
    }

    public String getIdModePaiement() {
        return idModePaiement;
    }

    public void setIdModePaiement( String idModePaiement ) {
        this.idModePaiement = idModePaiement;
    }


    public String getReference() {
        return reference;
    }

    public void setReference( String reference ) {
        this.reference = reference;
    }

    public String getIdBc() {
        return idBc;
    }

    public void setIdBc( String idBc ) {
        this.idBc = idBc;
    }


    public Date getDateEcheancePaiement() {
        return dateEcheancePaiement;
    }

    public void setDateEcheancePaiement( Date dateEcheancePaiement ) {
        this.dateEcheancePaiement = dateEcheancePaiement;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte( String compte ) {
        this.compte = compte;
    }

    public String getFournisseurlib() {
        return fournisseurlib;
    }

    public void setFournisseurlib( String fournisseurlib ) {
        this.fournisseurlib = fournisseurlib;
    }


    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }


    public void generateAndPersistFF( FactureFournisseur factureFournisseur, FactureFournisseurDetails[] filles, Connection c )
            throws Exception {
        boolean estOuvert = false;
        UserEJB userEJBBean = UserEJBClient.lookupUserEJBBeanLocal();
        try {
            if ( c == null ) {
                estOuvert = true;
                c = new UtilDB().GetConn( "gallois", "gallois" );
                c.setAutoCommit( false );
            }

//            userEJBBean.createObjectMultipleGallois( factureFournisseur, "idFactureFournisseur", filles, c );
            System.out.println( "Générer la facture" );
            if ( estOuvert ) c.commit();
        } catch ( Exception e ) {
            if ( c != null ) c.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            if ( c != null && estOuvert == true ) c.close();
        }
    }


    public Prevision genererPrevision( String u, Connection c )
            throws Exception {
        Prevision mere = new Prevision();
        FactureFournisseur factureWithMontant = getFactureWithMontant( c );
        mere.setDaty( getDatyPrevu() );
        mere.setDebit( factureWithMontant.getMontantttcAr() );
        mere.setIdFacture( this.id );
        mere.setIdCaisse( ConstanteStation.idCaisse );
        mere.setDesignation( "Prevision rattachée au FF N" + this.getId() );
        mere.setIdDevise( "AR" );
        System.out.println( "GET ID DEVISE:" + mere.getIdDevise() );
        return ( Prevision ) mere.createObject( u, c );
    }

    public FactureFournisseur getFactureWithMontant( Connection c )
            throws Exception {

        return ( FactureFournisseur ) new FactureFournisseur().getById( this.getId(), "FACTUREFOURNISSEURCPL", c );
    }

    public void genererEcritureDecaissement( String u, Connection c )
            throws Exception {
        ComptaEcriture mere = new ComptaEcriture();
        Date dateDuJour = utilitaire.Utilitaire.dateDuJourSql();
        int exercice = utilitaire.Utilitaire.getAnnee( getDaty() );
        mere.setDaty( dateDuJour );
        mere.setDesignation( this.getDesignation() );
        mere.setExercice( "" + exercice );
        mere.setDateComptable( this.getDaty() );
        mere.setJournal( ConstanteStation.journalAchat );
        mere.setOrigine( this.getId() );
        mere.setIdobjet( this.getId() );
        mere.createObject( u, c );
        ComptaSousEcriture[] filles = this.genererSousEcritureDecaissement( c );
        for ( int i = 0; i < filles.length; i++ ) {
            filles[ i ].setIdMere( mere.getId() );
            filles[ i ].setExercice( exercice );
            filles[ i ].setDaty( this.getDaty() );
            filles[ i ].setJournal( ConstanteStation.JOURNALVENTE );

            if ( filles[ i ].getDebit() > 0 || filles[ i ].getCredit() > 0 ) filles[ i ].createObject( u, c );
        }
    }

    public ComptaSousEcriture[] genererSousEcritureDecaissement( Connection c )
            throws Exception {
        ComptaSousEcriture[] compta = {};
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            FactureFournisseur[] facturefournisseurs = ( FactureFournisseur[] ) CGenUtil.rechercher( new FactureFournisseur( "FACTUREFOURNISSEUR_MERECMPT" ), null, null, c, " and id = '" + this.getId() + "'" );
            if ( facturefournisseurs.length < 1 ) throw new Exception( "Facture mere Introuvable" );
            this.setCompte( facturefournisseurs[ 0 ].getCompte() );

            compta = new ComptaSousEcriture[ 2 ];

            compta[ 0 ] = new ComptaSousEcriture();
            compta[ 0 ].setLibellePiece( this.getDesignation() );
            compta[ 0 ].setRemarque( this.getDesignation() );
            compta[ 0 ].setCompte( getCaisse( c ).getCompte() );
            compta[ 0 ].setCredit( facturefournisseurs[ 0 ].getMontantttc() );

            compta[ 1 ] = new ComptaSousEcriture();
            compta[ 1 ].setLibellePiece( "Decaissement fournisseur " + facturefournisseurs[ 0 ].getFournisseurlib() );
            compta[ 1 ].setRemarque( "Decaissement fournisseur " + facturefournisseurs[ 0 ].getFournisseurlib() );
            compta[ 1 ].setCompte( this.getCompte() );
//            compta[i].setDebit((montantHT-retenue) * ((this.getTva()/100)));
            compta[ 1 ].setDebit( facturefournisseurs[ 0 ].getMontantttc() );

        } catch ( Exception e ) {
            throw e;
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
        Caisse[] caisses = ( Caisse[] ) CGenUtil.rechercher( caisse, null, null, c, " and idMagasin = '" + this.getIdMagasin() + "'" );
        if ( caisses.length > 0 ) {
            return caisses[ 0 ];
        }
        return null;
    }

    public Fournisseur getFournisseur( Connection c )
            throws Exception {
        Fournisseur crt = new Fournisseur();
        crt.setId( this.getIdFournisseur() );
        Fournisseur[] liste = ( Fournisseur[] ) CGenUtil.rechercher( crt, null, null, c, "" );
        if ( liste.length == 0 ) return null;
        return liste[ 0 ];
    }

    public void genererEcriture( String u, Connection c )
            throws Exception {
        Date dateDuJour = Utilitaire.dateDuJourSql();
        int exercice = this.getDaty().getYear() + 1900;
        ComptaEcriture mere = new ComptaEcriture();
        //System.out.println("Daty "+this.getDaty().getYear()+" designation "+this.getDesignation()+" id "+this.getId());
        mere.setDaty( this.getDaty() );
        mere.setDesignation( "Ecriture liee a la facture " + this.getDesignation() + " ref : " + this.getId() );
        mere.setExercice( "" + exercice );
        mere.setDateComptable( this.getDaty() );
        mere.setJournal( ConstanteStation.journalAchat );
        mere.setIdobjet( this.getId() );
        mere.setOrigine( this.getId() );
        mere.createObject( u, c );
        ComptaSousEcriture[] filles = this.genererSousEcriture( c );
        for ( int i = 0; i < filles.length; i++ ) {
            filles[ i ].setIdMere( mere.getId() );
            filles[ i ].setExercice( exercice );
            filles[ i ].setDaty( this.getDaty() );
            filles[ i ].setJournal( ConstanteStation.journalAchat );
            filles[ i ].createObject( u, c );
        }
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
            //FactureFournisseur[] facturefournisseur = (FactureFournisseur[]) CGenUtil.rechercher(new FactureFournisseur("FACTUREFOURNISSEUR_MERECMPT"), null, null, c, " and id = '"+this.getId()+"'");
            //if(facturefournisseur.length<1) throw new Exception("Facture Fournisseur mère Introuvable");
            FactureFournisseurDetails details[] = this.getDetails( c );
            //this.setCompte(facturefournisseur[0].getCompte());
            double montantTva = AdminGen.calculSommeDouble( details, "montantTva" ) * details[ 0 ].getTauxDeChange();
            double montantHT = AdminGen.calculSommeDouble( details, "montantHT" ) * details[ 0 ].getTauxDeChange();
            double montantTTC = AdminGen.calculSommeDouble( details, "montantTTC" ) * details[ 0 ].getTauxDeChange();
            int taille = details.length;
            compta = new ComptaSousEcriture[ taille + ( montantTva > 0 ? 2 : 1 ) ];
            int i = 0;
            for ( i = i; i < taille; i++ ) {

                compta[ i ] = new ComptaSousEcriture();
                compta[ i ].setLibellePiece( this.getDesignation() );
                compta[ i ].setRemarque( this.getDesignation() );
                compta[ i ].setCompte( details[ i ].getCompte() );
                compta[ i ].setDebit( details[ i ].getMontantHT() * details[ 0 ].getTauxDeChange() );
            }
            if ( montantTva > 0 ) {
                compta[ i ] = new ComptaSousEcriture();
                compta[ i ].setLibellePiece( "TVA Deductible" );
                compta[ i ].setRemarque( "TVA Deductible" );
                compta[ i ].setCompte( ConstanteStation.compteTVADeductible );
                //            compta[i].setDebit((montantHT-retenue) * ((this.getTva()/100)));
                compta[ i ].setDebit( montantTva * details[ 0 ].getTauxDeChange() );
                i++;
            }

            Fournisseur fo = this.getFournisseur( c );
            compta[ i ] = new ComptaSousEcriture();
            compta[ i ].setLibellePiece( "Achat Fournisseur " + fo.getNom() );
            compta[ i ].setRemarque( "Achat Fournisseur " + fo.getNom() );
            compta[ i ].setCompte( fo.getCompte() );
            compta[ i ].setCredit( montantTTC );

        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( canClose ) {
                c.close();
            }

        }
        return compta;
    }

    public FactureFournisseurDetails[] getDetails( Connection c )
            throws Exception {
        FactureFournisseurDetails[] ffdetails = null;
        try {
            FactureFournisseurDetails details = new FactureFournisseurDetails();
            details.setNomTable( "FACTUREFOURNISSEUR_FILLE_VISE" );
            String awhere = " and IDFACTUREFOURNISSEUR = '" + this.getId() + "'";
            ffdetails = ( FactureFournisseurDetails[] ) CGenUtil.rechercher( details, null, null, c, awhere );
        } catch ( Exception e ) {
            e.printStackTrace();
        }
        return ffdetails;
    }

    @Override
    public Object validerObject( String u, Connection c )
            throws Exception {
        super.validerObject( u, c );
        genererEcriture( u, c );
        if ( estPrevu == 0 && this.getDatyPrevu() != null ) {
            genererPrevision( u, c );
        }
        return this;
    }


    public FactureFournisseurCpl getFactureFournisseurCpl( Connection c )
            throws Exception {
        if ( c == null ) {
            throw new Exception( "Connection non etablie" );
        }
        FactureFournisseurCpl fact = new FactureFournisseurCpl();
        fact.setNomTable( "FACTUREFOURNISSEURCPL_MONTANT" );
        fact.setId( this.getId() );
        FactureFournisseurCpl[] epts = ( FactureFournisseurCpl[] ) CGenUtil.rechercher( fact, null, null, c, " " );
        if ( epts.length > 0 ) {
            return epts[ 0 ];
        }
        return null;
    }

    public String genererLivraison( String u, Connection c )
            throws Exception {
        boolean estOuvert = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }

            FactureFournisseur ff = ( FactureFournisseur ) this.getById( this.getId(), this.getNomTable(), c );
            //  CGenUtil.rechercher(f,null,null,c,"");
            return ff.genererBL( u, c ).getId();
        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( estOuvert ) c.close();
        }
    }

    private As_BonDeLivraison genererBL( String u, Connection c )
            throws Exception {
        boolean estOuvert = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                estOuvert = true;
            }
            As_BonDeLivraison bl = createBL();
            bl = ( As_BonDeLivraison ) bl.createObject( u, c );
            generateBLFille( bl, c, u );
            System.out.println( "B onL ivraison" );
            return bl;
        } catch ( Exception e ) {
            throw e;
        } finally {
            if ( estOuvert ) c.close();
        }
    }

    @Override
    public ClassMAPTable createObject( String u, Connection c )
            throws Exception {
        //this.setTaux(((FactureFournisseurDetails[])this.getFille())[0].getTaux());
        return super.createObject( u, c );
    }

    private void generateBLFille( As_BonDeLivraison bl, Connection c, String u )
            throws Exception {
        FactureFournisseurDetailResteALivrerLib[] details = getDetailsResteALivrer( c, "FFFILLERESTEALIVRER" );
        for ( FactureFournisseurDetailResteALivrerLib d : details ) {
            As_BonDeLivraison_Fille blf = d.createBLFille( bl.getId() );
            blf.createObject( u, c );
        }
    }

    public FactureFournisseurDetailResteALivrerLib[] getDetailsResteALivrer( Connection c, String nomtable )
            throws Exception {
        FactureFournisseurDetailResteALivrerLib[] ffdetails = null;

        if ( nomtable == null ) {
            nomtable = "FFFILLERESTEALIVRERLIB";
        }

        FactureFournisseurDetailResteALivrerLib details = new FactureFournisseurDetailResteALivrerLib();
        details.setNomTable( nomtable );
        ffdetails = ( FactureFournisseurDetailResteALivrerLib[] ) CGenUtil.rechercher( details, null, null, c, " and idfacturefournisseur = '" + this.getId() + "' and qte > 0" );
        if ( ffdetails.length == 0 ) {
            throw new Exception( "Aucune livraison possible" );
        }
        for ( int i = 0; i < ffdetails.length; i++ ) {
            ffdetails[ i ].calculerTva();
            ffdetails[ i ].calculerHT();
            ffdetails[ i ].calculerTTC();
        }

        return ffdetails;
    }

    public As_BonDeLivraison createBL()
            throws Exception {
        As_BonDeLivraison bl = new As_BonDeLivraison();
        bl.setDaty( Utilitaire.dateDuJourSql() );
        bl.setIdbc( this.getId() );
        bl.setMagasin( this.getIdMagasin() );
        return bl;
    }

    public FactureFournisseurDetailsCpl[] getFactureFournisseurDetails( Connection c )
            throws Exception {
        System.out.println( "FOURNISSEUR DETAIKLLLLLLSSSS" );
        FactureFournisseurDetailsCpl obj = new FactureFournisseurDetailsCpl();
        obj.setNomTable( "FACTUREFOURNISSEURFILLECPL" );
        obj.setIdFactureFournisseur( this.getId() );
        FactureFournisseurDetailsCpl[] objs = ( FactureFournisseurDetailsCpl[] ) CGenUtil.rechercher( obj, null, null, c, " " );
        if ( objs.length > 0 ) {
            return objs;
        }
        return null;
    }

    public void genererAPartirLivraison( String[] ids, String u, Connection c )
            throws Exception {
        boolean canClose = false;
        try {
            if ( c == null ) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            As_BonDeLivraison[] bls = As_BonDeLivraison.getAll( ids, c );
            As_BonDeLivraison.controlerFournisseur( bls );

            this.setDesignation( "Facturation de Bon de Livraison" );
            this.setIdFournisseur( bls[ 0 ].getIdFournisseur() );
            this.setIdMagasin( bls[ 0 ].getMagasin() );
            this.setDaty( Utilitaire.dateDuJourSql() );
            this.setIdDevise( "AR" );
            this.createObject( u, c );
            for ( As_BonDeLivraison bl : bls ) {
                bl.setIdFactureFournisseur( this.getId() );
                bl.setEtat( 1 );
                bl.updateToTableWithHisto( u, c );
            }
            As_BonDeLivraison_Fille blf = new As_BonDeLivraison_Fille();
            String[] somGr = { "quantite" };
            String[] gr = { "produit" };
            String[] tabvide = {};
            ResultatEtSomme rs = CGenUtil.rechercherGroupe( blf, gr, somGr, null, null,
                    " and numbl in " + Utilitaire.tabToString( ids, "'", "," ), tabvide, "", c );
            As_BonDeLivraison_Fille[] blfs = ( As_BonDeLivraison_Fille[] ) rs.getResultat();
            for ( As_BonDeLivraison_Fille item : blfs ) {
                FactureFournisseurDetails vd = item.toFactureFournisseurDetails();
                vd.setIdFactureFournisseur( this.getId() );
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

    public void lierLivraisons( String u, String[] idLivraison )
            throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            FactureFournisseurDetails[] factDetails = getFactureFournisseurDetails( c );
            As_BonDeLivraison[] blcs = As_BonDeLivraison.getAll( idLivraison, c );
            As_BonDeLivraison.controlerFournisseur( blcs );
            for ( As_BonDeLivraison blcTemp : blcs ) {
                blcTemp.setIdFactureFournisseur( this.getId() );
                blcTemp.updateToTableWithHisto( u, c );
                As_BonDeLivraison_Fille[] blcfs = ( As_BonDeLivraison_Fille[] ) CGenUtil.rechercher( new As_BonDeLivraison_Fille(), null, null, c, " and NUMBL = '" + blcTemp.getId() + "'" );
                for ( int i = 0; i < factDetails.length; i++ ) {
                    for ( As_BonDeLivraison_Fille as_BonDeLivraisonFilleTemp : blcfs ) {
                        if ( factDetails[ i ].getIdProduit().equals( as_BonDeLivraisonFilleTemp.getProduit() ) ) {
                            as_BonDeLivraisonFilleTemp.setIdFactureFournisseur( factDetails[ i ].getId() );
                            as_BonDeLivraisonFilleTemp.updateToTableWithHisto( u, c );
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

}
