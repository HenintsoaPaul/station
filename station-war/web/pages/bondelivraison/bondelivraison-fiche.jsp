<%--
    Document   : encaissement-fiche
    Created on : 3 avr. 2024, 16:22:00
    Author     : Angela
--%>

<%@page import="faturefournisseur.As_BonDeLivraison_Lib"%>
<%@page import="faturefournisseur.As_BonDeLivraison"%>
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
        String pageModif = "bondelivraison/bondelivraison-modif.jsp";
        String classe = "faturefournisseur.As_BonDeLivraison";
        String pageActuel = "bondelivraison/bondelivraison-fiche.jsp";

        //Information sur la fiche
        As_BonDeLivraison_Lib objet = new As_BonDeLivraison_Lib();
        PageConsulte pc = new PageConsulte(objet, request, (user.UserEJB) session.getValue("u"));
        objet = (As_BonDeLivraison_Lib) pc.getBase();
        String id = request.getParameter("id");
        pc.getChampByName("id").setLibelle("Id");
        pc.getChampByName("etatlib").setLibelle("Etat");
        pc.getChampByName("etat").setVisible(false);
        pc.getChampByName("magasinlib").setLibelle("Magasin");
        pc.getChampByName( "station-ejb/src/java/magasin" ).setVisible(false);
        pc.getChampByName("idFournisseur").setVisible(false);
        pc.getChampByName("idFournisseurLib").setLibelle("Fournisseur");
        pc.getChampByName("idbc").setLien(lien+"?but=bondecommande/bondecommande-fiche.jsp", "id="+objet.getIdbc()+"&libelle=");
        pc.getChampByName("idbc").setLibelle("Bon de commande");


        pc.setTitre("Details bon de livraison");
        Onglet onglet = new Onglet("page1");
        onglet.setDossier("inc");
        Map<String, String> map = new HashMap<String, String>();
        map.put("bondelivraison-details", "");
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "bondelivraison-details";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";

        String genererMouvement = "bondelivraison/apresMvtStock.jsp";


%>
<div class="content-wrapper">
       <div class="row">

        <div class="col-md-12" >
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=bondelivraison/bondelivraison-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    </div>
                    <div class="box-body " style="margin:20px">
                        <%
                            out.println(pc.getHtml());
                        %>
                        <br/>
                        <div class="box-footer">
                            <% if (objet.getEtat() < ConstanteEtat.getEtatValider()) {%>
                            <a class="pull-right" href="<%= lien + "?but=apresTarif.jsp&id=" + id + "&acte=annuler&bute="+pageActuel+"&classe=" + classe%>"><button class="btn btn-danger" style="margin-right: 10px">Annuler</button></a>
                            <a class="btn btn-success pull-right" href="<%= lien + "?but=apresTarif.jsp&acte=valider&id=" + request.getParameter("id") + "&bute="+pageActuel+"&classe=" + classe%> " style="margin-right: 10px">Viser</a>
                            <a class="btn btn-warning pull-right"  href="<%= lien + "?but="+ pageModif +"&id=" + id%>" style="margin-right: 10px">Modifier</a>
                           <% } else { %>

                               <a href="<%=(String) session.getValue("lien")%>?but=<%= genererMouvement+"&id="+request.getParameter("id") %>">

                           <% }%>
                            Generer Entree de Stock
                           </a>
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
                    <li class="<%=map.get("bondelivraison-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=bondelivraison-details">Details</a></li>
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
