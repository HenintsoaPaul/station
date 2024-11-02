package venteLubrifiant.henin;

import henin.MyVente;
import vente.Vente;

public class MyVenteLub extends MyVente {

    /**
     * Creer une vente, et ajoute le venteDetail dans la mere.
     */
    public Vente creerVente()
            throws Exception {
        Vente vente = super.creerVente();
        String des = "Vente de lubrifiant \"" + this.getIdProduit() + "\" le " + this.getDaty();
        vente.setDesignation( des );

        super.addDetails( vente );

        return vente;
    }
}
