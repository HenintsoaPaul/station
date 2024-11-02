<%--
    Document   : depense-saisie.jsp
    Created on : 10 mai 2024, 10:22:02
    Author     : CMCM
--%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="depense.Depense"%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Produit"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "depense.Depense",
            nomtable = "station-ejb/src/java/depense",
            apres = "station-ejb/src/java/depense/depense-fiche.jsp",
            titre = "Insertion Depense";

    Depense  objet  = new Depense();
    objet.setNomTable("DEPENSE");
    PageInsert pi = new PageInsert(objet, request, u);
    affichage.Champ[] liste = new affichage.Champ[2];
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idCaisse").setPageAppel("choix/caisse/caisse-choix.jsp");
    pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("idOrigine").setVisible(false);
    pi.getFormu().getChamp("idOp").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("daty").setDefaut(Utilitaire.dateDuJour());
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
