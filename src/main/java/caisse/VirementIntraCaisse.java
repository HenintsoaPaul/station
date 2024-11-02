/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.ClassEtat;
import bean.ClassMAPTable;
import constante.ConstanteEtat;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class VirementIntraCaisse extends ClassEtat{
private String id,designation,idCaisseDepart,idCaisseArrive,idOrigine;
private double montant;
private Date daty;

    @Override
    public boolean isSynchro(){
        return true;
    }
    public VirementIntraCaisse() {
        this.setNomTable("virementIntraCaisse");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("VIC", "GETSEQVirementIntraCaisse");
        this.setId(makePK(c));
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdCaisseDepart() {
        return idCaisseDepart;
    }

    public void setIdCaisseDepart(String idCaisseDepart) {
        this.idCaisseDepart = idCaisseDepart;
    }

    public String getIdCaisseArrive() {
        return idCaisseArrive;
    }

    public void setIdCaisseArrive(String idCaisseArrive) {
        this.idCaisseArrive = idCaisseArrive;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public MvtCaisse createMvtCaisse() throws Exception {
            MvtCaisse caisse=new MvtCaisse();
            caisse.setDesignation(this.getDesignation());
            caisse.setIdVirement(this.getId());
            caisse.setDaty(this.getDaty());
            return caisse;
    }
    public MvtCaisse createMvtCaisseDebit() throws Exception {
            MvtCaisse caisse=createMvtCaisse();
            caisse.setIdCaisse(this.getIdCaisseDepart());
            caisse.setDebit(this.getMontant());
            return caisse;
    }
    public MvtCaisse createMvtCaisseCredit() throws Exception {
            MvtCaisse caisse=createMvtCaisse();
            caisse.setIdCaisse(this.getIdCaisseArrive());
            caisse.setCredit(this.getMontant());
            return caisse;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        Object r=null;
        try {
            r=super.validerObject(u, c);
            MvtCaisse caissedep=createMvtCaisseDebit();
            caissedep.createObject(u, c);
            caissedep.validerObject(u, c);

            MvtCaisse caissearr=createMvtCaisseCredit();
            caissearr.createObject(u, c);
            caissearr.validerObject(u, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return r;
    }

    @Override
    public void annulerVisa(String u, Connection c) throws Exception {
        throw new Exception(" virement intra ne peut etre annuler ");
    }
    
}
