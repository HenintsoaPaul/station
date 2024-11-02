<%--
    Document   : depenseEncaissement-saisie.jsp
    Created on : 10 mai 2024, 14:23:28
    Author     : CMCM
--%>

<%@page import="depense.DepenseEncaissement"%>
<%@page import="encaissement.EncaissementTemp"%>
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
        EncaissementTemp mere = new EncaissementTemp();
        DepenseEncaissement fille = new DepenseEncaissement();
        int nombreLigne = 10;
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);
        String id = request.getParameter("id");
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idCaisse").setVisible(false);
        pi.getFormu().getChamp("designation").setVisible(false);
        pi.getFormu().getChamp("daty").setVisible(false);
        pi.getFormu().getChamp("idEncaissement").setDefaut(id);
        pi.getFormu().getChamp("idEncaissement").setAutre("readonly");

        affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        for (int i = 0; i < nombreLigne; i++) {
            pi.getFormufle().getChamp("daty_"+i).setDefaut(Utilitaire.dateDuJour());
        }
        pi.getFormufle().getChampMulitple("idEncaissement").setVisible(false);
        pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation");
        pi.getFormufle().getChamp("daty_0").setLibelle("Date");
        pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
        pi.getFormufle().getChampMulitple("etat").setVisible(false);
        pi.getFormufle().getChampMulitple("idEncaissement").setVisible(false);
        pi.preparerDataFormu();

        //Variables de navigation
        String classeMere = "encaissement.EncaissementTemp";
        String classeFille = "depense.DepenseEncaissement";
        String tab="depenseEncaissement-liste";
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
                        <h1>Depense Encaissement</h1>
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

