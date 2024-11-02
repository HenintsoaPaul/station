<%--
    Document   : encaissement-precision-saisie
    Created on : 16 avr. 2024, 15:04:04
    Author     : Angela
--%>

<%@page import="encaissement.EncaissementViaP"%>
<%@page import="encaissement.PrecisionDetailEncaissement"%>
<%@page import="encaissement.Encaissement"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="caisse.CategorieCaisse"%>
<%
    try {
        UserEJB u = null;
        u = (UserEJB) session.getValue("u");
        EncaissementViaP mere = new EncaissementViaP();
        PrecisionDetailEncaissement fille = new PrecisionDetailEncaissement();
        int nombreLigne = 10;
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idCaisse").setPageAppel("choix/caisse/caisse-choix.jsp");
        pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("daty").setDefaut(utilitaire.Utilitaire.dateDuJour());

        affichage.Liste[] liste = new Liste[1];
        CategorieCaisse categ = new CategorieCaisse();
        categ.setNomTable("CategorieCaisse");
        liste[0] = new Liste("idCategorieCaisse",categ,"val","id");
        pi.getFormufle().changerEnChamp(liste);
        pi.getFormufle().getChamp("idCategorieCaisse_0").setLibelle("Categorie Caisse");
        pi.getFormufle().getChamp("reference_0").setLibelle("Reference");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        pi.getFormufle().getChamp("idClient_0").setLibelle("Client");
        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        pi.getFormufle().getChampMulitple("daty").setVisible(false);
        pi.getFormufle().getChampMulitple("idEncaissement").setVisible(false);
        for (int i = 0; i < nombreLigne; i++) {
            pi.getFormufle().getChamp("idClient_"+i).setPageAppel("choix/client/client-choix.jsp", "idClient_"+i+";idClientlibelle_"+i);
        }
        pi.preparerDataFormu();


        //Variables de navigation
        String classeMere = "encaissement.EncaissementViaP";
        String classeFille = "encaissement.PrecisionDetailEncaissement";
        String tab="precision-details";
        String butApresPost = "station-ejb/src/java/encaissement/encaissement-fiche.jsp&tab=" +tab;
        String colonneMere = "idEncaissement";
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();

%>
<div class="content-wrapper">
   <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1>Insertion Encaissement</h1>
                    </div>
                    <div class="box-body">
                        <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
                            <%

                                out.println(pi.getFormu().getHtmlInsert());
                                out.println(pi.getFormufle().getHtmlTableauInsert());
                            %>
                            <input name="acte" type="hidden" id="nature" value="insert">
                            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                            <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
                            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>


