<%--
    Document   : depense-fiche
    Created on : 10 mai 2024, 11:24:32
    Author     : CMCM
--%>

<%@page import="depense.Depense"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    UserEJB u = (user.UserEJB) session.getValue("u");

%>
<%    Depense objet = new Depense();
    objet.setNomTable("DEPENSE");
    PageConsulte pc = new PageConsulte(objet, request, u);
    pc.setTitre("Fiche Depense");
    pc.getBase();
    String id = pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("designation").setLibelle("D&eacute;signation");
    pc.getChampByName("daty").setLibelle("Date");
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/depense/depense-modif.jsp";
    String classe = "depense.Depense";
    String idEncaissement = request.getParameter("idEncaissement");
%>

<div class="content-wrapper">
       <div class="row">
              <div class="col-md-3"></div>
              <div class="col-md-6">
                     <div class="box-fiche">
                            <div class="box">
                                   <div class="box-title with-border">
                                          <% if (idEncaissement == null) {%>
                                          <h1 class="box-title"><a href=<%= lien + "?but=depense/depense-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                                                 <% } else {%>
                                          <h1 class="box-title"><a href=<%= lien + "?but=encaissement/encaissement-fiche.jsp&id=" + idEncaissement%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                                                 <% }%>
                                   </div>
                                   <div class="box-body">
                                          <%
                                              out.println(pc.getHtml());
                                          %>
                                          <br/>
                                          <div class="box-footer">
                                                 <% if (objet.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                                 <a class="btn btn-warning pull-right" href="<%= lien + "?but=" + pageModif + "&id=" + id+ ( idEncaissement==null ? "" : ("&idEncaissement="+idEncaissement) )%>" style="margin-right: 10px">Modifier</a>
                                                 <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute=depense/depense-fiche.jsp&classe=" + classe%>"><button class="btn btn-danger" style="margin-right: 10px">Annuler</button></a>
                                                 <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=depense/depense-fiche.jsp&classe=" + classe%> " style="margin-right: 10px">Viser</a>
                                                 <% }%>
                                          </div>
                                          <br/>

                                   </div>
                            </div>
                     </div>
              </div>
       </div>
</div>


