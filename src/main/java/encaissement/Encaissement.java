/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;

import bean.AdminGen;
import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import bean.ClassMere;
import caisse.DetailsBonCaisse;
import caisse.MvtCaisse;
import caisse.VirementIntraCaisse;
import cheque.Cheque;
import cheque.ChequeCpl;
import depense.Depense;
import java.sql.Connection;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import prelevement.Prelevement;
import utilitaire.ConstanteEtat;
import utilitaire.UtilDB;
import utils.ConstanteEtatStation;
import vente.Vente;
import vente.VentePrelevement;
import venteLubrifiant.VenteLubrifiant;
import venteLubrifiant.VenteLubrifiantLib;

/**
 *
 * @author Angela
 */
public class Encaissement extends ClassMere {

    protected String id;
    protected String designation;
    protected String idCaisse;
    protected Date daty;
    protected String idOrigine;
    protected String idTypeEncaissement;
    protected double montant;
    protected String idDevise;
    protected double  taux;

    public String getIdTypeEncaissement() {
        return idTypeEncaissement;
    }

    public void setIdTypeEncaissement(String idTypeEncaissement) {
        this.idTypeEncaissement = idTypeEncaissement;
    }
    
    public Encaissement() {
        this.setNomTable("ENCAISSEMENT");
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDesignation() {
        return designation;
    }

    public void setDesignation(String designation) {
        this.designation = designation;
    }

    public String getIdCaisse() {
        return idCaisse;
    }

    public void setIdCaisse(String idCaisse) {
        this.idCaisse = idCaisse;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("ECM", "getSeqEncaissement");
        this.setId(makePK(c));
    }

    public String getIdOrigine() {
	 return idOrigine;
    }

    public void setIdOrigine(String idOrigine) {
	 this.idOrigine = idOrigine;
    }


    

    public VentePrelevement[] getVentePrelevement(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        VentePrelevement vente = new VentePrelevement();
        vente.setIdEncaissement(this.getId());
        VentePrelevement[] ventes = (VentePrelevement[]) CGenUtil.rechercher(vente, null, null, c, " ");
        if (ventes.length > 0) {
            return ventes;
        }
        return null;
    }

    public EncaissementPrecisionTotal[] getEncaissementPrecisionTotal(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        EncaissementPrecisionTotal ept = new EncaissementPrecisionTotal();
        ept.setIdEncaissement(this.getId());
        EncaissementPrecisionTotal[] epts = (EncaissementPrecisionTotal[]) CGenUtil.rechercher(ept, null, null, c, " ");
        if (epts.length > 0) {
            return epts;
        }
        return null;
    }

    public void controllerMontantPrelevement(Connection c) throws Exception {
        VentePrelevement[] vente = getVentePrelevement(c);
        if (vente != null) {
            double montant = vente[0].getMontantTotalEncaissement();
            double montantTotalVente = AdminGen.calculSommeDouble(vente, "montantTotalVente");
            double difference2 = montant - montantTotalVente;
            
            if (difference2 > 0.02 * montant) {
                throw new Exception("La différence en pourcentage du prelevement  est supérieure à 2");
            }

        }
        if (vente == null) {
            throw new Exception("Aucun prélèvement attaché");
        }

    }

    public void controllerMontantPrecision(Connection c) throws Exception {
        EncaissementPrecisionTotal[] epts = getEncaissementPrecisionTotal(c);
        if (epts != null) {
            for (EncaissementPrecisionTotal ept : epts) {
                double montant = ept.getMontant();
                double montantTotalPrecision = ept.getMontantTotalPrecision();
                double difference = Math.abs(montant - montantTotalPrecision);
                if (difference > 0.02 * montant) {
                    throw new Exception("La différence en pourcentage  du presicion est supérieure à 2");
                }
            }
        }
    }

    /////get all precisions
    public PrecisionDetailEncaissement[] getPrecision(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        PrecisionDetailEncaissement pde = new PrecisionDetailEncaissement();
        pde.setIdEncaissement(this.getId());
        PrecisionDetailEncaissement[] pdes = (PrecisionDetailEncaissement[]) CGenUtil.rechercher(pde, null, null, c, "and IDCATEGORIECAISSE ='CTC002' OR IDCATEGORIECAISSE ='CTC001'");
        if (pdes.length > 0) {
            return pdes;
        }
        return null;
    }

    /////get all details 
    public EncaissementDetails[] getEncaissementDetails(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        EncaissementDetails ed = new EncaissementDetails();
        ed.setIdEncaissement(this.getId());
        EncaissementDetails[] eds = (EncaissementDetails[]) CGenUtil.rechercher(ed, null, null, c, "");
        if (eds.length > 0) {
            return eds;
        }
        return null;
    }

    /////getallPrelevement
    public PrelevementEncaisse[] getPrelevementEncaisses(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        PrelevementEncaisse objet = new PrelevementEncaisse();
        objet.setIdEncaissement(this.getId());
        PrelevementEncaisse[] objets = (PrelevementEncaisse[]) CGenUtil.rechercher(objet, null, null, c, "");
        if (objets.length > 0) {
            return objets;
        }
        return null;
    }

   
    
    @Override
    public void controlerUpdate(Connection c) throws Exception {
        super.controlerUpdate(c);
    }

    public void preValiderObject(String u, Connection c) throws Exception {
    }

    public void postValiderObject(String u, Connection c) throws Exception {
        generateEcriture(u, c);
	 MvtCaisse vic=generateMvtCaisse(); 
	 vic.createObject(u, c);
	 vic.validerObject(u, c);
    }
    public void generateEcriture(String u,Connection c) throws Exception{
        Vente[]vs= getVente(c);
        if (vs!=null) {
            for (int i = 0; i < vs.length; i++) {
                vs[i].genererEcriture(u, c);
            }
        }
    }
    public Vente[] getVente(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        Vente vente = new Vente();
        vente.setId(this.getIdOrigine());
        Vente[] ventes = (Vente[]) CGenUtil.rechercher(vente, null, null, c, " ");
        if (ventes.length > 0) {
            return ventes;
        }
        return null;
    }
    
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        super.validerObject(u, c);
        postValiderObject(u, c);
        return this;
    }

    public EncaissementLib getEncaissementLib(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            EncaissementLib encLib = new EncaissementLib();
            encLib.setId(this.getId());
            EncaissementLib[] encLibs = (EncaissementLib[]) CGenUtil.rechercher(encLib, null, null, c, " ");
            if (encLibs.length > 0) {
                return encLibs[0];
            }

            return null;
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    public double getMontant() {
	 return montant;
    }

    public void setMontant(double montant) {
	 this.montant = montant;
    }

    public String getIdDevise() {
	 return idDevise;
    }

    public void setIdDevise(String idDevise) {
	 this.idDevise = idDevise;
    }

    public double getTaux() {
	 return taux;
    }

    public void setTaux(double taux) throws Exception {
	 if(this.getMode().compareTo("modif")==0)
        {
            if(taux==0)
                throw new Exception("taux obligatoire");
        }
	 this.taux = taux;
    }

      
   


    public MvtCaisse generateMvtCaisse() throws Exception {
            MvtCaisse caisse=new MvtCaisse();
            caisse.setDesignation("mouvement caisse du " +this.getDaty() );
	     caisse.setIdCaisse(this.getId());
            caisse.setIdVirement(this.getId());
            caisse.setDaty(this.getDaty());
            caisse.setCredit(this.getMontant());
	     caisse.setIdDevise(this.getIdDevise());
	     caisse.setTaux(this.getTaux());
            return caisse;
    }


    
}
