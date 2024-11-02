

<%@page import="faturefournisseur.As_BonDeLivraison_Fille_Cpl"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    /*
    String id,produit,numbl;
    double quantite;
    String iddetailsfacturefournisseur;
    String magasin;
    String unite;
    */
    try {
        String lien = (String) session.getValue("lien");
        String pageModif = "bondelivraison/bondelivraison-modif.jsp";
        As_BonDeLivraison_Fille_Cpl t = new As_BonDeLivraison_Fille_Cpl();
        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id","produitlib", "quantite","unitelib"};
        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        String id =request.getParameter("id");
        if(request.getParameter("id") != null){
            pr.setAWhere(" and numbl='"+id+"'");
        }
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
        int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] = {"id","produit", "quantite","unite"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        if (pr.getTableau().getHtml() != null) {
            out.println(pr.getTableau().getHtml());
        } else {
    %><center><h4>Aucune donne trouvee</h4></center><%
                   }


        %>
    <div class="box-footer">

    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }%>

