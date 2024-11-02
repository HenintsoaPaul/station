/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package caisse;

import bean.CGenUtil;
import bean.ClassEtat;
import bean.ClassMAPTable;
import java.sql.Connection;
import java.sql.Date;

/**
 *
 * @author 26134
 */
public class PaiementBon extends ClassEtat{
    String id,idClient,idCaisseBon,idCaissePaiement;
    double montant;
    Date daty;

    public PaiementBon() {
        this.setNomTable("PaiementBon");
    }
    
    @Override
    public String getTuppleID() {
        return id; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String getAttributIDName() {
        return "id"; //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public void construirePK(Connection c) throws Exception {
        this.preparePk("PB", "GETSEQPaiementBon");
        this.setId(makePK(c));
    }
    
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIdClient() {
        return idClient;
    }

    public void setIdClient(String idClient) {
        this.idClient = idClient;
    }

    public String getIdCaisseBon() {
        return idCaisseBon;
    }

    public void setIdCaisseBon(String idCaisseBon) {
        this.idCaisseBon = idCaisseBon;
    }

    public String getIdCaissePaiement() {
        return idCaissePaiement;
    }

    public void setIdCaissePaiement(String idCaissePaiement) {
        this.idCaissePaiement = idCaissePaiement;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Date getDaty() {
        return daty;
    }

    public void setDaty(Date daty) {
        this.daty = daty;
    }

    protected DetailsBonCaisseClientReste getDetailsBonCaisseClientReste(Connection c) throws Exception{
        DetailsBonCaisseClientReste dbc=null;
        DetailsBonCaisseClientReste[] dbcs=(DetailsBonCaisseClientReste[])CGenUtil.rechercher(new DetailsBonCaisseClientReste(), null, null, c, " and id = '"+idClient+"' ");
        if (dbcs.length==1) {
            dbc=dbcs[0];
        }
        return dbc;
    }
    @Override
    public void controler(Connection c) throws Exception {
        if (idCaisseBon.isEmpty()||idCaisseBon==null||idCaisseBon.equalsIgnoreCase("")) {
            throw new Exception("CaisseBon vide");
        }
        DetailsBonCaisseClientReste r=getDetailsBonCaisseClientReste(c);
        if (r.getReste()< montant) {
            throw new Exception("Reste à payer bon < montant");
        }
    }

    protected VirementIntraCaisse createVirementIntraCaisse(){
            VirementIntraCaisse vic=new  VirementIntraCaisse();
            vic.setDesignation("paiement bon de "+this.getIdClient());
            vic.setIdCaisseArrive(this.getIdCaissePaiement());
            vic.setIdCaisseDepart(this.getIdCaissePaiement());
            vic.setDaty(this.getDaty());
            vic.setMontant(this.getMontant());
            vic.setIdOrigine(this.getId());
        return vic;
    }
    
    protected DetailsBonCaisse createBonCaisse() {
        DetailsBonCaisse dbc= new DetailsBonCaisse();
        dbc.setDebit(this.getMontant());
        dbc.setDaty(this.getDaty());
        dbc.setIdCaisse(this.getIdCaisseBon());
        dbc.setIdClient(this.getIdClient());
        dbc.setRemarque("paiement bon de "+this.getIdClient());
        return dbc;
    }
    @Override
    public Object validerObject(String u, Connection c) throws Exception {
        VirementIntraCaisse vic=this.createVirementIntraCaisse();
        vic.createObject(u, c);
        vic.validerObject(u, c);
        DetailsBonCaisse dbc=this.createBonCaisse();
        dbc.createObject(u, c);
        return super.validerObject(u, c); 
    }

    
}
