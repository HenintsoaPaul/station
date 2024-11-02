<%--
    Document   : jauge-saisie
    Created on : 26 mars 2024, 14:32:05
    Author     : Angela
--%>


<%@page import="jauge.Jauge"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>
<%@page import="magasin.Magasin"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "jauge.Jauge",
            nomtable = "JAUGE",
            apres = "station-ejb/src/java/jauge/jauge-fiche.jsp",
            titre = "Insertion jauge";

    Jauge  jauge = new Jauge();
    jauge.setNomTable( "station-ejb/src/java/jauge" );
    PageInsert pi = new PageInsert(jauge, request, u);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("qte").setLibelle("Quantit&eacute;");
    pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pi.getFormu().getChamp("idMagasin").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
    pi.setLien((String) session.getValue("lien"));
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
