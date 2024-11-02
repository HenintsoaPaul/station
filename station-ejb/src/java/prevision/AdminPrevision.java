/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prevision;

import bean.CGenUtil;
import caisse.EtatCaisse;
import java.sql.Connection;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;

/**
 *
 * @author Estcepoire
 */
public class AdminPrevision {

    Prevision[] listePrev;
    Prevision minimum;
    double[] somme;

    public Prevision[] getListePrev() {
        return listePrev;
    }

    public void setListePrev(Prevision[] listePrev) {
        this.listePrev = listePrev;
    }

    public Prevision getMinimum() {
        return minimum;
    }

    public void setMinimum(Prevision minimum) {
        this.minimum = minimum;
    }

    public double[] getSomme() {
        return somme;
    }

    public void setSomme(double[] somme) {
        this.somme = somme;
    }

    public double getSoldeInitiale(Connection c, String daty) throws Exception{
        Date d = Utilitaire.string_date("dd/MM/yyyy", daty);
        d=Utilitaire.ajoutJourDate(d, -1);
        String requette = "SELECT SUM(reste) as reste from ( "+ (new EtatCaisse()).generateQueryCore(d,d)+" ) ";
        //System.out.println(requette);
        EtatCaisse[] e = (EtatCaisse[])CGenUtil.rechercher(new EtatCaisse(), requette);
        if (e.length > 0) {
            return e[0].getReste();
        }
        return 0;
    }
    public String getRequete(String datyFiltre, String deb, String fin,String grouper) throws Exception {
        String requette = " SELECT daty, debit, credit,semaine,mois,annee "
                    + "   FROM resultatPrevEffectifTous "
                    + "   WHERE DATY >= TO_DATE('" + deb + "','DD/MM/YYYY') AND DATY < TO_DATE('" + datyFiltre + "','DD/MM/YYYY') "
                    + "   UNION ALL ( SELECT daty, debit, credit,semaine,mois,annee "
                    + "                FROM RESULTATPREVISIONNELTOUSMVT "
                    + "                     WHERE DATY >= TO_DATE('" + datyFiltre + "','DD/MM/YYYY') and DATY <= TO_DATE('" + fin + "','DD/MM/YYYY') ) ";
              
        if(grouper!=null && grouper.compareToIgnoreCase("semaine")==0)
        {
            requette = "select min(daty) as daty, sum(debit) as debit, sum(credit) as credit from ("+requette+") group by semaine,mois,annee" ;   
        }
        if(grouper!=null && grouper.compareToIgnoreCase("mois")==0)
        {
            requette = "select min(daty) as daty, sum(debit) as debit, sum(credit) as credit from ("+requette+") group by mois,annee" ;   
        }
            
        return requette + "    order by DATY ASC ";
    }

    public void getPrevision(String datyFiltre, String deb, String fin,String grouper) throws Exception {
        boolean canClose = false;
        Connection c = null;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                canClose = true;
            }
            String requette=getRequete(datyFiltre,deb,fin,grouper);
            Prevision[] previsions = (Prevision[]) CGenUtil.rechercher(new Prevision(), requette);
            this.setListePrev(previsions);
            this.setMinimum(listePrev[0]);
            listePrev[0].setSoldeInitial(this.getSoldeInitiale(c, deb)); 
            listePrev[0].calculerSoldeFinale();
            for (int i = 1; i < this.getListePrev().length; i++) {
                listePrev[i].setSoldeInitial(listePrev[i-1].getSoldeFinale());
                listePrev[i].calculerSoldeFinale();
                if(minimum.getSoldeFinale()>listePrev[i].getSoldeFinale()) this.setMinimum(listePrev[i]);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            if (canClose) {
                c.close();
            }
        }
    }
}
