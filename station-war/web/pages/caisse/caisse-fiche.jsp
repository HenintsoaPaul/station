
<%@page import="caisse.CaisseCpl"%>
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

%>
<%

    CaisseCpl caisse = new CaisseCpl();
    PageConsulte pc = new PageConsulte(caisse, request, u);
    pc.setTitre("Fiche caisse");
    pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("D&eacute;signation");
    pc.getChampByName("desce").setLibelle("Description");
    pc.getChampByName("idTypeCaisseLib").setLibelle("Type");
    pc.getChampByName("idPointLib").setLibelle("Point");
    pc.getChampByName("idCategorieCaisseLib").setLibelle("Categorie");
    pc.getChampByName("idMagasinLib").setLibelle("Magasin");
    pc.getChampByName("IdPoint").setVisible(false);
    pc.getChampByName("IdMagasin").setVisible(false);
    pc.getChampByName("IdTypeCaisse").setVisible(false);
    pc.getChampByName("idCategorieCaisse").setVisible(false);
    pc.getChampByName("etatLib").setVisible(false);
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/caisse/caisse-modif.jsp";
    String classe = "caisse.Caisse";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=caisse/caisse-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if(caisse.getEtat() > 0) { %>
                              <a  class="btn btn-danger pull-right"  href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=annuler&bute=caisse/caisse-fiche.jsp&classe="+classe %>">Annuler</button></a>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=caisse/caisse-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                                 <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <% } %>
                            <% if(caisse.getEtat()== 11) { %>
                                <a  href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&id=" + request.getParameter("id") + "&bute=caisse/caisse-fiche.jsp&classe=" + classe %>"><button class="btn btn-secondary pull-right" style="margin-right: 10px">Annuler Visa</button></a>
                            <% } %>
                        </div>
                        <br/>

                    </div>
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
