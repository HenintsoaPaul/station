package mg.cnaps.compta;

import java.sql.Date;

public class ComptaSousEcritureLib extends ComptaSousEcriture{
    String numero;
    String idJournal;
    String ecriture;
    Date dateComptable;
    int horsExercice;
    String od;
    String origine;
  

    String libellePiece ;
  

    String analytique;


      public String getAnalytique() {
        return analytique;
    }
    public void setAnalytique(String analytique) {
        this.analytique = analytique;
    }

      public String getLibellePiece() {
        return libellePiece;
    }
    public void setLibellePiece(String libellePiece) {
        this.libellePiece = libellePiece;
    }

    public void setIdJournal(String idJournal){
        this.idJournal=idJournal;
    }
    public String getIdJournal(){
        return this.idJournal;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getEcriture() {
        return ecriture;
    }

    public void setEcriture(String ecriture) {
        this.ecriture = ecriture;
    }

    public Date getDateComptable() {
        return dateComptable;
    }

    public void setDateComptable(Date dateComptable) {
        this.dateComptable = dateComptable;
    }

    public int getHorsExercice() {
        return horsExercice;
    }

    public void setHorsExercice(int horsExercice) {
        this.horsExercice = horsExercice;
    }

    public String getOd() {
        return od;
    }

    public void setOd(String od) {
        this.od = od;
    }

    public String getOrigine() {
        return origine;
    }

    public void setOrigine(String origine) {
        this.origine = origine;
    }

    public ComptaSousEcritureLib() throws Exception {
        super();
    }
}
