<%--
    Document   : produit-recherche
    Created on : 26 janv. 2024, 10:25:56
    Author     : Angela
--%>




<%@page import="annexe.ProduitLib"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.Categorie"%>
<%@page import="annexe.Produit"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>

<% try{
    ProduitLib t = new ProduitLib();
    t.setNomTable("PRODUIT_LIB");
    String listeCrt[] = {"id", "val","desce","idCategorieLib","idTypeProduitLib","idUniteLib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val", "desce","idCategorieLib","idTypeProduitLib","idUniteLib","puVente"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des produits ");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/annexe/produit/produit-liste.jsp" );
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("desce").setLibelle("Description");
    affichage.Champ[] liste = new affichage.Champ[3];
    Categorie cat= new Categorie();
    liste[0] = new Liste("idCategorieLib", cat, "val", "val");
    Unite uni= new Unite();
    liste[1] = new Liste("idUniteLib", uni, "val", "val");
    TypeProduit typp= new TypeProduit();
    liste[2] = new Liste("idTypeProduitLib", typp,"val", "val");
    pr.getFormu().changerEnChamp(liste);
    pr.getFormu().getChamp("idCategorieLib").setLibelle("Cat&eacute;gorie");
    pr.getFormu().getChamp("idUniteLib").setLibelle("Unit&eacute;");
    pr.getFormu().getChamp("idTypeProduitLib").setLibelle("Type produit");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=annexe/produit/produit-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"ID", "D&eacute;signation","Description","Cat&eacute;gorie","Type produit","Unit&eacute;","Prix de vente"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



