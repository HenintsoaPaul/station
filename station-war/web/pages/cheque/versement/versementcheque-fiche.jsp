<%@page import="cheque.VersementCheque"%>
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
    VersementCheque versement = new VersementCheque();
    PageConsulte pc = new PageConsulte(versement, request, u);
    pc.setTitre("Fiche versement cheque");
    versement = (VersementCheque) pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("Id").setLibelle("Id");
    String pageActuel = "station-ejb/src/java/cheque/versement/versementcheque-fiche.jsp";

    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/cheque/versement/versementcheque-modif.jsp";
    String classe = "cheque.VersementCheque";

    Map<String, String> map = new HashMap<String, String>();
    map.put("inc/versementchequedetails-liste", "");

    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inc/versementchequedetails-liste";
    }
    map.put(tab, "active");
    tab = tab + ".jsp";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=cheque/versement/versementcheque-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (versement.getEtat() != ConstanteEtat.getEtatValider()) {%>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=cheque/versement/versementcheque-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                                <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                                <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute=cheque/versement/versementcheque-fiche.jsp&classe=" + classe %>"><button class="btn btn-danger">Annuler</button></a>
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
                    <li class="<%=map.get("inc/versementchequedetails-liste")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/versementchequedetails-liste">versement cheque détails</a></li>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idVersementCheque" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>

