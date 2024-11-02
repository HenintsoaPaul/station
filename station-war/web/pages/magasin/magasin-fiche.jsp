<%@page import="magasin.Magasin"%>
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
    Magasin unite = new Magasin();
    unite.setNomTable("magasinlib");
    PageConsulte pc = new PageConsulte(unite, request, u);
    pc.setTitre("Fiche Magasin");
    pc.getBase();
    Magasin magasin = (Magasin)pc.getBase();
    String id = magasin.getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("val").setLibelle("Libell&eacute;");
    pc.getChampByName("desce").setLibelle("Description");
    pc.getChampByName("idPointlib").setLibelle("Point");
    pc.getChampByName("idTypeMagasinlib").setLibelle("Type magasin");
    pc.getChampByName("idProduitlib").setLibelle("Produit");
    String lienModif = "";
    if(magasin.getIdTypeMagasinlib().compareToIgnoreCase("reservoir") == 0){
        lienModif = "&typemagasin=reservoir";
    }
    pc.getChampByName("idPoint").setVisible(false);
    pc.getChampByName("idTypeMagasin").setVisible(false);
    pc.getChampByName("idProduit").setVisible(false);
    String lien = (String) session.getValue("lien");
    String pageModif = "station-ejb/src/java/magasin/magasin-modif.jsp" +lienModif;
    String classe = "magasin.Magasin";
%>

<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=magasin/magasin-liste.jsp"%> <i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                            <a  class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id+"&acte=delete&bute=magasin/magasin-liste.jsp&classe="+classe %>"><button class="btn btn-danger">Supprimer</button></a>
                        </div>
                        <br/>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

