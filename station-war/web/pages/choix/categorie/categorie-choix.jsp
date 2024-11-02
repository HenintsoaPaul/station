<%-- 
    Document   : caisse-choix
    Created on : 22 mars 2024, 15:29:55
    Author     : BICI
--%>


<%@page import="annexe.CategorieLib"%>
<%@page import="utils.ConstanteStation"%>
<%@page import="annexe.Unite"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%> 


<%
    try{
    String champReturn = request.getParameter("champReturn");
    CategorieLib choix = new CategorieLib();
    choix.setNomTable("CATEGORIELIB");
    String listeCrt[] = {"id", "val", "desce","idTypeProduitlib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val", "desce","idTypeproduit","idTypeProduitLib"};
    int range = 2;
    PageRechercheChoix pr = new PageRechercheChoix(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setTitre("Page choix categorie");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("categorie/categorie-choix.jsp");
    pr.setChampReturn(champReturn);
   
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("desce").setLibelle("Description");
    pr.getFormu().getChamp("idTypeProduitlib").setLibelle("Type Produit");
   

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id", "valeur", "description","idTypeproduit","Type Produit"};
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
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>