

<%@page import="caisse.CaisseCpl"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    CaisseCpl t = new CaisseCpl();
    String listeCrt[] = {"id", "val","desce","idTypeCaisseLib" , "idPointLib","idCategorieCaisseLib"};
    String listeInt[] = {};
    String libEntete[] = {"id", "val","desce","idTypeCaisseLib" , "idPointLib","idCategorieCaisseLib"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des caisses");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/caisse/caisse-liste.jsp" );
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("desce").setLibelle("Description");
    pr.getFormu().getChamp("idTypeCaisseLib").setLibelle("Type");
    pr.getFormu().getChamp("idPointLib").setLibelle("Point");
    pr.getFormu().getChamp("idCategorieCaisseLib").setLibelle("Categorie");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=caisse/caisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"ID", "D&eacute;signation", "Description","Type" , "Point","Categorie"};
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



