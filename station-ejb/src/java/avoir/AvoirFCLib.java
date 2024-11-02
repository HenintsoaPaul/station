/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package avoir;

import bean.CGenUtil;
import java.sql.Connection;
import utilitaire.UtilDB;
import vente.Vente;
import vente.VenteDetails;

/**
 *
 * @author randr
 */
public class AvoirFCLib extends AvoirFC {

    String idMagasinLib;
    String idVenteLib;
    String idMotifLib;
    String idCategorieLib;
    String clientlib;
    String iddevise;
    double tauxdechange;
    double montantHT;
    double montantTVA;
    double montantTTC;
    double montantHTAr;
    double montantTVAAr;
    double montantTTCAr;
    double resteapayer;
    double resteapayerar;
    
    public AvoirFCLib(){
        this.setNomTable("avoirFCLib");
    }
    
    public AvoirFCLib(String nomtable){
        this.setNomTable(nomtable);
    }

    public String getIdMagasinLib() {
        return idMagasinLib;
    }

    public void setIdMagasinLib(String idMagasinLib) {
        this.idMagasinLib = idMagasinLib;
    }

    public String getIdVenteLib() {
        return idVenteLib;
    }

    public void setIdVenteLib(String idVenteLib) {
        this.idVenteLib = idVenteLib;
    }

    public String getIdMotifLib() {
        return idMotifLib;
    }

    public void setIdMotifLib(String idMotifLib) {
        this.idMotifLib = idMotifLib;
    }

    public String getIdCategorieLib() {
        return idCategorieLib;
    }

    public void setIdCategorieLib(String idCategorieLib) {
        this.idCategorieLib = idCategorieLib;
    }

    public String getIddevise() {
        return iddevise;
    }

    public void setIddevise(String iddevise) {
        this.iddevise = iddevise;
    }

    public double getTauxdechange() {
        return tauxdechange;
    }

    public void setTauxdechange(double tauxdechange) {
        this.tauxdechange = tauxdechange;
    }

    public double getMontantHT() {
        return montantHT;
    }

    public void setMontantHT(double montantHT) {
        this.montantHT = montantHT;
    }

    public double getMontantTVA() {
        return montantTVA;
    }

    public void setMontantTVA(double montantTVA) {
        this.montantTVA = montantTVA;
    }

    public double getMontantTTC() {
        return montantTTC;
    }

    public void setMontantTTC(double montantTTC) {
        this.montantTTC = montantTTC;
    }

    public double getMontantHTAr() {
        return montantHTAr;
    }

    public void setMontantHTAr(double montantHTAr) {
        this.montantHTAr = montantHTAr;
    }

    public double getMontantTVAAr() {
        return montantTVAAr;
    }

    public void setMontantTVAAr(double montantTVAAr) {
        this.montantTVAAr = montantTVAAr;
    }

    public double getMontantTTCAr() {
        return montantTTCAr;
    }

    public void setMontantTTCAr(double montantTTCAr) {
        this.montantTTCAr = montantTTCAr;
    }

    public String getClientlib() {
        return clientlib;
    }

    public void setClientlib(String clientlib) {
        this.clientlib = clientlib;
    }

    public double getResteapayer() {
        return resteapayer;
    }

    public void setResteapayer(double resteapayer) {
        this.resteapayer = resteapayer;
    }

    public double getResteapayerar() {
        return resteapayerar;
    }

    public void setResteapayerar(double resteapayerar) {
        this.resteapayerar = resteapayerar;
    }
    
    public static AvoirFCLib getById(Connection c, String id) throws Exception{
        AvoirFCLib afl = new AvoirFCLib();
        boolean canClose=false;
        try{
            if(c==null){
                c=new UtilDB().GetConn();
                canClose=true;
            }
            afl.setNomTable("avoirfclib_cpl");
            afl.setId(id);
            afl = ((AvoirFCLib[]) CGenUtil.rechercher(afl, null, null, c, "")).length > 0 ? (AvoirFCLib)((AvoirFCLib[]) CGenUtil.rechercher(afl, null, null, c, ""))[0] : null;
        } catch(Exception e){
            throw e;
        } finally {
            if(canClose){
                c.close();
            }
        }
        return afl;
    }
    
}
