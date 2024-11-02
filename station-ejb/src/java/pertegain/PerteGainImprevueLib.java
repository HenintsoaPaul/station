/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pertegain;

import bean.CGenUtil;
import java.sql.Connection;
import java.sql.SQLException;
import utilitaire.UtilDB;

/**
 *
 * @author bruel
 */
public class PerteGainImprevueLib extends PerteGainImprevue{
    
    private String type;
    private String compte;
    private double montanttva, montantht, montantttc;
    private String tierslib, tierscompte;

    public PerteGainImprevueLib() {
        super.setNomTable("pertegainimprevuelib");
    }

    public PerteGainImprevueLib(String type, String compte) {
        this.type = type;
        this.compte = compte;
    }
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
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

    public String getTierslib() {
        return tierslib;
    }

    public void setTierslib(String tierslib) {
        this.tierslib = tierslib;
    }

    public String getTierscompte() {
        return tierscompte;
    }

    public void setTierscompte(String tierscompte) {
        this.tierscompte = tierscompte;
    }
    
    public static PerteGainImprevueLib getById(String id) throws SQLException{
        Connection c = new UtilDB().GetConn();
        try {
            PerteGainImprevueLib pgil = new PerteGainImprevueLib();
            pgil.setId(id);
            PerteGainImprevueLib[] data = (PerteGainImprevueLib[])CGenUtil.rechercher(pgil, null, null, c, "");
            return data.length > 0 ? data[0] : null;
        } catch (Exception e) {
            e.printStackTrace();
            c.close();
        } finally {
            c.close();
        }
        return null;
    }
}
