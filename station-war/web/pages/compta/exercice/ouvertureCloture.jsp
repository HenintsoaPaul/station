<%-- 
    Document   : ouvertureCloture
    Created on : 2 août 2017, 09:30:12
    Author     : Me
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="user.UserEJB"%>
<%@page import="mg.cnaps.compta.ClotureMoisAnnee"%>
<%@page import="affichage.Liste"%>
<%@page import="utilitaire.ConstanteEtat"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%  
    UserEJB u = null;
    u = (UserEJB) session.getAttribute("u");
    
    ClotureMoisAnnee lv = new ClotureMoisAnnee();
    boolean verif = true;
    String user = u.getUser().getLoginuser();
    String listeCrt[] = {"mois", "annee"};
    String listeInt[] = {"mois", "annee"};
    String libEntete[] = {"mois", "annee","etatAction"};
    PageRecherche pr = new PageRecherche(lv, request, listeCrt, listeInt, 3, libEntete, 3);
    pr.setOrdre("ORDER BY ANNEE DESC, MOIS DESC");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("compta/exercice/ouvertureCloture.jsp");
    pr.getFormu().getChamp("mois1").setLibelle("Mois min");
    pr.getFormu().getChamp("mois2").setLibelle("Mois max");
    pr.getFormu().getChamp("annee1").setLibelle("Année min");
    pr.getFormu().getChamp("annee2").setLibelle("Année max");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

    String[] libAffichage={"Mois","Année","&Eacute;tat"};
    pr.getTableau().setLibelleAffiche(libAffichage);
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1>Liste Mois/Année</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="incident" id="incident">
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
    
<script type="text/javascript">
    const divExport=document.getElementsByClassName("btn-export");
    console.log("DIV EXPORT=",divExport)
    for (let i = 0; i < divExport.length; i++) {
        divExport[i].style.display='none';
    }
</script>
