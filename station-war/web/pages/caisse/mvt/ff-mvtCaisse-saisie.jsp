<%@page import="utils.ConstanteStation"%>
<%@page import="caisse.Caisse"%>
<%@page import="faturefournisseur.FactureFournisseur"%>
<%@page import="caisse.MvtCaisse"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
    MvtCaisse a = new MvtCaisse();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
		String id =request.getParameter("id");
		String montant =request.getParameter("montant");
		Liste[] liste = new Liste[1];
    Caisse type = new Caisse();
		type.setIdPoint(ConstanteStation.getFichierCentre());
    type.setNomTable("CAISSE");
		liste[0] = new Liste("idCaisse",type,"val","id");
		pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("IdVenteDetail").setVisible(false);
    pi.getFormu().getChamp("IdVirement").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idOp").setVisible(false);
    pi.getFormu().getChamp("idOrigine").setVisible(false);
    pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
    pi.getFormu().getChamp("credit").setVisible(false);
    pi.getFormu().getChamp("debit").setLibelle("Montant a payer ");
		pi.getFormu().getChamp("debit").setDefaut(montant);
		pi.getFormu().getChamp("idOrigine").setDefaut(id);
		pi.getFormu().getChamp("designation").setDefaut("Facture fournisseur");
    //Variables de navigation
    String classe = "caisse.MvtCaisseTemp";
    String butApresPost = "station-ejb/src/java/caisse/mvt/mvtCaisse-fiche.jsp&idFF=" +id;
    String nomTable = "MOUVEMENTCAISSE";
    //Generer les affichages
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Encaissement Facture Fournisseur </h1>
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

