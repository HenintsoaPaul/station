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
public class TypeProduit extends TypeObjet{
    public TypeProduit() {
        setNomTable("Type_Produit");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("TPR", "getSeqTypeProduit");
        this.setId(makePK(c));
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
