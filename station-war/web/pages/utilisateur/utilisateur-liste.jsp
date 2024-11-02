<%@page import="utilisateurstation.UtilisateurStation"%>
<%@page import="affichage.PageRecherche"%>
<%
    try {
    UtilisateurStation users = new UtilisateurStation();
    
    String listeCrt[] = {"refuser", "nomuser","teluser", "idrole"};
    String listeInt[] = {""};
    String libEntete[] = {"refuser", "nomuser","teluser", "idrole"};
    
    PageRecherche pr = new PageRecherche(users, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    
    pr.getFormu().getChamp("teluser").setLibelle("Tel");
    pr.getFormu().getChamp("refuser").setLibelle("R&eacute;f&eacute;rence");
    pr.getFormu().getChamp("nomuser").setLibelle("Nom et prenom");
    pr.getFormu().getChamp("idrole").setLibelle("Role");
    
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("utilisateur/utilisateur-liste.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste des utilisateurs</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=utilisateur/utilisateur-liste.jsp" method="post" name="listeUtilisateur" id="listeUtilisateur">
            <%

                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        <%
            
            
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            String libEnteteAffiche[] = {"R&eacute;f&eacute;rence","Nom et Pr&eacute;nom", "Tel", "Ro&#770;le"};
            
            String lienTableau[] = {pr.getLien() + "?but=utilisateur/utilisateur-fiche.jsp", pr.getLien() + "?but=personnel/personnel-fiche.jsp"};
            String colonneLien[] = {"refuser"};
            String urlLienMultiple[] = {"refuser"};
            String urlLienAffiche[] = {"refuser"};
            
            pr.getTableau().setUrlLienAffiche(urlLienAffiche);
            pr.getTableau().setUrlLien(urlLienMultiple);
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(colonneLien);
            
            pr.getTableau().setLibelleAffiche(libEnteteAffiche);
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <% } catch(Exception e){e.printStackTrace();} %>