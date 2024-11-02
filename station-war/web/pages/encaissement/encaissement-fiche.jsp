<%--
    Document   : encaissement-fiche
    Created on : 3 avr. 2024, 16:22:00
    Author     : Angela
--%>

<%@page import="encaissement.EncaissementCpl"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="constante.ConstanteEtat" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
    try {
        //Information sur les navigations via la page
        String lien = (String) session.getValue("lien");
        String pageModif = "station-ejb/src/java/encaissement/encaissement-modif.jsp";
        String classe = "encaissement.Encaissement";
        String pageActuel = "station-ejb/src/java/encaissement/encaissement-fiche.jsp";

        //Information sur la fiche
        EncaissementCpl objet = new EncaissementCpl();
        PageConsulte pc = new PageConsulte(objet, request, (user.UserEJB) session.getValue("u"));
        objet = (EncaissementCpl) pc.getBase();
        String id = request.getParameter("id");
        pc.getChampByName("id").setLibelle("Id");
        pc.getChampByName("designation").setLibelle("D&eacute;signation");
        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("etat").setVisible(false);
        pc.getChampByName("idCaisse").setVisible(false);
        pc.getChampByName("idPoint").setVisible(false);
        pc.getChampByName("idCaisselib").setVisible(false);
        pc.getChampByName("idOrigine").setVisible(false);
        pc.getChampByName("etatLib").setLibelle("Etat");
        pc.getChampByName("idTypeEncaissement").setVisible(false);
        pc.setTitre("Fiche encaissement");
        Onglet onglet = new Onglet("page1");
        onglet.setDossier("inc");
        Map<String, String> map = new HashMap<String, String>();
        map.put("encaissement-details", "");
        map.put("precision-details", "");
        map.put("prelevement-liste", "");
        map.put("venteLubrifiant-liste", "");
        map.put("depenseEncaissement-liste", "");
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "encaissement-details";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
        objet=(EncaissementCpl)pc.getBase();

%>
<div class="content-wrapper">
       <div class="row">

        <div class="col-md-12" >
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <% if (objet.getIdOrigine().contains("VNT")) {%>
                                <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=vente/vente-fiche.jsp&id=<%=objet.getIdOrigine()%>"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                        <% }else{%>
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=encaissement/encaissement-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                        <% }%>
                    </div>
                    <div class="box-body " style="margin:20px">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (objet.getEtat() != ConstanteEtat.getEtatValider()) {%>
                            <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute=encaissement/encaissement-fiche.jsp&classe=" + classe%>"><button class="btn btn-danger" style="margin-right: 10px">Annuler</button></a>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=encaissement/encaissement-fiche.jsp&classe=" + classe%> " style="margin-right: 10px">Viser</a>
                           <% }%>
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
                    <li class="<%=map.get("encaissement-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=encaissement-details">Details</a></li>
                <!--    <li class="<%=map.get("precision-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=precision-details">Precisions</a></li>
                    <li class="<%=map.get("prelevement-liste")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=prelevement-liste">Prelevements</a></li>
                    <li class="<%=map.get("venteLubrifiant-liste")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=venteLubrifiant-liste">Ventes Lubrifiant</a></li>
                    <li class="<%=map.get("depenseEncaissement-liste")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=depenseEncaissement-liste">Depenses</a></li>
                -->
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab%>" >
                        <jsp:param name="idmere" value="<%= id%>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>


<%
    } catch (Exception e) {
        e.printStackTrace();
    }%>
