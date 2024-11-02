<%--
    Document   : prelevement-choix
    Created on : 27 mars 2024, 14:36:04
    Author     : SAFIDY
--%>


<%@page import="prelevement.Prelevement"%>
<%@page import="pompe.PompisteLib"%>
<%@page import="pompe.Pompe"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%>


<%
    String champReturn = request.getParameter("champReturn");
    Prelevement choix = new Prelevement();
    choix.setNomTable("PRELEVEMENT");
    String listeCrt[] = {"id", "idPrelevementAnterieur", "compteur", "daty", "heure", "idPompiste","idPompe"};
    String listeInt[] = {};
    String libEntete[] = {"id", "idPrelevementAnterieur", "compteur", "daty", "heure", "idPompiste","idPompe"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("idPrelevementAnterieur").setLibelle("Pr&eacute;levement Ant�rieur");
    pr.getFormu().getChamp("compteur").setLibelle("Compteur");
    pr.getFormu().getChamp("daty").setLibelle("Date");
    pr.getFormu().getChamp("heure").setLibelle("Heure");
    affichage.Champ[] liste = new affichage.Champ[2];
    PompisteLib cat = new PompisteLib();
    liste[0] = new Liste("idPompiste", cat, "nomuser", "refuser");
    Pompe uni = new Pompe();
    liste[1] = new Liste("idPompe", uni, "val", "id");
    pr.getFormu().changerEnChamp(liste);

    pr.setTitre("Page choix");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/prelevement/prelevement-choix.jsp" );
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("idPompiste").setLibelle("Pompiste");
    pr.getFormu().getChamp("idPompe").setLibelle("Pompe");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "idPrelevementAnterieur", "compteur", "daty", "heure", "idPompiste","idPompe"};
    pr.getTableau().setLibeEntete(libEnteteAffiche);
%>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= pr.getTitre()%></title>
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <jsp:include page='./../../../elements/css.jsp'/>
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
                <form action="./../../apresChoix.jsp" method="post" name="frmchx" id="frmchx">
                    <input type="hidden" name="champReturn" value="<%=pr.getChampReturn()%>">
                    <%

                        out.println(pr.getTableau().getHtmlWithRadioButton()); %>
                </form>
                <% out.println(pr.getBasPage());%>
            </section>
        </div>
        <jsp:include page='./../../../elements/js.jsp'/>
    </body>
</html>
