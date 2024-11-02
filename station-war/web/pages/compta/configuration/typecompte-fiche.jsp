<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.TypeCompte"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    TypeCompte t = new TypeCompte();
    t.setNomTable("compta_type_compte");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("Nom");
    pc.getChampByName("desce").setLibelle("Description");
    pc.setTitre("Fiche d'un type de compte");
    String lien = (String) session.getValue("lien");
    String pageModif = "compta/configuration/typecompte-modif.jsp";
    String classe = "mg.cnaps.compta.TypeCompte";
    String pageListe = "compta/configuration/typecompte-liste.jsp";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title">
                            <a href=<%= lien + "?but=compta/configuration/typecompte-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a>
                            <%=pc.getTitre()%>
                        </h1>
                    </div>
                    <div class="box-body">
                        <%= pc.getHtml() %>
                        <br />
                    </div>
                     <div class="box-footer">
                            <a  href="<%=(String) session.getValue("lien") + "?but=compta/configuration/typecompte-modif.jsp&id=" + request.getParameter("id")%>" class="btn btn-warning">Modifier</a>
                        </div>
                    <br/>
                </div>
            </div>
        </div>
    </div>

</div>

<%
} catch (Exception e) {
    e.printStackTrace();
} %>



