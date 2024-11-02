/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pertegain;

import bean.CGenUtil;
import bean.ClassEtat;
import caisse.MvtCaisse;
import faturefournisseur.FactureFournisseur;
import java.sql.Connection;
import java.sql.Date;
import mg.cnaps.compta.ComptaEcriture;
import mg.cnaps.compta.ComptaSousEcriture;
import utilitaire.UtilDB;
import utils.ConstanteStation;

/**
 *
 * @author bruel
 */
public class PerteGainImprevue extends ClassEtat{
    private String id;
    private String designation;
    private String idtypegainperte;
    private double perte;
    private double gain;
    private Date daty;
    private String idorigine;
    private double tva;
    private String tiers;

    public PerteGainImprevue() {
        super.setNomTable("pertegainimprevue");
    }
    
    public PerteGainImprevue(String nomtable) {
        super.setNomTable(nomtable);
    }

    public PerteGainImprevue(String id, String designation, String idtypegainperte, double perte, double gain, Date daty, String idorigine) {
        this.setId(id);
        this.setDesignation(designation);
        this.setIdtypegainperte(idtypegainperte);
        this.setPerte(perte);
        this.setGain(gain);
        this.setDaty(daty);
        this.setIdorigine(idorigine);
    }
    
    public TypePerteGain getTypePerteGain(Connection c) throws Exception{
        TypePerteGain type = new TypePerteGain();
        type.setId(this.getIdtypegainperte());
        TypePerteGain[] typePerteGain = (TypePerteGain[])CGenUtil.rechercher(type, null, null, c, "");
        return typePerteGain.length > 0 ? typePerteGain[0] : null;
    }
    
    @Override
    public void controler(Connection c) throws Exception{
        if(this.getPerte()<0||this.getGain()<0) throw new Exception("Les montants ne doivent pas etre negatifs");
        if(this.getPerte()>0&&this.getGain()>0) throw new Exception("Les champs 'gain' et 'perte' ne peuvent pas etre remplis en meme temps.");
        if(this.getPerte()==0&&this.getGain()==0) throw new Exception("Les champs 'gain' et 'perte' ne peuvent pas etre nulls en meme temps.");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdtypegainperte() {
        return idtypegainperte;
    }

    public void setIdtypegainperte(String idtypegainperte) {
        this.idtypegainperte = idtypegainperte;
    }

    public double getPerte() {
        return perte;
    }

    public void setPerte(double perte) {
        this.perte = perte;
    }

    public double getGain() {
        return gain;
    }

    public void setGain(double gain) {
        this.gain = gain;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getIdorigine() {
        return idorigine;
    }

    public void setIdorigine(String idorigine) {
        this.idorigine = idorigine;
    }

    public double getTva() {
        return tva;
    }

    public void setTva(double tva) {
        this.tva = tva;
    }

    public String getTiers() {
        return tiers;
    }

    public void setTiers(String tiers) {
        this.tiers = tiers;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PGI", "GETSEQPERTEGAINIMPREVUE");
        this.setId(makePK(c));
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
            }
            super.validerObject(u, c);
            genererEcriture(u, c);
            return this;

        } catch (Exception e) {
            if (c != null) {
                c.rollback();
            }
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }
    
    public void genererEcriture(String u, Connection c) throws Exception{
        ComptaEcriture mere = new ComptaEcriture();
        Date dateDuJour = utilitaire.Utilitaire.dateDuJourSql();
        int exercice = utilitaire.Utilitaire.getAnnee(daty);
        mere.setDaty(dateDuJour);
        mere.setDesignation(this.getDesignation());
        mere.setExercice(""+exercice);
        mere.setDateComptable(this.getDaty());
        if(this.getIdorigine().contains("VTN")){
            mere.setJournal(ConstanteStation.JOURNALVENTE);
        } else {
            mere.setJournal(ConstanteStation.journalAchat);
        }
        
        mere.setOrigine(this.getId());
        mere.setIdobjet(this.getId());
        mere.createObject(u, c);
        ComptaSousEcriture[] filles = this.genererSousEcriture(c);
        for(int i=0; i<filles.length; i++){
            filles[i].setIdMere(mere.getId());
            filles[i].setExercice(exercice);
            filles[i].setDaty(this.getDaty());
            filles[i].setJournal(ConstanteStation.JOURNALVENTE);
            
            if(filles[i].getDebit()>0 || filles[i].getCredit()>0) filles[i].createObject(u, c);
        }
    }
    
    public ComptaSousEcriture[] genererSousEcriture(Connection c) throws Exception{
        ComptaSousEcriture[] compta={};
        boolean canClose=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                canClose=true;
            }
            PerteGainImprevueLib[] perteGainImprevue = (PerteGainImprevueLib[]) CGenUtil.rechercher(new PerteGainImprevueLib(), null, null, c, " and id = '"+this.getId()+"'");
            if(perteGainImprevue.length<1) throw new Exception("Perte ou Gain Introuvable");
            //this.setCompte(facturefournisseurs[0].getCompte());

            
            compta = new ComptaSousEcriture[3];
            if(perteGainImprevue[0].getPerte()>0){
                compta[0]=new ComptaSousEcriture();
                compta[0].setLibellePiece("Perte - "+ perteGainImprevue[0].getType()+" "+perteGainImprevue[0].getDaty());
                compta[0].setRemarque(perteGainImprevue[0].getDesignation());
                compta[0].setCompte(perteGainImprevue[0].getTierscompte());
                compta[0].setCredit(perteGainImprevue[0].getMontantttc());
                
                compta[1]=new ComptaSousEcriture();
                compta[1].setLibellePiece("TVA Deductible");
                compta[1].setRemarque(perteGainImprevue[0].getDesignation());
                compta[1].setCompte(ConstanteStation.compteTVADeductible);
                compta[1].setDebit(perteGainImprevue[0].getMontanttva());

                compta[2]=new ComptaSousEcriture();
                compta[2].setLibellePiece("Perte - "+ perteGainImprevue[0].getType()+" "+perteGainImprevue[0].getDaty());
                compta[2].setRemarque(perteGainImprevue[0].getDesignation());
                compta[2].setCompte(perteGainImprevue[0].getCompte());
                compta[2].setDebit(perteGainImprevue[0].getMontantht());
            } else if (perteGainImprevue[0].getGain()>0) {
                compta[0]=new ComptaSousEcriture();
                compta[0].setLibellePiece("Gain - "+ perteGainImprevue[0].getType()+" "+perteGainImprevue[0].getDaty());
                compta[0].setRemarque(perteGainImprevue[0].getDesignation());
                compta[0].setCompte(perteGainImprevue[0].getTierscompte());
                compta[0].setDebit(perteGainImprevue[0].getMontantttc());
                
                compta[1]=new ComptaSousEcriture();
                compta[1].setLibellePiece("TVA Collectee");
                compta[1].setRemarque(perteGainImprevue[0].getDesignation());
                compta[1].setCompte(ConstanteStation.compteTVACollecte);
                compta[1].setCredit(perteGainImprevue[0].getMontanttva());

                compta[2]=new ComptaSousEcriture();
                compta[2].setLibellePiece("Gain - "+ perteGainImprevue[0].getType()+" "+perteGainImprevue[0].getDaty());
                compta[2].setRemarque(perteGainImprevue[0].getDesignation());
                compta[2].setCompte(perteGainImprevue[0].getCompte());
                compta[2].setCredit(perteGainImprevue[0].getMontantht());
                
            }
            
            
        } catch(Exception e){
            throw e;
        } finally {
            if(canClose){
                c.close();
            }
        }
        return compta;
    }
    
    MvtCaisse getMouvementCaisse(Connection c) throws Exception{
        MvtCaisse mvtCaisse = new MvtCaisse();
        mvtCaisse.setIdOrigine(this.getId());
        MvtCaisse[] mvtCaisses = (MvtCaisse[]) CGenUtil.rechercher(mvtCaisse, null, null, c, "");
        return mvtCaisses.length > 0 ? mvtCaisses[0] : null;
    }
    
    @Override
    public void controlerAnnulationVisa(Connection c) throws Exception{
        MvtCaisse mvtCaisse = getMouvementCaisse(c);
        if(mvtCaisse != null) throw new Exception("Perte ou Gain a deja généré un mouvement de caisse et ne peut pas être annulé!");
    }
}
