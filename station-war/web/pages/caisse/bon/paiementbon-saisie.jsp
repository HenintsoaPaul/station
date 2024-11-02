<%@page import="caisse.PaiementBon"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    PaiementBon a = new PaiementBon();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    /*
    idClient
idCaisseBon
idCaissePaiement
    */
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idClient").setPageAppel("choix/caisse/detailsboncaissereste-choix.jsp","idClient;idClientlibelle;idCaisseBon;montant");
    pi.getFormu().getChamp("idCaissePaiement").setPageAppel("choix/caisse/caisse-choix.jsp");
    pi.getFormu().getChamp("idCaisseBon").setAutre("readonly");
    pi.getFormu().getChamp("idClient").setAutre("readonly");
    pi.getFormu().getChamp("idCaissePaiement").setAutre("readonly");
    //Variables de navigation
    String classe = "caisse.PaiementBon";
    String butApresPost = "station-ejb/src/java/caisse/bon/paiementbon-fiche.jsp";
    String nomTable = "PaiementBon";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie paiement bon</h1>
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

