package vente;

import java.sql.Connection;
import java.sql.Date;

import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import bean.*;
import faturefournisseur.As_BonDeCommande;

public class BonDeCommande extends ClassMere {
    private String id;
    private String idClient;
    private Date daty;
    private int etat;
    private String remarque;
    private String modepaiement;
    private String reference;
    private String designation;
    private String idDevise;
    private String idMagasin;

    
    public String getIdMagasin() {
        return idMagasin;
    }

    public void setIdMagasin(String idMagasin) {
        this.idMagasin = idMagasin;
    }

    public String getIdDevise() {
        return idDevise;
    }

    public void setIdDevise(String idDevise) {
        this.idDevise = idDevise;
    }

    public String genererFacture(String u) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            String idFacture =  genererFacture(u,c);
            c.commit();
            return idFacture;
        }
        catch(Exception e){
            if(c!=null) c.rollback();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    public void controlerFacturer(Connection c) throws Exception{
        Vente[] ventesAnterieur = (Vente[])CGenUtil.rechercher(new Vente(), null,null,c," AND idOrigine='"+this.getId()+"' and etat >0");
        if(ventesAnterieur.length > 0){
            throw new Exception("Facture existante");
        }

    }
    public String genererFacture(String u,Connection c) throws Exception{
        BonDeCommande enBase = (BonDeCommande)this.getById(this.getId(), this.getNomTable(), c);
        BonDeCommandeFille vLib = new BonDeCommandeFille();
        vLib.setNomTable("BONDECOMMANDE_CLIENTF_taux");
        BonDeCommandeFille[] details = (BonDeCommandeFille[]) CGenUtil.rechercher(vLib,null,null,c," AND idBc='"+this.getId()+"'");
        if(details.length > 0){
            Vente vente = new Vente();
            vente.setIdClient(enBase.getIdClient());
            vente.setDesignation("Facture de la BC "+this.getId());
            vente.setDaty(Utilitaire.dateDuJourSql());
            vente.setIdOrigine(enBase.getId());
            vente.setIdMagasin(enBase.getIdMagasin());
            vente.setEtat(1);
            vente.createObject(u, c);
            for(BonDeCommandeFille detail:details){
                VenteDetails detailVente= new VenteDetails();
                detailVente.setIdOrigine(detail.getId());
                detailVente.setIdProduit(detail.getProduit());
                detailVente.setQte(detail.getQuantite());
                detailVente.setPu(detail.getPu());
                detailVente.setTva(detail.getTva());
                detailVente.setIdVente(vente.getId());
                detailVente.setIdDevise(detail.getIdDevise());
                detailVente.setTauxDeChange(detail.getTaux());
                detailVente.createObject(u, c);
            }
            return vente.getId();
        }
        throw new Exception("Plus aucun article à facturer");
    }

    public String genererBonLivraison(String u) throws Exception{
        Connection c = null;
        try{
            c = new UtilDB().GetConn();
            c.setAutoCommit(false);
            BonDeCommande enbase = (BonDeCommande)this.getById(this.getId(),this.getNomTable(), c);
            BonDeCommandeFille vLib = new BonDeCommandeFille();
            vLib.setNomTable("BC_DETAILS_RESTE");
            BonDeCommandeFille[] details = (BonDeCommandeFille[]) CGenUtil.rechercher(vLib,null,null,c," AND idBc='"+this.getId()+"' AND reste > 0");
            if(details.length > 0){
                As_BondeLivraisonClient client = new As_BondeLivraisonClient();
                client.setMode("modif");
                client.setIdbc(this.getId());
                client.setEtat(1);
                client.setIdclient(enbase.getIdClient());
                client.setRemarque("Livraison du bon de commande numero "+this.getId());
                client.setDaty(Utilitaire.dateDuJourSql());
                client.createObject(u, c);
                for(BonDeCommandeFille detail:details){
                    As_BondeLivraisonClientFille clientFille = new As_BondeLivraisonClientFille();
                    clientFille.setMode("modif");
                    clientFille.setProduit(detail.getProduit());
                    clientFille.setUnite(detail.getUnite());
                    clientFille.setQuantite(detail.getReste());
                    clientFille.setIdbc_fille(detail.getId());
                    clientFille.setNumbl(client.getId());
                    clientFille.createObject(u, c);
                }
                c.commit();
                return client.getId();
            }
            throw new Exception("Plus aucun article à livrer");
        }
        catch(Exception e){
            if(c!=null) c.rollback();
            throw e;
        }
        finally{
            if(c!=null) c.close();
        }
    }
    
    public BonDeCommande() {
        setNomTable("BONDECOMMANDE_CLIENT");
    }

    public void construirePK(Connection c) throws Exception {
        this.preparePk("FCBC", "getseqBONDECOMMANDE_CLIENT");
        this.setId(makePK(c));
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDaty() {
        return this.daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getEtat() {
        return this.etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public String getRemarque() {
        return this.remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getDesignation() {
        return Utilitaire.champNull(designation);
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getModepaiement() {
        return Utilitaire.champNull(modepaiement);
    }

    public void setModepaiement(String modepaiement) {
        this.modepaiement = modepaiement;
    }

    public String getReference() {
        return this.reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) throws Exception{
        if(this.getMode().equals("modif")){
            if(idClient==null || idClient.isEmpty()){
                throw new Exception("Le client est obligatoire");
            }
        }
        this.idClient = idClient;
    }

    protected void lierDeviseFille() { 
        BonDeCommandeFille[] filles = (BonDeCommandeFille[])this.getFille();
        for(BonDeCommandeFille bcf:filles){
            bcf.setIdDevise(this.getIdDevise());
        }
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception{
        lierDeviseFille();
        return super.createObject(u, c);
    }
}
