<%-- 
    Document   : perteventeimprevue-details
    Created on : 29 juil. 2024, 16:19:06
    Author     : bruel
--%>

<%@page import="pertegain.PerteGainImprevueLib"%>
<%@page import="pertegain.PerteGainImprevue"%>
<%@page import="caisse.MvtCaisseCpl"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
        PerteGainImprevueLib t = new PerteGainImprevueLib();
        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id", "designation", "type", "compte", "perte", "gain", "daty"};
        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        if (request.getParameter("id") != null) {
            pr.setAWhere(" and idorigine='" + request.getParameter("id") + "'");
        }
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=pertegain/pertegainimprevue-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);

%>

<div class="box-body">
    <%  String libEnteteAffiche[] = {"id", "Designation", "Type", "Compte", "Perte", "Gain", "Date"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        pr.getTableau().getData();
        if (pr.getTableau().getHtml() != null) {
            out.println(pr.getTableau().getHtml());
        } else {
    %><center><h4>Aucune donne trouvee</h4></center><%
        }


        %>
</div>
<%    } catch (Exception e) {
        e.printStackTrace();
    }%>