/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package vente;

import bean.CGenUtil;
import bean.AdminGen;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;

import prevision.Prevision;
import prevision.PrevisionComplet;
import utilitaire.UtilDB;

/**
 *
 * @author tahina
 */
public abstract class FactureCF extends  ClassMere{
    protected String id;
    protected String designation;
    java.sql.Date daty;
    java.sql.Date datyPrevu;
    protected double montantttc, montanttva, montantht,montantttcAr;
    public String getId() {
        return id;
    }
    public double getMontantttcAr() {
        return montantttcAr;
    }

    public void setMontantttcAr(double montantttcAr) {
        this.montantttcAr = montantttcAr;
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
    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }
    public Date getDatyPrevu() {
        return datyPrevu;
    }

    public void setDatyPrevu(Date datyPrevu) {
        this.datyPrevu = datyPrevu;
    }
    public double getMontantttc() {
        return montantttc;
    }

    public void setMontantttc(double montantttc) {
        this.montantttc = montantttc;
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
    
    public PrevisionComplet[] getPrevisions(String nomTable,Connection c) throws Exception{
        boolean estOuvert = false;
        try{
            if(c==null){
                c = new UtilDB().GetConn();
                estOuvert=true;
            }
            PrevisionComplet prevision = new PrevisionComplet();
            if(nomTable!=null&&nomTable.compareToIgnoreCase("")!=0)prevision.setNomTable(nomTable);
            prevision.setIdFacture(this.getId());
            PrevisionComplet[] prev = (PrevisionComplet[]) CGenUtil.rechercher(prevision, null, null, c, "");
            return prev;
        } catch (Exception e) {
            throw e;
        } finally {
            if(estOuvert)c.close();
        }     
    }
    public String  getTiers()
    {
        return null;
    }

    public void controlerPlanPaiement(Prevision[] previsions, Connection c) throws Exception {
        
        double debit = AdminGen.calculSommeDouble(previsions,"debit");
        double credit = AdminGen.calculSommeDouble(previsions,"credit");

        if(credit >0 &&  debit>0 )
        {
            throw new Exception("Probleme dans le sens de paiement");
        }
    }
 
    public void  updatePlanPaiement(String u,Prevision[] previsions,Connection c) throws Exception{
        boolean estOuvert = false;
        try {
            if(previsions.length == 0){
                throw new Exception("Aucun Facture pour plan de paiement");
            }
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
                c.setAutoCommit(false);
            }
            FactureCF facture = (FactureCF) this.getById(this.getTuppleID(), this.getNomTable(), c); 
            // if(getTiers()==null)
            // {
            //     System.out.println("anaty tiers null");
            //     // FactureCF f =(FactureCF) this.getById(this.getTuppleID(),"vente_cpl",c );
            //     facture.updatePlanPaiement(u,previsions,c);
            // }

            this.controlerPlanPaiement(previsions, c);
            for(int i=0; i< previsions.length; i++)
            {

                if (facture.getDaty().compareTo(previsions[i].getDaty()) > 0) {
                    throw new Exception("la date est superieur a la date de facturation");
                }else{
                    if (previsions[i].getTuppleID() != null && !previsions[i].getTuppleID().isEmpty()) {
           
                        previsions[i].updateToTableWithHisto(u, c);
                    } else {
                        previsions[i].setEtat(1);
                        previsions[i].setIdFacture(this.getTuppleID());
                        previsions[i].createObject(u, c);
                    }
                }  
            }
               
            PrevisionComplet[] prev= getPrevisions("prevision",c);
            double montant_somme = AdminGen.calculSommeDouble(prev,this.getSensPrev());
            double ecart =  facture.getMontantttcAr() - montant_somme;
            if( ecart != 0)
            {   
                throw new Exception("Montant total du plan de paiement different du montantttcAr ");
            }
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
}
