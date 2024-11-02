<%-- 
    Document   : avoir-details
    Created on : 9 août 2024, 10:22:24
    Author     : bruel
--%>


<%@page import="avoir.AvoirFCFilleLib"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try{
    AvoirFCFilleLib t = new AvoirFCFilleLib();
    t.setNomTable("AVOIRFCFILLELIB");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "idproduitlib","designation","pu","idDevise","tauxDeChange","tva"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and IDAVOIRFC='"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =  {"id", "Produit","D&eacute;signation", "Montant", "Devise", "Taux", "TVA(en %)"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        AvoirFCFilleLib[] liste=(AvoirFCFilleLib[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
    %>
   
    <%  }if(pr.getTableau().getHtml() == null)
         {
               %><center><h4>Aucune donne trouvee</h4></center><%
         }

        
    %>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>

