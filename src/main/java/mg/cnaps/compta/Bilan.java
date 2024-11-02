/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import utilitaire.UtilDB;

/**
 *
 * @author QAngela
 */
public class Bilan extends ClassMAPTable{
    
    private String exercice;
    private BilanSection[] sectionsPassifs;
    private BilanSection[] sectionsActifs;
    public String getExercice() {
        return exercice;
    }
    
    
    public long getTotalActifsCurrent() {
        double total = AdminGen.calculSommeDouble(this.getSectionsActifs(), "totalCurrent");
        return (long) total;
    }
    
    public long getTotalPassifsCurrent() {
        double total = AdminGen.calculSommeDouble(this.getSectionsPassifs(), "totalCurrent");
        return (long) total;
    }
    
    
    public long getTotalActifsPrevious() {
        double total = AdminGen.calculSommeDouble(this.getSectionsActifs(), "totalPrevious");
        return (long) total;
    }
    
    public long getTotalPassifsPrevious() {
        double total = AdminGen.calculSommeDouble(this.getSectionsPassifs(), "totalPrevious");
        return (long) total;
    }
    
    
    
    
    public String getExercicePrecedent() {
        return String.valueOf(Integer.parseInt(exercice)-1);
    }

    public void setExercice(String exercice) {
        this.exercice = exercice;
    }

    public BilanSection[] getSectionsPassifs() {
        return sectionsPassifs;
    }

    public void setSectionsPassifs(BilanSection[] sectionsPassifs) {
        this.sectionsPassifs = sectionsPassifs;
    }

    public BilanSection[] getSectionsActifs() {
        return sectionsActifs;
    }

    public void setSectionsActifs(BilanSection[] sectionsActifs) {
        this.sectionsActifs = sectionsActifs;
    }
    
    
    public void init() throws Exception {
        Connection c=null;
        boolean verif= false;
        try {
            if (!verif) {
                c = new UtilDB().GetConn();
                verif=true;
            }
            this.setSectionsPassifs(fetchSectionsPassifs(c));
            this.setSectionsActifs(fetchSectionActifs(c));
            
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif)
                c.close();
        }
    }

    
    public BilanSection[] fetchSectionsPassifs(Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            BilanSection [] liste = (BilanSection[]) CGenUtil.rechercher(new BilanSection(), null, null, c, " AND type = 'P' AND idParent IS NULL  ");
            for (BilanSection section : liste) {
                section.setBilan(this);
                section.setFilles(section.getFilles(c));    
            }
           return liste;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }    
    }
    
    
    public BilanSection[] fetchSectionActifs(Connection c) throws Exception {
        if(c==null)throw new Exception("Connection non etablie");
        try {
            BilanSection [] liste = (BilanSection[]) CGenUtil.rechercher(new BilanSection(), null, null, c, " AND type = 'A' AND idParent IS NULL  ");
            for (BilanSection section : liste) {
                section.setBilan(this); 
                section.setFilles(section.getFilles(c));    
            }
            return liste;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }    
    }

    @Override
    public String getTuppleID() {
         return exercice;
    }

    @Override
    public String getAttributIDName() {
        return "exercice";
    }


}
