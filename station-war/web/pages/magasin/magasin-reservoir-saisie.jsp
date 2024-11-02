<%@page import="magasin.Magasin"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    Magasin a = new Magasin();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    Liste[] liste = null;
    String titre = "Magasin";

        liste = new Liste[2];
        TypeObjet point = new TypeObjet();
        point.setNomTable("point");
        liste[0] = new Liste("idPoint", point, "val", "id");

        TypeObjet produit = new TypeObjet();
        produit.setNomTable("produit");
        liste[1] = new Liste("idProduit", produit, "val", "id");

        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("idTypeMagasin").setDefaut("TYPMG000001");
        titre = "R&eacute;servoir";
        pi.getFormu().getChamp("idProduit").setLibelle("Produit");


    pi.getFormu().getChamp("val").setLibelle("Libell&eacute;");
    pi.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
    pi.getFormu().getChamp("idPoint").setLibelle("Point");
    pi.getFormu().getChamp("idTypeMagasin").setAutre("readonly");
    pi.getFormu().getChamp("idTypeMagasin").setLibelle("Type magasin");



    String classe = "magasin.Magasin";

    String butApresPost = "station-ejb/src/java/magasin/magasin-fiche.jsp";
    String nomTable = "station-ejb/src/java/magasin";
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie <%=titre%></h1>
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
