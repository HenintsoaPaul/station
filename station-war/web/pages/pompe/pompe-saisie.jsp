<%--
    Document   : pompe-ajout
    Created on : 21 mars 2024, 12:14:41
    Author     : SAFIDY
--%>


<%@page import="pompe.Pompe"%>
<%@page import="magasin.Magasin"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "pompe.Pompe",
            nomtable = "POMPE",
            apres = "station-ejb/src/java/pompe/pompe-fiche.jsp",
            titre = "Insertion Pompe";
    Pompe  pompe = new Pompe();
    pompe.setNomTable("POMPE");
    PageInsert pi = new PageInsert(pompe, request, u);
    affichage.Champ[] liste = new affichage.Champ[1];
    Magasin o= new Magasin();
    liste[0] = new Liste("idMagasin", o, "VAL", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pi.getFormu().getChamp("max").setLibelle("Compteur Max");
    pi.getFormu().getChamp("max").setDefaut("1000000");
    pi.preparerDataFormu();
%>
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
