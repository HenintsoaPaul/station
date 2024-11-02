package mg.cnaps.compta.web;
import mg.cnaps.compta.ComptaEtatBalanceChiffre3;

import utilitaire.Utilitaire;
import mg.cnaps.compta.ComptaEtatBalanceChiffre2PDF;
import mg.cnaps.compta.ComptaEtatBalanceGenerator;
import affichage.PageInsert;
import mg.cnaps.compta.ComptaEtatBalanceChiffre2;
import utilitaire.UtilDB;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.lang.Math;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import javax.servlet.http.HttpSession;

import java.util.Collection;

import java.sql.Date;


import javax.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.LinkedHashMap;


/**
 *
 * @author Manda
 */
@WebServlet(name = "BalanceCompta", urlPatterns = {"/BalanceCompta"})
public class BalanceCompta extends HttpServlet {

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
            if (action.equalsIgnoreCase("balanceCompta")) {
                balanceCompta(request, response);
            } 

        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/html");
            // response.setBufferSize(8192);
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
            Logger.getLogger(BalanceCompta.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(BalanceCompta.class.getName()).log(Level.SEVERE, null, ex);
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

    
    private void balanceCompta(HttpServletRequest request, HttpServletResponse response) throws Exception {
       Connection c = null;
        try{
            c = (new UtilDB()).GetConn();
        ComptaEtatBalanceGenerator general=new ComptaEtatBalanceGenerator();
        general.setNomTable("v_compta_etat_balance");
        PageInsert pi=new PageInsert(general,request);
        ComptaEtatBalanceGenerator generateurBalance=(ComptaEtatBalanceGenerator)pi.getObjectAvecValeur();
        ComptaEtatBalanceChiffre2[] balances = generateurBalance.genererBalance(null);
        
        ArrayList<ComptaEtatBalanceChiffre2PDF> retour = new ArrayList<>();
        for(int i=0;i<balances.length;i++){
            retour.addAll(balances[i].makeLignePDF());
        }
        List dataSource = new ArrayList();
        dataSource.addAll(retour);
        Map param = new HashMap();
        
        param.put("daty1",request.getParameter("daty1"));
        param.put("daty2",request.getParameter("daty2"));
        setNomJasper("BALANCE_COMPTA_GENEREAUX");
        UtilitaireImpression.imprimer(request, response, "BALANCE_COMPTA_GENEREAUX", param, dataSource,
                    getReportPath());
        } catch (Exception e) {
            e.printStackTrace();
        } 
        finally {
            if (c != null) {
                c.close();
            }
        }
    }
    
    
}
