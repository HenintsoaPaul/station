<%--
    Document   : venteLubrifiantLubrifiant-fiche
    Created on : 8 mai 2024, 12:30:27
    Author     : CMCM
--%>

<%@page import="venteLubrifiant.VenteLubrifiantLib"%>
<%@ page import="constante.ConstanteEtat" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
    try {
        //Information sur les navigations via la page
        String lien = (String) session.getValue("lien");
        String pageModif = "station-ejb/src/java/venteLubrifiant/venteLubrifiant-modif.jsp";
        String classe = "venteLubrifiant.VenteLubrifiant";
        String pageActuel = "station-ejb/src/java/venteLubrifiant/venteLubrifiant-fiche.jsp";

        //Information sur la fiche
        VenteLubrifiantLib dp = new VenteLubrifiantLib();
        PageConsulte pc = new PageConsulte(dp, request, (user.UserEJB) session.getValue("u"));
        dp = (VenteLubrifiantLib) pc.getBase();
        String id = request.getParameter("id");
        pc.getChampByName("id").setLibelle("Id");
        pc.getChampByName("remarque").setLibelle("Remarque");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("etat").setLibelle("Etat");
        pc.getChampByName("idMagasin").setVisible(false);
        pc.getChampByName("idProduitLib").setLibelle("Produit");
        pc.getChampByName("etatlib").setVisible(false);
        pc.getChampByName("idMagasinLib").setLibelle("Magasin");

        pc.setTitre("Fiche venteLubrifiant");


%>
<div class="content-wrapper">
       <div class="row">
              <div class="col-md-3"></div>
              <div class="col-md-6">
                     <div class="box-fiche">
                            <div class="box">
                                   <div class="box-title with-border">
                                          <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=encaissement/encaissement-fiche.jsp&id=<%=dp.getIdEncaissement()%>&tab=venteLubrifiant-liste"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                                   </div>
                                   <div class="box-body">
                                          <%
                                              out.println(pc.getHtml());
                                          %>
                                          <br/>
                                          <div class="box-footer">
                                                 <% if (dp.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                                 <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute=venteLubrifiant/venteLubrifiant-fiche.jsp&classe=" + classe%>"><button class="btn btn-danger" style="margin-right: 10px">Annuler</button></a>
                                                 <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=venteLubrifiant/venteLubrifiant-fiche.jsp&classe=" + classe%> " style="margin-right: 10px">Viser</a>
                                                 <% }%>
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
    }%>
