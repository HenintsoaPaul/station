<%--
    Document   : encaissement-prelevement-modif
    Created on : 12 avr. 2024, 08:38:57
    Author     : Angela
--%>

<%@page import="depense.Depense"%>
<%@page import="encaissement.EncaissementTemp"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    try {
        //Variable de navigation
        String classeMere = "encaissement.EncaissementTemp";
        String classeFille = "depense.Depense";
        String tab = "depenseEncaissement-liste";
        String butApresPost = "station-ejb/src/java/encaissement/encaissement-fiche.jsp&tab=" + tab;
        String colonneMere = "idOrigine";
        //Definition de l'affichage
        String id = request.getParameter("id");
        EncaissementTemp mere = new EncaissementTemp();
        mere.setNomTable("Encaissement");
        Depense fille = new Depense();
        fille.setIdOrigine(id);
        Depense[] details = (Depense[]) CGenUtil.rechercher(fille, null, null, "");
        int nombreLigne = details.length + 2;
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, (user.UserEJB) session.getValue("u"), 2);
        //Information globale
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idCaisse").setVisible(false);
        pi.getFormu().getChamp("designation").setVisible(false);
        pi.getFormu().getChamp("daty").setVisible(false);

        //fille
       pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation");
       pi.getFormufle().getChamp("daty_0").setLibelle("Date");
       pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
       pi.getFormufle().getChampMulitple("etat").setVisible(false);
       pi.getFormufle().getChampMulitple("idOp").setVisible(false);
       affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
        //Preparer affichage
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1>Modification Depense</h1>
                    </div>
                    <div class="box-body">
                        <form action="<%=(String) session.getValue("lien")%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                            <div class="row">
                                <div class="col-md-10 col-md-offset-1">
                                    <%
                                        out.println(pi.getFormu().getHtmlInsert());
                                    %>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-10 col-md-offset-1">
                                    <%
                                        out.println(pi.getFormufle().getHtmlTableauInsert());
                                    %>
                                </div>
                            </div>
                            <input name="acte" type="hidden" id="acte" value="updateInsert">
                            <input name="bute" type="hidden" id="bute" value="<%= butApresPost%>">
                            <input name="classe" type="hidden" id="classe" value="<%= classeMere%>">
                            <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille%>">
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
                            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere%>">
                            <input name="liaisonMere" type="hidden" id="liaisonMere" value="<%= colonneMere%>">
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


