<%@page import="stock.MvtStockFilleLib"%> 
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8;" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<% 
               
    try{
        MvtStockFilleLib  t = new MvtStockFilleLib();
    t.setNomTable("mvtstockfillelib");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","idmvtstock","idproduitlib","entree","sortie","idventedetail"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" AND idmvtstock in (select id from mvtstock where idtransfert ='"+request.getParameter("id")+"') ");
    }
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme); 
%>

<div class="box-body">
    <%
        String lienTableau[] = {pr.getLien() + "?but=stock/mvtstock-fiche.jsp"};
        String colonneLien[] = {"idmvtstock"};
        pr.getTableau().setLien(lienTableau);
   
        pr.getTableau().setColonneLien(colonneLien);
        String libEnteteAffiche[] =   {"ID","ID Mvt Stock","Produit","Entree","Sortie","ID Details Vente"};
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