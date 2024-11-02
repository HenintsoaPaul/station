<%@page import="mg.cnaps.compta.Bilan"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>
<%
    UserEJB u = null;
    String lien = null;
    u = (UserEJB) session.getValue("u");
    lien = (String) session.getValue("lien");
    Bilan b = new Bilan();
    b.setNomTable("V_BILAN_SECTION_COMPTE_COMPLET");
    String listeCrt[] = {"exercice"};
    String listeInt[] = {};
    String libEntete[] = {"exercice"};
    PageRecherche pr = new PageRecherche(b, request, listeCrt, listeInt, 1, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("compta/etat/bilan-resultat.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Bilan</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/etat/bilan-resultat.jsp" method="post" name="incident" id="incident">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <br/><br/>
        </form>
        <br>
    </section>
</div>
