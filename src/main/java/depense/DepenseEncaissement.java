/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package depense;

import bean.CGenUtil;
import bean.ClassFille;
import bean.ClassMAPTable;
import encaissement.EncaissementLib;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilitaire.UtilDB;

/**
 *
 * @author 26134
 */
public class DepenseEncaissement extends ClassFille{
    String id,designation,idEncaissement;
    Date daty;
    double montant;

    public DepenseEncaissement() {
        try {
            this.setNomTable("DEPENSEENCAISSEMENT");
            this.setNomClasseMere("encaissement.Encaissement");
        } catch (Exception ex) {
            Logger.getLogger(DepenseEncaissement.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
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
    
    public EncaissementLib getEncaissement(Connection c) throws SQLException, Exception{
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            EncaissementLib[] el = (EncaissementLib[]) CGenUtil.rechercher(new EncaissementLib(), null, null, c, " and id='"+this.idEncaissement+"' ");
            if (el.length > 0) {
                return el[0];
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
        return null;
    }
    
    public Depense createDepense(Connection c) throws Exception{
        EncaissementLib elib=this.getEncaissement(c);
        Depense de=new Depense();
        de.setIdCaisse(elib.getIdCaisse());
        de.setDesignation("depense de encaissement_ "+this.getDesignation());
        de.setIdOrigine(this.getIdEncaissement());
        de.setDaty(this.getDaty());
        de.setMontant(this.getMontant());
        return de;
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        Depense de=this.createDepense(c);
        return de.createObject(u, c);
    }
    
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idEncaissement");
    }
    
}
