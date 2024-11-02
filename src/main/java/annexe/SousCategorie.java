/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

import bean.TypeObjet;
import java.sql.Connection;

/**
 *
 * @author CMCM
 */
public class SousCategorie extends TypeObjet{
    

    public SousCategorie() {
        this.setNomTable("SousCategorie");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("CTG", "GETSEQSOUSCATEGORIE");
        this.setId(makePK(c));
    }
    
}
