<%@page import="stock.MvtStockLib"%>
<%@page import="stock.MvtStock"%>
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
    MvtStockLib unite = new MvtStockLib();
    PageConsulte pc = new PageConsulte(unite, request, u);
    pc.setTitre("Fiche mouvement de stock");
    pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("Id").setLibelle("Id");
    pc.getChampByName("designation").setLibelle("D&eacute;signation");
    pc.getChampByName("idMagasinlib").setLibelle("Magasin");
    pc.getChampByName("idVentelib").setLibelle("Vente");
    pc.getChampByName("idTransfertlib").setLibelle("Transfert");
    pc.getChampByName("idTypeMvStocklib").setLibelle("Type mouvement de stock");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("etat").setLibelle("Etat");

    pc.getChampByName("idMagasin").setVisible(false);
    pc.getChampByName("idVente").setVisible(false);
    pc.getChampByName("idTransfert").setVisible(false);
    pc.getChampByName("idTypeMvStock").setVisible(false);
    pc.getChampByName("etatLib").setVisible(false);
    String pageActuel = "station-ejb/src/java/stock/mvtstock-fiche.jsp";

    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/stock/mvtstock-modif.jsp";
    String classe = "stock.MvtStock";

    Map<String, String> map = new HashMap<String, String>();
    map.put("mvtfille-liste", "");

    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "mvtfille-liste";
    }
    map.put(tab, "active");
    tab = tab + ".jsp";
%>

<div class="content-wrapper">
    <div class="row">
              <div class="col-md-12" >
              <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=stock/mvtstock-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                      <div class="box-body " style="margin:20px">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a  class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=annexe/unite/unite-liste.jsp&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                              <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=stock/mvtstock-fiche.jsp&classe=" + classe%> " style="margin-right: 10px">Viser</a>
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
                    <li class="<%=map.get("mvtfille-liste")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=mvtfille-liste">Mouvement détails</a></li>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idmvtstock" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>

