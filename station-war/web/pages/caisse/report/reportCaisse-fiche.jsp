
<%@page import="caisse.ReportCaisseCpl"%>
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
    ReportCaisseCpl caisse = new ReportCaisseCpl();
    PageConsulte pc = new PageConsulte(caisse, request, u);
    pc.setTitre("Fiche report caisse");
    pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("idCaisseLib").setLibelle("Caisse");
    pc.getChampByName("IdCaisse").setVisible(false);
    pc.getChampByName("MontantTheorique").setVisible(false);
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/caisse/report/reportCaisse-modif.jsp";
    String classe = "caisse.ReportCaisse";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=caisse/report/reportCaisse-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=caisse/report/reportCaisse-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>

                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

