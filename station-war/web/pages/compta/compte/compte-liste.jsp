<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="mg.cnaps.compta.ComptaCompte"%>
<%@page import="affichage.PageRecherche"%>

<%
    try {
    ComptaCompte lv = new ComptaCompte();
    lv.setNomTable("compta_compte_libelle");
    String listeCrt[] = {"id", "compte", "libelle", "typeCompte", "idjournal"};
    String listeInt[] = null;
    String libEntete[] = {"id", "compte", "libelle", "typeCompte", "idjournal"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 5);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.getFormu().getChamp("libelle").setLibelle("Libelle");
    pr.getFormu().getChamp("typeCompte").setLibelle("Type de compte");

    affichage.Champ[] liste = new affichage.Champ[1];
    TypeObjet c = new TypeObjet();
    c.setNomTable("COMPTA_JOURNAL_VIEW");
    liste[0] = new Liste("idjournal", c, "desce", "desce");
    
    pr.getFormu().changerEnChamp(liste);
    pr.setApres("compta/compte/compte-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des Comptes</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/compte/compte-liste.jsp" method="post" name="incident" id="incident">
            <%
                // pr.getFormu().makeHtmlNew();
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%  String lienTableau[] = {pr.getLien() + "?but=compta/compte/compte-fiche.jsp"};
            String colonneLien[] = {"id"};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
//            out.println(pr.getTableauRecap().getHtmlRecap());
        %>
        <%
            String libEnteteAffiche[] = {"ID", "Compte", "Libelle", "Type de Compte","Journal"};
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());

        %>
    </section>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
        throw e;
    }
%>