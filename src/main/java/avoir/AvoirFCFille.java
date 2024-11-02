/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.ClassFille;
import java.sql.Connection;
/**
 *
 * @author randr
 */
public class AvoirFCFille extends ClassFille {

    String id;
    String idAvoirFC;
    String idProduit;
    String idOrigine;
    double qte;
    double pu;
    double remise;
    double tva;
    double puAchat;
    double puVente;
    String idDevise;
    double tauxDeChange;
    String designation;
    String idVenteDetails;
    String compte;
    double montantht, montanttva, montantttc;
    double montanthtar, montanttvaar, montantttcar;

    
    public AvoirFCFille() throws Exception{
        this.setNomTable("AvoirFCFille");
        this.setLiaisonMere("idAvoirFC");
        super.setNomClasseMere("avoir.AvoirFC");
    }
    
    public AvoirFCFille(String nomtable)throws Exception{
        this.setNomTable(nomtable);
        this.setLiaisonMere("idAvoirFC");
        super.setNomClasseMere("avoir.AvoirFC");
    }
    public static String getNomClasseMere() {
        return "avoir.AvoirFC";
    }

    

    /**
     * Avoir le champs de liaison entre fille et mère
     * @return le champs de liaison
     */
    public String getLiaisonMere() {
        return "idAvoirFC";
    }  
    public String getIdAvoirFC() {
        return idAvoirFC;
    }

    public void setIdAvoirFC(String idAvoirFC) {
        this.idAvoirFC = idAvoirFC;
    }

    public String getIdProduit() {
        return idProduit;
    }

    public void setIdProduit(String idProduit) {
        this.idProduit = idProduit;
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public double getQte() {
        return qte;
    }

    public void setQte(double qte) {
        if(this.getMode().compareTo("modif")==0){
            this.qte=1;
        }else{
            this.qte = qte;
        }
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getRemise() {
        return remise;
    }

    public void setRemise(double remise) {
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

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public double getTauxDeChange() {
        return tauxDeChange;
    }

    public void setTauxDeChange(double tauxDeChange) {
        this.tauxDeChange = tauxDeChange;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdVenteDetails() {
        return idVenteDetails;
    }

    public void setIdVenteDetails(String idVenteDetails) {
        this.idVenteDetails = idVenteDetails;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getMontantht() {
        return montantht;
    }

    public void setMontantht(double montantht) {
        this.montantht = montantht;
    }

    public double getMontanttva() {
        return montanttva;
    }

    public void setMontanttva(double montanttva) {
        this.montanttva = montanttva;
    }

    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
    }

    public double getMontanthtar() {
        return montanthtar;
    }

    public void setMontanthtar(double montanthtar) {
        this.montanthtar = montanthtar;
    }

    public double getMontanttvaar() {
        return montanttvaar;
    }

    public void setMontanttvaar(double montanttvaar) {
        this.montanttvaar = montanttvaar;
    }

    public double getMontantttcar() {
        return montantttcar;
    }

    public void setMontantttcar(double montantttcar) {
        this.montantttcar = montantttcar;
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
    public void construirePK(Connection c) throws Exception {
        this.preparePk("AVRFCF", "GETSEQAVOIRFCFILLE");
        this.setId(makePK(c));
    }
}
