<%@page import="cheque.VersementChequeDetails"%>
<%@page import="cheque.VersementCheque"%>
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
        UserEJB u = (UserEJB) session.getValue("u");
         String classeMere = "cheque.VersementCheque",
               classeFille = "cheque.VersementChequeDetails",
               titre = "Saisie versement cheque",
                nomtablefille="VersementChequeDetails",
		redirection = "station-ejb/src/java/cheque/versement/versementcheque-fiche.jsp";
        String colonneMere = "idVersementCheque";

        VersementCheque mere = new VersementCheque();
        mere.setNomTable("VersementCheque");
        VersementChequeDetails fille = new VersementChequeDetails();
        fille.setNomTable("VersementChequeDetails");
        fille.setIdVersementCheque(request.getParameter("id"));
        VersementChequeDetails[] details = (VersementChequeDetails[]) CGenUtil.rechercher(fille, null, null, " and IdVersementCheque='"+request.getParameter("id")+"' ");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), details.length);
        pi.setLien((String) session.getValue("lien"));

        pi.getFormu().getChamp("idCaisse").setPageAppel("choix/caisse/caisse-choix.jsp");
        pi.getFormu().getChamp("idCaisse").setAutre("readonly");
        pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("etat").setVisible(false);

        for(int i=0; i<pi.getNombreLigne(); i++){
            pi.getFormufle().getChamp("idCheque_" + i).setPageAppel("choix/cheque/cheque-choix.jsp", "idCheque_" + i + ";idChequelibelle_" + i);
            pi.getFormufle().getChamp("idCheque_" + i).setAutre("readonly");
        }
        pi.getFormufle().getChamp("idCheque_0").setLibelle("Cheque");
        pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");


        Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
        Champ.setVisible(pi.getFormufle().getChampFille("idVersementCheque"),false);
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
            <h2>Modification versement cheque</h2>
        </div>
        <%
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="<%=redirection%>">
        <input name="classe" type="hidden" id="classe" value="<%=classeMere%>">
        <input name="classefille" type="hidden" id="classefille" value="<%=classeFille%>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=details.length + 2%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%=colonneMere%>">
        <input name="nomtable" type="hidden" id="classefille" value="<%=nomtablefille%>">
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
