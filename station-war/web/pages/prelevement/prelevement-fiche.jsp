<%--
    Document   : prelevement-fiche
    Created on : 27 mars 2024, 11:30:32
    Author     : SAFIDY
--%>

<%@page import="prelevement.Prelevement"%>
<%@page import="prelevement.PrelevementLib"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>


<%
    UserEJB u = (user.UserEJB)session.getValue("u");

%>
<%
    String lien = (String) session.getValue("lien");
    PrelevementLib objet = new PrelevementLib();
    objet.setNomTable("PRELEVEMENTLIB");
    PageConsulte pc = new PageConsulte(objet, request, u);
    pc.setTitre("Fiche Prelevement");
    objet=(PrelevementLib)pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idPrelevementAnterieur").setLibelle("Prelevement Anterieur");
    pc.getChampByName("compteur").setLibelle("Compteur");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("heure").setLibelle("Heure");
    pc.getChampByName("idPompiste").setVisible(false);
    pc.getChampByName("idPompe").setVisible(false);
    pc.getChampByName("descriptionMagasin").setVisible(false);
    pc.getChampByName("idRole").setVisible(false);
    pc.getChampByName("nomUser").setLibelle("Pompiste");
    pc.getChampByName("nomMagasin").setLibelle("Pompe");
    pc.getChampByName("designation").setLibelle("D&eacute;signation");
    String pageModif = "station-ejb/src/java/prelevement/prelevement-modif.jsp";
    String pageActuel = "station-ejb/src/java/prelevement/prelevement-fiche.jsp";
    String classe = "prelevement.Prelevement";
    Onglet onglet = new Onglet("page1");
        onglet.setDossier("inc");
        Map<String, String> map = new HashMap<String, String>();
        String tab = request.getParameter("tab");
        if (objet.getEtat() == ConstanteEtat.getEtatValider()) {
        map.put("mvtcaisse-details", "");
        map.put("vente-details", "");
        }

        if (tab == null) {
            tab = "vente-details";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";


%>

<div class="content-wrapper">
    <div class="row">
          <div class="col-md-12" >
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=prelevement/prelevement-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body " style="margin:20px">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                         <% if (objet.getEtat() != ConstanteEtat.getEtatValider()) {%>
                            <a class="btn btn-warning pull-right" href="<%= lien + "?but=" + pageModif + "&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute=prelevement/prelevement-fiche.jsp&classe=" + classe%>"><button class="btn btn-danger" style="margin-right: 10px">Annuler</button></a>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=prelevement/prelevement-fiche.jsp&classe=" + classe%> " style="margin-right: 10px">Viser</a>
                            <% }%>
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
                    <li class="<%=map.get("vente-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=vente-details">Détails Vente</a></li>
                        <% if (objet.getEtat() == ConstanteEtat.getEtatValider()) {%>
                    <li class="<%=map.get("mvtcaisse-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=mvtcaisse-details">Mouvement Caisse</a></li>
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

