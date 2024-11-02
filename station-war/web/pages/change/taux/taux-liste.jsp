<%@page import="change.TauxDeChange"%>
<%@page import="caisse.Devise"%>
<%@page import="affichage.*"%>
<%@page import="java.time.temporal.*"%>
<%@page import="java.time.LocalDate"%>

<%
    String[] listCriteres = {"id","idDevise","taux","daty"};
    String[] listIntervals = {"daty"};
    String[] libEntete = {"id", "idDevise", "taux","daty"};

    TauxDeChange taux = new TauxDeChange();
    LocalDate now = new java.sql.Date( System.currentTimeMillis() ).toLocalDate();
    int lastDay = now.with(TemporalAdjusters.lastDayOfMonth())
      .getDayOfMonth();
    String month = String.valueOf(now.getMonthValue());
    int year = now.getYear();

    // Mila fenoina zero roa hafa ao afarany
    if( month.length() == 1 ) month = "0" + month;


    PageRecherche pr = new PageRecherche( taux, request, listCriteres, listIntervals, 3, libEntete, libEntete.length );
    pr.setTitre("Liste des taux de changes");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/change/taux/taux-liste.jsp" );
    Liste[] listes = new Liste[1];
    listes[0] = new Liste("idDevise", new Devise(), "val", "id");
    pr.getFormu().changerEnChamp(listes);
    pr.getFormu().getChamp("idDevise").setLibelle("Devise");
    pr.getFormu().getChamp("daty1").setLibelle("Date minimum");
    pr.getFormu().getChamp("daty1").setDefaut("01/"+month+"/"+year);
    pr.getFormu().getChamp("daty2").setLibelle("Date maximum");
    pr.getFormu().getChamp("daty2").setDefaut(lastDay+"/"+month+"/"+year);
    pr.getFormu().getChamp("taux").setLibelle("Taux de Change");
    pr.getFormu().getChamp("colonne").setDefaut("daty");
    pr.getFormu().getChamp("ordre").setDefaut("desc");
    String[] colSomme = null;

    pr.creerObjetPage(libEntete, colSomme);

    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=change/taux/taux-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    String libEnteteAffiche[] = {"Id","Devise","Taux de Change","Date"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);

%>

<div class="content-wrapper">

    <section class="content-header">
        <h1>
            <%= pr.getTitre() %>
        </h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>

        <% out.println(pr.getTableauRecap().getHtml()); %>

        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>

    </section>

</div>
