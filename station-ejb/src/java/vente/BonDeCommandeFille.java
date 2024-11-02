package vente;

import bean.*;
import java.sql.Connection;

public class BonDeCommandeFille extends ClassFille {
    private String id, produit, idbc, unite;
    private double quantite;
    private double pu;
    private double montant;
    private double tva;
    private double remise;
    private double reste;
    private String idDevise;
    private double taux;

    

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) {
        this.taux = taux;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public BonDeCommandeFille() throws Exception {
        super.setNomTable("BONDECOMMANDE_CLIENT_FILLE");
        this.setNomClasseMere("vente.BonDeCommande");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("CBCF", "getseqBC_CLIENT_FILLE");
        this.setId(makePK(c));
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idbc");
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProduit() {
        return this.produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }

    public String getIdbc() {
        return this.idbc;
    }

    public void setIdbc(String idbc) throws Exception {

        this.idbc = idbc;
    }

    public double getQuantite() throws Exception {
        return this.quantite;
    }

    public void setQuantite(double quantite) throws Exception{
        if(this.getMode().equals("modif")){
            if(quantite<=0){
                throw new Exception("Une des lignes a une qte < 0");
            }
        }
        this.quantite = quantite;
    }

    public double getPu() {
        return this.pu;
    }

    public void setPu(double pu) {
        if (pu < 0) {
            this.pu = 0;
        }
        this.pu = pu;
    }

    public double getMontant() {
        return this.montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public double getTva() {
        return this.tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public String getUnite() {
        return this.unite;
    }

    public void setUnite(String unite) {
        this.unite = unite;
    }

    public double getRemise() {
        return this.remise;
    }

    public void setRemise(double remise) {
        this.remise = remise;
    }

}
