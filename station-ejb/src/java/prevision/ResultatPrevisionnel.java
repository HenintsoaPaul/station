/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prevision;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author dm
 */
public class ResultatPrevisionnel extends ClassMAPTable{
    private String id;
    private Date daty;
    private int mois;
    private int annee;
    private double soldeInitiale;
    private double depensePrevision;
    private double depenseRealisation;
    private double recettePrevision;
    private double recetteRealisation;
    private double soldePrevision;
    private double soldeRealisation;

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public ResultatPrevisionnel() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getMois() {
        return mois;
    }

    public void setMois(int mois) {
        this.mois = mois;
    }

    public int getAnnee() {
        return annee;
    }

    public void setAnnee(int annee) {
        this.annee = annee;
    }

    public double getSoldeInitiale() {
        return soldeInitiale;
    }

    public void setSoldeInitiale(double soldeInitiale) {
        this.soldeInitiale = soldeInitiale;
    }

    public double getDepensePrevision() {
        return depensePrevision;
    }

    public void setDepensePrevision(double depensePrevision) {
        this.depensePrevision = depensePrevision;
    }

    public double getDepenseRealisation() {
        return depenseRealisation;
    }

    public void setDepenseRealisation(double depenseRealisation) {
        this.depenseRealisation = depenseRealisation;
    }

    public double getRecettePrevision() {
        return recettePrevision;
    }

    public void setRecettePrevision(double recettePrevision) {
        this.recettePrevision = recettePrevision;
    }

    public double getRecetteRealisation() {
        return recetteRealisation;
    }

    public void setRecetteRealisation(double recetteRealisation) {
        this.recetteRealisation = recetteRealisation;
    }

    public double getSoldePrevision() {
        return soldePrevision;
    }

    public void setSoldePrevision(double soldePrevision) {
        this.soldePrevision = soldePrevision;
    }

    public double getSoldeRealisation() {
        return soldeRealisation;
    }

    public void setSoldeRealisation(double soldeRealisation) {
        this.soldeRealisation = soldeRealisation;
    }
    
}
