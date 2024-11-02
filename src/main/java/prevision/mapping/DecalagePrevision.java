/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prevision.mapping;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import prevision.Prevision;

/**
 *
 * @author Mendrika
 */
public class DecalagePrevision extends ClassMAPTable{
    String id,idPrevision,idDevise;
    double debit, credit;
    Date datyNouveau;
    
    public DecalagePrevision() {
        this.setNomTable("decalagePrevision");
    }
    
    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdPrevision() {
        return idPrevision;
    }

    public void setIdPrevision(String idPrevision) {
        this.idPrevision = idPrevision;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
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

    public Date getDatyNouveau() {
        return datyNouveau;
    }

    public void setDatyNouveau(Date datyNouveau) {
        this.datyNouveau = datyNouveau;
    }
    
    public Prevision getPrevision(Connection c) throws Exception {
        Prevision prevision = new Prevision();        
        return (Prevision) prevision.getById(idPrevision,"PREVISION" , c);
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        Prevision prevision = this.getPrevision(c);
        return prevision.decaler(debit, credit, idDevise, datyNouveau, u, c);
       
    }   
}
