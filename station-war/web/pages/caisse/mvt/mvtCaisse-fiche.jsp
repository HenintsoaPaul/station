
<%@page import="caisse.MvtCaisseCpl"%>
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
    MvtCaisseCpl caisse = new MvtCaisseCpl();
    PageConsulte pc = new PageConsulte(caisse, request, u);
    pc.setTitre("Fiche mouvement caisse");
    pc.getBase();
		String iff=request.getParameter("idFF");
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("designation").setLibelle("D&eacute;signation");
    pc.getChampByName("idCaisseLib").setLibelle("Caisse");
    pc.getChampByName("idVenteDetail").setVisible(false);
    pc.getChampByName("idVirement").setVisible(false);
    pc.getChampByName("debit").setLibelle("d&eacute;bit");
    pc.getChampByName("credit").setLibelle("cr&eacute;dit");
    pc.getChampByName("idCaisse").setVisible(false);
    pc.getChampByName("idVente").setVisible(false);
    pc.getChampByName("idOrigine").setLibelle("Origine");
    pc.getChampByName("etatLib").setVisible(false);
    pc.getChampByName("idTiers").setVisible(false);
    String pageActuel = "station-ejb/src/java/caisse/mvt/mvtCaisse-fiche.jsp";
    String lien = (String) session.getValue("lien");
    String classe = "caisse.MvtCaisse";
    Onglet onglet =  new Onglet("page1");
    onglet.setDossier("inc");
    caisse = (MvtCaisseCpl) pc.getBase();

    onglet.setDossier("inc");
    Map<String, String> map = new HashMap<String, String>();
    map.put("ecriture-details", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "ecriture-details";
    }
    map.put(tab, "active");
    tab = "inc/" + tab + ".jsp";

%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <%if(iff!=null){%>
                        <h1 class="box-title"><a href=<%= lien + "?but=facturefournisseur/facturefournisseur-fiche.jsp&id="+iff%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                        <%}else{%>
                        <h1 class="box-title"><a href=<%= lien + "?but=caisse/mvt/mvtCaisse-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                        <%}%>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <%
                                if(caisse.getEtat() == 11 ){
                                %>
                                    <a class="btn btn-primary pull-right" href="<%= (String) session.getValue("lien") + "?but=prevision/prevision-non-regle.jsp&idMvtCaisse=" + request.getParameter("id") %>" style="margin-right: 10px">Attacher prevision</a>
                                <%
                                }
                                if( caisse.getEtat() != 11 ){ %>
                                    <a class="btn btn-warning pull-right" href="<%= (String) session.getValue("lien") + "?but=caisse/mvt/mvtCaisse-modif.jsp&id=" + request.getParameter("id") %>" style="margin-right: 10px">Modifier</a>
                            <%    }
                            %>
                            <% if(caisse.getEtat() > 0 && caisse.getEtat() < 11) { %>
                                <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=caisse/mvt/mvtCaisse-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
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
                    <% if (caisse.getEtat() >= ConstanteEtat.getEtatValider()) {%>
                    <li class="<%=map.get("ecriture-detail")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=ecriture-details">Ecriture</a></li>
                    <% }%>
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
</div>
</div>

