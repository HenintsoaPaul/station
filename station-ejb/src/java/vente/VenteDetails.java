/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import annexe.Produit;
import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import caisse.MvtCaisse;
import encaissement.EncaissementDetails;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import stock.EtatStock;
import stock.MvtStockFille;
import utilitaire.Utilitaire;

/**
 *
 * @author Angela
 */
public class VenteDetails extends ClassFille {

    private String id;
    private String idVente;
    private String idProduit;
    private String idOrigine, compte, libelle;
    private String idDevise;
    private double qte;
    private double pu;
    protected double remise;
    protected double tva;
    protected double puAchat;
    protected double puVente;
    protected double montant;
    protected int etat;
    private double montantTTC, montantTva, montantHT,montantRemise;
    private double tauxDeChange;
    private String designation;

    public double getMontantRemise() {
        return montantRemise;
    }

    public void setMontantRemise(double montantRemise) {
        this.montantRemise = montantRemise;
    }
    

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        if(this.getMode().equals("modif")){
            if(idDevise.isEmpty()){
                this.setIdDevise("MGA");
            }
        }
        this.idDevise = idDevise;
    }

    public double getTauxDeChange() {
        return tauxDeChange;
    }

    public void setTauxDeChange(double tauxDeChange) throws Exception{
        if(this.getMode().equals("modif")){
            if(tauxDeChange<0){
                throw new Exception("taux de change ne peut etre negatif");
            }
        }
        this.tauxDeChange = tauxDeChange;
    }
            
    @Override
    public boolean isSynchro(){
        return true;
    }
    
    public double getRemise() {
        return remise;
    }

    public void setRemise(double remise)throws Exception {
        if(this.getMode().compareToIgnoreCase("modif")==0)
        {
            if(remise>100||remise<0) throw new Exception("Remise invalide");
        }
        this.remise = remise;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public double getPuAchat() {
        return puAchat;
    }

    public void setPuAchat(double puAchat) {
        this.puAchat = puAchat;
    }

    public double getPuVente() {
        return puVente;
    }

    public void setPuVente(double puVente) {
        this.puVente = puVente;
    }

    public VenteDetails(String nomtable){
        super.setNomTable(nomtable);
    }

    public VenteDetails() {
        super.setNomTable("Vente_Details");
        try {
            this.setNomClasseMere("vente.Vente");
            this.setLiaisonMere("idVente");
        } catch (Exception ex) {
            Logger.getLogger(VenteDetails.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdVente() {
        return idVente;
    }

    public void setIdVente(String idVente) {
        this.idVente = idVente;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) throws Exception {
        /*if(this.getMode().compareTo("modif")==0)
        {
            if(idProduit==null||idProduit.compareToIgnoreCase("")==0)
                throw new Exception("produit obligatoire");
        }*/
        this.idProduit = idProduit;
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) throws Exception{
        if(this.getMode().equals("modif") && compte.isEmpty()){
            throw new Exception("Compte obligatoire pour les details");
        }
        this.compte = compte;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) throws Exception{
        if(this.getMode().equals("modif")){
            if(qte <= 0){
                throw new Exception("Qte insuffisant pour une ligne");
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

    public double getMontantTTCLocal(){
        calculerTTC();
        return montantTTC;
    }
    public double getMontantTTC() {
        return montantTTC;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public double getMontantTvaLocal(){
        calculerTva();
        return montantTva;
    }

    public double getMontantTva() {
        return montantTva;
    }

    public void setMontantTva(double montantTva) {
        this.montantTva = montantTva;
    }
    
    public double getMontantHTLocal(){
        calculerHT();
        return montantHT;
    }
    public double getMontantHT() {
        return montantHT;
    }

    public void setMontantHT(double montantHT) {
        this.montantHT = montantHT;
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
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("VTD", "getSeqVenteDetails");
        this.setId(makePK(c));
    }

    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idVente");
    }

    public Produit getProduit(Connection c) throws Exception {
        
        Produit produit = new Produit();
        produit.setId(this.getIdProduit());
        Produit[] produits = (Produit[]) CGenUtil.rechercher(produit, null, null, c, " ");
        if (produits.length > 0) {
            return produits[0];
        }
        return null;
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        //Produit produit = getProduit(c);
       // this.setPu(produit.getPuVente());
        return super.createObject(u, c);
    }

    public MvtStockFille createMvtStockFille() throws Exception {
        MvtStockFille msf = new MvtStockFille();
        msf.setIdProduit(this.getIdProduit());
        msf.setSortie(this.getQte());
        return msf;
    }

    @Override
    public void controler(Connection c) throws Exception {
       super.controler(c);
       //CheckEtatStock( c);
    }
    

    public void CheckEtatStock(Connection c) throws Exception {

        Vente[] ventes = (Vente[]) CGenUtil.rechercher(new Vente(), null, null, c, " and id='" + this.getIdVente() + "' ");
        if (ventes.length != 1 || ventes==null) {
            throw new Exception("Vente introuvable");
        }
        EtatStock[] et = (EtatStock[]) CGenUtil.rechercher(new EtatStock(), null, null, c, " and id='" + this.getIdProduit() + "' and idmagasin='" + ventes[0].getIdMagasin() + "' ");
        if (et.length != 1) {
            throw new Exception("produit introuvable dans stock");
        }
        if (et[0].getReste()< this.getQte()) {
            throw new Exception("produit insuffisant car  Stock  :"+et[0].getReste()+"< Demande: "+this.getQte());
        }

    }
    
    public double calculerTva(){
        System.out.println(" MONTANT = "+this.getMontant()+" ---- TVA = "+this.getTva()+" ---- OPERATION = "+((this.getMontant() * this.getTva()) / 100));
        double montantTvaC = (this.getMontant() * this.getTva()) / 100;
        this.setMontantTva(montantTvaC);
        return montantTvaC;
    }
    
    public double calculerHT(){
        double montantHTC = this.getMontant();
        this.setMontantHT(montantHTC);
        return montantHTC;
    }
    
    public double calculerTTC(){
        double montantTTCC = this.getMontantHT() + this.getMontantTva();
        this.setMontantTTC(montantTTCC);
        return montantTTCC;
    }
    
    public int lierBonDeLivraisonDetails(String[] idMere, Connection c)throws Exception{
        Statement cmd = null;
        As_BondeLivraisonClientFille bl = new As_BondeLivraisonClientFille();
        try {
            String req = "update " + bl.getNomTable() + " set idventedetails='" + this.getId() + "' where numbl in "+Utilitaire.tabToString(idMere, "'", ",")+" and idproduit='"+this.getIdProduit()+"'";
            cmd = c.createStatement();
            return cmd.executeUpdate(req);
        } catch (Exception ex) {
            if( c != null ){c.rollback();}
            throw ex;
        } finally {
            cmd.close();
        }
    }
}
