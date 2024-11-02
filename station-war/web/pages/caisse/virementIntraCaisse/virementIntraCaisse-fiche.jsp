<%--
    Document   : page-fiche-simple
    Created on : 9 mars 2023, 10:08:42
    Author     : BICI
--%>

<%@page import="constante.ConstanteEtat"%>
<%@page import="caisse.VirementIntraCaisseCpl"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    VirementIntraCaisseCpl t = new VirementIntraCaisseCpl();
    t.setNomTable("VirementIntraCaisseCpl");
    PageConsulte pc = new PageConsulte(t, request, (user.UserEJB) session.getValue("u"));
    String id=pc.getBase().getTuppleID( );
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idCaisseDepartLib").setLibelle("Caisse depart");
    pc.getChampByName("idCaisseArriveLib").setLibelle("Caisse arrive");
    pc.getChampByName("idCaisseDepart").setVisible(false);
    pc.getChampByName("idCaisseArrive").setVisible(false);
    pc.setTitre("Fiche virement intra caisse ");
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/caisse/virementIntraCaisse/virementIntraCaisse-modif.jsp";
    String classe = "caisse.VirementIntraCaisse";
    t=(VirementIntraCaisseCpl)pc.getBase();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%= lien + "?but=caisse/virementIntraCaisse/virementIntraCaisse-liste.jsp"%>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (t.getEtat()!=ConstanteEtat.getEtatValider()) { %>
                                    <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=caisse/virementIntraCaisse/virementIntraCaisse-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                                    <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                                    <a class="btn btn-danger pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=caisse/virementIntraCaisse/virementIntraCaisse-liste.jsp&classe="+classe+"&nomtable=VirementIntraCaisse" %>">Supprimer</a>
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


