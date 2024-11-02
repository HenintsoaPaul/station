<%-- 
    Document   : etatstock-lubrifiant-choix.jsp
    Created on : 2 mai 2024, 13:01:26
    Author     : CMCM
--%>

<%@page import="utils.ConstanteStation"%>
<%@page import="stock.PageRechercheChoixEtatStock"%>
<%@page import="stock.EtatStock"%>
<%@page import="affichage.Liste"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%
    String champReturn = request.getParameter("champReturn");
    EtatStock choix = new EtatStock();
    String listeCrt[] = {"id","idProduitLib","idTypeProduitLib","idMagasinLib","dateDernierInventaire","quantite","entree","sortie","reste","idUniteLib"};
    String listeInt[] = {"dateDernierInventaire"};
    String libEntete[] = {"id","idProduitLib","idTypeProduitLib","idMagasinLib","dateDernierInventaire","puVente","quantite","entree","sortie","reste","idUniteLib"};
    int range = 2;
    PageRechercheChoixEtatStock pr = new PageRechercheChoixEtatStock(choix, request, listeCrt, listeInt, range, libEntete, libEntete.length);
    pr.setAWhere("AND IDTYPEMAGASIN ='"+ConstanteStation.idTypeMagasinIlot+"'AND IDPOINT='"+ConstanteStation.getFichierCentre()+"'");
    pr.setTitre("Page choix");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("choix/stock/etatstock-lubrifiant-choix.jsp");
    pr.setChampReturn(champReturn);
   
    pr.getFormu().getChamp("idProduitLib").setLibelle("Produit");
    pr.getFormu().getChamp("idTypeProduitLib").setLibelle("Type Produit");
    pr.getFormu().getChamp("idMagasinLib").setLibelle("Magasin");
    pr.getFormu().getChamp("idUniteLib").setLibelle("Unite");
    pr.getFormu().getChamp("dateDernierInventaire1").setLibelle("Date min");
    pr.getFormu().getChamp("dateDernierInventaire1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("dateDernierInventaire2").setLibelle("Date max");
    pr.getFormu().getChamp("dateDernierInventaire2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    String libEnteteAffiche[] = {"id","Produit","Type Produit","Magasin","date Dernier Inventaire","Prix","quantite","entree","sortie","reste","Unite"};
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