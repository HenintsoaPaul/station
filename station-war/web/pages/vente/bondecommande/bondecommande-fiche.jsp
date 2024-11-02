<%@page import="faturefournisseur.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="vente.BonDeCommande"%>

<%
    UserEJB u = (user.UserEJB)session.getValue("u");
%>
<%
    BonDeCommande f = new BonDeCommande();
    f.setNomTable("BONDECOMMANDE_CLIENT");
    PageConsulte pc = new PageConsulte(f, request, u);
    pc.setTitre("Fiche bon de Commande");
    pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("daty").setLibelle("date");
    pc.getChampByName("remarque").setLibelle("Remarque");
    pc.getChampByName("designation").setLibelle("d&eacute;signation");
    pc.getChampByName("idClient").setLibelle("Client");
    pc.getChampByName("etat").setLibelle("Etat");
      pc.getChampByName("modepaiement").setVisible(false);
    String pageActuel = "station-ejb/src/java/vente/bondecommande/bondecommande-fiche.jsp";

    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/vente/bondecommande/bondecommande-modif.jsp";
    String classe = "vente.BonDeCommande";

    Map<String, String> map = new HashMap<String, String>();
    map.put("../inc/bondecommande-liste-detail", "");

    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "../inc/bondecommande-liste-detail";
    }

    map.put(tab, "active");
    tab = tab + ".jsp";
    f = (BonDeCommande)pc.getBase();
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=bondecommande/bondecommande-fiche.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (f.getEtat() < ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=vente/bondecommande/bondecommande-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                                <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <% } %>
                            <% if (f.getEtat() >= ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=bondelivraison-client/apresLivraisonCommande.jsp&id=" + request.getParameter("id") + "&classe=" + classe%> " style="margin-right: 10px">Livrer</a>
                                <a class="btn btn-warning pull-right" href="<%= (String) session.getValue("lien") + "?but=vente/bondecommande/apresFacturer.jsp&id=" + request.getParameter("id") + "&classe=" + classe%> " style="margin-right: 10px">Facturer</a>
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
                    <li class="<%=map.get("../inc/bondecommande-liste-detail")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=/inc/bondecommande-liste-detail">Détails</a></li>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idbc" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>
