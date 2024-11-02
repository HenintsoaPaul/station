<%--
    Document   : encaissement-details
    Created on : 4 avr. 2024, 10:05:37
    Author     : Angela
--%>

<%@page import="depense.DepenseLib"%>
<%@page import="depense.DepenseEncaissement"%>
<%@page import="encaissement.PrecisionDetailEncaissementLib"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        String lien = (String) session.getValue("lien");
        String pageModif = "station-ejb/src/java/encaissement/depenseEncaissement-modif.jsp";
        DepenseLib  t = new DepenseLib();
        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id","daty","designation","idCaisseLib","montant","etatLib"};
        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        String id = request.getParameter("id");
        if (request.getParameter("id") != null) {
            pr.setAWhere(" and idOrigine='" + id + "'");
        }
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
       int nombreLigne = pr.getTableau().getData().length;
       String lienTableau[] = {pr.getLien() + "?but=depense/depense-fiche.jsp&idEncaissement="+id};
       String colonneLien[] = {"id"};
       pr.getTableau().setLien(lienTableau);
       pr.getTableau().setColonneLien(colonneLien);
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] = {"id","Date", "D&eacute;signation", "Caisse","Montant","Etat"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        DepenseLib[] liste = (DepenseLib[]) pr.getTableau().getData();
        if (pr.getTableau().getHtml() != null) {
            out.println(pr.getTableau().getHtml());
        } else {
    %><center><h4>Aucune donne trouvee</h4></center><%
        }


        %>
    <div class="box-footer">

        <a class="btn btn-warning pull-right" href="<%= lien + "?but=" + pageModif + "&id=" + id%>" style="margin-right: 10px">Modifier</a>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }%>

