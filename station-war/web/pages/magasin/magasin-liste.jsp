<%@page import="magasin.Magasin"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    Magasin magasin = new Magasin();
    magasin.setNomTable("magasinlib");
    String listeCrt[] = {"id", "val","desce","idpointlib","idTypeMagasinlib","idProduitlib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val","desce","idpointlib","idTypeMagasinlib","idProduitlib"};
    PageRecherche pr = new PageRecherche(magasin, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des magasins/r&eacute;servoirs");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/magasin/magasin-liste.jsp" );
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("Libell&eacute;");
    pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");
    pr.getFormu().getChamp("idpointlib").setLibelle("Point");
    pr.getFormu().getChamp("idTypeMagasinlib").setLibelle("Type");
    pr.getFormu().getChamp("idProduitlib").setLibelle("Produit");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=magasin/magasin-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"Id", "Libell&eacute;","D&eacute;scription","Point","Type","Produit"};
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
        %>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



