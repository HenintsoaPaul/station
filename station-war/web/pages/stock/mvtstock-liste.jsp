<%@page import="stock.MvtStockLib"%>
<%@page import="stock.MvtStock"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="magasin.Magasin"%>
<%@page import="affichage.Liste"%>
<%@page import="stock.TypeMvtStock"%>

<% try{
    MvtStockLib stock = new MvtStockLib();
    if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
        stock.setNomTable(request.getParameter("etat"));
    }else{
        stock.setNomTable("mvtstocklib");
    }

    String listeCrt[] = {"id","designation","idMagasin","idTypeMvStock","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","designation","idMagasinlib","idVentelib","idTransfertlib","idTypeMvStocklib","daty","etatlib"};
    PageRecherche pr = new PageRecherche(stock, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des mouvements de stocks");

    // Changer en Liste
    // Initialisation Liste

    Liste[] dropDowns = new Liste[2];
    dropDowns[0] = new Liste( "idMagasin", new Magasin(), "val" , "id" );
    dropDowns[1] = new Liste( "idTypeMvStock", new TypeMvtStock(), "val" , "id" );

    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/stock/mvtstock-liste.jsp" );
    pr.getFormu().changerEnChamp(dropDowns);
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pr.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pr.getFormu().getChamp("idTypeMvStock").setLibelle("Type mouvement de stock");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=stock/mvtstock-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"Id","D&eacute;signation","Magasin","Vente","Transfert","Type mouvement de stock","Date","Etat"};
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
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("mvtstocklib") == 0) {%>
                        <option value="mvtstocklib" selected>Tous</option>
                        <% } else { %>
                        <option value="mvtstocklib" >Tous</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("mvtstocklibcreer") == 0) {%>
                        <option value="mvtstocklibcreer" selected>Cr&eacute;e</option>
                        <% } else { %>
                        <option value="mvtstocklibcreer">Cr&eacute;e</option>
                        <% } %>
                        <% if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("mvtstocklibvalider") == 0) {%>
                        <option value="mvtstocklibvalider" selected>Vis&eacute;e</option>
                        <% } else { %>
                        <option value="mvtstocklibvalider">Vis&eacute;e</option>
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



