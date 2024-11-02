<%@page import="magasin.TypeMagasin"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    TypeMagasin magasin = new TypeMagasin();
    magasin.setNomTable("typemagasin");
    String listeCrt[] = {"id", "val","desce"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val","desce"};
    PageRecherche pr = new PageRecherche(magasin, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des types de magasins");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/magasin/typemagasin-liste.jsp" );
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("Libell&eacute;");
    pr.getFormu().getChamp("desce").setLibelle("D&eacute;scription");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=magasin/typemagasin-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"Id", "Libell&eacute;","D&eacute;scription"};
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



