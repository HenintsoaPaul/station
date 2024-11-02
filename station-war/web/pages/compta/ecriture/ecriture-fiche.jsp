
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="mg.cnaps.compta.ComptaEcriture" %>

<%
    UserEJB u = (user.UserEJB)session.getValue("u");
    
%>
<%
    try{
    ComptaEcriture f = new ComptaEcriture();
    f.setNomTable("compta_ecriture");
    PageConsulte pc = new PageConsulte(f, request, u);
    pc.setTitre("D&eacute;tail Compta Ecriture");
    f=(ComptaEcriture)pc.getBase();
    request.setAttribute("ComptaEcriture", f);
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("Id").setLibelle("Id");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("dateComptable").setLibelle("Date Comptable");
   pc.getChampByName("designation").setLibelle("D&eacute;signation");
    pc.getChampByName("dateComptable").setLibelle("Date Comptable");

 
	pc.getChampByName("horsExercice").setVisible(false);
    pc.getChampByName("od").setVisible(false);
    pc.getChampByName("origine").setVisible(false);
    pc.getChampByName("credit").setVisible(false);
	pc.getChampByName("debit").setVisible(false);
    pc.getChampByName("idUser").setVisible(false);
    pc.getChampByName("periode").setVisible(false);
    pc.getChampByName("trimestre").setVisible(false);
    pc.getChampByName("periode").setVisible(false);
    pc.getChampByName("annee").setVisible(false);
    pc.getChampByName("idobjet").setVisible(false);
    
    
    String pageActuel = "compta/ecriture/ecriture-fiche.jsp";

    String lien = (String) session.getValue("lien");
    String pageModif = "compta/ecriture/ecriture-modif.jsp";
    String classe = "mg.cnaps.compta.ComptaEcriture";
    
    Map<String, String> map = new HashMap<String, String>();

    map.put("inc/sous-ecriture-detail", "");
    String tab = request.getParameter("tab");
    if (tab == null) {
        tab = "inc/sous-ecriture-detail";
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
                        <h1 class="box-title"><a href=<%= lien + "?but=compta/ecriture/ecriture-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (f.getEtat() < 11) { %>
                            <a class="btn btn-success pull-right" href="<%= (String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute=facturefournisseur/facturefournisseur-fiche.jsp&classe=" + classe %> " style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <% }
                            %>

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
                    <li class="<%=map.get("inc/sous-ecriture-detail")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>?&tab=inc/sous-ecriture-detail">Détails</a></li>


                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab %>" >
                        <jsp:param name="idFactureFournisseur" value="<%= id %>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>                    
</div>

<% } catch(Exception e) { 
    e.printStackTrace();
    throw e;
} %>