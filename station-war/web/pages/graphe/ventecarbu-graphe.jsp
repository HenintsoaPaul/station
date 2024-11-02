<%@page import="encaissement.PrelevementEncaissementGraph"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%
try{
    //Graphe ventecarbu
    PrelevementEncaissementGraph p = new PrelevementEncaissementGraph();
    String nomTable = "vente_carbu_client";
    String bute="graphe/ventecarbu-graphe.jsp";
    p.setNomTable(nomTable);
    String listeCrt[] = {"daty"};
    String listeInt[] = {"daty"};
    String colDefaut[] = {"nomuser"};
    int npp = 10;
    String typegraphe = "barchart";
    p.setNomTable(nomTable);
    String somDefaut[] = {"venteCarburant"};
    String[] libelles = { "station-ejb/src/java/vente" };
    PageGraph pr1 = new PageGraph(p, request, listeCrt, listeInt, 3, colDefaut, somDefaut, colDefaut.length, somDefaut.length);
    pr1.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr1.setLien((String) session.getValue("lien"));
    String[]couleur={"red","green","yellow","blue","grey"};
    pr1.setCouleur(couleur);
    pr1.setHeight(250);
    pr1.setX("nomuser");
    pr1.setY("venteCarburant");
    pr1.getChart().setScaleShowGridLines(true);
    pr1.setTitre("vente Carburant");
    pr1.getChart().setType(typegraphe);
    pr1.setNpp(npp);
    pr1.setChartName("chart1");
    pr1.creerObjetPage();
    pr1.getFormu().getChamp("daty1").setLibelle("Date min");
    pr1.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr1.getFormu().getChamp("daty2").setLibelle("Date max");
    pr1.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    /* pr1.getChartOption().setColOnClick("projet");
    pr1.getChartOption().getChart().setLienOnClick(pr1.getLien()+"?but=ligneCredit/situation-ligneCreditDepense.jsp");
    pr1.getChartOption().getChart().setLibelleOnClick("projet");*/
    pr1.getChartOption().getTableau().setLibelleAffiche(libelles);

%>

<div class="content-wrapper">
    <section class="content-header">
		<h1>Analyse Vente Carburant</h1>
    </section>
    <form action="<%=pr1.getLien()%>?but=ligneCredit/analyse.jsp" method="post" name="analyse" id="analyse">
        <% out.println(pr1.getFormu().getHtmlEnsemble());%>
        <br>
        <section class="content">

            <div class="row">
                <div class="col-md-12">
                    <%
                        out.println(pr1.getHtml());
                    %>
                </div>
            </div>

            <div id="basPage"><%= pr1.getBasPage() %></div>
        </section>
    </form>
</div>

<%}catch(Exception ex){
    ex.printStackTrace();
}%>
