/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package prevision;

import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.AdminGen;
import caisse.Caisse;
import java.sql.Connection;

import caisse.MvtCaisse;
import caisse.ReportCaisse;
import faturefournisseur.FactureFournisseur;
import java.sql.Date;
import java.time.LocalDateTime;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import vente.FactureCF;
import vente.Vente;
import vente.VenteLib;

/**
 *
 * @author dm
 */
public class Prevision extends MvtCaisse{
    
    private String id;
    private String compte;
    private double soldeInitial;
    private double soldeFinale;
    private String idFacture;

    public Prevision() {
        this.setNomTable("PREVISION");
    }

    @Override
    public void setIdDevise(String idDevise) throws Exception {
        this.idDevise = idDevise;
    } 
    
    public boolean isDepense()
    {
        if(this.getDebit()>0&&this.getCredit()<=0) return true;
        return false;
    }
    public boolean isRecette()
    {
        if(this.getCredit()==0)return false;
        return !isDepense();
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    public double getSoldeInitial() {
        return soldeInitial;
    }

    public void setSoldeInitial(double soldeInitial) {
        this.soldeInitial = soldeInitial;
    }

    public double getSoldeFinale() {
        return soldeFinale;
    }

    public void setSoldeFinale(double soldeFinale) {
        this.soldeFinale = soldeFinale;
    }

    public String getIdFacture() {
        return idFacture;
    }

    public void setIdFacture(String idFacture) {
        this.idFacture = idFacture;
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PREV", "getseqprevision");
        super.construirePK(c);
    }

    public void attacherFacture(String[] ids, String u, Connection c)throws Exception{
        boolean canClose=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                canClose=true;
            }
        MvtCaisse[] mvtCaisses =  MvtCaisse.getAll(ids, c);
        MvtCaisse m = null;
        for (int i = 0; i < mvtCaisses.length; i++) {
            m = mvtCaisses[i].attacherPrevision(this.getId(), u, c);
        }
        }catch(Exception e){
            throw e;
        } finally {
            if(canClose){
                c.close();
            }
        }  
    }
    @Override
    public void controler(Connection c) throws Exception {
        if((this.getCredit()==0&&this.getDebit()==0)) throw new Exception("Montant invalide");
    }
    
       @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception{
        
        return createObjectSF(u, c);
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }
    public Vente getVente(Connection c) throws Exception
    {
        return null;
    }
    public FactureFournisseur getFF(Connection c) throws Exception
    {
        return null;
    }
    
    public double calculerSoldeFinale(){
        double sfinal = this.getSoldeInitial() + this.getCredit() - this.getDebit();
        this.setSoldeFinale(sfinal);
        return this.getSoldeFinale();
    }   
    
    @Override
    public String[] getMotCles() {
        return new String[]{"id","compte","designation"};
    }
    public FactureCF getFactureClientouFournisseur(String ntable, Connection c)throws Exception
    {
        if(this.getIdFacture()==null)return null;
        if(this.isRecette())
        {
            if(ntable==null||ntable.compareToIgnoreCase("")==0) ntable="vente_cpl";
            VenteLib crt=new VenteLib();
            crt.setNomTable(ntable);
            crt.setId(this.getIdFacture());
            VenteLib[] liste= (VenteLib[])CGenUtil.rechercher(crt, null, null, c,"");
            if(liste.length>0)return liste[0];
        }
        if(this.isDepense())
        {
            if(ntable==null||ntable.compareToIgnoreCase("")==0) ntable="FACTUREFOURNISSEUR_MERECMPT";
            FactureFournisseur crt=new FactureFournisseur();
            crt.setNomTable(ntable);
            crt.setId(this.getIdFacture());
            FactureFournisseur[] ffs = (FactureFournisseur[]) CGenUtil.rechercher(crt, null, null, c, "");
            if(ffs.length>0)return ffs[0];
        }
        return null;
    }
    
    public Prevision decaler(double montantDebit, double montantCredit, String devise, Date datyVaovao, String u, Connection c) throws Exception{
        double debit = this.getDebit();
        double credit = this.getCredit();   
        if(debit < montantDebit){
            throw new Exception("Le montant saisi ne doit pas etre superieur au débit");
        }
        if(credit < montantCredit){
            throw new Exception("Le montant saisi ne doit pas etre superieur au credit");
        }
        Prevision nouvelle = (Prevision) this.dupliquer(u, c);
        nouvelle.setDebit(montantDebit);
        nouvelle.setCredit(montantCredit);
        nouvelle.setIdDevise(devise);
        nouvelle.setDaty(datyVaovao);
        nouvelle.createObject(u, c);
        debit -= montantDebit;
        credit -= montantCredit;
        this.updateToTableWithHisto(this, c);
        return nouvelle;
        
    }
    public void scinderAndSave(int nombre,String u,Connection c) throws Exception
    {
        Prevision[] liste=scinder(nombre,u,c);
        CGenUtil.insertBatch(liste, c);
    }
    public Prevision[] scinder(int nombre, String u, Connection c) throws Exception{
        Prevision[] previsions = new Prevision[nombre-1];
            if(this.isDepense()){
                this.setDebit(this.getDebit() / nombre);
            }
            if(this.isRecette()){
                this.setCredit(this.getCredit() / nombre);
            }
        this.updateToTableWithHisto(u, c);
        Prevision duplication = null;
        for (int i = 0; i <= nombre-2 ; i++) {
            duplication = (Prevision) this.dupliquer(u, c);
            duplication.setDaty(utilitaire.Utilitaire.ajoutJourDate(this.getDaty(),utils.ConstanteStation.nombreJourScindeDefaut*(i+1)));
            //duplication.createObject(u, c);
        }
        return previsions;
    }
    public static Prevision genererPrevision(ClassMAPTable o) throws Exception
    {
        if(o.getNomChampTotalPrev()==null)throw new Exception ("Nom de champ de total de prevision non defini");
        Prevision vao=new Prevision();
        java.sql.Date d= Utilitaire.stringDate(CGenUtil.getValeurInsert(o, o.getNomChampDatyDuplique()));
        double montant=Utilitaire.stringToDouble(CGenUtil.getValeurInsert(o,o.getNomChampTotalPrev()));
        String designation="prevision genere par : "+o.getTuppleID();
        vao.setEtat(1);
        vao.setIdDevise(ConstantePrev.deviseDef);
        vao.setIdFacture(o.getTuppleID());
        vao.setValChamp(o.getSensPrev(), montant);
        vao.setDaty(d);
        vao.setDesignation(designation);
        return vao;
    }
    @Override 
    public void controlerUpdate(Connection c) throws Exception{
        MvtCaissePrevision[] mvt= (MvtCaissePrevision[]) CGenUtil.rechercher(new MvtCaissePrevision(),null,null, c," and id2='"+this.getId()+"'");
        double debitDejaPaye = AdminGen.calculSommeDouble(mvt,"montantMere");
        double creditDejaPaye = AdminGen.calculSommeDouble(mvt, "montantCredit");
        if(debitDejaPaye > this.getDebit())
        {
            throw new Exception("Montant debit deja paye superieur a montant");
        }
        if(creditDejaPaye > this.getCredit())
        {
            throw new Exception("Montant credit deja paye superieur a montant");
        }

    } 
    
}


