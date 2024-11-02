/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ordonnerpaiement;

import bean.CGenUtil;
import bean.ClassFille;
import constante.ConstanteEtat;
import encaissement.EncaissementLib;
import faturefournisseur.FactureFournisseurCpl;
import java.sql.Connection;
import java.sql.SQLException;
import paiement.PaiementFF;
import utilitaire.UtilDB;
import utilitaire.Utilitaire;
import utils.ConstanteEtatStation;

/**
 *
 * @author CMCM
 */
public class OrdonnerPaiementDetail extends ClassFille {

    protected String id;
    protected String idOP;
    protected String idFF;
    protected double montant;
    protected FactureFournisseurCpl ff;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdOP() {
        return idOP;
    }

    public void setIdOP(String idOP) {
        this.idOP = idOP;
    }

    public String getIdFF() {
        return idFF;
    }

    public void setIdFF(String idFF) {
        this.idFF = idFF;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    @Override
    public String getTuppleID() {
        return this.getId();
    }

    @Override
    public String getAttributIDName() {
        return "id";
    }

    public FactureFournisseurCpl getFf() {
        return ff;
    }

    public void setFf(FactureFournisseurCpl ff) {
        this.ff = ff;
    }

    public FactureFournisseurCpl getFF(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            if (this.getFf() == null) {
                FactureFournisseurCpl ffl = new FactureFournisseurCpl();
                ffl.setId(this.getIdFF());
                FactureFournisseurCpl[] ffls = (FactureFournisseurCpl[]) CGenUtil.rechercher(ffl, null, null, c, " ");
                if (ffls.length > 0) {
                    setFf(ffls[0]);
                }
            }
            return this.getFf();
        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }
    }

    protected void checkEtatFF(Connection c) throws Exception {
        FactureFournisseurCpl ffl = getFF(c);
        if (ffl.getEtat() < ConstanteEtat.getEtatValider()) {
            throw new Exception("Facture fournisseur pas encore valide");
        }
    }

    protected void checkValiditeFF(Connection c) throws Exception {
        boolean estOuvert = false;
        try {
            if (c == null) {
                estOuvert = true;
                c = new UtilDB().GetConn();
            }
            if (this.getFf() == null) {
                OrdonnerPaiementDetailLib odl = new OrdonnerPaiementDetailLib();
                odl.setIdFF(this.getIdFF());
                if (this.getIdOP() != null) {
                    odl.setIdOP(this.getIdOP());
                }
                OrdonnerPaiementDetailLib[] odls = (OrdonnerPaiementDetailLib[]) CGenUtil.rechercher(odl, null, null, c, " AND ETAT >= 11 ");
                if (odls.length > 0) {
                    throw new Exception("La facture est déjà liée à une OP");
                }
            }

        } catch (Exception e) {
            throw e;
        } finally {
            if (c != null && estOuvert == true) {
                c.close();
            }
        }

    }

    public void checkValidite(Connection c) throws Exception {
        checkEtatFF(c);
        checkValiditeFF(c);
    }

    @Override
    public void controler(Connection c) throws Exception {
        super.controler(c);
        checkValidite(c);

    }

    @Override
    public void controlerUpdate(Connection c) throws Exception {
        super.controlerUpdate(c);
        checkValidite(c);

    }

    protected PaiementFF createPaiementFF(double montant) {
        PaiementFF p = new PaiementFF();
        p.setMontant(montant);
        p.setIdFF(this.getIdFF());
        p.setIdOP(this.getIdOP());
        p.setDaty(Utilitaire.dateDuJourSql());
        return p;
    }


    public void payer(double montant,Connection c,String refUser) throws Exception
    {
        PaiementFF p= createPaiementFF(montant);
        p.createObject(refUser, c);
    }

}
