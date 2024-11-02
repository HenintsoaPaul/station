<%@page import="stock.TransfertStockDetails"%>
<%@page import="stock.TransfertStock"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="stock.TypeMvtStock"%>
<%@page import="stock.MvtStockFille"%>
<%@page import="stock.MvtStock"%>
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
        String classeMere = "stock.TransfertStock",
               classeFille = "stock.TransfertStockDetails",
               titre = "Saisie transfert de stock",
			   redirection = "station-ejb/src/java/stock/transfertstock/transfertstock-fiche.jsp";
        String colonneMere = "idTransfertStock";
        int taille = 10;

        TransfertStock mere = new TransfertStock();
        mere.setNomTable("TransfertStock");
        TransfertStockDetails fille = new TransfertStockDetails();
        fille.setNomTable("TransfertStockDetails");
        fille.setIdTransfertStock(request.getParameter("id"));
        TransfertStockDetails[] details = (TransfertStockDetails[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), details.length);
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idMagasindepart").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
        pi.getFormu().getChamp("idMagasinarrive").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
        pi.getFormu().getChamp("idMagasindepart").setLibelle("Magasin Depart");
        pi.getFormu().getChamp("idMagasinarrive").setLibelle("Magasin Depart");

        for(int i=0; i<pi.getNombreLigne(); i++){
            pi.getFormufle().getChamp("idProduit_" + i).setPageAppel("choix/stock/etatstock-choix.jsp", "idProduit_" + i + ";idProduitlibelle_" + i);
            pi.getFormufle().getChamp("idProduit_" + i).setAutre("readonly");
        }

        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("quantite_0").setLibelle("quantite");

        Champ.setVisible(pi.getFormufle().getChampFille("idTransfertStock"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
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
            <h2>Modification transfert de stocks</h2>
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
        <input name="nomtable" type="hidden" id="classefille" value="TransfertStockDetails">
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
