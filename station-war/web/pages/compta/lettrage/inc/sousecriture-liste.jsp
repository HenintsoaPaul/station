<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mg.cnaps.compta.ComptaSousEcriture" %>
<%@ page import="affichage.PageRecherche" %><%--
  Created by IntelliJ IDEA.
  User: tsiry
  Date: 20/02/2024
  Time: 10:58
  To change this template use File | Settings | File Templates.
--%>
<%
    ComptaSousEcriture sousecr = new ComptaSousEcriture();
//    String mvtstockId = "AND lettrage = '" + request.getParameter("id") + "' order by id asc";
    String[] listeCrt = {"lettrage"};
    String[] listeInt = {};
    String[] libEntete = {"id", "compte", "debit", "credit", "remarque"};

    PageRecherche pr = new PageRecherche(sousecr, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
//    pr.setAWhere(mvtstockId);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("#");
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;

    String[] libEntAffichage = {"Id", "Compte", "Débit", "Credit", "Remarque"};
    pr.getTableau().setLibelleAffiche(libEntAffichage);

%>

<%
    if (pr.getTableau().getHtmlAvecOrdre() != null) {
        out.println(pr.getTableau().getHtmlAvecOrdre());
    } else {
%>
<div style="text-align: center;"><h4>Aucune donnée trouvée pour la liste des sous-écritures</h4></div>
<%
    }
%>

