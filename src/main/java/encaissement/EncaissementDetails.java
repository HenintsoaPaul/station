/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.CGenUtil;
import bean.ClassFille;
import caisse.Caisse;
import caisse.VirementIntraCaisse;
import java.sql.Connection;
import utils.ConstanteStation;

/**
 *
 * @author Angela
 */
public class EncaissementDetails extends ClassFille{

    protected String id;
    protected String idEncaissement;
    protected String idDevise;
    protected double montant;
    protected String remarque;
    protected String idOrigine;

    
    public String getIdOrigine() {
        return idOrigine;
    }


    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }


    public EncaissementDetails() throws Exception {
        this.setNomTable("Encaissement_Details");
        this.setNomClasseMere("encaissement.Encaissement");
    }

    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

 

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ECD", "getSeqEncaissementDetails");
        this.setId(makePK(c));
    }
    
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idEncaissement");
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }
    
    
    
    public EncaissementCpl getEncaissement(Connection c) throws Exception {
        EncaissementCpl encaissement = new EncaissementCpl();
        encaissement.setId(this.getIdEncaissement());
        EncaissementCpl[] encaissements = (EncaissementCpl[]) CGenUtil.rechercher(encaissement, null, null, c, " ");
        if (encaissements.length > 0) {
            return encaissements[0];
        }
        return null;
    }
    
    
    
    public VirementIntraCaisse generateVirementIntraCaisse (Connection c) throws Exception{
        
        EncaissementCpl encmt= getEncaissement(c);
        Caisse caisse=new Caisse(encmt.getIdPoint());
        //caisse.setIdCategorieCaisse(this.getIdCategorieCaisse());
        VirementIntraCaisse vic=new VirementIntraCaisse();
        vic.setIdCaisseDepart(encmt.getIdCaisse());
        vic.setDesignation("virement intra caisse du "+encmt.getDaty());
        vic.setDaty(encmt.getDaty());
        vic.setMontant(this.getMontant());
        vic.setIdCaisseDepart(caisse.getCaisse(c).getId());
        vic.setIdOrigine(this.getId());
        return vic;
    }

}

