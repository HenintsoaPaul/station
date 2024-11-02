package mg.cnaps.compta;

public class ComptaLettrageLib extends ComptaLettrage {
    String compte;

    public ComptaLettrageLib() {
        super.setNomTable("COMPTA_LETTRAGE_LIB");
    }   

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }
}
