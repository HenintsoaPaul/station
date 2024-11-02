<%--
    Document   : client
    Created on : 4 avr. 2024, 15:15:17
    Author     : Angela
--%>


<%@page import="client.Client"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%>


<%
    String champReturn = request.getParameter("champReturn");
    Client choix = new Client();
    choix.setNomTable("CLIENT");
    String listeCrt[] = {"id","nom","telephone","mail","adresse","remarque"};
    String listeInt[] = {};
    String libEntete[] = {"id","nom","telephone","mail","adresse","remarque"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.setTitre("Page choix client");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/client/client-choix.jsp" );
    pr.setChampReturn(champReturn);

    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("nom").setLibelle("Nom");
    pr.getFormu().getChamp("telephone").setLibelle("T&eacute;l&eacute;phone");
    pr.getFormu().getChamp("mail").setLibelle("Adresse e-mail");
    pr.getFormu().getChamp("adresse").setLibelle("Adresse");
    pr.getFormu().getChamp("remarque").setLibelle("Remarque");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"ID", "Nom", "Telephone","Adresse e-mail","Adresse","Remarque"};
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




















