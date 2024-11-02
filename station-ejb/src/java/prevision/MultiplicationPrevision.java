/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prevision;

import bean.CGenUtil;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDate;
import utilitaire.Utilitaire;
/**
 *
 * @author Mendrika
 */
public class MultiplicationPrevision extends ClassMAPTable{
    String id,idPrevision,frequenceUnite;
    int frequence;
    Date daty;

    public MultiplicationPrevision() {
        this.setNomTable("MULTIPLICATION_PREVISION");
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

    public String getFrequenceUnite() {
        return frequenceUnite;
    }

    public void setFrequenceUnite(String frequenceUnite) {
        this.frequenceUnite = frequenceUnite;
    }

    public int getFrequence() {
        return frequence;
    }

    public void setFrequence(int frequence) {
        this.frequence = frequence;
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
    
    public Date getNextDatyMois(){
        return  Utilitaire.ajoutMoisDate(this.daty, 1);
    }
    
    public Date getNextDatySemaine(){
        return  Utilitaire.ajoutJourDate(this.daty, 7);
    }
    
    public Date getNextDatyJour(){
        return  Utilitaire.ajoutJourDate(this.daty, 1);
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        Prevision prev = new Prevision();
        Prevision[] previsions = (Prevision[]) CGenUtil.rechercher(prev, null, null, c, "and ID = '"+this.getIdPrevision()+"'");
            for (int i = 0; i < frequence; i++) {
                Prevision nouveau = (Prevision) previsions[0].dupliquer(u, c);
                nouveau.setDaty(this.daty);
                nouveau.createObject(u, c);
                if(frequenceUnite.equalsIgnoreCase("semaine")){
                    this.daty = getNextDatySemaine();
                } else if(frequenceUnite.equalsIgnoreCase("mois")){
                    this.daty = getNextDatyMois();
                }else {
                    this.daty = getNextDatyJour();
                } 
                
            }
        return previsions[0];     
    }
    
}
