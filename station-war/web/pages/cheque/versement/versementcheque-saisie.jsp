<%@page import="cheque.VersementChequeDetails"%>
<%@page import="cheque.VersementCheque"%>
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
        String classeMere = "cheque.VersementCheque",
               classeFille = "cheque.VersementChequeDetails",
               titre = "Saisie versement cheque",
                nomtablefille="VersementChequeDetails",
		redirection = "station-ejb/src/java/cheque/versement/versementcheque-fiche.jsp";
        String colonneMere = "idVersementCheque";
        int taille = 10;

        VersementCheque mere = new VersementCheque();
        mere.setNomTable("VersementCheque");
        VersementChequeDetails fille = new VersementChequeDetails();
        fille.setNomTable("VersementChequeDetails");
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, taille, u);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("idCaisse").setPageAppel("choix/caisse/caisse-choix.jsp");
        pi.getFormu().getChamp("idCaisse").setAutre("readonly");
        pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("etat").setVisible(false);

        for(int i=0; i<taille; i++){
            pi.getFormufle().getChamp("idCheque_" + i).setPageAppel("choix/cheque/cheque-choix.jsp", "idCheque_" + i + ";idChequelibelle_" + i);
            pi.getFormufle().getChamp("idCheque_" + i).setAutre("readonly");
        }
        pi.getFormufle().getChamp("idCheque_0").setLibelle("Cheque");
        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");


        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idVersementCheque"),false);
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
            <h2>Détails versement cheque</h2>
        </div>
        <%
            out.println(pi.getFormufle().getHtmlTableauInsert());

        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nomtable" type="hidden" id="classefille" value="<%=nomtablefille%>">
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
