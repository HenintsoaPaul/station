/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prelevement;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import utilitaire.UtilDB;

/**
 *
 * @author CMCM
 */
public class PrelevementPompiste extends ClassMAPTable {

    protected double indexf, indexo, vente, pu, montant;
    protected String id, produit;

    public PrelevementPompiste() {
        this.setNomTable("Prelevement_Pompiste");
    }

    public PrelevementPompiste(double indexf, double indexo, double vente, double pu, double montant, String produit) {
        this.indexf = indexf;
        this.indexo = indexo;
        this.vente = vente;
        this.pu = pu;
        this.montant = montant;
        this.produit = produit;
    }

    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public double getIndexf() {
        return indexf;
    }

    public void setIndexf(double indexf) {
        this.indexf = indexf;
    }

    public double getIndexo() {
        return indexo;
    }

    public void setIndexo(double indexo) {
        this.indexo = indexo;
    }

    public double getVente() {
        return vente;
    }

    public void setVente(double vente) {
        this.vente = vente;
    }

    public double getPu() {
        return pu;
    }

    public void setPu(double pu) {
        this.pu = pu;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProduit() {
        return produit;
    }

    public void setProduit(String produit) {
        this.produit = produit;
    }

   
}
