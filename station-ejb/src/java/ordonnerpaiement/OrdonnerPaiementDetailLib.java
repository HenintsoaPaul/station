/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ordonnerpaiement;

/**
 *
 * @author CMCM
 */
public class OrdonnerPaiementDetailLib extends OrdonnerPaiementDetail {
    
    protected String idFournisseur;
    protected String idFournisseurLib;
    protected String idFFLib;
    protected String nif;
    protected String stat;
    protected String numeroPiece;
    protected double montantPaye;
    protected double resteAPayer;
    protected double montantOP;
    protected double montantOPPaye;
    protected double resteAPayerOP;

    public String getIdFournisseur() {
        return idFournisseur;
    }

    public void setIdFournisseur(String idFournisseur) {
        this.idFournisseur = idFournisseur;
    }

    public String getIdFournisseurLib() {
        return idFournisseurLib;
    }

    public void setIdFournisseurLib(String idFournisseurLib) {
        this.idFournisseurLib = idFournisseurLib;
    }

    public String getIdFFLib() {
        return idFFLib;
    }

    public void setIdFFLib(String idFFLib) {
        this.idFFLib = idFFLib;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public String getNumeroPiece() {
        return numeroPiece;
    }

    public void setNumeroPiece(String numeroPiece) {
        this.numeroPiece = numeroPiece;
    }

    public double getMontantPaye() {
        return montantPaye;
    }

    public void setMontantPaye(double montantPaye) {
        this.montantPaye = montantPaye;
    }

    public double getResteAPayer() {
        return resteAPayer;
    }

    public void setResteAPayer(double resteAPayer) {
        this.resteAPayer = resteAPayer;
    }

    public double getMontantOP() {
        return montantOP;
    }

    public void setMontantOP(double montantOP) {
        this.montantOP = montantOP;
    }

    public double getMontantOPPaye() {
        return montantOPPaye;
    }

    public void setMontantOPPaye(double montantOPPaye) {
        this.montantOPPaye = montantOPPaye;
    }

    public double getResteAPayerOP() {
        return resteAPayerOP;
    }

    public void setResteAPayerOP(double resteAPayerOP) {
        this.resteAPayerOP = resteAPayerOP;
    }


    public double getMontantPaiementFactureAFaire(double montantTotal) {
        double montantPaiement = (montantTotal * this.getResteAPayer()) / this.getResteAPayerOP();
        return  Math.abs(montantPaiement);
    }


}
