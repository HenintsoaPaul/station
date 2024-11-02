<%@page import="inventaire.InventaireLib"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="affichage.Liste"%>
<%@page import="magasin.Magasin"%>

<% try{
    InventaireLib inventaire = new InventaireLib();
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        inventaire.setNomTable(request.getParameter("etat"));
    }else{
        inventaire.setNomTable("INVENTAIRELIB");
    }

    String listeCrt[] = {"id","designation","idMagasin","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","designation","idMagasinlib","daty","remarque","etatlib"};
    PageRecherche pr = new PageRecherche(inventaire, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
     Liste[] listes = new Liste[1];
    listes[0] = new Liste("idMagasin", new Magasin(), "val", "id");
    pr.setTitre("Liste des inventaires");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/inventaire/inventaire-liste.jsp" );
    pr.getFormu().changerEnChamp(listes);
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=inventaire/inventaire-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"Id","D&eacute;signation","Magasin","Date","Remarque","Etat"};
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
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat :
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()" >
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("INVENTAIRELIB") == 0) {%>
                        <option value="INVENTAIRELIB" selected>Tous</option>
                        <% } else { %>
                        <option value="INVENTAIRELIB" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("INVENTAIRELIB_CREE") == 0) {%>
                        <option value="INVENTAIRELIB_CREE" selected>Cr&eacute;e</option>
                        <% } else { %>
                        <option value="INVENTAIRELIB_CREE">Cr&eacute;e</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("INVENTAIRELIB_VALIDEE") == 0) {%>
                        <option value="INVENTAIRELIB_VALIDEE" selected>Vis&eacute;e</option>
                        <% } else { %>
                        <option value="INVENTAIRELIB_VALIDEE">Vis&eacute;e</option>
                        <% } %>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
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



