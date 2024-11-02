/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author Angela
 */
public class Categorie extends TypeObjet{
    
    String idTypeProduit;

    public Categorie() {
        this.setNomTable("CATEGORIE");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CTG", "getSeqCategorie");
        this.setId(makePK(c));
    }

    public String getIdTypeProduit() {
        return idTypeProduit;
    }

    public void setIdTypeProduit(String idTypeProduit) {
        this.idTypeProduit = idTypeProduit;
    }


    @Override
    public String[] getMotCles() {
        String[] motCles={"id","val"};
        return motCles;
    }

    @Override
    public String[] getValMotCles() {
	 String[] valMotCles={"val"};
        return valMotCles;
    }
}
