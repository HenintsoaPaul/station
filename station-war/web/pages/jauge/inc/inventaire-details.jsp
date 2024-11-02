<%-- 
    Document   : inventaire-details
    Created on : 27 mars 2024, 11:17:04
    Author     : Angela
--%>
<%@page import="inventaire.InventaireFilleCpl"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
        InventaireFilleCpl t = new InventaireFilleCpl();
        String listeCrt[] = {};
        String listeInt[] = {};
        String libEntete[] = {"id", "idProduitlib","quantiteTheorique","quantite"};
        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        if (request.getParameter("id") != null) {
            pr.setAWhere(" and idJauge='" + request.getParameter("id") + "'");
        }
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);

%>

        <div class="box-body">
            <%  
                String libEnteteAffiche[] =  {"Id", "Produit","Quantit&eacute; th&eacute;orique","Quantit&eacute;"};
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

