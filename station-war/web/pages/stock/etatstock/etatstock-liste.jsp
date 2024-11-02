<%--
    Document   : etatcaisse-liste
    Created on : 2 avr. 2024, 10:11:22
    Author     : 26134
--%>


<%@page import="utils.ConstanteStation"%>
<%@page import="stock.PageRechercheEtatStock"%>
<%@page import="stock.EtatStock"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="magasin.Magasin"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Unite"%>
<%@page import="affichage.Liste"%>

<% try{
    EtatStock t = new EtatStock();
    t.setNomTable("V_ETATSTOCK");
    String listeCrt[] = {"id","idProduitLib","idTypeProduit","idMagasin","dateDernierInventaire","quantite","entree","sortie","reste","idUnite","puVente"};
    String listeInt[] = {"dateDernierInventaire","puVente"};
    String libEntete[] = {"id","idProduitLib","idTypeProduitLib","idMagasinLib","dateDernierInventaire","puVente","quantite","entree","sortie","reste","idUniteLib"};
    PageRechercheEtatStock pr = new PageRechercheEtatStock(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    // pr.setAWhere("AND IDPOINT='"+ConstanteStation.getFichierCentre()+"'");
    pr.setTitre("Etat de Stock");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/stock/etatstock/etatstock-liste.jsp" );


    // Initialisation Liste
    Liste[] dropDowns = new Liste[3];
    dropDowns[0] = new Liste("idMagasin", new Magasin(), "val", "id");
    dropDowns[1] = new Liste("idTypeProduit", new TypeProduit(), "val", "id");
    dropDowns[2] = new Liste("idUnite", new Unite(), "desce", "id");

    pr.getFormu().changerEnChamp(dropDowns);
    pr.getFormu().getChamp("idProduitLib").setLibelle("Produit");
    pr.getFormu().getChamp("idTypeProduit").setLibelle("Type Produit");
    pr.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pr.getFormu().getChamp("idUnite").setLibelle("Unite");
    pr.getFormu().getChamp("puVente1").setLibelle("Prix de vente minimum");
    pr.getFormu().getChamp("puVente2").setLibelle("Prix de vente maximum");
    pr.getFormu().getChamp("dateDernierInventaire1").setLibelle("Date min");
    pr.getFormu().getChamp("dateDernierInventaire1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("dateDernierInventaire2").setLibelle("Date max");
    pr.getFormu().getChamp("dateDernierInventaire2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
/*    String lienTableau[] = {pr.getLien() + "?but=fiche/template-fiche-simple.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);*/
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"id","Produit","Type Produit","Magasin","date Dernier Inventaire","puVente","quantite","entree","sortie","reste","Unite"};
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



