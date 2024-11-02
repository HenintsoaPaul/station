package vente;

import java.sql.Connection;

import bean.ClassMAPTable;

public class As_BondeLivraisonClientFilleInsertion extends As_BondeLivraisonClientFille {
    protected String uniteLib;
    protected String produitLib;

    public String getUniteLib() {
        return uniteLib;
    }


    public void setUniteLib(String uniteLib) {
        this.uniteLib = uniteLib;
    }


    public String getProduitLib() {
        return produitLib;
    }


    public void setProduitLib(String produitLib) {
        this.produitLib = produitLib;
    }


    public As_BondeLivraisonClientFilleInsertion() throws Exception {
        super();
        super.setNomTable("As_BLClientFilleInsertion");
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception{
        super.setNomTable("AS_BONDELIVRAISON_CLIENT_FILLE");
        return super.createObject(u,c);
    }

    @Override
    public int updateToTableWithHisto(String u, Connection c) throws Exception{
        super.setNomTable("AS_BONDELIVRAISON_CLIENT_FILLE");
        return super.updateToTableWithHisto(u,c);
    }


    
}
