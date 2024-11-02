/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package caisse;


import affichage.Champ;
import affichage.PageRechercheChoix;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.ResultatEtSomme;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import utilitaire.Utilitaire;

/**
 *
 * @author Angela
 */
public class PageRechercheChoixEtatCaisse extends PageRechercheChoix {
    
    Date dateMin;
    Date  dateMax;
    boolean isSimpleSearch;

    public PageRechercheChoixEtatCaisse(ClassMAPTable o, HttpServletRequest req, String[] vrt, String[] listInterval, int nbRange, String[] tabAff, int nbAff) throws Exception {
       super(o, req, vrt, listInterval, nbRange, tabAff, nbAff);
    }

    public Date getDateMin() {
        return dateMin;
    }

    public void setDateMin(Date dateMin) {
        this.dateMin = dateMin;
    }
    
    public Date getDateMax() {
        return dateMax;
    }

    public void setDateMax(Date dateMax) {
        this.dateMax = dateMax;
    }

    public boolean isIsSimpleSearch() {
        return isSimpleSearch;
    }

    public void setIsSimpleSearch(boolean isSimpleSearch) {
        this.isSimpleSearch = isSimpleSearch;
    }

    
    public void setDateMax(String dateMax){
        this.dateMax =Utilitaire.stringDate(dateMax);
    }

    public void setDateMin(String dateMin){
        this.dateMin = Utilitaire.stringDate(dateMin);
    }


   public  boolean processDateParameter(String dateMin, String dateMax) {
    boolean isSimplesearch = false;
    LocalDate localDate = LocalDate.now();
    Date dateDuJours = Date.valueOf(localDate);
    try {
        Date dateMinDate = Utilitaire.stringDate(dateMax);
        Date dateMaxDate = Utilitaire.stringDate(dateMin);
        this.setDateMax(dateMaxDate);
        this.setDateMin(dateMinDate);
        if ((dateMinDate == null) && (dateMaxDate == null)) {
            isSimplesearch = true;
            this.setDateMax(dateDuJours);
            this.setDateMin(dateDuJours);
        }
        if ((dateMinDate == null) && dateDuJours.equals(dateMaxDate)) {
            isSimplesearch = true;
             this.setDateMax(dateDuJours);
            this.setDateMin(dateDuJours);
        }
        if ((dateMaxDate == null) && dateDuJours.equals(dateMinDate)) {
            isSimplesearch = true;
            this.setDateMax(dateDuJours);
            this.setDateMin(dateDuJours);
        }
        if (dateDuJours.equals(dateMinDate) && dateDuJours.equals(dateMaxDate)) {
            isSimplesearch = true;
            this.setDateMax(dateDuJours);
            this.setDateMin(dateDuJours);
        }
        if ((dateMinDate == null) && !dateDuJours.equals(dateMaxDate) && (dateMaxDate != null)) {
            isSimpleSearch = false;
            this.setDateMax(dateMaxDate);
            this.setDateMin(dateDuJours);
        }
        if ((dateMaxDate == null) && !dateDuJours.equals(dateMinDate) && (dateMinDate != null) ) {
            isSimpleSearch = false;
            this.setDateMax(dateDuJours);
            this.setDateMin(dateMinDate);
        }
    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }
    return isSimplesearch;
}

   
   
    @Override
    public void makeCritere() throws Exception {
        EtatCaisse etatCaisse=(EtatCaisse)this.getCritere();
        Vector colIntv = new Vector();
        Vector valIntv = new Vector();
        Champ[] tempChamp = this.getFormu().getCrtFormu();
        this.getCritere().setMode("select");
        String temp = "";
        for (int i = 0; i < tempChamp.length; i++) {
            
            Field f = bean.CGenUtil.getField(getBase(), tempChamp[i].getNom());
            //System.out.println("getParamSansnUll "+getParamSansNull(tempChamp[i].getNom()) + "tempChamp === "+tempChamp[i].getValeur());
            if (tempChamp[i].getEstIntervalle() == 1) {
                if(tempChamp[i].getNom().equals(etatCaisse.getFieldDateName())){
                    String dateMaxi=getParamSansNull(tempChamp[i].getNom() + "1");
                    String dateMini=getParamSansNull(tempChamp[i].getNom() + "2");
                    processDateParameter(dateMini,dateMaxi);
                    continue;
                }
                colIntv.add(tempChamp[i].getNom());
                if((getParamSansNull(tempChamp[i].getNom() + "1")==null||getParamSansNull(tempChamp[i].getNom() + "1").compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom() + "1"))!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "1")).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "1")).getDefaut().compareToIgnoreCase("")!=0)
                {
                    valIntv.add(this.getFormu().getChamp((tempChamp[i].getNom() + "1")).getDefaut());
                }
                else valIntv.add(getParamSansNull(tempChamp[i].getNom() + "1"));
                if((getParamSansNull(tempChamp[i].getNom() + "2")==null||getParamSansNull(tempChamp[i].getNom() + "2").compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom() + "2"))!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "2")).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom() + "2")).getDefaut().compareToIgnoreCase("")!=0)
                {
                    valIntv.add(this.getFormu().getChamp((tempChamp[i].getNom() + "2")).getDefaut());
                }
                else valIntv.add(getParamSansNull(tempChamp[i].getNom() + "2"));
            } else if (f.getType().getName().compareToIgnoreCase("java.lang.String") == 0) {
                if((getParamSansNull(tempChamp[i].getNom())==null||getParamSansNull(tempChamp[i].getNom()).compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom()))!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut().compareToIgnoreCase("")!=0)
                {
                    bean.CGenUtil.setValChamp(getCritere(), f, this.getFormu().getChamp(tempChamp[i].getNom()).getValeur());
                }
                else
                {
                    String valeurChamp = getReq().getParameter(utilitaire.Utilitaire.remplacerUnderscore(tempChamp[i].getNom()));
                    if (valeurChamp != null && valeurChamp.compareTo("") != 0) {
                        // System.out.println(" getCritere() = " + getCritere() + " f.getName() " + f.getName() + " getParamSansNull(tempChamp[i].getNom()) " + getParamSansNull(tempChamp[i].getNom()));

                        bean.CGenUtil.setValChamp(getCritere(), f, getParamSansNull(tempChamp[i].getNom()));
                    }
                }
            } 
            else {
                if((getParamSansNull(tempChamp[i].getNom())==null||getParamSansNull(tempChamp[i].getNom()).compareToIgnoreCase("")==0)&&this.getFormu().getChamp((tempChamp[i].getNom()))!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut()!=null&&this.getFormu().getChamp((tempChamp[i].getNom())).getDefaut().compareToIgnoreCase("")!=0)
                   this.setAWhere(this.getAWhere() + " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(this.getFormu().getChamp(tempChamp[i].getNom()).getValeur()) + "'");
                else    
                    this.setAWhere(this.getAWhere() + " and " + f.getName() + " like '" + Utilitaire.getValeurNonNull(getParamSansNull(tempChamp[i].getNom())) + "'");
            }
        }
        this.setColInt(new String[colIntv.size()]);
        colIntv.copyInto(this.getColInt());
        this.setValInt(new String[valIntv.size()]);
        valIntv.copyInto(this.getValInt());
        if (getReq().getParameter("triCol") != null) {
            this.getFormu().getChamp("colonne").setValeur(getReq().getParameter("newcol"));
            if (getReq().getParameter("ordre").compareToIgnoreCase("") == 0) {
                this.getFormu().getChamp("ordre").setValeur("asc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " asc ");
            } else if (getReq().getParameter("ordre").compareToIgnoreCase("desc") == 0) {
                this.getFormu().getChamp("ordre").setValeur("asc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " asc ");
            } else {
                this.getFormu().getChamp("ordre").setValeur("desc");
                this.setOrdre(" order by " + getReq().getParameter("newcol") + " desc ");
            }
        }
        if (this.getFormu().getChamp("colonne").getValeur() != null && this.getFormu().getChamp("ordre").getValeur().compareToIgnoreCase("-") != 0 && this.getFormu().getChamp("colonne").getValeur().compareToIgnoreCase("") != 0 ) {
            this.setOrdre(" order by " + this.getFormu().getChamp("colonne").getValeur() + " " + this.getFormu().getChamp("ordre").getValeur());
        }
        this.setAWhere(this.getAWhere() + this.getOrdre());
    }
 
  

    public String generateEtatCaisseQuery() throws Exception
    {
        EtatCaisse etatCaisse=(EtatCaisse)this.getCritere();
        String query ="select qc.* ,rownum as r from ( "+etatCaisse.generateQueryCore(dateMin, dateMax)+ " ) qc where " + CGenUtil.makeWhere(this.getCritere())+" "+ CGenUtil.makeWhereIntervalle(this.getColInt(),this.getValInt()) +" "+this.getAWhere();
        return query;
    }

    protected ResultatEtSomme getEtatCaisseData(Connection c) throws Exception {
        String query =generateEtatCaisseQuery();
        ResultatEtSomme resultat = CGenUtil.rechercherPage(getCritere(), query, getNumPage(), getColSomme(), c, this.getNpp());
        return resultat;
    }
    
    
    
    @Override
    public void preparerDataList(Connection c) throws Exception {
        String recap=getReq().getParameter("recap");
        this.getCritere().setNomTable(getBase().getNomTable());
        this.makeCritere();
        if(recap!=null && recap.compareToIgnoreCase("checked")==0)
        {
            if(isIsSimpleSearch())
            {
                recap="checked";
                this.getFormu().setRecapcheck(recap);
                this.setRs( getUtilisateur().getDataPageMax(this.getCritere(), getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), c, this.getNpp()));
           
            }else{
                this.setRs( getEtatCaisseData(c));
                double[] sommeNombre = new double[this.getColSomme().length + 1];
                for (int i = 0; i < this.getColSomme().length; i++) {
                    sommeNombre[i] = 0;
                }
                this.getRs().setSommeEtNombre(sommeNombre);
            }
        }
        else
        {
            recap="";
              this.setRs(getUtilisateur().getDataPageMaxSansRecap(this.getCritere(), getColInt(), getValInt(), getNumPage(), getAWhere(), getColSomme(), c, this.getNpp()));
        }        
        setListe((bean.ClassMAPTable[]) this.getRs().getResultat());
    }

    
}
