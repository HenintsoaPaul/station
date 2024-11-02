package ecritureManip;

import bean.ClassMAPTable;

import java.util.Date;

public class Ecriture extends ClassMAPTable {
    String id,compte;
    double debit,credit;
    String remarque,libellePiece,idmere,reference_engagement,compte_aux,lettrage,journal;
    int exercice,etat;
    Date daty;
    String folio,analytique,source;

    public Ecriture() {
        this.setNomTable("COMPTA_SOUS_ECRITURE");
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

    public String getRemarque() {
        return remarque;
    }

    public void setRemarque(String remarque) {
        this.remarque = remarque;
    }

    public String getLibellePiece() {
        return libellePiece;
    }

    public void setLibellePiece(String libellePiece) {
        this.libellePiece = libellePiece;
    }

    public String getIdmere() {
        return idmere;
    }

    public void setIdmere(String idmere) {
        this.idmere = idmere;
    }

    public String getReference_engagement() {
        return reference_engagement;
    }

    public void setReference_engagement(String reference_engagement) {
        this.reference_engagement = reference_engagement;
    }

    public String getCompte_aux() {
        return compte_aux;
    }

    public void setCompte_aux(String compte_aux) {
        this.compte_aux = compte_aux;
    }

    public String getLettrage() {
        return lettrage;
    }

    public void setLettrage(String lettrage) {
        this.lettrage = lettrage;
    }

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public int getExercice() {
        return exercice;
    }

    public void setExercice(int exercice) {
        this.exercice = exercice;
    }

    public int getEtat() {
        return etat;
    }

    public void setEtat(int etat) {
        this.etat = etat;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    public String getFolio() {
        return folio;
    }

    public void setFolio(String folio) {
        this.folio = folio;
    }

    public String getAnalytique() {
        return analytique;
    }

    public void setAnalytique(String analytique) {
        this.analytique = analytique;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    @Override
    public String getTuppleID() {
        return "id";
    }

    @Override
    public String getAttributIDName() {
        return id;
    }
}
