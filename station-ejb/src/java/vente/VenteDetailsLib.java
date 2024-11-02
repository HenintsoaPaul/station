/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import encaissement.EncaissementDetails;
import java.sql.Date;

/**
 *
 * @author Angela
 */
public class VenteDetailsLib  extends VenteDetails{
    
    protected String idProduitLib;
    protected String idCategorie;
    protected String idCategorieLib;
    protected double puRevient;
    protected  double puTotal;
    protected Date daty;
    protected String idMagasin;
    protected String idMagasinLib;
    protected String idPoint;
    protected String idPointLib;
    protected double reste,montant;
    protected String idUnite;
    protected String idDeviseLib;

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getIdDeviseLib() {
        return idDeviseLib;
    }

    public void setIdDeviseLib(String idDeviseLib) {
        this.idDeviseLib = idDeviseLib;
    }

    public String getIdPoint() {
        return idPoint;
    }

    public void setIdPoint(String idPoint) {
        this.idPoint = idPoint;
    }



    public String getIdPointLib() {
        return idPointLib;
    }



    public void setIdPointLib(String idPointLib) {
        this.idPointLib = idPointLib;
    }



    public String getIdMagasin() {
        return idMagasin;
    }



    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }



    public String getIdMagasinLib() {
        return idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    }



    public Date getDaty() {
        return daty;
    }



    public void setDaty(Date daty) {
        this.daty = daty;
    }



    public String getIdCategorie() {
        return idCategorie;
    }



    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }



    public String getIdCategorieLib() {
        return idCategorieLib;
    }



    public void setIdCategorieLib(String idCategorieLib) {
        this.idCategorieLib = idCategorieLib;
    }

    public double getPuRevient() {
        return puRevient;
    }

    public void setPuRevient(double puRevient) {
        this.puRevient = puRevient;
    }

    public VenteDetailsLib() {
        this.setNomTable("VENTE_DETAILS_LIB");
    }
    
    

    public String getIdProduitLib() {
        return idProduitLib;
    }

    public void setIdProduitLib(String idProduitLib) {
        this.idProduitLib = idProduitLib;
    }

    public double getPuTotal() {
        return puTotal;
    }

    public void setPuTotal(double puTotal) {
        this.puTotal = puTotal;
    }

    
        public EncaissementDetails generateEncaissementDetails()throws Exception{
        EncaissementDetails encaissementDetails = new EncaissementDetails();
        encaissementDetails.setMontant(montant);
        encaissementDetails.setIdOrigine(this.getId());
        encaissementDetails.setIdDevise(this.getIdDevise());
        encaissementDetails.setRemarque("Encaissement Vente "+this.getIdProduitLib());
        
        return encaissementDetails;
    }
    
    
    
}
