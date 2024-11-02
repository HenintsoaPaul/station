<%-- 
    Document   : etatcaisse-choix
    Created on : 3 avr. 2024, 09:21:05
    Author     : 26134
--%>

<%@page import="caisse.DetailsBonCaisseClientReste"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String champReturn = request.getParameter("champReturn");
    DetailsBonCaisseClientReste choix = new DetailsBonCaisseClientReste();
    choix.setNomTable("V_DetailsBonCaisseClientReste ");
    String listeCrt[] = {"id", "idCaisseLib","idPointLib","idClientLib"};
    String listeInt[] = {};
    String libEntete[] = {"id","idClientLib","idCaisse","idCaisseLib","idPoint","idPointLib","debit","credit","reste"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.setTitre("Page choix");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("choix/caisse/detailsboncaissereste-choix.jsp");
    pr.setChampReturn(champReturn);

    pr.getFormu().getChamp("idPointlib").setLibelle("Point");
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id","idClientLib","idCaisse","idCaisseLib","idPoint","idPointLib","debit","credit","reste"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre()%></title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='./../../elements/css.jsp'/>
    </head>
    <body class="skin-blue sidebar-mini">
        <div class="wrapper">
            <section class="content-header">
                <h1><%= pr.getTitre()%></h1>
            </section>
            <section class="content">
                <form action="<%=pr.getApres()%>?champReturn=<%=champReturn%>" method="post" name="fcdetailsliste" id="fcdetailsliste">
                    <% out.println(pr.getFormu().getHtmlEnsemble());%>
                </form>
                <form action="./../apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <%

                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='./../../elements/js.jsp'/>
    </body>
</html>