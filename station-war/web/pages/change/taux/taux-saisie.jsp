<%@page import="change.TauxDeChange"%>
<%@page import="caisse.Devise"%>
<%@page import="affichage.*"%>

<%
    TauxDeChange taux = new TauxDeChange();

    PageInsert pageInsert = new PageInsert( taux, request, (user.UserEJB) session.getValue("u") );
    Liste[] listes = new Liste[1];
    listes[0] = new Liste("idDevise", new Devise(), "val", "id");
    pageInsert.setLien((String) session.getValue("lien"));

    pageInsert.getFormu().changerEnChamp(listes);
    pageInsert.getFormu().getChamp("idDevise").setLibelle("Devise");
    pageInsert.getFormu().getChamp("daty").setLibelle("Date de change");
    pageInsert.getFormu().getChamp("daty").setDefaut(utilitaire.Utilitaire.dateDuJour());

    pageInsert.getFormu().getChamp("taux").setLibelle("Taux de Change");

    String classe = "change.TauxDeChange";
    String butApresPost = "station-ejb/src/java/change/taux/taux-fiche.jsp"; // A changer en fiche
    String table = "tauxdechange";

    pageInsert.preparerDataFormu();
    pageInsert.getFormu().makeHtmlInsertTabIndex();
%>

<div class="content-wrapper">
    <h1 align="center">saisie taux de change</h1>
    <form action="<%=pageInsert.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pageInsert.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= table %>">
    </form>
</div>
