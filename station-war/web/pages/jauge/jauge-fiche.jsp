<%--
    Document   : jauge-fiche
    Created on : 26 mars 2024, 14:32:19
    Author     : Angela
--%>

<%@page import="jauge.Jauge"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="constante.ConstanteEtat"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>


<%
    UserEJB u = (user.UserEJB) session.getValue("u");

%>
<%

    String pageActuel = "station-ejb/src/java/jauge/jauge-fiche.jsp";
    Jauge objet = new Jauge();
    objet.setNomTable("JAUGE");
    PageConsulte pc = new PageConsulte(objet, request, u);
    pc.setTitre("Fiche Jauge");
    objet = (Jauge) pc.getBase();
    String id = pc.getBase().getTuppleID();
    pc.getChampByName("idMagasin").setLibelle( "station-ejb/src/java/magasin" );
    pc.getChampByName("qte").setLibelle("Quantit&eacute;");
    pc.getChampByName("daty").setLibelle("Date");
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/jauge/jauge-modif.jsp";
    String classe = "jauge.Jauge";
    Onglet onglet = new Onglet("page1");
    onglet.setDossier("inc");
    Map<String, String> map = new HashMap<String, String>();
    map.put("inventaire-details", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inventaire-details";
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
                        <h1 class="box-title"><a href=<%= lien + "?but=jauge/jauge-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (objet.getEtat() != ConstanteEtat.getEtatValider()) {%>
                            <a class="btn btn-warning pull-right" href="<%= lien + "?but=" + pageModif + "&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute=jauge/jauge-fiche.jsp&classe=" + classe%>"><button class="btn btn-danger" style="margin-right: 10px">Annuler</button></a>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=jauge/jauge-fiche.jsp&classe=" + classe%> " style="margin-right: 10px">Viser</a>
                            <% }%>

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
                        <% if (objet.getEtat() == ConstanteEtat.getEtatValider()) {%>
                    <li class="<%=map.get("inventaire-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=sinventaire-details">Mouvement Inventaire</a></li>
                        <% }%>
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


