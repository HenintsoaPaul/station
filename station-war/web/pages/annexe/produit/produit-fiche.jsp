<%--
    Document   : produit-fiche
    Created on : 21 mars 2024, 09:44:57
    Author     : Angela
--%>


<%@page import="annexe.ProduitLib"%>
<%@page import="annexe.Produit"%>
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
    ProduitLib objet = new ProduitLib();
    objet.setNomTable("PRODUIT_LIB");
    PageConsulte pc = new PageConsulte(objet, request, u);
    pc.setTitre("Details Produit");
    objet=(ProduitLib)pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("D&eacute;signation");
    pc.getChampByName("desce").setLibelle("Description");
    pc.getChampByName("idCategorie").setVisible(false);
    pc.getChampByName("idUnite").setVisible(false);
    pc.getChampByName("idTypeProduit").setVisible(false);
    pc.getChampByName("idCategorieLib").setLibelle("Cat&eacute;gorie");
    pc.getChampByName("idCategorieLib").setLien(lien+"?but=annexe/categorie/categorie-fiche.jsp", "id="+objet.getIdCategorie()+"&libelle=");
    pc.getChampByName("idUniteLib").setLibelle("Unit&eacute;");
    pc.getChampByName("idUniteLib").setLien(lien+"?but=annexe/unite/unite-fiche.jsp", "id="+objet.getIdUnite()+"&libelle=");
    pc.getChampByName("idTypeProduitLib").setLibelle("Type produit");
    pc.getChampByName("idTypeProduitLib").setLien(lien+"?but=annexe/type-produit/type-produit-fiche.jsp", "id="+objet.getIdTypeProduit()+"&libelle=");
    pc.getChampByName("puAchat").setVisible(false);
    pc.getChampByName("puVente").setLibelle("Prix de vente");
    pc.getChampByName("puAchatUsd").setLibelle("PU Achat Usd");
    pc.getChampByName("puAchatEuro").setLibelle("PU Achat Euro");
    pc.getChampByName("puAchatAutreDevise").setLibelle("PU Achat Autre Devise");
    pc.getChampByName("puVenteUsd").setLibelle("PU Vente Usd");
    pc.getChampByName("puVenteEuro").setLibelle("PU Vente Euro");
    pc.getChampByName("puVenteAutreDevise").setLibelle("PU Vente Autre Devise");

    String pageModif = "station-ejb/src/java/annexe/produit/produit-modif.jsp";
    String pageActuel = "station-ejb/src/java/annexe/produit/produit-fiche.jsp";
    String classe = "annexe.Produit";
    Onglet onglet =  new Onglet("page1");
    onglet.setDossier("inc");
    Map<String, String> map = new HashMap<String, String>();
    map.put("historique-liste", "");
    String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "historique-liste";
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
                        <h1 class="box-title"><a href=<%= lien + "?but=annexe/produit/produit-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
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
                    <li class="<%=map.get("historique-liste")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=historique-liste">Historiques des prix</a></li>

                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idmere" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>

