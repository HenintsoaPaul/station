<%--
    Document   : prelevement-saisie
    Created on : 27 mars 2024, 11:31:14
    Author     : SAFIDY
--%>

<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageInsert"%>
<%@page import="prelevement.Prelevement"%>
<%@page import="pompe.PompisteLib"%>
<%@page import="pompe.Pompe"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>

<%
    try{
    String autreparsley = "data-parslsey-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "prelevement.Prelevement",
            nomtable = "PRELEVEMENT",
            apres = "station-ejb/src/java/prelevement/prelevement-fiche.jsp",
            titre = "Insertion Prelevement";

    Prelevement  prelevement = new Prelevement();
    PageInsert pi = new PageInsert(prelevement, request, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idPrelevementAnterieur").setVisible(false);
    pi.getFormu().getChamp("compteur").setLibelle("Compteur");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("heure").setLibelle("Heure");
    pi.getFormu().getChamp("heure").setType("time");
    pi.getFormu().getChamp("idPompiste").setLibelle("Pompiste");
    pi.getFormu().getChamp("idPompe").setLibelle("Pompe");
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("etat").setVisible(false);
    Liste[] liste = new Liste[2];
        PompisteLib us = new PompisteLib();
        us.setNomTable("POMPISTELIB");
        liste[0] = new Liste("idPompiste",us,"NOMUSER","REFUSER");
        Pompe pompe = new Pompe();
        pompe.setNomTable("POMPE");
        liste[1] = new Liste("idPompe",pompe,"val","id");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idPompiste").setLibelle("Pompiste");
    pi.getFormu().getChamp("idPompe").setLibelle("Pompe");
    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="<%=apres%>">
    <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
    <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>
