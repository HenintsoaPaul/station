<%--
    Document   : avoirFC-liste
    Created on : 2 ao�t 2024, 15:48:25
    Author     : randr
--%>


<%@page import="avoir.AvoirFCLib"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    AvoirFCLib t = new AvoirFCLib();
    String listeCrt[] = {"id", "idMagasinLib", "idVenteLib", "idMotifLib" , "idCategorieLib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "idMagasinLib", "idVenteLib", "idMotifLib" , "idCategorieLib", "montantHT", "montantTVA", "montantTTC", "montantHTAr", "montantTVAAr", "montantTTCAr"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste avoirFC");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/avoir/avoirFC-liste.jsp" );
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("idMagasinLib").setLibelle("Magasin");
    pr.getFormu().getChamp("idVenteLib").setLibelle("Vente");
    pr.getFormu().getChamp("idCategorieLib").setLibelle("Categorie");
    pr.getFormu().getChamp("idMotifLib").setLibelle("Motif");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=avoir/avoirFC-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"ID", "iMagasin", "Vente", "Motif" , "Categorie", "montant HT", "montant TVA", "montant TTC", "montant HT Ar", "montant TVA Ar", "montant TTC Ar"};
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



