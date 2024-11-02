/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package encaissement;


import bean.CGenUtil;
import bean.ClassFille;
import caisse.Caisse;
import caisse.DetailsBonCaisse;
import cheque.Cheque;
import java.sql.Connection;
import java.sql.Date;
import magasin.Magasin;
import utils.ConstanteStation;

/**
 *
 * @author Angela
 */
public class PrecisionDetailEncaissement extends ClassFille {

    protected String id;
    protected String idEncaissement;    
    protected String idCategorieCaisse; 
    protected String idClient;
    protected double montant;
    protected String reference ;
    protected Date daty;

    public PrecisionDetailEncaissement() throws Exception {
        this.setNomTable("Precision_Detail_Encaissement");
        this.setNomClasseMere("encaissement.Encaissement");
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdEncaissement() {
        return idEncaissement;
    }

    public void setIdEncaissement(String idEncaissement) {
        this.idEncaissement = idEncaissement;
    }

    public String getIdCategorieCaisse() {
        return idCategorieCaisse;
    }

    public void setIdCategorieCaisse(String idCategorieCaisse) {
        this.idCategorieCaisse = idCategorieCaisse;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
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
        this.preparePk("ECP", "GETSEQPRECISIONDETENCAISSEMENT");
        this.setId(makePK(c));
    }
    
    
    public EncaissementCpl getEncaissement(Connection c) throws Exception {
        if (c == null) {
            throw new Exception("Connection non etablie");
        }
        EncaissementCpl encaissement = new EncaissementCpl();
        encaissement.setId(this.getIdEncaissement());
        EncaissementCpl[] encaissements = (EncaissementCpl[]) CGenUtil.rechercher(encaissement, null, null, c, " ");
        if (encaissements.length > 0) {
            return encaissements[0];
        }
        return null;
    }
    
    
    
    
    
    public Cheque generateCheque (Connection c) throws Exception
    {
        Cheque cheque=new Cheque();
        EncaissementCpl encmt= getEncaissement(c);
        Caisse caisse=new Caisse(encmt.getIdPoint());
        caisse.setIdCategorieCaisse(ConstanteStation.CATEGORIECAISSECHEQUE);
        cheque.setIdCaisse(caisse.getCaisse(c).getId());
        cheque.setIdClient(this.getIdClient());
        cheque.setDaty(this.getDaty());
        cheque.setMontant(this.getMontant());
        cheque.setReference(this.getReference());
        cheque.setIdPrecisionDetailEncaissement(this.getId());
        cheque.setRemarque("details cheque");
        return cheque;
    }
     
    
    
     
     
    public DetailsBonCaisse generateDetailsBonCaisse (Connection c) throws Exception
    {
        DetailsBonCaisse dbc=new DetailsBonCaisse();
        EncaissementCpl encmt= getEncaissement(c);
        Caisse caisse=new Caisse(encmt.getIdPoint());
        caisse.setIdCategorieCaisse(ConstanteStation.CATEGORIECAISSEBON);
        dbc.setIdCaisse(caisse.getCaisse(c).getId());
        dbc.setCredit(this.getMontant());
        dbc.setIdClient(this.getIdClient());
        dbc.setIdPrecisionDetailEncaissement(this.getId());
        dbc.setDaty(this.getDaty());
        dbc.setRemarque("details bon");
        return dbc;
    }
    
    @Override
    public void setLiaisonMere(String liaisonMere) {
        super.setLiaisonMere("idEncaissement");
    }
    
}
