<%--
    Document   : avoirFC-fiche
    Created on : 2 août 2024, 15:56:27
    Author     : randr
--%>


<%@page import="avoir.AvoirFCLib"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
		 try{
    UserEJB u = (user.UserEJB)session.getValue("u");

    AvoirFCLib avoir = new AvoirFCLib();
    avoir.setNomTable("avoirfclib_cpl");
    PageConsulte pc = new PageConsulte(avoir, request, u);
    pc.setTitre("Fiche AvoirFC");
    String pageActuel = "station-ejb/src/java/avoir/avoirFC-fiche.jsp";
    avoir =(AvoirFCLib) pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idMagasinLib").setLibelle("Magasin");
    pc.getChampByName("idVente").setLibelle("Vente");
    pc.getChampByName("idVenteLib").setLibelle("Vente Lib");
    pc.getChampByName("idCategorieLib").setLibelle("Categorie");
    pc.getChampByName("idMotifLib").setLibelle("Motif");
    pc.getChampByName("montantHT").setLibelle("Montant HT");
    pc.getChampByName("montantTVA").setLibelle("Montant TVA");
    pc.getChampByName("montantTTC").setLibelle("Montant TTC");
    pc.getChampByName("montantHTAr").setLibelle("Montant HT Ar");
    pc.getChampByName("montantTVAAr").setLibelle("Montant TVA Ar");
    pc.getChampByName("montantTTCAr").setLibelle("Montant TTC Ar");
    pc.getChampByName("resteapayer").setLibelle("Reste &agrave; payer");
    pc.getChampByName("resteapayerar").setLibelle("Reste &agrave; payer Ar");
    pc.getChampByName("designation").setLibelle("D&eacute;signation");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("etat").setLibelle("Etat");
    pc.getChampByName("idMagasin").setVisible(false);
    pc.getChampByName("idOrigine").setVisible(false);
    pc.getChampByName("idClient").setVisible(false);
    pc.getChampByName("idMotif").setVisible(false);
    pc.getChampByName("idCategorie").setVisible(false);
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/avoir/avoirFC-modif.jsp";
    String classe = "avoir.AvoirFC";

    Onglet onglet = new Onglet("page1");
    onglet.setDossier("inc");
    Map<String, String> map = new HashMap<String, String>();
    map.put("avoirfc-details", "");
    if(avoir.getEtat() >= ConstanteEtat.getEtatValider()) {
        map.put("ecriture-detail", "");
        map.put("encaissement-vise-liste", "");
    }
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "avoirfc-details";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=avoir/avoirFC-liste.jsp"%> <i class="fa fa-arrow-circle-left"> </i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if(avoir.getEtat() > 0) { %>
                              <a  class="btn btn-danger pull-right"  href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=annuler&bute=avoir/avoirFC-fiche.jsp&classe="+classe %>">Annuler</button></a>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=avoir/avoirFC-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                            <% } %>
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <% if(avoir.getEtat()>= 11) { %>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=caisse/mvt/mvtCaisse-saisie-entree-avoir.jsp&idOrigine=" + avoir.getId()%> " style="margin-right: 10px">Decaisser</a>
                            <% } %>
                            <% if(avoir.getEtat()== 11) { %>
                                <a  href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&id=" + request.getParameter("id") + "&bute=avoir/avoirFC-fiche.jsp&classe=" + classe %>"><button class="btn btn-secondary pull-right" style="margin-right: 10px">Annuler Visa</button></a>
                            <% } %>
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
                    <li class="<%=map.get("avoirfc-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=avoirfc-details">D&eacute;tails</a></li>
                    <% if(avoir.getEtat() > 0) { %>
                        <li class="<%=map.get("ecriture-detail")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=ecriture-detail">Ecriture</a></li>
                        <li class="<%=map.get("encaissement-vise-liste")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=encaissement-vise-liste">Paiement</a></li>
                    <% } %>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab%>" >
                        <jsp:param name="idmere" value="<%= id%>" />
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>


<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
		history.back();</script>

<% }%>
