<%@page import="caisse.VirementIntraCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    VirementIntraCaisse a = new VirementIntraCaisse();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    //Modification des affichages
    //pi.getFormu().getChamp("id").setVisible(false);
    pi.getFormu().getChamp("idCaisseDepart").setPageAppel("choix/caisse/etatcaisse-choix.jsp");
    pi.getFormu().getChamp("idCaisseArrive").setPageAppel("choix/caisse/etatcaisse-choix.jsp");
    pi.getFormu().getChamp("idCaisseDepart").setLibelle("Caisse depart");
    pi.getFormu().getChamp("idCaisseArrive").setLibelle("Caisse arrive");
    pi.getFormu().getChamp("Etat").setVisible(false);
    pi.getFormu().getChamp("idOrigine").setVisible(false);
    //Variables de navigation
    String classe = "caisse.VirementIntraCaisse";
    String butApresPost = "station-ejb/src/java/caisse/virementIntraCaisse/virementIntraCaisse-fiche.jsp";
    String nomTable = "VirementIntraCaisse";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Virement intra caisse</h1>
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
