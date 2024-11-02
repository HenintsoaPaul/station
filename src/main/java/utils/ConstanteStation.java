/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 *
 * @author Audace
 */
public class ConstanteStation {
    public static final int nombreJourScindeDefaut=7;
    public static final String idTypeReservoir = "TYPMG000001";
    public static final String idTypeCarburant = "TPRD001";
    public static final String idTypeNormal = "TYPMG000002";
    private static String fichierCentre = "Z:\\git\\gestion-station\\fichierCentre.txt";
    
    public static final String idTypeMagasinIlot = "TYPMG000023";
    public static final String TypeProduitLubrifiant = "TPR000021";
    public static final String TYPEMVTSTOCKENTREE = "TPMVST000001";
    public static final String TYPEMVTSTOCKSORTIE = "TPMVST000022";

    //TYPE CAISSE
    public static final String CAISSETYPEBANQUE = "TCA001";
    public static final String CAISSETYPEMOBILEMONEY = "TCA002";
    public static final String CAISSETYPEPHYSIQUE = "TCA003";
    public static final String CAISSETYPEVIRTUELLE = "TCA004";

    // CATEGORIE CAISSE 
    public static final String CATEGORIECAISSEMVOLA = "CTC004";
    public static final String CATEGORIECAISSEESPECES = "CTC003";
    public static final String CATEGORIECAISSEORANGEMONEY = "CTC005";
    public static final String CATEGORIECAISSEFANILO = "CTC006";
    public static final String CATEGORIECAISSETPE = "CTC007";
    public static final String CARTEVISA = "CTC008";
    public static final String CATEGORIECAISSEBON = "CTC001";
    public static final String CATEGORIECAISSECHEQUE = "CTC002";
    public static String JOURNALVENTE = "COMP000039";
    public static String comptaOriginefactureClient = "FC";
    public static String comptaOriginevente = "VNT";
    public static String journalAchat = "COMP000039";
    public static String comptaOriginefactureFournisseur = "FF";
    public static String compteFournisseurDivers = "401000";
    public static String compteTVACollecte = "44571";
    public static String compteTVADeductible = "44566";
    
    //TYPE ENCAISSEMENT
    public static String TYPE_ENCAISSEMENT_SORTIE = "TE002";
    public static String TYPE_ENCAISSEMENT_ENTREE ="TE001";
    
    //ID CAISSE
    public static String idCaisse = "CAI000238";
    public static final String idClientDivers="CLI000054";
    public static final String idFournisseurDivers="FRNDIV01";
    public static String getFichierCentre() throws IOException {

        //String contenu = new String(Files.readAllBytes(Paths.get(fichierCentre)));
        return "PNT000084";
    }

}
