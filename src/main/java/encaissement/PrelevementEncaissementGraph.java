/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package encaissement;

import bean.ClassMAPTable;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class PrelevementEncaissementGraph extends ClassMAPTable{
    String idPrelevement,idEncaissement,idPompiste,nomuser,idPompe,nomMagasin;
    double venteCarburant;
    Date daty;

    public PrelevementEncaissementGraph() {
        this.setNomTable("vente_carbu_client");
    }
    
    @Override
    public String getTuppleID() {
        return idPrelevement;
    }

    @Override
    public String getAttributIDName() {
        return "idPrelevement";
    }

    public String getIdPrelevement() {
        return idPrelevement;
    }

    public void setIdPrelevement(String idPrelevement) {
        this.idPrelevement = idPrelevement;
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }

    public String getIdPompiste() {
        return idPompiste;
    }

    public void setIdPompiste(String idPompiste) {
        this.idPompiste = idPompiste;
    }

    public String getNomuser() {
        return nomuser;
    }

    public void setNomuser(String nomuser) {
        this.nomuser = nomuser;
    }

    public String getIdPompe() {
        return idPompe;
    }

    public void setIdPompe(String idPompe) {
        this.idPompe = idPompe;
    }

    public String getNomMagasin() {
        return nomMagasin;
    }

    public void setNomMagasin(String nomMagasin) {
        this.nomMagasin = nomMagasin;
    }

    public double getVenteCarburant() {
        return venteCarburant;
    }

    public void setVenteCarburant(double venteCarburant) {
        this.venteCarburant = venteCarburant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }
    
}
