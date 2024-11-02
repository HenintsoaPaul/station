<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page import="mg.cnaps.compta.ComptaLettrageLib"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="bean.TypeObjet"%>
<%
    UserEJB u = null;
    String lien = null;

    u = (UserEJB) session.getValue("u");
    lien = (String) session.getValue("lien");

    ComptaLettrageLib lv = new ComptaLettrageLib();

    String listeCrt[] = {"id", "lettre", "date_lettrage",  "compte"};
    String listeInt[] = {"date_lettrage"};
    String libEntete[] = {"id", "lettre","date_lettrage", "compte"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 4);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.getFormu().getChamp("date_lettrage1").setLibelle(" date lettrage min");
    pr.getFormu().getChamp("date_lettrage1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("date_lettrage2").setLibelle(" date lettrage max");
    pr.getFormu().getChamp("date_lettrage2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("compta/lettrage/lettrage-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Lettrage</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/lettrage/lettrage-liste.jsp" method="post" name="incident" id="incident">
            <%

                // pr.getFormu().makeHtmlNew();
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <br/><br/>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=compta/lettrage/lettrage-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
        %>
        <br>

        <%
            String libEnteteAffiche[] = {"ID", "Lettre", "Date lettrage", "Compte"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
