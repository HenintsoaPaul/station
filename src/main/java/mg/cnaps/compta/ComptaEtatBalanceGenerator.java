package mg.cnaps.compta;

import java.sql.Connection;
import java.util.LinkedHashMap;
import java.util.Map;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.UtilDB;

public class ComptaEtatBalanceGenerator extends ClassMAPTable {
    int exercice;
    String typeCompte;
    int moisDebut;
    int moisFin;
    String debutCompte;
    String finCompte;
    String etat;

    @Override
    public String getTuppleID() {
        throw new UnsupportedOperationException("Not supported yet.");

    }

    @Override
    public String getAttributIDName() {
        throw new UnsupportedOperationException("Not supported yet.");

    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public String getTypeCompte() {
        return typeCompte;
    }

    public void setTypeCompte(String typeCompte) {
        this.typeCompte = typeCompte;
    }

    public int getMoisDebut() {
        return moisDebut;
    }

    public void setMoisDebut(int moisDebut) {
        this.moisDebut = moisDebut;
    }

    public int getMoisFin() {
        return moisFin;
    }

    public void setMoisFin(int moisFin) {
        this.moisFin = moisFin;
    }

    public String getDebutCompte() {
        return debutCompte;
    }

    public void setDebutCompte(String debutCompte) {
        this.debutCompte = debutCompte;
    }

    public String getFinCompte() {
        return finCompte;
    }

    public void setFinCompte(String finCompte) {
        this.finCompte = finCompte;
    }

    public String getEtat() {
        return etat;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public ComptaEtatBalanceGenerator(int exercice, String typeCompte, int moisDebut, int moisFin,
            String debutCompte, String finCompte, String etat) {
        setExercice(exercice);
        setTypeCompte(typeCompte);
        setMoisDebut(moisDebut);
        setMoisFin(moisFin);
        setDebutCompte(debutCompte);
        setFinCompte(finCompte);
        setEtat(etat);
    }

    public ComptaEtatBalanceGenerator() {

    }

    public String getConditionEtat()throws Exception{
        try {
            if(this.etat!=null && !this.etat.equals("0")){
                return "AND etat="+this.etat;
            }
            return "";
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }  

    }

    public String getRequeteMouvement() throws Exception {
        try {
            ComptaEtatBalance etatBalance = new ComptaEtatBalance();
            etatBalance.setExercice(this.exercice);
            etatBalance.setNomTableMouvementSelonTypeCompte(Integer.valueOf(this.typeCompte));
            String[] colInt = { "mois", "annee" };
            String[] valInt = { String.valueOf(this.getMoisDebut()), String.valueOf(this.getMoisFin()),
                    String.valueOf(exercice), String.valueOf(exercice)};
            String[] colGroupe = { "compte", "libelle_compte", "typecompte", "chiffre3", "chiffre2" };
            String[] colSomme = { "debit", "credit" };
            String retour = "SELECT " + CGenUtil.getListeChampGroupeSomme(colGroupe, colSomme) + " FROM " +
                    etatBalance.getNomTable() + " WHERE " +
                    CGenUtil.makeWhere(etatBalance) + CGenUtil.makeWhereIntervalle(colInt, valInt)+" "+getConditionEtat() + " GROUP BY "
                    + CGenUtil.getListeChampGroupeSomme(colGroupe, null) + " ORDER BY chiffre3,compte ASC";
                    return retour;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public String getRequeteReport() throws Exception {
        try {
            ComptaEtatBalance etatBalance = new ComptaEtatBalance();
            etatBalance.setExercice(this.exercice);
            System.out.println("TYPE DE COMPTE : " + this.typeCompte);
            etatBalance.setNomTableReportSelonTypeCompte(Integer.valueOf(this.typeCompte));

            int moisReport = this.getMoisDebut() - 1;

            String[] colInt = { "mois", "annee" };
            String[] valInt = { "1", String.valueOf(moisReport), String.valueOf(exercice), String.valueOf(exercice) };
            String[] colGroupe = { "compte", "libelle_compte", "typecompte", "chiffre3", "chiffre2" };
            String[] colSomme = { "debit", "credit" };

            if (this.getMoisDebut() == 1) {
                etatBalance.setNomTable("REPORTSOLDE_JANVIER");
                colInt = new String[] { "annee", "typecompte" };
                valInt = new String[] { String.valueOf(exercice), String.valueOf(exercice), typeCompte, typeCompte };
            }

            String retour = "SELECT " + CGenUtil.getListeChampGroupeSomme(colGroupe, colSomme) + " FROM "
                    + etatBalance.getNomTable() + " WHERE " + CGenUtil.makeWhere(etatBalance)
                    + CGenUtil.makeWhereIntervalle(colInt, valInt) + " GROUP BY "
                    + CGenUtil.getListeChampGroupeSomme(colGroupe, null) + " ORDER BY chiffre3,compte ASC";
            return retour;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public ComptaBalanceLigne[] getAllComptaBalanceLigne(Connection c) throws Exception {
        try {
            String requeteInterne = "SELECT CASE WHEN report.compte is NULL THEN mouvement.compte ELSE report.compte END compte, "
                    + "CASE WHEN report.chiffre3 is NULL THEN mouvement.chiffre3 ELSE report.chiffre3 END chiffre3, CASE WHEN report.chiffre2 is NULL "
                    + "THEN mouvement.chiffre2 ELSE report.chiffre2 END chiffre2, CASE WHEN report.libelle_compte is NULL THEN mouvement.libelle_compte "
                    + "ELSE report.libelle_compte END libelleCompte, cast(coalesce(report.debit,0) as numeric(30,2)) AS anterieurDebit, cast(coalesce(report.credit,0) as numeric(30,2)) AS anterieurCredit, cast(coalesce(mouvement.debit,0) as numeric(30,2)) AS mouvementDebit, cast(coalesce(mouvement.credit,0) as numeric(30,2)) AS mouvementCredit "
                    + "FROM (" + getRequeteReport() + ") report FULL JOIN (" + getRequeteMouvement()
                    + ") mouvement ON report.compte = mouvement.compte";

            String requeteInterne1 = requeteInterne + " ORDER BY chiffre3,compte ASC";

            ComptaBalanceLigne balance = new ComptaBalanceLigne();
            balance.setNomTable("balance_vide");
            return (ComptaBalanceLigne[]) CGenUtil.rechercher(balance, requeteInterne1, c);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

    public ComptaEtatBalanceChiffre2[] regrouperParChiffre2(ComptaBalanceLigne[] tab) throws Exception {
        LinkedHashMap<Integer, ComptaEtatBalanceChiffre2> listeComptaBalanceC2 = new LinkedHashMap<Integer, ComptaEtatBalanceChiffre2>();
        for (int i = 0; i < tab.length; i++) {
            ComptaEtatBalanceChiffre2 balance = listeComptaBalanceC2.get(Integer.valueOf(tab[i].getChiffre2()));
            if (balance != null) {
                balance.ajouter(tab[i]);
            } else {
                ComptaEtatBalanceChiffre2 nouvBalance = new ComptaEtatBalanceChiffre2();
                nouvBalance.setComptePrefix(Integer.valueOf(tab[i].getChiffre2()));
                listeComptaBalanceC2.put(Integer.valueOf(tab[i].getChiffre2()), nouvBalance);
                nouvBalance.ajouter(tab[i]);
            }
        }
        return listeComptaBalanceC2.values().toArray(new ComptaEtatBalanceChiffre2[0]);
    }

    public ComptaEtatBalanceChiffre2[] genererBalance(Connection c) throws Exception {
        int verif = 0;
        try {
            if (c == null) {
                c = new UtilDB().GetConn();
                verif = 1;
            }
            ComptaBalanceLigne[] lignes = getAllComptaBalanceLigne(c);
            return regrouperParChiffre2(lignes);
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null && verif == 1)
                c.close();
        }
    }

    public String getLink() throws Exception {
        String rep = "exercice=" + this.exercice + "&typeCompte=" + this.typeCompte + "&moisDebut=" + this.moisDebut;
        rep += "&moisFin=" + this.moisFin + "&debutCompte=" + this.debutCompte + "&finCompte=" + this.finCompte;
        rep += "&etat=" + this.etat;
        return rep;
    }
}
