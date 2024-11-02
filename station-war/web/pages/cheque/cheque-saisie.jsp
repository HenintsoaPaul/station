<%@page import="cheque.Cheque"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    Cheque a = new Cheque();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    //pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("idCaisse").setPageAppel("choix/caisse/caisse-choix.jsp");
    pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("idClient").setPageAppel("choix/client/client-choix.jsp");
    pi.getFormu().getChamp("idClient").setLibelle("Client");
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("idPrecisionDetailEncaissement").setVisible(false);
    //Variables de navigation
    String classe = "cheque.Cheque";
    String butApresPost = "station-ejb/src/java/cheque/cheque-fiche.jsp";
    String nomTable = "Cheque";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">saisie cheque</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>
