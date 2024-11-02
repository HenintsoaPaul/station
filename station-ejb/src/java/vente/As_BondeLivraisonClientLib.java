package vente;

public class As_BondeLivraisonClientLib extends As_BondeLivraisonClient{
    String idVente;
    String magasinlib;
    String idClientLib;
    String idClient;

    public As_BondeLivraisonClientLib()throws Exception{
        setNomTable("AS_BONDELIVRAISONCLIENT_LIB");
    }

    public String getIdVente() {
        return idVente;
    }
    public void setIdVente(String idVente) {
        this.idVente = idVente;
    }
    public String getMagasinlib() {
        return magasinlib;
    }
    public void setMagasinlib(String magasinlib) {
        this.magasinlib = magasinlib;
    }

    public String getIdClientLib() {
        return idClientLib;
    }

    public void setIdClientLib(String idClientLib) {
        this.idClientLib = idClientLib;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }
    
}
