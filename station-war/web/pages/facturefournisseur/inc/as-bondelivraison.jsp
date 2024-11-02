
<%@page import="faturefournisseur.As_BonDeLivraison"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8;" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    As_BonDeLivraison t = new As_BonDeLivraison();
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","remarque","daty", "station-ejb/src/java/magasin" };
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idbc='"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =  {"Id","Remarque","Date","Magasin"};
        String libEnteteAffiche[] =  {"Id","Remarque","Date","Magasin"};
        String lienTableau[] = {pr.getLien() + "?but=bondelivraison/bondelivraison-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setColonneLien(colonneLien);
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
         }else
         {
               %><div style="text-align: center;"><h4>Aucune donnée trouvée</h4></div><%
         }


    %>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>


