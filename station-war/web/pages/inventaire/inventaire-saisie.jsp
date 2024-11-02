<%@page import="inventaire.InventaireFille"%>
<%@page import="inventaire.Inventaire"%>
<%@page import="stock.TypeMvtStock"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.Liste"%>
<%@page import="affichage.PageInsertMultiple"%>
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
        int taille = 10;

        Inventaire mere = new Inventaire();
        mere.setNomTable("Inventaire");
        InventaireFille fille = new InventaireFille();
        fille.setNomTable("InventaireFille");
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("idMagasin").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
        pi.getFormu().getChamp("idMagasin").setAutre("readonly");
        pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
        pi.getFormu().getChamp("remarque").setLibelle("Remarque");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("etat").setVisible(false);

        for(int i=0; i<taille; i++){
            pi.getFormufle().getChamp("idProduit_" + i).setPageAppel("choix/produit/produit-choix.jsp", "idProduit_" + i + ";idProduitlibelle_" + i);
            pi.getFormufle().getChamp("idProduit_" + i).setAutre("readonly");
            pi.getFormufle().getChamp("quantiteTheorique_" + i).setAutre("readonly");
        }
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("explication_0").setLibelle("Explication");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantit&eacute;");

        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idInventaire"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("quantiteTheorique"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idJauge"),false);

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("idInventaire"),false);
        pi.preparerDataFormu();

//        pi.getFormufle().setNbLigne(5);

        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
%>
<div class="content-wrapper">
    <h1><%=titre%></h1>
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
        <%

            out.println(pi.getFormu().getHtmlInsert());
        %>
        <div style="text-align: center;">
            <h2>Détails mouvement de stocks</h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="classefille" value="inventairefille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="10">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
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
