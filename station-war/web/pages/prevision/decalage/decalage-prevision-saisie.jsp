<%--
    Document   : decalage-prevision-saisie
    Created on : 23 ao�t 2024, 17:32:14
    Author     : Mendrika
--%>

<%@page import="prevision.mapping.DecalagePrevision"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="caisse.ReportCaisse"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>

<%
    try{
    String autreparsley = "data-parslsey-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "prevision.mapping.DecalagePrevision",
            nomtable = "DECALAGEPREVISION",
            apres = "station-ejb/src/java/prevision/prevision-fiche.jsp",
            titre = "Decalage prevision";

    DecalagePrevision  decalage = new DecalagePrevision();
    decalage.setNomTable("DECALAGEPREVISION");
    PageInsert pi = new PageInsert(decalage, request, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idPrevision").setLibelle("Prevision");
    pi.getFormu().getChamp("idPrevision").setDefaut(request.getParameter("id"));
    pi.getFormu().getChamp("idPrevision").setAutre("readonly");
    pi.getFormu().getChamp("debit").setLibelle("D&eacute;bit");
    pi.getFormu().getChamp("debit").setDefaut(request.getParameter("debit"));
    pi.getFormu().getChamp("credit").setLibelle("Cr&eacute;dit");
    pi.getFormu().getChamp("credit").setDefaut(request.getParameter("credit"));
    pi.getFormu().getChamp("idDevise").setLibelle("Devise");
    pi.getFormu().getChamp("idDevise").setDefaut(request.getParameter("devise"));
    pi.getFormu().getChamp("datyNouveau").setLibelle("Date");
    pi.getFormu().getChamp("datyNouveau").setDefaut(Utilitaire.dateDuJour());
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
