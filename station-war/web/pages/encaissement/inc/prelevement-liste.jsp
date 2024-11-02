<%--
    Document   : encaissement-details
    Created on : 4 avr. 2024, 10:05:37
    Author     : Angela
--%>

<%@page import="encaissement.PrelevementEncaisse"%>
<%@page import="encaissement.PrecisionDetailEncaissementLib"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{

    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/encaissement/prelevement-encaisse-modif.jsp";
    PrelevementEncaisse t = new PrelevementEncaisse();
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "idPrelevement","remarque"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String id =request.getParameter("id");
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idEncaissement='"+id+"'");
    }
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =  {"id", "Id Prelevement","Remarque"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        PrelevementEncaisse[] liste=(PrelevementEncaisse[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());

        }else
        {%>
            <center><h4>Aucune donne trouvee</h4></center>
        <%}


    %>
        <div class="box-footer">

            <a class="btn btn-warning pull-right" href="<%= lien + "?but=" + pageModif + "&id=" + id%>" style="margin-right: 10px">Modifier</a>
        </div>

</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>

