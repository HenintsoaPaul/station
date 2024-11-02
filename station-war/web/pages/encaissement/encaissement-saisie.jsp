


<%@page import="caisse.Caisse"%>
<%@page import="utils.ConstanteStation"%>
<%@page import="encaissement.Encaissement"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.Liste"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "encaissement.Encaissement",
            nomtable = "Encaissement",
            apres = "station-ejb/src/java/encaissement/encaissement-fiche.jsp",
            titre = "Paiement";
		String  montant=request.getParameter("montant");
		String idOrigine=request.getParameter("idOrigine");
		String devise=request.getParameter("devise");
    Encaissement enc = new Encaissement();
    enc.setNomTable("Encaissement");
    PageInsert pi = new PageInsert(enc, request, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("daty").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pi.getFormu().getChamp("taux").setDefaut("1");
    pi.getFormu().getChamp("montant").setDefaut(montant);
    pi.getFormu().getChamp("idOrigine").setDefaut(idOrigine);
    pi.getFormu().getChamp("idOrigine").setVisible(false);
    pi.getFormu().getChamp("etat").setVisible(false);
		pi.getFormu().getChamp("designation").setDefaut("Paiement de la facture : "+idOrigine);
		affichage.Champ[] liste = new affichage.Champ[2];
    liste[0] = new Liste("idDevise",new caisse.Devise(),"val","id");
		Caisse c = new Caisse();
		c.setIdPoint(ConstanteStation.getFichierCentre());
    liste[1] = new Liste("idCaisse",c,"val","id");
    liste[0].setDefaut(devise);
		pi.getFormu().changerEnChamp(liste);
		pi.getFormu().getChamp("idDevise").setLibelle("Devise");
		pi.getFormu().getChamp("idCaisse").setLibelle("Caisse");
		pi.getFormu().getChamp("idTypeEncaissement").setDefaut(ConstanteStation.TYPE_ENCAISSEMENT_ENTREE);
    pi.getFormu().getChamp("idTypeEncaissement").setVisible(false);




    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
				out.println(pi.getHtmlAddOnPopup());
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
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>
