/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package faturefournisseur;

import bean.ClassFille;
import bean.ClassMAPTable;

import java.sql.Connection;

/**
 *
 * @author nouta
 */
public class FactureFournisseurDetails extends ClassFille{
    protected String id,idFactureFournisseur,idProduit,idbcDetail, compte,idDevise;
    protected double qte,pu,tva,remises, montantTva, montantTTC, montantHT, montant,taux,montantRemise;
    protected int etat;
    protected double tauxDeChange;

    public double getMontantRemise() {
        return montantRemise;
    }

    public void setMontantRemise(double montantRemise) {
        this.montantRemise = montantRemise;
    }

    public double getTauxDeChange() {
        return tauxDeChange;
    }

    public void setTauxDeChange(double tauxDeChange)throws  Exception{
        if (this.getMode().equals("modif")) {
            if (tauxDeChange < 0) {
                throw new Exception("elle ne peut pas etre negatif");
            }
        }
        this.tauxDeChange = tauxDeChange;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise)throws Exception {
        if (this.getMode().equals("modif")) {
            if (idDevise == null) {
                this.setIdDevise("AR");
            }
        }
        this.idDevise = idDevise;
    }

    public double getTaux() {
        return taux;
    }

    public void setTaux(double taux) throws Exception{
         if (this.getMode().equals("modif")) {
            if (taux <0) {
               throw new Exception("elle ne peut pas etre negatif");
            }
        }
        this.taux = taux;
    }

    public FactureFournisseurDetails() throws Exception {
        super.setNomTable("FACTUREFOURNISSEURFILLE");
        this.setLiaisonMere("idFactureFournisseur");
        this.setNomClasseMere("faturefournisseur.FactureFournisseur");
    }
    public void construirePK(Connection c) throws Exception {
        this.preparePk("FFD", "GETSEQFACTUREFOURNISSEURFILLE");
        this.setId(makePK(c));
    }

    public String getIdFactureFournisseur() {
        return idFactureFournisseur;
    }

    public void setIdFactureFournisseur(String idFactureFournisseur) {
        this.idFactureFournisseur = idFactureFournisseur;
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

    public String getIdbcDetail() {
        return idbcDetail;
    }

    public void setIdbcDetail(String idbcDetail) {
        this.idbcDetail = idbcDetail;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) throws Exception {
        if(this.getMode().equals("modif")){
            if(qte < 1){
                throw new Exception("Veuillez verifier, presence de quantite nulle ou negative");
            }
        }
        this.qte = qte;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getRemises() {
        return remises;
    }

    public void setRemises(double remises)throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0)
        {
            if(remises>100||remises<0) throw new Exception("Remise invalide");
        }
        this.remises = remises;
    }

    public double getMontantTva() {
        return montantTva;
    }

    public void setMontantTva(double montantTva) {
        this.montantTva = montantTva;
    }

    public double getMontantTTC() {
        return montantTTC;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public double getMontantHT() {
        return montantHT;
    }

    public void setMontantHT(double montantHT) {
        this.montantHT = montantHT;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) throws Exception {
        if(this.getMode().equals("modif") && compte.isEmpty()){
            throw new Exception("Compte obligatoire pour les details");
        }
        this.compte = compte;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idFactureFournisseur");
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        super.setNomClasseMere("faturefournisseur.FactureFournisseur");
        super.controlerUpdate(c);
    }
    public double calculerTva(){
        double montantTva = (this.getPu() * this.getQte() * this.getTva()) / 100;
        this.setMontantTva(montantTva);
        return montantTva;
    }
    
    public double calculerHT(){
        double montantHT = this.getPu() * this.getQte();
        this.setMontantHT(montantHT);
        return montantHT;
    }
    
    public double calculerTTC(){
        double montantTTC = this.getMontantHT() + this.getMontantTva();
        this.setMontantTTC(montantTTC);
        return montantTTC;
    }

}
