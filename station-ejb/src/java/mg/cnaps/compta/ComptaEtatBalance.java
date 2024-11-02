package mg.cnaps.compta;

import bean.ClassMAPTable;
import java.sql.Date;
import utilitaire.Utilitaire;

public class ComptaEtatBalance extends ClassMAPTable {
    private String compte, libelle_compte, gras, fond, compteDeuxChiffres, compteUnChiffre, typecompte;
    private boolean isTotaux;
    private double debit, credit, solde_debit, solde_credit, ant_debit, ant_credit;
    private java.sql.Date daty;
    private int exercice;
    private double debit_n, credit_n,
            debit_n_1, credit_n_1,
            debit_n_2, credit_n_2,
            debit_m_1, credit_m_1,
            debit_m_2, credit_m_2,
            debit_m_3, credit_m_3,
            debit_m_4, credit_m_4,
            debit_m_5, credit_m_5,
            debit_m_6, credit_m_6,
            debit_m_7, credit_m_7,
            debit_m_8, credit_m_8,
            debit_m_9, credit_m_9,
            debit_m_10, credit_m_10,
            debit_m_11, credit_m_11,
            debit_m_12, credit_m_12;

    public ComptaEtatBalance() {
        setNomTable("compta_balance_etat");
    }

    public boolean isIsTotaux() {
        return isTotaux;
    }

    public void setIsTotaux(boolean isTotaux) {
        this.isTotaux = isTotaux;
    }

    public String getCompteDeuxChiffres() {
        return compteDeuxChiffres;
    }

    public void setCompteDeuxChiffres(String compteDeuxChiffres) {
        this.compteDeuxChiffres = compteDeuxChiffres;
    }

    public String getCompteUnChiffre() {
        return compteUnChiffre;
    }

    public void setCompteUnChiffre(String compteUnChiffre) {
        this.compteUnChiffre = compteUnChiffre;
    }

    public String getCompte() {
        return compte == null ? "" : compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
        if (compte.length() > 2)
            setCompteDeuxChiffres(compte.substring(0, 2));
        if (compte.length() > 1)
            setCompteUnChiffre(compte.substring(0, 1));
    }

    public String getLibelle_compte() {
        // return libelle_compte;
        if (libelle_compte != null)
            return libelle_compte;
        else
            return "";
    }

    public void setLibelle_compte(String libelle_compte) {
        this.libelle_compte = libelle_compte;
    }

    public String getGras() {
        return gras;
    }

    public void setGras(String gras) {
        this.gras = gras;
    }

    public String getFond() {
        return fond;
    }

    public void setFond(String fond) {
        this.fond = fond;
    }

    public double getDebit() {
        return debit;
    }

    public void setDebit(double debit) {
        this.debit = debit;
    }

    public double getCredit() {
        return credit;
    }

    public void setCredit(double credit) {
        this.credit = credit;
    }

    public double getSolde_debit() {
        return solde_debit;
    }

    public void setSolde_debit(double solde_debit) {
        this.solde_debit = solde_debit;
    }

    public double getSolde_credit() {
        return solde_credit;
    }

    public void setSolde_credit(double solde_credit) {
        this.solde_credit = solde_credit;
    }

    public double getAnt_debit() {
        return ant_debit;
    }

    public void setAnt_debit(double ant_debit) {
        this.ant_debit = ant_debit;
    }

    public double getAnt_credit() {
        return ant_credit;
    }

    public void setAnt_credit(double ant_credit) {
        this.ant_credit = ant_credit;
    }

    @Override
    public String getTuppleID() {
        return "";
    }

    @Override
    public String getAttributIDName() {
        return "";
    }

    public String getTypecompte() {
        return typecompte;
    }

    public void setTypecompte(String typecompte) {
        this.typecompte = typecompte;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public double getDebit_n() {
        return debit_n;
    }

    public void setDebit_n(double debit_n) {
        this.debit_n = debit_n;
    }

    public double getCredit_n() {
        return credit_n;
    }

    public void setCredit_n(double credit_n) {
        this.credit_n = credit_n;
    }

    public double getDebit_n_1() {
        return debit_n_1;
    }

    public void setDebit_n_1(double debit_n_1) {
        this.debit_n_1 = debit_n_1;
    }

    public double getCredit_n_1() {
        return credit_n_1;
    }

    public void setCredit_n_1(double credit_n_1) {
        this.credit_n_1 = credit_n_1;
    }

    public double getDebit_n_2() {
        return debit_n_2;
    }

    public void setDebit_n_2(double debit_n_2) {
        this.debit_n_2 = debit_n_2;
    }

    public double getCredit_n_2() {
        return credit_n_2;
    }

    public void setCredit_n_2(double credit_n_2) {
        this.credit_n_2 = credit_n_2;
    }

    public double getDebit_m_1() {
        return debit_m_1;
    }

    public void setDebit_m_1(double debit_m_1) {
        this.debit_m_1 = debit_m_1;
    }

    public double getCredit_m_1() {
        return credit_m_1;
    }

    public void setCredit_m_1(double credit_m_1) {
        this.credit_m_1 = credit_m_1;
    }

    public double getDebit_m_2() {
        return debit_m_2;
    }

    public void setDebit_m_2(double debit_m_2) {
        this.debit_m_2 = debit_m_2;
    }

    public double getCredit_m_2() {
        return credit_m_2;
    }

    public void setCredit_m_2(double credit_m_2) {
        this.credit_m_2 = credit_m_2;
    }

    public double getDebit_m_3() {
        return debit_m_3;
    }

    public void setDebit_m_3(double debit_m_3) {
        this.debit_m_3 = debit_m_3;
    }

    public double getCredit_m_3() {
        return credit_m_3;
    }

    public void setCredit_m_3(double credit_m_3) {
        this.credit_m_3 = credit_m_3;
    }

    public double getDebit_m_4() {
        return debit_m_4;
    }

    public void setDebit_m_4(double debit_m_4) {
        this.debit_m_4 = debit_m_4;
    }

    public double getCredit_m_4() {
        return credit_m_4;
    }

    public void setCredit_m_4(double credit_m_4) {
        this.credit_m_4 = credit_m_4;
    }

    public double getDebit_m_5() {
        return debit_m_5;
    }

    public void setDebit_m_5(double debit_m_5) {
        this.debit_m_5 = debit_m_5;
    }

    public double getCredit_m_5() {
        return credit_m_5;
    }

    public void setCredit_m_5(double credit_m_5) {
        this.credit_m_5 = credit_m_5;
    }

    public double getDebit_m_6() {
        return debit_m_6;
    }

    public void setDebit_m_6(double debit_m_6) {
        this.debit_m_6 = debit_m_6;
    }

    public double getCredit_m_6() {
        return credit_m_6;
    }

    public void setCredit_m_6(double credit_m_6) {
        this.credit_m_6 = credit_m_6;
    }

    public double getDebit_m_7() {
        return debit_m_7;
    }

    public void setDebit_m_7(double debit_m_7) {
        this.debit_m_7 = debit_m_7;
    }

    public double getCredit_m_7() {
        return credit_m_7;
    }

    public void setCredit_m_7(double credit_m_7) {
        this.credit_m_7 = credit_m_7;
    }

    public double getDebit_m_8() {
        return debit_m_8;
    }

    public void setDebit_m_8(double debit_m_8) {
        this.debit_m_8 = debit_m_8;
    }

    public double getCredit_m_8() {
        return credit_m_8;
    }

    public void setCredit_m_8(double credit_m_8) {
        this.credit_m_8 = credit_m_8;
    }

    public double getDebit_m_9() {
        return debit_m_9;
    }

    public void setDebit_m_9(double debit_m_9) {
        this.debit_m_9 = debit_m_9;
    }

    public double getCredit_m_9() {
        return credit_m_9;
    }

    public void setCredit_m_9(double credit_m_9) {
        this.credit_m_9 = credit_m_9;
    }

    public double getDebit_m_10() {
        return debit_m_10;
    }

    public void setDebit_m_10(double debit_m_10) {
        this.debit_m_10 = debit_m_10;
    }

    public double getCredit_m_10() {
        return credit_m_10;
    }

    public void setCredit_m_10(double credit_m_10) {
        this.credit_m_10 = credit_m_10;
    }

    public double getDebit_m_11() {
        return debit_m_11;
    }

    public void setDebit_m_11(double debit_m_11) {
        this.debit_m_11 = debit_m_11;
    }

    public double getCredit_m_11() {
        return credit_m_11;
    }

    public void setCredit_m_11(double credit_m_11) {
        this.credit_m_11 = credit_m_11;
    }

    public double getDebit_m_12() {
        return debit_m_12;
    }

    public void setDebit_m_12(double debit_m_12) {
        this.debit_m_12 = debit_m_12;
    }

    public double getCredit_m_12() {
        return credit_m_12;
    }

    public void setCredit_m_12(double credit_m_12) {
        this.credit_m_12 = credit_m_12;
    }

    public void setAnt_debit(java.sql.Date date) throws Exception {
        setAnt("Debit", date);
    }

    public void setAnt_credit(java.sql.Date date) throws Exception {
        setAnt("Credit", date);
    }

    public void setAnt(String typeSolde, Date date) throws Exception {
        int mois;
        double montant;
        mois = Utilitaire.getMois(date);
        if (mois == 1 && typeSolde == "Debit")
            setAnt_debit(getDebit_n());
        if (mois == 1 && typeSolde == "Credit")
            setAnt_credit(getCredit_n());
        else {
            Class[] paramTypes = { double.class };
            montant = (Double) this.getClass().getMethod("get" + typeSolde + "_m_" + mois, paramTypes).invoke(this);
            this.getClass().getMethod("set" + typeSolde + "_m_" + mois, paramTypes).invoke(this,
                    new Object[] { montant });
        }
    }

    public void setNomTableMouvementSelonTypeCompte(int typeCompte) {
        if (typeCompte == ConstanteComptabilite.TYPE_COMPTE_ANALYTIQUE) {
            this.setNomTable("COMPTA_MOUVEMENT_ANALYTIQUE");
        }
        if (typeCompte == ConstanteComptabilite.TYPE_COMPTE_GENERAL) {
            this.setNomTable("COMPTA_MOUVEMENT_GENERAL");
        }
    }

    public void setNomTableReportSelonTypeCompte(int typeCompte) {
        if (typeCompte == ConstanteComptabilite.TYPE_COMPTE_ANALYTIQUE) {
            this.setNomTable("REPORTSOLDE_ANALYTIQUE");
        }
        if (typeCompte == ConstanteComptabilite.TYPE_COMPTE_GENERAL) {
            this.setNomTable("REPORTSOLDE_GENERAL");
        }
    }
}