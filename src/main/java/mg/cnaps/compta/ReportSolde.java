/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.util.Calendar;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utilitaire.*;

/**
 *
 * @author Me
 */
public class ReportSolde extends ClassMAPTable{
    double debit;
    double credit;
    String compte;
    Date daty;

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public ReportSolde() {
        super.setNomTable("REPORTSOLDE");
    }

    public ReportSolde(double debit, double credit, String compte, Date daty) {
        this.setDebit(debit);
        this.setCredit(credit);
        this.setCompte(compte);
        this.setDaty(daty);
    }
    public void  setNomTableSelonTypeCompte(int typeCompte){
        if (typeCompte==ConstanteComptabilite.TYPE_COMPTE_ANALYTIQUE){
            super.setNomTable("REPORTSOLDE_ANALYTIQUE");
        } 
         if (typeCompte==ConstanteComptabilite.TYPE_COMPTE_GENERAL) {
            super.setNomTable("REPORTSOLDE_GENERAL");
        }
    }
    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}

