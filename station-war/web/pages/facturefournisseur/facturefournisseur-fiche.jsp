<%@page import="faturefournisseur.FactureFournisseurCpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    UserEJB u = (user.UserEJB)session.getValue("u");

%>
<%
    try{
    FactureFournisseurCpl f = new FactureFournisseurCpl();
    f.setNomTable("FACTUREFOURNISSEURCPL");
    PageConsulte pc = new PageConsulte(f, request, u);
    pc.setTitre("D&eacute;tail facture fournisseur");
    f=(FactureFournisseurCpl)pc.getBase();
    request.setAttribute("factureFournisseur", f);
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("Id").setLibelle("Id");
    pc.getChampByName("idMagasinLib").setLibelle("Magasin");
    pc.getChampByName("idFournisseurLib").setLibelle("Fournisseur");
    pc.getChampByName("designation").setLibelle("d&eacute;signation");
    pc.getChampByName("reference").setLibelle("r&eacute;f&eacute;rence");
    pc.getChampByName("idModePaiementLib").setLibelle("Mode de paiement");
    pc.getChampByName("montantPaye").setLibelle("Montant Pay&eacute;");
    pc.getChampByName("montantReste").setLibelle("Montant Reste");
    pc.getChampByName("dateEcheancePaiement").setLibelle("Date &eacutech&eacuteance de paiement");
    pc.getChampByName("daty").setLibelle("Date");
	pc.getChampByName("idBc").setVisible(false);
    pc.getChampByName("taux").setVisible(false);
	pc.getChampByName("idMagasin").setVisible(false);
	pc.getChampByName("idFournisseur").setVisible(false);
	pc.getChampByName("idModePaiement").setVisible(false);
	pc.getChampByName("etatLib").setVisible(false);


    String pageActuel = "facturefournisseur/facturefournisseur-fiche.jsp";

    String lien = (String) session.getValue("lien");
    String pageModif = "facturefournisseur/facturefournisseur-modif.jsp";
    String classe = "faturefournisseur.FactureFournisseur";

    Map<String, String> map = new HashMap<String, String>();
    map.put("inc/facture-fournisseur-liste-detail", "");
    map.put("inc/mvtcaisse-details", "");
    map.put("inc/ecriture-detail", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inc/facture-fournisseur-liste-detail";
    }
    map.put(tab, "active");
    tab = tab + ".jsp";
    String idDevise = ((FactureFournisseurCpl)pc.getBase()).getIdDevise();
    request.setAttribute("idDevise", idDevise);

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=facturefournisseur/facturefournisseur-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (f.getEtat() < 11) { %>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=facturefournisseur/facturefournisseur-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <% }
                            %>
                            <% if (f.getEtat() >= 11) { %>
                                <a class="btn btn-primary pull-right" href="<%= lien + "?but="+ "facturefournisseur/apresLivraisonFacture.jsp" +"&id=" + id%>" style="margin-right: 10px">Livrer</a>
                                <a class="btn btn-warning pull-right" href="<%= lien + "?but="+ "station-ejb/src/java/caisse/mvt/mvtCaisse-saisie-sortie-fc.jsp" +"&idOrigine=" + id+"&devise="+f.getIdDevise()+"&montant="+f.getMontantreste()+"&tiers="+f.getIdFournisseur()+"&idPrevision="+f.getIdPrevision()%>" style="margin-right: 10px">Decaisser</a>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=vente/planPaiement-saisie.jsp&id="+id+"&classe=faturefournisseur.FactureFournisseur&table="+f.getNomTable()+"&bute="+pageActuel%>" style="margin-right: 10px">Plan de Paiement</a>
                            <% }
                            %>
                       </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <!-- a modifier -->
                    <li class="<%=map.get("inc/facture-fournisseur-liste-detail")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>?&tab=inc/facture-fournisseur-liste-detail">Détails</a></li>
                    <li class="<%=map.get("inc/ecriture-detail")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=inc/ecriture-detail">Ecriture</a></li>

                    <li class="<%=map.get("inc/mvtcaisse-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=inc/mvtcaisse-details">Mouvement Caisse</a></li>
                    <li class="<%=map.get("inc/liste-prevision")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=inc/liste-prevision">Plan de paiements</a></li>
                    <%-- <li class="<%=map.get("inc/as-bondelivraison")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/as-bondelivraison">Détails de Livraison</a></li> --%>

                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idFactureFournisseur" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>

<% } catch(Exception e) {
    e.printStackTrace();
    throw e;
} %>
