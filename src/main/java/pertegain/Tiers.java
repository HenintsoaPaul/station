/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package pertegain;

import bean.ClassMAPTable;

/**
 *
 * @author bruel
 */
public class Tiers extends ClassMAPTable{
    
    private String id;
    private String nom;
    private String compte;
  String adresse,nif,stat,pays,mail;
    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getNif() {
        return nif;
    }

    public void setNif(String nif) {
        this.nif = nif;
    }

    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }
  

    public Tiers() {
        super.setNomTable("tiers");
    }

    public Tiers(String id, String nom, String compte) {
        super.setNomTable("tiers");
        this.id = id;
        this.nom = nom;
        this.compte = compte;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getCompte() {
        return compte;
    }

    public void setCompte(String compte) {
        this.compte = compte;
    }

    @Override
    public String getTuppleID() {
        return "id";
    }

    @Override
    public String getAttributIDName() {
        return id;
    }
    
    @Override
    public String[] getMotCles() {
        String[] motCles={"id","nom"};
        return motCles;
    }
    
}
