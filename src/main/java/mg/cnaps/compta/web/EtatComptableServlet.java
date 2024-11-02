/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mg.cnaps.compta.web;

import bean.CGenUtil;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
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

//import org.omg.CORBA.SystemException;

import mg.cnaps.compta.*;
import utilitaire.Utilitaire;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperPrint;
import reporting.ReportingCdn;
import reporting.ReportingUtils;
import affichage.*;
import web.servlet.etat.Reporting;
import web.mg.cnaps.servlet.etat.UtilitaireImpression;
public class EtatComptableServlet extends HttpServlet {

    Reporting reporting = new Reporting();
    String nomJasper = "";

    public String getReportPath() throws IOException {
        return getServletContext().getRealPath(File.separator + "report" + File.separator + getNomJasper() + ".jasper");
    }

    public String getNomJasper() {
        return nomJasper;
    }

    public void setNomJasper(String nomJasper) {
        this.nomJasper = nomJasper;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("exportBalance")) {
                balanceGenerale(request, response);
            }
            reporting.setReportPath(getServletContext()
                    .getRealPath(File.separator + "report" + File.separator + reporting.getNomJasper() + ".jasper"));
            UtilitaireImpression.imprimerFichier(request, response, reporting);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head>");
            out.print("<script>alert('" + ex.getMessage() + "');history.back();</script>");
            out.println("</head>");
            out.println("</html>");
            out.close();
            throw ex;
        }
    }

    /**
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            Logger.getLogger(EtatComptableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(EtatComptableServlet.class.getName()).log(Level.SEVERE, null, ex);
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
    }

    private void balanceGenerale(HttpServletRequest request, HttpServletResponse response)
            throws IOException, JRException, Exception {
        ComptaEtatBalanceGenerator generale = new ComptaEtatBalanceGenerator();
        generale.setNomTable("v_compta_etat_balance");
        PageInsert pi = new PageInsert(generale, request);
        ComptaEtatBalanceGenerator rep = (ComptaEtatBalanceGenerator) pi.getObjectAvecValeur();
        ComptaEtatBalanceChiffre2[] tab = rep.genererBalance(null);
        Map param = new HashMap();
        reporting.setParametreJasper("balance_generale", "BALANCE_GENERAL", Arrays.asList(tab), param,
                ReportingUtils.ReportType.PDF, null);
        reporting.setTypeImpression(Reporting.TypeImpression.SIMPLE);
    }

}
