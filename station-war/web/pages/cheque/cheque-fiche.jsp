<%--
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="utils.ConstanteEtatStation"%>
<%@page import="cheque.ChequeCpl"%>
<%@page import="constante.ConstanteEtat"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    ChequeCpl t = new ChequeCpl();
    t.setNomTable("ChequeCpl");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID( );
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idCaisseLib").setLibelle("Caisse");
    pc.getChampByName("idCaisse").setVisible(false);
    pc.setTitre("Fiche cheque ");
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/cheque/cheque-modif.jsp";
    String classe = "cheque.Cheque";
    t=(ChequeCpl)pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien + "?but=cheque/cheque-liste.jsp"%>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (t.getEtat()!=ConstanteEtat.getEtatValider()&& t.getEtat()!=ConstanteEtatStation.getEtatTouche()) { %>
                                    <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=cheque/cheque-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                                    <a class="btn btn-warning pull-left"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                                    <a href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=#&classe="+classe+"&nomtable=Cheque" %>"><button class="btn btn-danger">Supprimer</button></a>
                            <% }  else if(t.getEtat()==ConstanteEtat.getEtatValider()){ %>
                                    <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=cheque/apresCheque.jsp&acte=toucherCheque&id=" + request.getParameter("id") + "&bute=cheque/cheque-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">toucher</a>
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


