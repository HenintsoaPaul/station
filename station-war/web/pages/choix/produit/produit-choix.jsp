<%-- 
    Document   : produit-choix
    Created on : 22 mars 2024, 15:29:55
    Author     : Angela
--%>


<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.Categorie"%>
<%@page import="annexe.ProduitLib"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%> 


<%
    String champReturn = request.getParameter("champReturn");
    ProduitLib choix = new ProduitLib();
    choix.setNomTable("PRODUIT_LIB");
    String listeCrt[] = {"id", "val", "desce", "idCategorieLib", "idTypeProduitLib", "idUniteLib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val", "desce", "idCategorieLib", "idTypeProduitLib", "idUniteLib", "puAchat", "puVente"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);

    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("desce").setLibelle("Description");
    affichage.Champ[] liste = new affichage.Champ[3];
    Categorie cat = new Categorie();
    liste[0] = new Liste("idCategorieLib", cat, "val", "val");
    Unite uni = new Unite();
    liste[1] = new Liste("idUniteLib", uni, "val", "val");
    TypeProduit typp = new TypeProduit();
    liste[2] = new Liste("idTypeProduitLib", typp, "val", "val");
    pr.getFormu().changerEnChamp(liste);

    pr.setTitre("Page choix");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("produit/produit-choix.jsp");
    pr.setChampReturn(champReturn);
    pr.getFormu().getChamp("idCategorieLib").setLibelle("Cat&eacute;gorie");
    pr.getFormu().getChamp("idUniteLib").setLibelle("Unit&eacute;");
    pr.getFormu().getChamp("idTypeProduitLib").setLibelle("Type produit");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"ID", "D&eacute;signation", "Description", "Cat&eacute;gorie", "Type produit", "Unit&eacute;", "Prix d'achat", "Prix de vente"};
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