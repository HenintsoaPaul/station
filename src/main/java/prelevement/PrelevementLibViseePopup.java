/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prelevement;

import java.sql.Date;

/**
 *
 * @author CMCM
 */
public class PrelevementLibViseePopup extends PrelevementLib {
    
    protected double compteurInit;
    protected Date datyInit;
    
    public PrelevementLibViseePopup() {
        this.setNomTable("prelevementlib_visee_pop");
    }

    public double getCompteurInit() {
        return compteurInit;
    }

    public void setCompteurInit(double compteurInit) {
        this.compteurInit = compteurInit;
    }

    public Date getDatyInit() {
        return datyInit;
    }

    public void setDatyInit(Date datyInit) {
        this.datyInit = datyInit;
    }

  
   


    
}
