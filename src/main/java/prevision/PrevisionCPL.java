package prevision;

public class PrevisionCPL extends Prevision {
    String idCaisseLib;
    String idVenteLib;
    String idDeviseLib;
    String idOpLib;
    double debit;
    double credit;
    double effectifdebit;
    double effectifcredit;
    double depenseecart;
    double recetteecart;

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

    public double getEffectifdebit() {
        return effectifdebit;
    }

    public void setEffectifdebit(double effectifdebit) {
        this.effectifdebit = effectifdebit;
    }

    public double getEffectifcredit() {
        return effectifcredit;
    }

    public void setEffectifcredit(double effectifcredit) {
        this.effectifcredit = effectifcredit;
    }

    public double getDepenseecart() {
        return depenseecart;
    }

    public void setDepenseecart(double depenseecart) {
        this.depenseecart = depenseecart;
    }

    public double getRecetteecart() {
        return recetteecart;
    }

    public void setRecetteecart(double recetteecart) {
        this.recetteecart = recetteecart;
    }
    
    
    public PrevisionCPL(){
        this.setNomTable("PREVISION_CPL");
    }

    public String getIdCaisseLib() {
        return idCaisseLib;
    }
    public void setIdCaisseLib(String idCaisseLib) {
        this.idCaisseLib = idCaisseLib;
    }
    public String getIdVenteLib() {
        return idVenteLib;
    }
    public void setIdVenteLib(String idVenteLib) {
        this.idVenteLib = idVenteLib;
    }
    public String getIdDeviseLib() {
        return idDeviseLib;
    }
    public void setIdDeviseLib(String idDeviseLib) {
        this.idDeviseLib = idDeviseLib;
    }
    public String getIdOpLib() {
        return idOpLib;
    }
    public void setIdOpLib(String idOpLib) {
        this.idOpLib = idOpLib;
    }

    

}
