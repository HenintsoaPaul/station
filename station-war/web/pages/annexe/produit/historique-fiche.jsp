<%--
    Document   : historique-fiche
    Created on : 21 mars 2024, 15:38:46
    Author     : Angela
--%>

<%@page import="annexe.HistoriqueProduitLib"%>
<%@page import="annexe.TypeProduit"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
        UserEJB u = (user.UserEJB) session.getValue("u");

        HistoriqueProduitLib objet = new HistoriqueProduitLib();
        objet.setNomTable("Historique_Produit_Lib");
        PageConsulte pc = new PageConsulte(objet, request, u);
        pc.setTitre("Fiche Historique");
        pc.getBase();
        String id = pc.getBase().getTuppleID();
        pc.getChampByName("id").setLibelle("Id");
        pc.getChampByName("puAchat").setVisible(false);
        pc.getChampByName("puVente").setLibelle("Prix de vente");

        String lien = (String) session.getValue("lien");
        String pageModif = "station-ejb/src/java/annexe/type-produit/type-produit-modif.jsp";
        String classe = "annexe.TypeProduit";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=annexe/produit/historique-liste.jsp"%> ><i class="fa fa-arrow-circle-left"> </i> </a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer"></div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<% } catch (Exception e) {
        e.printStackTrace();
    }%>

