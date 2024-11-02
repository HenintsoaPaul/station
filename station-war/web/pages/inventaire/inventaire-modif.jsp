<%@page import="inventaire.InventaireFille"%>
<%@page import="inventaire.Inventaire"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.Liste"%>
<%@page import="bean.CGenUtil"%>
<%@page import="bean.TypeObjet"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@ page import="affichage.Champ" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        UserEJB u = u = (UserEJB) session.getValue("u");
        String classeMere = "inventaire.Inventaire",
               classeFille = "inventaire.InventaireFille",
               titre = "Saisie inventaire",
			   redirection = "station-ejb/src/java/inventaire/inventaire-fiche.jsp";
        String colonneMere = "idInventaire";

         Inventaire mere = new Inventaire();
        mere.setNomTable("Inventaire");
        InventaireFille fille = new InventaireFille();
        fille.setNomTable("InventaireFille");
        fille.setIdInventaire(request.getParameter("id"));
        InventaireFille[] details = (InventaireFille[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), details.length);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("idMagasin").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
        pi.getFormu().getChamp("idMagasin").setAutre("readonly");
        pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
        pi.getFormu().getChamp("remarque").setLibelle("Remarque");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("etat").setVisible(false);

        for(int i=0; i<pi.getNombreLigne(); i++){
            pi.getFormufle().getChamp("idProduit_" + i).setPageAppel("choix/produit/produit-choix.jsp", "idProduit_" + i + ";idProduitlibelle_" + i);
            pi.getFormufle().getChamp("idProduit_" + i).setAutre("readonly");
        }
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("quantiteTheorique_0").setLibelle("Quantit&eacute; th&eacute;orique");
        pi.getFormufle().getChamp("quantiteTheorique_0").setAutre("readonly");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantit&eacute;");

        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idInventaire"),false);

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idInventaire"),false);
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" >
        <%

             pi.getFormu().makeHtmlInsertTabIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div style="text-align: center;">
            <h2>Modification mouvement de stocks</h2>
        </div>
        <%
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=details.length%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
        <input name="nomtable" type="hidden" id="nomtable" value="InventaireFille">
    </form>
</div>

<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>
