/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package venteLubrifiant;

import annexe.Produit;
import annexe.ProduitLib;
import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import constante.ConstanteEtat;
import encaissement.EncaissementLib;
import java.sql.Connection;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import magasin.MagasinLib;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utils.ConstanteStation;
import vente.Vente;
import vente.VenteDetails;

/**
 *
 * @author CMCM
 */
public class VenteLubrifiant extends ClassFille {

    protected String id;
    protected String idProduit;
    protected double qte;
    protected double pu;
    protected double tauxRemise;
    protected String idEncaissement;
    protected String idMagasin;
    protected Date daty;
    protected String remarque;
    protected String idMagasinLib;
    EncaissementLib encaissement;
    ProduitLib produit;

    public VenteLubrifiant() {

        this.setNomTable("venteLubrifiant");
        try {
            this.setNomClasseMere("encaissement.Encaissement");
        } catch (Exception ex) {
            Logger.getLogger(VenteLubrifiant.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) {
        this.qte = qte;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getTauxRemise() {
        return tauxRemise;
    }

    public void setTauxRemise(double tauxRemise) {
        this.tauxRemise = tauxRemise;
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getIdMagasinLib() {
        return idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    }

    public EncaissementLib getEncaissement() {
        return encaissement;
    }

    public void setEncaissement(EncaissementLib encaissement) {
        this.encaissement = encaissement;
    }

    public ProduitLib getProduit() {
        return produit;
    }

    public void setProduit(ProduitLib produit) {
        this.produit = produit;
    }

    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idEncaissement");
    }

    public void checkProduit(Connection c) throws Exception {
        ProduitLib p = getProduit(c);
        if (!p.getIdTypeProduit().equalsIgnoreCase(ConstanteStation.TypeProduitLubrifiant)) {
            throw new Exception("type produit doit etre lubrifiant");
        }
    }

    protected void checkMagasin(Connection c) throws Exception {
        MagasinLib m = getMagasin(c);
        if (!m.getIdTypeMagasin().equalsIgnoreCase(ConstanteStation.idTypeMagasinIlot)) {
            throw new Exception("type magasin doit etre Ilot");
        }

    }

    public ProduitLib getProduit(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            ProduitLib produit = new ProduitLib();
            produit.setId(this.getIdProduit());
            ProduitLib[] produits = (ProduitLib[]) CGenUtil.rechercher(produit, null, null, c, " ");
            if (produits.length > 0) {
                setProduit(produits[0]);
            }
            return this.getProduit();
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    protected void setPu(Connection c) throws Exception {
        Produit produit = getProduit(c);
        this.setPu(produit.getPuVente());
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        this.setDaty(Utilitaire.dateDuJourSql());
        this.getIdMagasinLib(c);
        this.setPu(c);
        return super.createObject(u, c);
    }

    public MagasinLib getMagasin(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            MagasinLib magasin = new MagasinLib();
            magasin.setId(this.getIdMagasin());
            MagasinLib[] magasins = (MagasinLib[]) CGenUtil.rechercher(magasin, null, null, c, " ");
            if (magasins.length > 0) {
                return magasins[0];
            }
            return null;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    public String getIdMagasinLib(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            if (this.getIdMagasinLib().isEmpty()) {
                MagasinLib mag = this.getMagasin(c);
                this.setIdMagasinLib(mag.getVal());
            }
            return this.getIdMagasinLib();
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    public EncaissementLib getEncaissement(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            if (this.getEncaissement() == null) {
                EncaissementLib encaissementLib = new EncaissementLib();
                encaissementLib.setId(this.getIdEncaissement());
                EncaissementLib[] encaissementLibs = (EncaissementLib[]) CGenUtil.rechercher(encaissementLib, null, null, c, " ");
                if (encaissementLibs.length > 0) {
                    setEncaissement(encaissementLibs[0]);
                }
            }
            return this.getEncaissement();
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    protected Vente generateVente(Connection c) throws Exception {
        EncaissementLib enc = getEncaissement(c);
        Vente v = new Vente();
        String des = "Vente du " + enc.getDaty() + " par le pompiste " + enc.getIdPompisteLib() + " sur " + this.getIdMagasinLib();
        v.setDesignation(des);
        v.setRemarque(this.getRemarque());
        v.setDaty(this.getDaty());
        v.setIdMagasin(this.getIdMagasin());
        v.setIdOrigine(this.getId());
        return v;
    }

    public VenteDetails[] generateVenteDetails() throws Exception {
        VenteDetails[] detailsArray = new VenteDetails[1];
        VenteDetails det = new VenteDetails();
        det.setIdOrigine(this.getId());
        det.setIdProduit(this.getIdProduit());
        det.setQte(this.getQte());
        detailsArray[0] = det;
        return detailsArray;
    }

    protected void addVente(Connection c, String refUser) throws Exception {
        Vente v = generateVente(c);
        v = (Vente) v.createObject(refUser, c);
        VenteDetails[] vds = generateVenteDetails();
        for (VenteDetails vd : vds) {
            vd.setIdVente(v.getId());
            vd.createObject(refUser, c);
        }
        v.validerObject(refUser, c);

    }

    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c);
        checkProduit(c);
        checkMagasin(c);
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        if (this.getEtat() < ConstanteEtat.getEtatValider()) {
            super.validerObject(u, c);
            addVente(c, u);
        }
        return this;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("VTL", "GETSEQVENTELUBRIFIANT");
        this.setId(makePK(c));
    }

}
