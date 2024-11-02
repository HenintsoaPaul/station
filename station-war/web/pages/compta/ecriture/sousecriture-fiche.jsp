<%-- 
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="mg.cnaps.compta.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="constante.ConstanteEtat" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    ComptaSousEcritureLib compta = new ComptaSousEcritureLib();
    compta.setNomTable("COMPTA_SOUSECRITURE_LIB");
    PageConsulte pc = new PageConsulte(compta, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID();
    ComptaSousEcritureLib rep=(ComptaSousEcritureLib)pc.getBase();
    pc.getChampByName("idjournal").setVisible(false);
    pc.getChampByName("origine").setVisible(false);
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("datecomptable").setLibelle("Date Comptable");
    pc.getChampByName("id").setLibelle("ID");
    pc.setTitre("Fiche Ecriture");
    String lien = (String) session.getValue("lien");
    String pageModif = "update/update-simple.jsp";
    String classe = "mg.cnaps.compta.ComptaSousEcritureLib";
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=compta/ecriture/sousecriture-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%= pc.getHtml() %>
                        <br/>
                        <div class="box-footer">
                            <% if (rep.getEtat() == ConstanteEtat.getEtatCreer()) {%>
                                <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=valider&bute=compta/ecriture/sousecriture-fiche.jsp&classe="+classe %>">
                                    <button class="btn btn-apj-secondary">Valider</button>
                                </a>
                                <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=compta/ecriture/sousecriture-liste.jsp&classe="+classe %>">
                                    <button class="btn btn-apj-warning">Supprimer</button>
                                </a>
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
} %>


