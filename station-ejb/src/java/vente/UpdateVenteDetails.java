package vente;

import java.sql.Connection;

public class UpdateVenteDetails extends VenteDetailsLib {
    
    private String compte;

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public UpdateVenteDetails() {
        setNomTable("UPDATEVENTEDETAILS");
    }

    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        setNomTable("VENTE_DETAILS");
        return super.updateToTableWithHisto(refUser, c);
    }
}
