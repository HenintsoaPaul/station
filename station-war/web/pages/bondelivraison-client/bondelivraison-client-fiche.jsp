<%--
    Document   : bondelivraison-client-fiche
    Created on : 29 juil. 2024, 17:39:44
    Author     : drana
--%>

<%@page import="java.util.*"%>
<%@page import="annexe.Unite"%>
<%@page import="magasin.Magasin"%>
<%@page import="user.*"%>
<%@page import="vente.*"%>
<%@page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    UserEJB u = (user.UserEJB)session.getValue("u");

%>
<%
    As_BondeLivraisonClient_Cpl f = new As_BondeLivraisonClient_Cpl();
    f.setNomTable("AS_BONDELIVRAISON_CLIENT_CPL");
    PageConsulte pc = new PageConsulte(f, request, u);
    pc.setTitre("Fiche bon de Livraison Client");
    As_BondeLivraisonClient_Cpl blf=(As_BondeLivraisonClient_Cpl)pc.getBase();
    String id=blf.getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("daty").setLibelle("date");
    pc.getChampByName("remarque").setLibelle("Remarque");
    pc.getChampByName("designation").setLibelle("Designation");
    pc.getChampByName("idVente").setLibelle("ID Vente");
    pc.getChampByName("idBC").setLibelle("ID Bon de Commande");
    pc.getChampByName( "station-ejb/src/java/magasin" ).setLibelle("Magasin");
    pc.getChampByName("etat").setAutre("readonly");
     pc.getChampByName("idVente").setAutre("readonly");
     pc.getChampByName("idBC").setAutre("readonly");
     pc.getChampByName("idMagasin").setAutre("readonly");
     pc.getChampByName("idMagasin").setVisible(false);
    String pageActuel = "bondelivraison-client/bondelivraison-client-fiche.jsp";

    String lien = (String) session.getValue("lien");
    String pageModif = "bondelivraison-client/bondelivraison-client-modif.jsp";
    String classe = "vente.As_BondeLivraisonClient";

    Map<String, String> map = new HashMap<String, String>();
    map.put("inc/bondelivraisonclient-liste-detail", "");

    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inc/bondelivraisonclient-liste-detail";
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
                        <h1 class="box-title"><a href=<%= lien + "?but=bondelivraison-client/bondelivraison-client-fiche.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=bondelivraison-client/bondelivraison-client-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Valider</a>
                            <%if(blf.getIdvente()==null||blf.getIdvente().compareTo("")==0)
                            {%>
                            <a class="btn btn-info pull-right" href="<%= (String) session.getValue("lien") + "?but=#&acte=valider&id=" + request.getParameter("id") + "&bute=bondelivraison-client/bondelivraison-client-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Facturer</a>
                            <%}%>
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>

                            <a class="btn btn-secondary pull-right"  href="<%=(String) session.getValue("lien") + "?but=bondelivraison-client/apresMvtStock.jsp&id=" + id%>"  style="margin-right: 10px;margin-top: 5px;">Generer mouvement de stock</a>
                            <a class="btn btn-info pull-right"  href="${pageContext.request.contextPath}/ExportPDF?action=fiche_bl&id=<%=request.getParameter("id")%>" style="margin: 5px 10px 0 0">Imprimer</a>

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
                    <li class="<%=map.get("inc/bondelivraisonclient-liste-detail")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/bondelivraisonclient-liste-detail">D�tails</a></li>
                    <li class="<%=map.get("inc/mouvementstock-liste-detail")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=inc/mouvementstock-liste-detail">Mouvement de Stock</a></li>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="numbl" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>
</div>
