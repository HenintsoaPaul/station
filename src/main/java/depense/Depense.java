/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package depense;

import bean.CGenUtil;
import bean.ClassEtat;
import caisse.MvtCaisse;
import java.sql.Connection;
import java.sql.Date;
import ordonnerpaiement.OrdonnerPaiement;
import utilitaire.UtilDB;

/**
 *
 * @author 26134
 */
public class Depense extends ClassEtat{
    String id,designation,idCaisse,idOp,idOrigine;
    Date daty;
    double montant;

    public Depense() {
        this.setNomTable("depense");
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

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public String getIdOp() {
        return idOp;
    }

    public void setIdOp(String idOp) {
        this.idOp = idOp;
    }

    public String getIdOrigine() {
        return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
        this.idOrigine = idOrigine;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("DP", "getSeqDepense");
        this.setId(makePK(c));
    }

    protected void checkMontant() throws Exception
    {
        if(this.getMontant()<=0)
        {
            throw new Exception("montant <=0");
        }
    }

    protected MvtCaisse createMvtCaisse() throws Exception {
        MvtCaisse mc=new MvtCaisse();
        mc.setIdOp(this.getIdOp());
        mc.setIdOrigine(this.getId());
        mc.setIdCaisse(this.getIdCaisse());
        mc.setDaty(this.getDaty());
        mc.setDesignation("Mouvement caisse de la depense du "+this.getDaty());
        return mc;
    }
    protected void generateMvtCaisse(Connection c,String refUser) throws Exception
    {
        MvtCaisse mv=createMvtCaisse();
        mv.createObject(refUser, c);
        mv.validerObject(refUser, c);
    }

    public OrdonnerPaiement getOP(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            OrdonnerPaiement op = new OrdonnerPaiement();
            op.setId(this.getIdOp());
            OrdonnerPaiement[] ops = (OrdonnerPaiement[]) CGenUtil.rechercher(op, null, null, c, " ");
            if (ops.length > 0) {
                return ops[0];
            }
            return null;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }

    }
    
    protected void payerOP(Connection c,String refUser) throws Exception
    {
        OrdonnerPaiement op= getOP(c) ;
        op.payerOr(this.getMontant(), c, refUser);
        
    }

    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c);
        checkMontant();
    }

    @Override
    public Object validerObject(String u, Connection c) throws Exception
    {
        super.validerObject(u, c);
        generateMvtCaisse(c,u);
        return this;
    }
}
