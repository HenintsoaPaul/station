<%-- 
    Document   : apresDeclaration
    Created on : 29 sept. 2015, 16:57:29
    Author     : Tafitasoa
--%>

<%@page import="mg.cnaps.compta.ComptaLettrageParam"%>
<%@page import="mg.cnaps.compta.ComptaLettrage"%>
<%@page import="mg.cnaps.compta.ComptaSousEcriture"%>
<%@page import="mg.cnaps.pret.PretPlanRemboursement"%>
<%@page import="mg.cnaps.recette.RecetteDeclaration"%>
<%@page import="mg.cnaps.utilisateur.CNAPSUser"%>
<%@page import="mg.cnaps.recette.RecetteVentillation"%>
<%@ page import="user.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="affichage.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <%!
        UserEJB u = null;
        String acte = null;
        String lien = null;
        String bute;
    %>
    <%
        try {
            lien = (String) session.getValue("lien");
            u = (UserEJB) session.getAttribute("u");
            acte = request.getParameter("acte");
            bute = request.getParameter("bute");
            Object temp = null;
            String[] rajoutLien = null;
            String classe = request.getParameter("classe");
            ClassMAPTable t = null;
            String tempRajout = request.getParameter("rajoutLien");
            String val = "";

            CNAPSUser util = new CNAPSUser();
            util.setId_utilisateur(u.getUser().getTuppleID());
            CNAPSUser[] utilisateur = (CNAPSUser[]) CGenUtil.rechercher(util, null, null, "");

            String rajoutLie = "";
            if (tempRajout != null && tempRajout.compareToIgnoreCase("") != 0) {
                rajoutLien = utilitaire.Utilitaire.split(tempRajout, "-");
            }
            if (bute == null || bute.compareToIgnoreCase("") == 0) {
                bute = "pub/Pub.jsp";
            }

            if (classe == null || classe.compareToIgnoreCase("") == 0) {
                classe = "pub.Montant";
            }

            if (acte.compareToIgnoreCase("insert") == 0) {
                String error = "";
                try {

                } catch (Exception e) {
                    out.println("<script language=\"JavaScript\">alert(\"" + e.getMessage() + "\")</script>");
                }

            }

            if (acte.compareToIgnoreCase("delete") == 0) {
                String error = "";
                try {
                    String idLettrage = request.getParameter("id");
                    ComptaLettrage cl = new ComptaLettrage();
                    cl.setId(idLettrage);
                    //cl.deleteToTableWithHisto(u.getUser().getTuppleID());
                    u.deleteObject(cl);
                    ComptaSousEcriture[] cse = (ComptaSousEcriture[]) CGenUtil.rechercher(new ComptaSousEcriture(), null, null, " AND LETTRAGE = '" + idLettrage + "'");
                    System.out.print("lettrage=" + idLettrage);
                  //  ComptaLettrageParam[] paramLettrage = (ComptaLettrageParam[]) CGenUtil.rechercher(new ComptaLettrageParam(), null, null, " AND ID_COMPTE_TIERS = '" + cse[0].getCompte() + "'");
                 //   u.deleteObject(paramLettrage[0]);
                    for (int i = 0; i < cse.length; i++) {
                        cse[i].setLettrage("");
                        cse[i].updateToTableWithHisto(u.getUser().getTuppleID());
                        System.out.print("lettrage tato=" + idLettrage);

                    }
                } catch (Exception e) {
                    out.println("<script language=\"JavaScript\">alert(" + e.getMessage() + ")</script>");
                    System.out.println("erreur suppression" + e.getMessage());
                }


    %>
    <script language="JavaScript">
        //alert("Erreur durant la suppression ");
    </script>
    <%        }
        if (acte.compareToIgnoreCase("update") == 0) {

        }

        if (rajoutLien != null) {

            for (int o = 0; o < rajoutLien.length; o++) {
                String valeur = request.getParameter(rajoutLien[o]);
                rajoutLie = rajoutLie + "&" + rajoutLien[o] + "=" + valeur;
            }
        }

    %>
    <script language="JavaScript"> document.location.replace("<%=lien%>?but=<%=bute + rajoutLie%>&valeur=<%=val%>");</script>
    <%

    } catch (Exception e) {
        e.printStackTrace();
    %>

    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
        <%
                return;
            }
        %>
</html>
