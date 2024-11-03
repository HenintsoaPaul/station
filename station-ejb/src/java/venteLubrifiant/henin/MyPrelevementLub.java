package venteLubrifiant.henin;

import henin.MyPrelevement;
import prelevementLub.PrelevementLub;
import vente.Vente;

import java.io.Serializable;
import java.text.ParseException;

public class MyPrelevementLub extends MyPrelevement implements Serializable {

    /**
     * Creer une vente, et ajoute le venteDetail dans la mere.
     */
    public Vente creerVente( int quantiteVendu )
            throws Exception {
        Vente vente = super.creerVente();
        String des = "Vente de lubrifiant apres le fin prelevement le " + this.getDaty();
        vente.setDesignation( des );

        super.addDetails( vente, quantiteVendu );

        return vente;
    }

    public PrelevementLub creerPrelevementLub()
            throws ParseException {
        return new PrelevementLub(
                this.getQuantite(),
                this.getDaty(),
                this.getIdMagasin(),
                Integer.parseInt( this.getIdPompiste() )
        );
    }

    @Override
    public String toString() {
        return super.toString();
    }
}
