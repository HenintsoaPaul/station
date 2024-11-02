/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMere;
import java.sql.Connection;

/**
 *
 * @author QAngela
 */
public class BilanSection extends ClassMere{
    
    
    private String id;
    private String key;
    private String libelle;
    private String idParent;
    private String type;
    private BilanSection[] filles=new BilanSection[0];
    private BilanSectionCompte[] current= new BilanSectionCompte[0];
    private BilanSectionCompte[] previous= new BilanSectionCompte[0];
    private Bilan bilan;

    public BilanSection() {
        this.setNomTable("BILANSECTION");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getLibelle() {
        return libelle;
    }

    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }

    public String getIdParent() {
        return idParent;
    }

    public void setIdParent(String idParent) {
        this.idParent = idParent;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BilanSection[] getFilles() {
        return filles;
    }

    public void setFilles(BilanSection[] filles) {
        this.filles = filles;
    }

    public BilanSectionCompte[] getCurrent() {
        return current;
    }

    public void setCurrent(BilanSectionCompte[] current) {
        this.current = current;
    }

    public BilanSectionCompte[] getPrevious() {
        return previous;
    }

    public void setPrevious(BilanSectionCompte[] previous) {
        this.previous = previous;
    }

    public Bilan getBilan() {
        return bilan;
    }

    public void setBilan(Bilan bilan) {
        this.bilan = bilan;
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public BilanSection[] getFilles(Connection c) throws Exception {
        BilanSection bsc=new BilanSection();
        if(c==null)throw new Exception("Connection non etablie");
        try {
            bsc.setIdParent(this.getId());
            BilanSection [] liste = (BilanSection[]) CGenUtil.rechercher(bsc, null, null, c, "");
            for (BilanSection fille : liste) {
                fille.setBilan(this.getBilan());
                fille.fillCurrent(c);
                fille.fillPrevious(c);
            }
            return liste;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }    
    }
    
    public void fillCurrent(Connection c) throws Exception {
        BilanSectionCompte bsc=new BilanSectionCompte();
        bsc.setNomTable("v_bilan_section_compte_complet");
        if(c==null)throw new Exception("Connection non etablie");
        try {
            bsc.setExercice(this.getBilan().getExercice());
            BilanSectionCompte [] liste = (BilanSectionCompte[]) CGenUtil.rechercher(bsc, null, null, c, "");
            this.setCurrent(liste);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }    
    }
    
    public void fillPrevious(Connection c) throws Exception {
        BilanSectionCompte bsc=new BilanSectionCompte();
        bsc.setNomTable("v_bilan_section_compte_complet");
        if(c==null)throw new Exception("Connection non etablie");
        try {
            bsc.setExercice( this.getBilan().getExercicePrecedent());
            BilanSectionCompte [] liste = (BilanSectionCompte[]) CGenUtil.rechercher(bsc, null, null, c, "");
            this.setPrevious(liste);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }    
    }
    
    public String getChampASommerSolde() {
        return type.equals("A") ? "soldeActif" : "soldePassif";
    }
    
    public long getTotalCurrent() {
    double total = AdminGen.calculSommeDouble(this.getCurrent(), getChampASommerSolde());
    total += AdminGen.calculSommeDouble(this.getFilles(), "totalCurrent");
    return (long) total;
}
    
    public long getTotalPrevious() {
        double total = AdminGen.calculSommeDouble(this.getPrevious(), getChampASommerSolde());
        total += AdminGen.calculSommeDouble(this.getFilles(), "totalPrevious");
        return (long)total;
    }
}
