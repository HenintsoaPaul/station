/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pompe;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author Angela
 */
public class Pompe extends TypeObjet {
    
    private double max;
    private String idMagasin;

    public Pompe() {
        this.setNomTable("POMPE");
    }
    
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PMP", "getSeqPompe");
        this.setId(makePK(c));
    }

    public double getMax() {
        return max;
    }

    public void setMax(double max) {
        this.max = max;
    }

    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }
    
    public void controllerValMax() throws Exception
    {
	 if(this.getMax() <= 0)
	 {
	     throw new Exception("La valeur maximale ne doit pas être inférieure ou égale à 0");
	 }
    }

    @Override
    public void controler(Connection c) throws Exception {
	 super.controler(c);
	 controllerValMax();
    }

    
    


     
     
    
}
