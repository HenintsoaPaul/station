<%-- 
    Document   : historique.jsp
    Created on : 21 mars 2024, 15:15:01
    Author     : Angela
--%>



<%@page import="annexe.HistoriqueProduit"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try{
    HistoriqueProduit t = new HistoriqueProduit();
    t.setNomTable("HISTORIQUE_PRODUIT");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "daty","puVente"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idProduit = '"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
       
        String libEnteteAffiche[] =  {"id", "Date","Prix de vente"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        HistoriqueProduit[] liste=(HistoriqueProduit[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
         }else
         {
               %><center><h4>Aucune donne trouv</h4></center><%
         }

        
    %>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>


