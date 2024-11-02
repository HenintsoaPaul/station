/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassMAPTable;
import bean.TypeObjet;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import utilitaire.Constante;

import utilitaire.UtilDB;
import utilitaire.Utilitaire;

public class ComptaCompte extends ClassMAPTable {

    private String id, compte, libelle, typeCompte, classe, analytique_obli;
    private String idjournal;
    List<ComptaSousEcriture> mouvements = new ArrayList<ComptaSousEcriture>();
    List<ReportSolde> reports = new ArrayList<ReportSolde>();
    double reportDebit;
    double reportCredit;
    double mouvementDebit;
    double mouvementCredit;

    @Override
    public String[] getMotCles() {
        String[] motCles={"compte","libelle"};
        return motCles;
    }
    
    public List<ComptaSousEcriture> getMouvements() {
        return mouvements;
    }

    public void setMouvements(List<ComptaSousEcriture> mouvements) {
        this.mouvements = mouvements;
    }

    public List<ReportSolde> getReports() {
        return reports;
    }

    public void setReports(List<ReportSolde> reports) {
        this.reports = reports;
    }

    public double getReportDebit() {
        return reportDebit;
    }

    public void setReportDebit(double reportDebit) {
        this.reportDebit = reportDebit;
    }

    public double getReportCredit() {
        return reportCredit;
    }

    public void setReportCredit(double reportCredit) {
        this.reportCredit = reportCredit;
    }

    public double getMouvementDebit() {
        return mouvementDebit;
    }

    public void setMouvementDebit(double mouvementDebit) {
        this.mouvementDebit = mouvementDebit;
    }

    public double getMouvementCredit() {
        return mouvementCredit;
    }

    public void setMouvementCredit(double mouvementCredit) {
        this.mouvementCredit = mouvementCredit;
    }

    public void addMouvement(ComptaSousEcriture mouvement) {
        mouvements.add(mouvement);
        mouvementDebit += mouvement.getDebit();
        mouvementCredit += mouvement.getCredit();
    }

    public void addReport(ReportSolde report) {
        reports.add(report);
        reportCredit += report.getCredit();
        reportDebit += report.getDebit();
    }

    public double getTotalDebit() {
        return reportDebit + mouvementDebit;
    }

    public double getTotalCredit() {
        return mouvementCredit + reportCredit;
    }

    public double getSoldeCredit() {
        return Math.max(getTotalCredit() - getTotalDebit(), 0);
    }

    public double getSoldeDebit() {
        return Math.max(getTotalDebit() - getTotalCredit(), 0);
    }

    public String getAnalytique_obli() {
        return analytique_obli;
    }

    public void setAnalytique_obli(String analytique_obli) throws Exception {
        if (getMode() == "modif") {
            if (analytique_obli.compareToIgnoreCase("0") == 0 || analytique_obli.compareToIgnoreCase("1") == 0)
                this.analytique_obli = analytique_obli;
            // else throw new Exception("Valeur non autorisé pour la compte analitique
            // obligatoire!");
        }
        this.analytique_obli = analytique_obli;
    }

    public ComptaCompte(String id, String compte, String libelle, String typeCompte, String classe) throws Exception {
        super.setNomTable("compta_compte");
        this.setId(id);
        this.setLibelle(libelle);
        this.setTypeCompte(typeCompte);
        this.setClasse(classe);
        this.setCompte(compte);
    }

    public String getValColLibelle() {
        return libelle+" : "+compte;
    }

    public ComptaCompte(String compte, String libelle, String typeCompte, String classe) throws Exception {
        super.setNomTable("compta_compte");
        this.setLibelle(libelle);
        this.setTypeCompte(typeCompte);
        this.setClasse(classe);
        this.setCompte(compte);
    }

    public ComptaCompte() {
        super.setNomTable("compta_compte");
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("COC", "GETSEQCOMPTACOMPTE");
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

    public String getCompte() {
        return Utilitaire.champNull(compte);
    }

    public void setCompte(String compte) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.compte = compte;
            return;
        }
        System.out.println("COMPTEEE "+compte);
        if (Utilitaire.champNull(compte).compareTo("") == 0)
            throw new Exception(" Veuillez remplir le champ compte");
        this.compte = compte;
    }

    public String getLibelle() {
        return Utilitaire.champNull(libelle);
    }

    public void setLibelle(String libelle) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.libelle = libelle;
            return;
        }
        if (Utilitaire.champNull(libelle).compareTo("") == 0)
            throw new Exception("Veuillez remplir le champ libelle");
        this.libelle = libelle;
    }

    public String getTypeCompte() {
        return Utilitaire.champNull(typeCompte);
    }

    public void setTypeCompte(String typeCompte) throws Exception {
        if (getMode().compareTo("modif") != 0) {
            this.typeCompte = typeCompte;
            return;
        }
        if (typeCompte == "")
            throw new Exception("Champ Type Compte manquant");
        this.typeCompte = typeCompte;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }
    
    public String getCompteReflechi(String compte) {
        String temp = "";
        if (compte.startsWith("6")) {
            temp = "90" + compte.substring(0, 2) + compte.substring(4, 5) + "00";
        }
        return temp;
    }

    public String getIdjournal() {
        return idjournal;
    }

    public void setIdjournal(String idjournal) {
        this.idjournal = idjournal;
    }

    private void controlerCompteIfExists(Connection c)throws Exception{
        ComptaCompte comptaCompte = new ComptaCompte();
        ComptaCompte[] comptaComptes = (ComptaCompte[]) CGenUtil.rechercher(comptaCompte, null, null, c,
                " and compte ='" + this.compte + "'");
        if (comptaComptes.length > 0) {
            throw new Exception("Compte existe deja");
        }
    }

    @Override
    public void controler(Connection c) throws Exception {
        controlerCompteIfExists(c);
        if (this.typeCompte.compareTo(Constante.COMPTA_TYPE_COMPTE_GENERAL) == 0) {
            controlerGeneral();
        } else if (this.typeCompte.compareTo(Constante.COMPTA_TYPE_COMPTE_AUTRE) == 0) {
            controlerAutre();
        } else {
            controlerAnalytique();
        }
    }

    public void controlerGeneral() throws Exception {
        if (!Utilitaire.isNumeric(this.getCompte())) {
            throw new Exception("Le compte doit être numérique");
        }
        if (this.getCompte().length() > Constante.COMPTA_COMPTE_GEN_MAX_CHAR) {
            throw new Exception(String.format("Le compte ne doit pas dépasser le nombre de caractères maximum %d",
                    Constante.COMPTA_COMPTE_GEN_MAX_CHAR));
        }
        String premierLettre = this.getCompte().subSequence(0, 1).toString();
        if (!(Utilitaire.stringToInt(premierLettre) >= 1 && Utilitaire.stringToInt(premierLettre) <= 7)) {
            throw new Exception("Le compte ne correspond pas au type de compte");
        }
        this.setCompte(Utilitaire.completerIntFin(Constante.COMPTA_COMPTE_GEN_MAX_CHAR, this.compte));
        this.setClasse(premierLettre);
    }

    public void controlerAutre() throws Exception {
        if (!Utilitaire.isNumeric(this.getCompte())) {
            throw new Exception("Le compte doit être numérique");
        }
        String premierLettre = this.getCompte().subSequence(0, 1).toString();
        if (premierLettre.compareTo("8") != 0) {
            throw new Exception("Le compte doit commencer par 8 pour ce type de compte");
        }
        if (this.getCompte().length() > Constante.COMPTA_COMPTE_GEN_MAX_CHAR) {
            throw new Exception(String.format("Le compte ne doit pas dépasser le nombre de caractères maximum %d",
                    Constante.COMPTA_COMPTE_GEN_MAX_CHAR));
        }
        this.setCompte(Utilitaire.completerIntFin(Constante.COMPTA_COMPTE_GEN_MAX_CHAR, this.compte));
        this.setClasse(premierLettre);
    }

    public void controlerAnalytique() throws Exception {
        if (this.getCompte().length() > Constante.COMPTA_COMPTE_ANAL_MAX_CHAR) {
            throw new Exception(String.format("Le compte ne doit pas dépasser le nombre de caractères maximum %d",
                    Constante.COMPTA_COMPTE_ANAL_MAX_CHAR));
        }
        String premierLettre = this.getCompte().subSequence(0, 1).toString();
        if ((Utilitaire.stringToInt(premierLettre) >= 1 && Utilitaire.stringToInt(premierLettre) <= 8)) {
            throw new Exception("Le compte ne correspond pas au type de compte");
        }
        this.setCompte(Utilitaire.completerIntFin(Constante.COMPTA_COMPTE_ANAL_MAX_CHAR, this.compte));
        this.setClasse("8");
    }

    public void creerJournalCompte(String u, Connection c) throws Exception {
        try {
            JournalCompte journalCompte = new JournalCompte(this.idjournal, this.compte);
            journalCompte.createObject(u, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

    }

    public void modifierJournalCompte(String u, Connection c) throws Exception {
        try {
            JournalCompte journalCompte = new JournalCompte();
            JournalCompte[] lJournalCompte = (JournalCompte[]) CGenUtil.rechercher(journalCompte, null, null, c,
                    String.format(" and desce = '%s'", this.compte));
            if (lJournalCompte.length > 0) {
                journalCompte = lJournalCompte[0];
                journalCompte.setVal(this.idjournal);
                journalCompte.updateToTableWithHisto(u, c);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

    }

    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        int retour = super.updateToTableWithHisto(refUser, c);
        if (this.compte.startsWith("512")) {
            modifierJournalCompte(refUser, c);
        }
        return retour;
    }

    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        ClassMAPTable classMAPTable = super.createObject(u, c);
        if (this.compte.startsWith("512")) {
            creerJournalCompte(u, c);
        }
        return classMAPTable;
    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        controlerCompteIfExists(c);
        if (this.typeCompte.compareTo(Constante.COMPTA_TYPE_COMPTE_ANALYTIQUE) == 0) {
            controlerComptaSousEcriture(c, "analytique");
            controlerAnalytique();
        } else if (this.typeCompte.compareTo(Constante.COMPTA_TYPE_COMPTE_AUTRE) == 0) {
            controlerComptaSousEcriture(c, "analytique");
            controlerAutre();
        } else {
            controlerComptaSousEcriture(c, "analytique");
            controlerGeneral();
        }
    }

    public void controlerComptaSousEcriture(Connection c, String type) throws Exception {
        ComptaSousEcriture sousEcriture = new ComptaSousEcriture();
        ComptaSousEcriture[] lComptaSousEcriture = (ComptaSousEcriture[]) CGenUtil.rechercher(sousEcriture, null, null,
                c, String.format(" and %s = '%s'", type, this.getCompte()));
        if (lComptaSousEcriture.length > 0) {
            throw new Exception("Ce compte est déjà utilisé dans une écriture");
        }
    }

    @Override
    public void controlerDelete(Connection c) throws Exception {
        if (this.getTypeCompte().compareTo(Constante.COMPTA_TYPE_COMPTE_ANALYTIQUE) == 0) {
            controlerComptaSousEcriture(c, "analytique");
        } else {
            controlerComptaSousEcriture(c, "analytique");
        }
    }

}
