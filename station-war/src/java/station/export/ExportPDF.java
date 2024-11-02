
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package station.export;


import bean.AdminGen;
import bean.CGenUtil;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import reporting.ReportingCdn;
import utilitaire.UtilDB;
import web.mg.cnaps.servlet.etat.UtilitaireImpression;
import encaissement.*;
import java.util.Arrays;
import org.xhtmlrenderer.css.style.derived.StringValue;
import prelevement.PrelevementPompiste;
import utilitaire.Utilitaire;
import vente.*;
import faturefournisseur.*;
/**
 *
 * @author Admin
 */
@WebServlet(name = "ExportPDF", urlPatterns = {"/ExportPDF"})
public class ExportPDF extends HttpServlet {
    String nomJasper = "";
    ReportingCdn.Fonctionnalite fonctionnalite = ReportingCdn.Fonctionnalite.RECETTE;
    
    public String getReportPath() throws IOException {
        return getServletContext().getRealPath(File.separator + "report" + File.separator + getNomJasper() + ".jasper");
    }
    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        String action = request.getParameter("action");
        if (action.equalsIgnoreCase("fiche_encaissement")) impressionEncaissement(request, response);
        if (action.equalsIgnoreCase("fiche_encaissement_pompiste")) impressionEncaissementPompist(request, response);
        if (action.equalsIgnoreCase("fiche_vente")) fiche_vente(request, response);
        if (action.equalsIgnoreCase("fiche_bc")) fiche_bc(request, response);
        if (action.equalsIgnoreCase("fiche_bl")) fiche_bl(request, response);
    }
    private void fiche_bc(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception{
        Connection c = null;
        Map param = new HashMap();
        List dataSource = new ArrayList();
         String id = request.getParameter("id");
        As_BonDeCommandeCpl v = new As_BonDeCommandeCpl();
        v.setNomTable("As_BonDeCommande_MERECPL");
        As_BonDeCommandeCpl[] enc_mere = (As_BonDeCommandeCpl[]) CGenUtil.rechercher(v, null, null, null,
                " AND ID = '" + id + "'");
        
        if (enc_mere.length > 0) {
          param.put("designation", enc_mere[0].getDesignation());
          param.put("ref", enc_mere[0].getReference());
          param.put("daty", enc_mere[0].getDaty());
          param.put("remarque", enc_mere[0].getRemarque());
          param.put("fournisseur", enc_mere[0].getFournisseurlib());
          param.put("modeP", enc_mere[0].getModepaiementlib());
          param.put("num", id);
          param.put("iddevise", enc_mere[0].getIdDevise());
          param.put("montantHT", enc_mere[0].getMontantHT());
          param.put("montantTVA", enc_mere[0].getMontantTVA());
          param.put("montantTTC", enc_mere[0].getMontantTTC());
          param.put("devise", enc_mere[0].getIdDeviselib());
        }
       
        As_BonDeCommande_Fille_CPL vf = new As_BonDeCommande_Fille_CPL();
        vf.setNomTable("AS_BONDECOMMANDE_CPL");
        As_BonDeCommande_Fille_CPL[] v_fille = (As_BonDeCommande_Fille_CPL[]) CGenUtil.rechercher(vf, null, null, null,
                " AND idbc = '" + id + "'");
        dataSource.addAll(Arrays.asList(v_fille));
        setNomJasper("BonDeCommande");
        UtilitaireImpression.imprimer(request, response, getNomJasper(), param, dataSource, getReportPath());
    }
    
    private void fiche_bl(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception{
        Connection c = null;
        Map param = new HashMap();
        List dataSource = new ArrayList();
         String id = request.getParameter("id");
        As_BondeLivraisonClient_Cpl v = new As_BondeLivraisonClient_Cpl();
        v.setNomTable("AS_BONDELIVRAISON_CLIENT_CPL");
        As_BondeLivraisonClient_Cpl[] enc_mere = (As_BondeLivraisonClient_Cpl[]) CGenUtil.rechercher(v, null, null, null,
                " AND id = '" + id + "'");
        if (enc_mere.length > 0) {
          param.put("designation", enc_mere[0].getDesignation());
          param.put("daty", enc_mere[0].getDaty());
          param.put("remarque", enc_mere[0].getRemarque());
          param.put("magasin", enc_mere[0].getMagasin());
          param.put("num", id);
        }
        As_BondeLivraisonClientFille_Cpl vf = new As_BondeLivraisonClientFille_Cpl();
        vf.setNomTable("AS_BONLIVRFILLE_CLIENT_CPL");
        As_BondeLivraisonClientFille_Cpl[] v_fille = (As_BondeLivraisonClientFille_Cpl[]) CGenUtil.rechercher(vf, null, null, null,
                " AND numbl = '" + id + "'");
        dataSource.addAll(Arrays.asList(v_fille));
        setNomJasper("BonDeLivraison");
        UtilitaireImpression.imprimer(request, response, getNomJasper(), param, dataSource, getReportPath());
    }
    private void fiche_vente(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception{
        Connection c = null;
        Map param = new HashMap();
        List dataSource = new ArrayList();
         String id = request.getParameter("id");
        VenteLib v = new VenteLib();
        VenteLib[] enc_mere = (VenteLib[]) CGenUtil.rechercher(v, null, null, null,
                " AND ID = '" + id + "'");
        if (enc_mere.length > 0) {
          param.put("designation", enc_mere[0].getDesignation());
          param.put("magasin", enc_mere[0].getIdMagasinLib());
          param.put("daty", enc_mere[0].getDaty());
          param.put("remarque", enc_mere[0].getRemarque());
          param.put("devise", enc_mere[0].getIdDevise());
          param.put("numFact", id);
        }
       
        VenteDetailsLib vf = new VenteDetailsLib();
        vf.setNomTable("VENTE_DETAILS_CPL");
        VenteDetailsLib[] v_fille = (VenteDetailsLib[]) CGenUtil.rechercher(vf, null, null, null,
                " AND idVente = '" + id + "'");
        dataSource.addAll(Arrays.asList(v_fille));
         String devise = v_fille[0].getIdDevise();
        double montantHT = AdminGen.calculSommeDouble(v_fille,"montantHTLocal");
        double montantTVA = AdminGen.calculSommeDouble(v_fille,"montantTvaLocal");
        double montantTTC = AdminGen.calculSommeDouble(v_fille,"montantTTCLocal");
        
        param.put("montantHT", montantHT);
        param.put("montantTVA", montantTVA);
        param.put("montantTTC", montantTTC);
        param.put("devise", devise);
        
        setNomJasper("factureclient");
        UtilitaireImpression.imprimer(request, response, getNomJasper(), param, dataSource, getReportPath());
    }
    private void impressionEncaissement(HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception{
        Connection c = null;
        Map param = new HashMap();
        List dataSource = new ArrayList();
         String id = request.getParameter("id");
        EncaissementLib eM = new EncaissementLib();
        eM.setNomTable("ENCAISSEMENT_LIB");
        EncaissementLib[] enc_mere = (EncaissementLib[]) CGenUtil.rechercher(eM, null, null, null,
                " AND ID = '" + id + "'");
        if (enc_mere.length > 0) {
          param.put("carburants", Utilitaire.formaterAr(enc_mere[0].getVenteCarburant()));
          param.put("lubrifiants", Utilitaire.formaterAr(enc_mere[0].getVenteLubrifiant()));
          param.put("totalrecette", Utilitaire.formaterAr(enc_mere[0].getTotalRecette()));
          param.put("depense", Utilitaire.formaterAr(enc_mere[0].getDepense()));
          param.put("montantecart", Utilitaire.formaterAr(enc_mere[0].getEcart()));
          param.put("versement", Utilitaire.formaterAr(enc_mere[0].getTotalVersement()));
         
        }
        EncaissementDetailsLib eF = new EncaissementDetailsLib();
        eF.setNomTable("Encaissement_Details_Lib");
        EncaissementDetailsLib[] enc_fille = (EncaissementDetailsLib[]) CGenUtil.rechercher(eF, null, null, null,
                " AND idEncaissement = '" + id + "'");
        dataSource.addAll(Arrays.asList(enc_fille));
        setNomJasper("encaissement");
        UtilitaireImpression.imprimer(request, response, getNomJasper(), param, dataSource, getReportPath());
    }

     private void impressionEncaissementPompist (HttpServletRequest request, HttpServletResponse response) throws IOException, JRException, Exception{
        Connection c = null;
        Map param = new HashMap();
        List dataSource = new ArrayList();
         String id = request.getParameter("id");
        EncaissementFichePdf eM = new EncaissementFichePdf();
       
        EncaissementFichePdf[] enc_mere = (EncaissementFichePdf[]) CGenUtil.rechercher(eM, null, null, null,
                " AND ID = '" + id + "'");

      
        EncaissementReport er=new EncaissementReport();
        er.setId(id);
        er.init(c);

        if (enc_mere.length > 0) {
          param.put("date", enc_mere[0].getDaty());
          param.put("nom", enc_mere[0].getIdPompisteLib());
          param.put("ecart", enc_mere[0].getEcart());
          param.put("versement", enc_mere[0].getTotalVersement());
          param.put("espece", enc_mere[0].getTotalEspece());
          param.put("om", enc_mere[0].getTotalOrangeMoney());
        }
       
        dataSource.add(er);


        setNomJasper("encaissementPompiste");
        UtilitaireImpression.imprimer(request, response, getNomJasper(), param, dataSource, getReportPath());
    }

    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ExportPDF.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ExportPDF.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}
