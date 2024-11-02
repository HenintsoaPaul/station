/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ordonnerpaiement;

import bean.CGenUtil;
import bean.ClassMere;
import java.sql.Connection;
import java.sql.Date;
import utilitaire.UtilDB;

/**
 *
 * @author CMCM
 */
public class OrdonnerPaiement extends ClassMere {

    protected String id;
    protected String designation;
    protected Date daty;
    protected String remarque;
    
    public OrdonnerPaiement() {
        this.setNomTable("OrdonnerPaiement");
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
    
    public Date getDaty() {
        return daty;
    }
    
    public void setDaty(Date daty) {
        this.daty = daty;
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

    
    public OrdonnerPaiementDetailLib[] getDetails(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            
            OrdonnerPaiementDetailLib opl = new OrdonnerPaiementDetailLib();
            opl.setIdOP(this.getId());
            OrdonnerPaiementDetailLib[] opls = (OrdonnerPaiementDetailLib[]) CGenUtil.rechercher(opl, null, null, c, " ");
            if (opls.length > 0) {
                return opls;
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

    public void payerOr(double montant, Connection c, String refUser) throws Exception {
        OrdonnerPaiementDetailLib[] opds = getDetails(c);
        for (OrdonnerPaiementDetailLib opd : opds) {
            double m = opd.getMontantPaiementFactureAFaire(montant);
            opd.payer(m, c, refUser);
        }
    }
    
    protected void checkValiditeDetails(Connection c) throws Exception {
        OrdonnerPaiementDetailLib[] opds = getDetails(c);
        for (OrdonnerPaiementDetailLib opd : opds) {
            opd.checkValidite(c);
        }
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        checkValiditeDetails(c);
        super.validerObject(u, c);
        return this;
    }
}
