

<%@page import="faturefournisseur.Fournisseur"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%> 


<%
    String champReturn = request.getParameter("champReturn");
    Fournisseur choix = new Fournisseur();
    String listeCrt[] = {"id", "nom","nif","stat" , "adresse","codePostal"};
    String listeInt[] = {};
    String libEntete[] = {"id", "nom","nif","stat" , "adresse","codePostal"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.setTitre("liste fournisseurs");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("fournisseur/fournisseur-choix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("codePostal").setLibelle("code postal");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
     String libEnteteAffiche[] = {"id", "nom","nif","stat" , "adresse","codePostal"};
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