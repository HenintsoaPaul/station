<%-- 
    Document   : produit-choix
    Created on : 22 mars 2024, 15:29:55
    Author     : Angela
--%>


<%@page import="affichage.PageInsertPopup"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsert"%>
<%@page import="annexe.Produit"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.Categorie"%>
<%@page import="annexe.ProduitLib"%>
<%@page import="affichage.PageRechercheChoix"%>
<%@page import="affichage.Liste"%> 


<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String mapping = "annexe.Produit",
         nomtable = "Produit",
         apres = "popup/apresPopup.jsp",
         titre = "Insertion Produit";

    Produit objet = new Produit();
    objet.setNomTable("Produit");
    PageInsertPopup pi = new PageInsertPopup(objet, request, u);
    affichage.Champ[] liste = new affichage.Champ[1];
    Unite uni = new Unite();
    liste[0] = new Liste("idUnite", uni, "VAL", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("idTypeProduit").setLibelle("Type produit");
    pi.getFormu().getChamp("idTypeProduit").setAutre("readonly");
    pi.getFormu().getChamp("idCategorie").setPageAppel("./../../choix/categorie/categorie-choix.jsp", "idCategorie;idCategorielibelle;idTypeProduit");
    pi.getFormu().getChamp("idCategorie").setLibelle("Categorie");
    pi.getFormu().getChamp("idUnite").setLibelle("Unite");
    pi.getFormu().getChamp("puAchat").setVisible(false);
    pi.getFormu().getChamp("puVente").setLibelle("Prix de vente");
    pi.preparerDataFormu();
%>
<html>
       <head>
              <meta charset="UTF-8">
              <title><%= pi.getTitre()%></title>
              <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
              <jsp:include page='./../../elements/css.jsp'/>
       </head>
       <body class="skin-blue sidebar-mini">
              <div class="wrapper">
                     <h1> <%=titre%></h1>
                     <form action="./../../apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">

                            <%
                                pi.getFormu().makeHtmlInsertTabIndex();
                                out.println(pi.getFormu().getHtmlInsert());
                                out.println(pi.getHtmlAddOnPopup());%>
                            %>
                            <input name="acte" type="hidden" id="nature" value="insert">
                            <input name="bute" type="hidden" id="bute" value="<%=apres%>">
                            <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
                            <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
                     </form>
              </div>
              <jsp:include page='./../../elements/js.jsp'/>
       </body>
</html>