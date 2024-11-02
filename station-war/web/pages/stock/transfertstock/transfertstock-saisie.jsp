<%@page import="magasin.Magasin"%>
<%@page import="annexe.Categorie"%>
<%@page import="annexe.Point"%>
<%@page import="stock.TypeMvtStock"%>
<%@page import="stock.TransfertStockDetails"%>
<%@page import="stock.TransfertStock"%>
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
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("etat").setVisible(false);


				Liste[] liste = new Liste[2];
        Magasin m1 = new Magasin();
        m1.setNomTable("Magasin");

				Magasin m2 = new Magasin();
        m2.setNomTable("Magasin");

        liste[0] = new Liste("idMagasinDepart", m1, "val", "id");
				liste[1] = new Liste("idMagasinArrive", m2, "val", "id");
        pi.getFormu().changerEnChamp(liste);



        pi.getFormu().getChamp("idMagasinDepart").setDefaut(Point.getDefaultMagasin());
        pi.getFormu().getChamp("idMagasinDepart").setLibelle("Magasin Depart");
        pi.getFormu().getChamp("idMagasinArrive").setLibelle("Magasin arrive");

        for(int i=0; i<taille; i++){
            pi.getFormufle().getChamp("idProduit_" + i).setPageAppel("choix/stock/etatstock-choix.jsp", "idProduit_" + i + ";idProduitlibelle_" + i);
            pi.getFormufle().getChamp("idProduit_" + i).setAutre("readonly");
        }
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("quantite_0").setLibelle("quantite");

        Champ.setVisible(pi.getFormufle().getChampFille("idTransfertStock"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);

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
            <h2>Détails transfert de stocks</h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="classefille" value="TransfertStockDetails">
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
