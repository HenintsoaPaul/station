<%--
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="caisse.PaiementBon"%>
<%@page import="constante.ConstanteEtat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    PaiementBon t = new PaiementBon();
    t.setNomTable("PaiementBon");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID( );
    pc.getChampByName("id").setLibelle("Id");
    pc.setTitre("Fiche Paiement Bon ");
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/caisse/bon/paiementbon-modif.jsp";
    String classe = "caisse.PaiementBon";
    t=(PaiementBon)pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien + "?but=caisse/bon/paiementbon-liste.jsp"%>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (t.getEtat()!=ConstanteEtat.getEtatValider()) { %>
                                    <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=caisse/bon/paiementbon-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                                    <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                                    <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=#&classe="+classe+"&nomtable=VirementIntraCaisse" %>"><button class="btn btn-danger">Supprimer</button></a>
                         <%    }  %>

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


