<%@page import="vente.As_BondeLivraisonClientFille_Cpl"%> 
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8;" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<% 
    try{
    As_BondeLivraisonClientFille_Cpl t = new As_BondeLivraisonClientFille_Cpl();
    t.setNomTable("AS_BONLIVRFILLE_CLIENT_CPL");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","produit","idproduitlib","quantite","idventedetail","idbc"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and numbl='"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =   {"ID","IDProduit","Nom du produit","Quantite","idventedetail","IDBC"};
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