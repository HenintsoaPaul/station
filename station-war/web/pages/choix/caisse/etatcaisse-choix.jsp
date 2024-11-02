<%-- 
    Document   : etatcaisse-choix
    Created on : 3 avr. 2024, 09:21:05
    Author     : 26134
--%>

<%@page import="caisse.PageRechercheChoixEtatCaisse"%>
<%@page import="caisse.EtatCaisse"%>
<%@page import="caisse.CaisseCpl"%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.Categorie"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String champReturn = request.getParameter("champReturn");
    EtatCaisse choix = new EtatCaisse();
    String listeCrt[] = {"idCaisse","idCaisselib","idPointlib","idTypeCaisselib","dateDernierReport","montantDernierReport","credit","debit"};
    String listeInt[] = {"dateDernierReport"};
    String libEntete[] = {"idCaisse","idCaisselib","idPointlib","idTypeCaisselib","dateDernierReport","montantDernierReport","credit","debit"};
    int range = 2;
    PageRechercheChoixEtatCaisse pr = new PageRechercheChoixEtatCaisse(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.setTitre("Page choix");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("choix/caisse/etatcaisse-choix.jsp");
    pr.setChampReturn(champReturn);
   
    pr.getFormu().getChamp("idCaisselib").setLibelle("Caisse");
    pr.getFormu().getChamp("idPointlib").setLibelle("Point");
    pr.getFormu().getChamp("idTypeCaisselib").setLibelle("Type Caisse");
    pr.getFormu().getChamp("montantDernierReport").setLibelle("Montant Dernier Report");
    pr.getFormu().getChamp("dateDernierReport1").setLibelle("Date min");
    pr.getFormu().getChamp("dateDernierReport1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("dateDernierReport2").setLibelle("Date max");
    pr.getFormu().getChamp("dateDernierReport2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id","Caisse","Point","Type Caisse","date Dernier Report","montant Dernier Report","credit","debit"};
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