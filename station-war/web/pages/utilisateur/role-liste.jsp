<%@page import="historique.MapRoles"%>
<%@page import="historique.MapHistorique"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
        MapRoles d = new MapRoles();
        d.setNomTable("roles");
        String listeCrt[] = {"idrole", "descrole", "rang"};
        String listeInt[] = null;
        String libEntete[] = {"idrole", "descrole", "rang"};
        PageRecherche pr = new PageRecherche(d, request, listeCrt, listeInt, 3, libEntete, 3);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("utilisateur/role-liste.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);

%>
<div class="content-wrapper">
    <h1>Liste profil</h1>
    <form action="<%=pr.getLien()%>?but=utilisateur/role-liste.jsp" method="post" name="listeRole" id="listeUtilisateur">
        <%
            pr.getFormu().getChamp("idrole").setLibelle("Role");
            pr.getFormu().getChamp("descrole").setLibelle("Description");
            out.println(pr.getFormu().getHtmlEnsemble());
        %>
    </form>
    <%
        String lienTableau[] = {pr.getLien() + "?but=utilisateur/role-fiche.jsp"};
        String colonneLien[] = {"idrole"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        out.println(pr.getTableauRecap().getHtml());%>
    <br>
    <%
        String libEnteteAffiche[] = {"Role/Profil", "Description", "Rang"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
        out.println(pr.getBasPage());
        out.print("</div>");
    } catch (Exception e) {
        e.printStackTrace();
    %>
    <script language="JavaScript"> alert('<%=e.getMessage()%>');
        history.back();</script>
    <%
        }
    %>