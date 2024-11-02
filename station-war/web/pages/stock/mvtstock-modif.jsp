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
        String classeMere = "stock.MvtStock",
               classeFille = "stock.MvtStockFille",
               titre = "Modification mouvement de stock",
			   redirection = "station-ejb/src/java/stock/mvtstock-fiche.jsp";
        String colonneMere = "idMvtStock";

        MvtStock mere = new MvtStock();
        mere.setNomTable("MVTSTOCK");
        MvtStockFille fille = new MvtStockFille();
        fille.setNomTable("MVTSTOCKFILLE");
        fille.setIdMvtStock(request.getParameter("id"));
        MvtStockFille[] details = (MvtStockFille[]) CGenUtil.rechercher(fille, null, null, "");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), details.length);
        pi.setLien((String) session.getValue("lien"));

        Liste[] liste = new Liste[1];
        TypeMvtStock typemvt = new TypeMvtStock();
        liste[0] = new Liste("idTypeMvStock",typemvt,"val","id");

        pi.getFormu().changerEnChamp(liste);

        pi.getFormu().getChamp("idMagasin").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
        pi.getFormu().getChamp("idMagasin").setAutre("readonly");
        pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
        pi.getFormu().getChamp("idVente").setVisible(false);
        pi.getFormu().getChamp("idTransfert").setVisible(false);
        pi.getFormu().getChamp("idTypeMvStock").setLibelle("Type mouvement de stock");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("etat").setVisible(false);

        for(int i=0; i<pi.getNombreLigne(); i++){
            pi.getFormufle().getChamp("idProduit_" + i).setPageAppel("choix/stock/etatstock-choix.jsp", "idProduit_" + i + ";idProduitlibelle_" + i);
            pi.getFormufle().getChamp("idProduit_" + i).setAutre("readonly");
        }

        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("Entree_0").setLibelle("Entr&eacute;e");
        pi.getFormufle().getChamp("Sortie_0").setLibelle("Sortie");

        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idMvtStock"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idTransfertDetail"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idVenteDetail"),false);

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idMvtStock"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idTransfertDetail"),false);
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
        <input name="nomtable" type="hidden" id="classefille" value="mvtstockfille">
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
