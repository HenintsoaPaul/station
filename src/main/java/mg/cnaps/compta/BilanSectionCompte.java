/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.CGenUtil;
import bean.ClassFille;
import java.sql.Connection;
import utilitaire.Utilitaire;


/**
 *
 * @author QAngela
 */
public class BilanSectionCompte extends ClassFille{
    
    private String id;
    private String compte;
    private String exercice;
    private double debit;
    private double credit;
    private boolean amorti;
  

    public BilanSectionCompte() {
        this.setNomTable("bilan_section_compte");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    
    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public String getExercice() {
        return exercice;
    }

    public void setExercice(String exercice) {
        this.exercice = exercice;
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

    public boolean isAmorti() {
        return amorti;
    }

    public void setAmorti(boolean amorti) {
        this.amorti = amorti;
    }

   
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    
    
  public double getSoldePassif() throws Exception {
        if (this.compte.startsWith("10") || this.compte.startsWith("11") || this.compte.startsWith("12")) {
            return this.getCredit() - this.getDebit();
        } else if (this.compte.startsWith("16") || this.compte.startsWith("4") || this.compte.startsWith("5")) {
            return this.getCredit();
        } else {
            return 0;
        }
    }

  public double getSoldeActif() throws Exception {      
      double somme=0;
        if (this.compte.startsWith("7") || this.compte.startsWith("28")) {
            somme= this.getCredit() - this.getDebit();
        } else if (this.compte.startsWith("6") || this.compte.startsWith("2") && !this.compte.startsWith("28") || this.compte.startsWith("3")) {
            somme= this.getDebit() - this.getCredit();
        } else if (this.compte.startsWith("4") || this.compte.startsWith("5") && !this.compte.startsWith("49")) {
            somme= this.getDebit();
        } else if (this.compte.startsWith("49")) {
            somme= this.getCredit();
        } else {
            return somme;
        }
        return somme;
        
    }
    
}
