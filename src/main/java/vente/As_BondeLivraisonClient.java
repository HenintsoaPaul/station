package vente;

import bean.CGenUtil;
import bean.ClassMere;
import constante.ConstanteEtat;

import java.sql.Connection;
import java.sql.Date;
import stock.MvtStock;
import stock.MvtStockFille;
import utilitaire.Utilitaire;
import utils.ConstanteEtatStation;
import utils.ConstanteStation;
import utilitaire.UtilDB;   

import java.sql.Date;

public class As_BondeLivraisonClient extends ClassMere{
    String id , remarque,idbc,magasin,idvente,idorigine, idclient;
    Date daty;
    int etat;
    String idClient;

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public As_BondeLivraisonClient() throws Exception{
        this.setNomTable("AS_BONDELIVRAISON_CLIENT");
	 setNomClasseFille("vente.As_BondeLivraisonClientFille");
	 setLiaisonFille("numbl");
    }

    public void construirePK(Connection c)throws Exception{
        this.preparePk("BLC","get_seqASBONDELIVRAISONCLIENT");
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
    public String getRemarque() {
        return remarque;
    }
    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }
    public String getIdbc() {
        return idbc;
    }
    public void setIdbc(String idbc) {
        this.idbc = idbc;
    }
    public String getMagasin() {
        return magasin;
    }
    public void setMagasin(String magasin) {
        this.magasin = magasin;
    }
    public String getIdvente() {
        return idvente;
    }
    public void setIdvente(String idvente) {
        this.idvente = idvente;
    }
    public Date getDaty() {
        return daty;
    }
    public void setDaty(Date daty) {
        this.daty = daty;
    }
    public int getEtat() {
        return etat;
    }
    public void setEtat(int etat) {
        this.etat = etat;
    }

    public String getIdorigine() {
        return idorigine;
    }

    public void setIdorigine(String idorigine) {
        this.idorigine = idorigine;
    }

    public String getIdclient() {
        return idclient;
    }

    public void setIdclient(String idclient) {
        this.idclient = idclient;
    }
    public MvtStock genererMvtStock(Connection c)throws Exception
    {
        boolean estOuvert=false;
        try
        {
            if(c==null)
            {
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
            
            MvtStock mv=new MvtStock();
            mv.setDaty(this.getDaty());
            mv.setDesignation("Mouvement de stock relatif "+this.getId());
            mv.setIdMagasin(this.getMagasin());
            mv.setIdTypeMvStock("TPMVST000022");
            mv.setIdTransfert(this.getId());
            mv.setIdVente(this.getIdvente());
            As_BondeLivraisonClientFille[] listeF=(As_BondeLivraisonClientFille[])this.getFille(null,c,"");
            
	     MvtStockFille[]lf=new MvtStockFille[listeF.length];
            for(int i=0;i<listeF.length;i++)
            {
                lf[i]=listeF[i].genererMvtStockFille(c);
		  lf[i].setIdMvtStock(mv.getId());
            }
            mv.setFille(lf);
            return mv;
        }
        catch(Exception e)
        {
            throw e;
        }
        finally
        {
            if(c!=null&&estOuvert==true)c.close();
        }
    }
    public void genererMvtStockPersist(String user)throws Exception
    {
	 boolean estOuvert=false;
	 Connection c=null;
        try
        {
            if(c==null){
                c=new UtilDB().GetConn();
                estOuvert=true;
            }
	     As_BondeLivraisonClient blc=(As_BondeLivraisonClient)this.getById(this.getId(),null,c);
	     MvtStock mvt=blc.genererMvtStock(c);
         mvt.setEtat(ConstanteEtat.getEtatValider());
	     mvt.createObjectMultiple(user,c);
	     /*MvtStockFille[] filles=(MvtStockFille[])mvt.getFille();
	     for( MvtStockFille lf:filles)
	     {
		  lf.setIdMvtStock(mvt.getId());
		  lf.createObject(user, c);
	     }*/
	 }
	 catch(Exception e){
            throw e;
        }
        finally
        {
            if(c!=null&&estOuvert==true)c.close();
        }
    }
    
    public static void controlerClient(As_BondeLivraisonClient[] bls)throws Exception{
        String idClient = "";
        for(As_BondeLivraisonClient item : bls){
            if(idClient.equals("") == false){
                if(idClient.equals(item.getIdClient()) == false){
                    throw new Exception("Tiers different");
                }
            }
            idClient = item.getIdClient();
        }
    }
    
    public static As_BondeLivraisonClient[] getAll(String[] ids, Connection co)throws Exception{
        As_BondeLivraisonClient bl = new As_BondeLivraisonClient();
        As_BondeLivraisonClient[] bls = (As_BondeLivraisonClient[]) CGenUtil.rechercher(bl, null, null,co, " and id in "+Utilitaire.tabToString(ids, "'", ","));
        return bls;
    }
    
}
