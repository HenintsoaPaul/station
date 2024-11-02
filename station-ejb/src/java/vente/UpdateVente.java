package vente;

import java.sql.Connection;

public class UpdateVente extends InsertionVente {

    public UpdateVente() {
        setNomTable("UPDATEVENTE");
    }

    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        setNomTable("VENTE");
        return super.updateToTableWithHisto(refUser, c);
    }
}