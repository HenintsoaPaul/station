/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.ClassMAPTable;
import java.sql.Date;
import java.time.LocalDate;

import utilitaire.Utilitaire;

/**
 *
 * @author 26134
 */
public class EtatCaisse extends ClassMAPTable{
String id,idCaisse,idCaisselib,idPoint,idPointlib,idTypeCaisse,idTypeCaisselib;
Date dateDernierReport;
double montantDernierReport,credit,debit,reste,solde;

    public EtatCaisse() {
        this.setNomTable("v_Etatcaisse");
    }

    public double getReste() {
        return reste;
    }

    public void setReste(double reste) {
        this.reste = reste;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public String getIdCaisselib() {
        return idCaisselib;
    }

    public void setIdCaisselib(String idCaisselib) {
        this.idCaisselib = idCaisselib;
    }

    public String getIdPoint() {
        return idPoint;
    }

    public void setIdPoint(String idPoint) {
        this.idPoint = idPoint;
    }

    public String getIdPointlib() {
        return idPointlib;
    }

    public void setIdPointlib(String idPointlib) {
        this.idPointlib = idPointlib;
    }

    public String getIdTypeCaisse() {
        return idTypeCaisse;
    }

    public void setIdTypeCaisse(String idTypeCaisse) {
        this.idTypeCaisse = idTypeCaisse;
    }

    public String getIdTypeCaisselib() {
        return idTypeCaisselib;
    }

    public void setIdTypeCaisselib(String idTypeCaisselib) {
        this.idTypeCaisselib = idTypeCaisselib;
    }

    public Date getDateDernierReport() {
        return dateDernierReport;
    }

    public void setDateDernierReport(Date dateDernierReport) {
        this.dateDernierReport = dateDernierReport;
    }

    public double getMontantDernierReport() {
        return montantDernierReport;
    }

    public void setMontantDernierReport(double montantDernierReport) {
        this.montantDernierReport = montantDernierReport;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getSolde() {
        return solde;
    }

    public void setSolde(double solde) {
        this.solde = solde;
    }
    
    public String getFieldDateName() {
        return "dateDernierReport";
    }
    @Override
    public String getTuppleID() {
        return this.id;
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }
    public String generateQueryCore(Date dateMin, Date dateMax ) {
        LocalDate localDate = LocalDate.now();
        Date dateDuJours = Date.valueOf(localDate);
        dateDuJours = Utilitaire.ajoutJourDate(dateDuJours, -1) ;
        String query ;
        // System.out.println(dateMin+"  date du jour ="+dateDuJours);
        if(dateDuJours.equals(dateMin)){
            query = "SELECT * FROM V_ETATCAISSE_devise_AR";
        }else{
            query= "SELECT " +
            " r.ID, " +
            " r.IDCAISSE, " +
            " c.val AS idcaisseLib, " +
            " c.idtypecaisse, " +
            " tc.desce AS idtypecaisselib, " +
            " c.idpoint, " +
            " p.desce AS idpointlib, " +
            " r.DATY dateDernierReport, " +
            " CAST(NVL(r.MONTANT*taux.taux,0) AS number(30,2)) montantDernierReport, " +
            " CAST(NVL(mvt.debit,0) AS number(30,2)) debit, " +
            " CAST(NVL(mvt.credit,0) AS number(30,2)) credit, " +
            " CAST((NVL(mvt.credit,0) + NVL(r.MONTANT*taux.taux,0) - NVL(mvt.debit,0)) AS number(30,2)) reste, " +
            " 'AR' AS devise " +
            "FROM REPORTCAISSE_devise r, " +
            " (" +
            "     SELECT r.IDCAISSE, MAX(r.DATY) maxDateReport " +
            "     FROM REPORTCAISSE_devise r " +
            "     WHERE r.ETAT = 11 " +
            "     AND r.DATY <  '"+ Utilitaire.datetostring(dateMin) + "'"+
            "     GROUP BY r.IDCAISSE " +
            " ) rm, " +
            " (" +
            "     SELECT m.IDCAISSE, SUM(nvl((m.DEBIT*t.taux),0)) DEBIT, SUM(nvl((m.CREDIT*t.taux),0)) CREDIT " +
            "     FROM MOUVEMENTCAISSE m, " +
            "     (" +
            "         SELECT r.IDCAISSE, MAX(r.DATY) maxDateReport " +
            "         FROM REPORTCAISSE r " +
            "         WHERE r.ETAT = 11 " +
            "         AND r.DATY < '"+ Utilitaire.datetostring(dateMin) + "'"+
            "         GROUP BY r.IDCAISSE " +
            "     ) rm, " +
            "     ( " +
            "         SELECT ta.* " +
            "         FROM TAUXDECHANGE ta, " +
            "         ( " +
            "             SELECT max(daty) AS daty, iddevise " +
            "             FROM TAUXDECHANGE t " +
            "             WHERE daty <= '"+ Utilitaire.datetostring(dateMin)  +"'"+
            "             GROUP BY iddevise " +
            "         ) tmax " +
            "         WHERE ta.daty = tmax.daty " +
            "         AND ta.iddevise = tmax.iddevise " +
            "     ) t " +
            "     WHERE m.iddevise = t.iddevise(+) " +
            "     AND m.IDCAISSE = rm.idcaisse(+) " +
            "     AND m.DATY > rm.maxDateReport " +
            "     AND m.DATY <= '" +Utilitaire.datetostring(dateMax)  +"'"+
            "     GROUP BY m.IDCAISSE " +
            " ) mvt, " +
            " ( " +
            "     SELECT ta.* " +
            "     FROM TAUXDECHANGE ta, " +
            "     ( " +
            "         SELECT max(daty) AS daty, iddevise " +
            "         FROM TAUXDECHANGE t " +
            "         WHERE daty <= '" +Utilitaire.datetostring(dateMin)  +"'"+
            "         GROUP BY iddevise " +
            "     ) tmax " +
            "     WHERE ta.daty = tmax.daty " +
            "     AND ta.iddevise = tmax.iddevise " +
            " ) taux, " +
            " caisse c, " +
            " typecaisse tc, " +
            " point p " +
            "WHERE r.DATY = rm.maxDateReport " +
            "AND r.IDDEVISE = taux.iddevise(+) " +
            "AND r.ETAT = 11 " +
            "AND r.IDCAISSE = rm.IDCAISSE " +
            "AND r.IDCAISSE = c.ID(+) " +
            "AND r.IDCAISSE = mvt.idcaisse(+) " +
            "AND c.IDTYPECAISSE = tc.ID(+) " +
            "AND c.IDPOINT = p.ID";
        }
            return query;
        }
    }
