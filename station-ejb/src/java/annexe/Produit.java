/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package annexe;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ClassEtat;
import inventaire.Inventaire;
import inventaire.InventaireFille;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDateTime;
import magasin.Magasin;
import utilitaire.Utilitaire;
import utils.ConstanteStation;
import utils.ConstanteEtatCustom;

/**
 *
 * @author Angela
 */
public class Produit extends ClassEtat{
    
    private String id,  idTypeProduit,idCategorie;
    private String val,desce;
    private double puAchat; 
    private double puVente; 
    private String idUnite;
    private String idSousCategorie;
    private double puAchatUsd, puAchatEuro, puAchatAutreDevise;
    private double puVenteUsd, puVenteEuro, puVenteAutreDevise;
    private int isAchat,isVente;

    public int getIsAchat() {
        return isAchat;
    }

    public void setIsAchat(int isAchat) {
        this.isAchat = isAchat;
    }

    public int getIsVente() {
        return isVente;
    }

    public void setIsVente(int isVente) {
        this.isVente = isVente;
    }

    public double getPuAchatUsd() {
        return puAchatUsd;
    }

    public void setPuAchatUsd(double puAchatUsd) throws Exception{
        if(this.getMode().equals("modif")){
            if(puAchatUsd<0){
                throw new Exception("Prix unitaire ne doit pas etre negatif");                
            }
        }
        this.puAchatUsd = puAchatUsd;
    }

    public double getPuAchatEuro() {
        return puAchatEuro;
    }

    public void setPuAchatEuro(double puAchatEuro) throws Exception{
        if(this.getMode().equals("modif")){
            if(puAchatEuro<0){
                throw new Exception("Prix unitaire ne doit pas etre negatif");                
            }
        }
        this.puAchatEuro = puAchatEuro;
    }

    public double getPuAchatAutreDevise() {
        return puAchatAutreDevise;
    }

    public void setPuAchatAutreDevise(double puAchatAutreDevise) throws Exception{
        if(this.getMode().equals("modif")){
            if(puAchatAutreDevise<0){
                throw new Exception("Prix unitaire ne doit pas etre negatif");                
            }
        }
        this.puAchatAutreDevise = puAchatAutreDevise;
    }

    public double getPuVenteUsd() {
        return puVenteUsd;
    }

    public void setPuVenteUsd(double puVenteUsd) throws Exception{
        if(this.getMode().equals("modif")){
            if(puVenteUsd<0){
                throw new Exception("Prix unitaire ne doit pas etre negatif");                
            }
        }
        this.puVenteUsd = puVenteUsd;
    }

    public double getPuVenteEuro() {
        return puVenteEuro;
    }

    public void setPuVenteEuro(double puVenteEuro) throws Exception{
        if(this.getMode().equals("modif")){
            if(puVenteEuro<0){
                throw new Exception("Prix unitaire ne doit pas etre negatif");                
            }
        }
        this.puVenteEuro = puVenteEuro;
    }

    public double getPuVenteAutreDevise() {
        return puVenteAutreDevise;
    }

    public void setPuVenteAutreDevise(double puVenteAutreDevise) throws Exception{
        if(this.getMode().equals("modif")){
            if(puVenteAutreDevise<0){
                throw new Exception("Prix unitaire ne doit pas etre negatif");                
            }
        }
        this.puVenteAutreDevise = puVenteAutreDevise;
    }

    public String getIdSousCategorie() {
        return idSousCategorie;
    }

    public void setIdSousCategorie(String idSousCategorie) {
        this.idSousCategorie = idSousCategorie;
    }

    public Produit() {
        setNomTable("Produit");
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesce() {
	 return desce;
    }

    public void setDesce(String desce) {
	 this.desce = desce;
    }

    
    @Override
     public void construirePK(Connection c) throws Exception {
        this.preparePk("PRD", "getSeqProduit");
        this.setId(makePK(c));
    }

    public String getIdCategorie() {
        return idCategorie;
    }

    public void setIdCategorie(String idCategorie) {
        this.idCategorie = idCategorie;
    }

    public String getIdTypeProduit() {
        return idTypeProduit;
    }

    public void setIdTypeProduit(String idTypeProduit) {
        this.idTypeProduit = idTypeProduit;
    }

    public double getPuAchat() {
        return puAchat;
    }

    public void setPuAchat(double puAchat) {
        this.puAchat = puAchat;
    }

    public double getPuVente() {
        return puVente;
    }

    public void setPuVente(double puVente) {
        this.puVente = puVente;
    }

    public String getIdUnite() {
        return idUnite;
    }

    public void setIdUnite(String idUnite) {
        this.idUnite = idUnite;
    }

    public String getVal() {
	 return val;
    }

    public void setVal(String val) {
	 this.val = val;
    }

    
    
    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        int i=super.updateToTableWithHisto(refUser,c);
        HistoriqueProduit h= new HistoriqueProduit();
        h.setPuAchat(this.getPuAchat());
        h.setPuVente(this.getPuVente());
        h.setDaty(utilitaire.Utilitaire.dateDuJourSql());
        h.setIdProduit(this.getId());
        h.createObject(refUser, c);
        return i;
    }
    @Override
    public  String chaineEtat(int value){
        if(value ==  ConstanteEtatCustom.PAYE_LIVRE) return "<b style='color:lightskyblue'>PAY&Eacute; ET LIVR&Eacute; </b>";
        if(value ==  ConstanteEtatCustom.LIVRE_NON_PAYE) return "<b style='color:orange'>LIV&Eacute; NON PAY&Eacute; </b>";
        if(value ==  ConstanteEtatCustom.PAYE_NON_LIVRE) return "<b style='color:green'>PAY&Eacute; NON LIVR&Eacute; </b>";
        return super.chaineEtat(value);
    }
    
    protected void createInventaireZero(String u,Connection c) throws Exception {
        Magasin[] listmag=(Magasin[])CGenUtil.rechercher(new Magasin(),null, null, c, "");
       
        for (int i = 0; i < listmag.length; i++) {
            Inventaire inv =(Inventaire)listmag[i].generateInventaireMere ().createObject(u, c);
            InventaireFille invF=inv.generateInventaireFilleZero();
            invF.setIdProduit(this.getId()); 
            invF.createObject(u, c);  
            inv.validerObject(u, c);
         }
    }
    
    public String getAttributIDName() {
        return "id";
    }

    public String getTuppleID() {
        return id;
    }

    @Override
     public ClassMAPTable createObject(String u,Connection c)throws Exception
     {
        ClassMAPTable o=super.createObject(u,c);
        HistoriqueProduit h= new HistoriqueProduit();
        h.setPuAchat(this.getPuAchat());
        h.setPuVente(this.getPuVente());
        h.setDaty(utilitaire.Utilitaire.dateDuJourSql());
        h.setIdProduit(this.getId());
        h.createObject(u, c);
        this.createInventaireZero(u, c);
        return o;
    }
    
    @Override
    public String[] getMotCles() {
        String[] motCles={"id","val"};
        return motCles;
    }

    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c);
	 if(this.getPuVente()<=0)
	 {
	    throw new Exception("Prix de vente invalide et doit être supérieur à 0");
	 }
    }
    
    
    
}
