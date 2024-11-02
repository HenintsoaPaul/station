/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package faturefournisseur;

import bean.CGenUtil;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;
import java.util.ArrayList;
import utilitaire.UtilDB;
import vente.*;
import utilitaire.Utilitaire;

/**
 *
 * @author micha
 */
public class As_BonDeCommande extends ClassMere {
    
    private String id;
    private Date daty;
    private int etat;
    private String remarque;
    private String designation;
    private String fournisseur;
    private String modepaiement;
    private String reference;
    private String modepaiementlib;
    private String fournisseurlib;
    private String idDevise;

    // private ArrayList<As_BonDeCommande_Fille> bcFilles;

    public String getModepaiementlib() {
        return modepaiementlib;
    }

    public void setModepaiementlib(String modepaiementlib) {
        this.modepaiementlib = modepaiementlib;
    }

    public String getFournisseurlib() {
        return fournisseurlib;
    }

    public void setFournisseurlib(String fournisseurlib) {
        this.fournisseurlib = fournisseurlib;
    }

    public As_BonDeCommande() {
        this.setNomTable("AS_BONDECOMMANDE");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("BC", "GETSEQBONCOMMANDE");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return this.id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return this.daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getEtat() {
        return this.etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public String getRemarque() {
        return this.remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getDesignation() {
        return Utilitaire.champNull(designation);
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getFournisseur() {
        return this.fournisseur;
    }

    public void setFournisseur(String fournisseur) throws Exception{
        if(fournisseur.compareToIgnoreCase("") == 0 || fournisseur == null)throw new Exception("Fournisseur manquant");
        this.fournisseur = fournisseur;
    }

    public String getModepaiement() {
        return Utilitaire.champNull(modepaiement);
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getReference() {
        return this.reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }
    
    // public ArrayList<As_BonDeCommande_Fille> getBcFilles() {
    //     return bcFilles;
    // }

    // public void setBcFilles(ArrayList<As_BonDeCommande_Fille> bcFilles) {
    //     this.bcFilles = bcFilles;
    // }
    @Override
    public void controler(Connection c) throws Exception
    {
        As_BonDeCommande_Fille[] bcfille = (As_BonDeCommande_Fille[]) CGenUtil.rechercher(new As_BonDeCommande_Fille(), null, null, c, "and idbc  ='" + this.getId() + "' and idDevise!='"+this.getIdDevise()+"'");
         if(bcfille.length>0){
             throw new Exception("Devise diff\\u00E9rent non accept\\u00E9");
         }
    }
            
    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }
    
    public String genererFacture(String u) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            System.out.println("Génération facture....");
            String idFacture =  genererFacture(u,c);
            c.commit();
            return idFacture;
        }
        catch(Exception e){
            if(c!=null) c.rollback();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }

    public String genererFacture(String u,Connection c) throws Exception{
        As_BonDeCommande enBase = (As_BonDeCommande)this.getById(this.getId(), this.getNomTable(), c);
        As_BonDeCommande_Fille vLib = new As_BonDeCommande_Fille();
        vLib.setNomTable("AS_BONDECOMMANDE_FILLE");
        As_BonDeCommande_Fille[] details = (As_BonDeCommande_Fille[]) CGenUtil.rechercher(vLib,null,null,c," AND idBc='"+this.getId()+"'");
        if(details.length > 0){
            Vente vente = new Vente();
            vente.setIdClient(enBase.getFournisseur());
            vente.setDesignation("Facture de la BC "+this.getId());
            vente.setDaty(Utilitaire.dateDuJourSql());
            vente.setIdOrigine(enBase.getId());
            // vente.setIdMagasin(enBase.getIdMagasin());
            vente.setEtat(1);
            vente.createObject(u, c);
            for(As_BonDeCommande_Fille detail:details){
                VenteDetails detailVente= new VenteDetails();
                detailVente.setIdOrigine(detail.getId());
                detailVente.setIdProduit(detail.getProduit());
                detailVente.setQte(detail.getQuantite());
                detailVente.setPu(detail.getPu());
                detailVente.setTva(detail.getTva());
                detailVente.setIdVente(vente.getId());
                detailVente.setIdDevise(detail.getIdDevise());
                detailVente.setTauxDeChange(detail.getTauxDeChange());
                detailVente.createObject(u, c);
            }
            return vente.getId();
        }
        throw new Exception("Plus aucun article à facturer");
    }    


    public As_BonDeLivraison createBL() throws Exception {
        As_BonDeLivraison bl = new As_BonDeLivraison();
        bl.setDaty(Utilitaire.dateDuJourSql());
        bl.setIdbc(this.getId());
        bl.setIdFournisseur(fournisseur);
        return bl;
    }

    public As_BonDeCommande_Fille[] getBCFilleResteALivrer(Connection c, String nomtable) {
        As_BonDeCommande_Fille[] bcfilles = null;
        try {
            if (c == null) {
                throw new Exception("Connexion non établie");
            }
            if (nomtable == null) {
                nomtable = "BCFILLERESTEALIVRERLIB";
            }
            As_BonDeCommande_Fille temp = new As_BonDeCommande_Fille();
            temp.setNomTable(nomtable);
            bcfilles = (As_BonDeCommande_Fille[]) CGenUtil.rechercher(temp, null, null, c, " and idbc = '" + this.getId() + "'");
            for (int i = 0; i < bcfilles.length; i++) {
                As_BonDeCommande_Fille bcfille = bcfilles[i];
                bcfille.calculerTva();
                bcfille.calculerHT();
                bcfille.calculerTTC();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return bcfilles;
    }

    private void generateBLFille(As_BonDeLivraison bl, Connection c, String u) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
                c.setAutoCommit(false);
            }
            As_BonDeCommande_Fille[] details = getBCFilleResteALivrer(c, "BCFILLERESTEALIVRERLIB");
            for (As_BonDeCommande_Fille d : details) {
                As_BonDeLivraison_Fille blf = d.createBLFille(bl.getId());
                blf.createObject(u, c);
            }
            
            if(estOuvert){
                c.commit();
            }
            
        } catch (Exception e) {
            if(estOuvert){
                c.rollback();
            }
            throw e;
        } finally {
            if (estOuvert) {
                c.close();
            }
        }
    }

    private As_BonDeLivraison genererBL(String u, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
                c.setAutoCommit(false);
            }
            As_BonDeLivraison bl = createBL();
            bl.setEtat(1);
            bl = (As_BonDeLivraison) bl.createObject(u, c);
            generateBLFille(bl, c, u);
            
            if(estOuvert){
                c.commit();
            }
            
            return bl;
        } catch (Exception e) {
            if(estOuvert){
                c.rollback();
            }
            throw e;
        } finally {
            if (estOuvert) {
                c.close();
            }
        }
    }

    public String genererLivraison(String u, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                estOuvert = true;
                c.setAutoCommit(false);
            }
            As_BonDeCommande f = new As_BonDeCommande();
            f.setId(this.getId());
            As_BonDeCommande[] ff = (As_BonDeCommande[]) CGenUtil.rechercher(f, null, null, c, "");
            String idLivraison = ff[0].genererBL(u, c).getId();
            if(estOuvert){
                c.commit();
            }
            return idLivraison;
        } catch (Exception e) {
            if(estOuvert){
                c.rollback();
            }
            throw e;
        } finally {
            if (estOuvert) {
                c.close();
            }
        }
    }
}
