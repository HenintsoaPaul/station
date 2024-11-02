
package caisse;

import bean.TypeObjet;
import java.sql.Connection;

public class Devise extends TypeObjet{
    
    String idTypeProduit;

    public Devise() {
        this.setNomTable("DEVISE");
    }
    
    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("DVS", "getSeqDevise");
        this.setId(makePK(c));
    }

    public String getIdTypeProduit() {
        return idTypeProduit;
    }

    public void setIdTypeProduit(String idTypeProduit) {
        this.idTypeProduit = idTypeProduit;
    }

}
