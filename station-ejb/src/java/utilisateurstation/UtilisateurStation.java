/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utilisateurstation;

import bean.CGenUtil;
import bean.ClassMAPTable;
import caisse.Caisse;
import historique.MapUtilisateur;
import historique.ParamCrypt;
import historique.ParamCryptUtil;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import mg.cnaps.utilisateur.CNAPSUser;
import utilisateur.Utilisateur;
import utilitaire.Utilitaire;
import utils.ConstanteStation;

/**
 *
 * @author 26134
 */
public class UtilisateurStation extends Utilisateur{
    private String adruser;

    public String getAdruser() {
        return adruser;
    }

    public void setAdruser(String adruser) {
        this.adruser = adruser;
    }
    
    public UtilisateurStation() {
        this.setNomTable("utilisateur");
    }

    private Caisse createCaissePompiste() throws IOException{
        Caisse newCaisse = new Caisse();
        newCaisse.setIdPoint(ConstanteStation.getFichierCentre());
        newCaisse.setVal("CAISSE DE " + this.getLoginuser());
        newCaisse.setDesce("CAISSE DE " + this.getLoginuser());
        return newCaisse;
    }
    
    @Override
    public ClassMAPTable createObject(String u, Connection c) throws Exception {
        try {      
        UtilisateurStation[] uList=(UtilisateurStation[]) CGenUtil.rechercher(new UtilisateurStation(), null, null,c, " AND LOGINUSER = '"+this.getLoginuser()+"' ");
        if (uList.length > 0) {
            throw new Exception("Login deja utilise!");
        }
        
            int niveau = 4;
            String passCrypt = null;
            passCrypt = Utilitaire.cryptWord(this.getPwduser().toLowerCase(), niveau, false);
            MapUtilisateur newUser = new MapUtilisateur(this.getLoginuser(), passCrypt, this.getNomuser(), "DIR42", this.getTeluser(), this.getIdRole());
            newUser.insertToTableWithHisto(u, c);
            ParamCrypt pc = new ParamCrypt(niveau, 1, newUser.getTuppleID());
            pc.insertToTable(c);
            CNAPSUser cu = new CNAPSUser("DIR00001", "1", "1", "1",this.getNomuser() , "1", Integer.toString( newUser.getRefuser() ) );
            cu.createObject(u, c);
            if (this.getIdRole().compareToIgnoreCase("pompiste")==0) {
                Caisse newCaisse=new Caisse();
                newCaisse.setIdPoint(ConstanteStation.getFichierCentre());
                newCaisse.setVal("CAISSE DE "+this.getLoginuser());
                newCaisse.setDesce("CAISSE DE "+this.getLoginuser());
                newCaisse.createObject(u, c);
                newCaisse.validerObject(u, c);
            }
        }catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
        return this;
    }

    @Override
    public int updateToTableWithHisto(String refUser, Connection c) throws Exception {
        int r=-1;
        ParamCrypt[] pc = (ParamCrypt[]) new ParamCryptUtil().rechercher(4, this.getRefuser());
        if (pc.length == 0) {
            throw new Exception("Pas de cryptage associe");
        }
        try{
            UtilisateurStation[] utils=(UtilisateurStation[]) CGenUtil.rechercher(new UtilisateurStation(), null, null,c, " AND REFUSER = '"+this.getRefuser()+"' ");
            if(utils.length>0 && utils[0].getLoginuser().compareToIgnoreCase(this.getLoginuser())!=0){
                UtilisateurStation[] util = (UtilisateurStation[])CGenUtil.rechercher(new UtilisateurStation(), null, null, " AND LOGINUSER = '"+this.getLoginuser()+"'");
                if(util.length>0) throw new Exception("LOGIN DEJA UTILISE");
            }
            String passCrypt = Utilitaire.cryptWord(this.getPwduser(), pc[0].getNiveau(), pc[0].getCroissante());
            MapUtilisateur u = new MapUtilisateur(this.getRefuser(), this.getLoginuser(), passCrypt, this.getNomuser(), this.getAdruser(), this.getTeluser(), this.getIdRole());
            historique.MapHistorique h = new historique.MapHistorique("Utilisateurs", "update", refUser, u.getTuppleID());
            h.insertToTable(c);
            r=u.updateToTable(c);
            //verif pompiste
            Caisse[] Cpomp=(Caisse[])CGenUtil.rechercher(new Caisse(), null, null,c, " AND idpompiste = '"+this.getRefuser()+"' ");
            if (this.getIdRole().compareToIgnoreCase("pompiste")==0 && Cpomp.length==0) {
                Caisse newCaisse=this.createCaissePompiste();
                newCaisse.createObject(refUser, c);
                newCaisse.validerObject(refUser, c);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("UtilisateurStation error UPDATE: " + e.getMessage());
        }
        return r;
    }
    
}
