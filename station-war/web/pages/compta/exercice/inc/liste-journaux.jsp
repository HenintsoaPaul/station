

<%@page import="affichage.PageRecherche"%>
<%@ page import="mg.cnaps.compta.ComptaSousEcritureLib" %>
<%@ page import="affichage.PageRechercheGroupe" %>

<% try{
    ComptaSousEcritureLib t = new ComptaSousEcritureLib();
    t.setNomTable("compta_sousecriture_visee");
    String listeCrt[] = {"dateComptable"};
    String listeInt[] = {"dateComptable"};
    String[] colGrp={"journal"};
    String[] colSomme={"debit", "credit"};
    PageRechercheGroupe pr = new PageRechercheGroupe(t, request, listeCrt, listeInt, 3, colGrp,colSomme, colGrp.length, 2);
    pr.setTitre("Liste des journaux");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
//    pr.setApres("personne/inc/association-liste.jsp");
    pr.creerObjetPage();
    String lienTableau[] = {pr.getLien() + "?but=compta/ecriture/sousecriture-liste.jsp&daty1="+pr.getFormu().getChamp("dateComptable1").getValeur()+"&daty2="+pr.getFormu().getChamp("dateComptable2").getValeur()};
    String colonneLien[] = {"journal"};
    String libEnteteAffiche[] = {"journal","debit","credit"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setGroupe(false);

%>

<%--<div class="content-wrapper">--%>
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>" method="get" name="analyse" id="analyse">
            <input type="hidden" name="but" value="<%= pr.getApres() %>" />
<%--            <%out.println(pr.getFormu().getHtmlEnsemble());%>--%>
        </form>
        <%

//            out.println(pr.getTableauRecap().getHtml());
        %>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
//            out.println(pr.getBasPage());
        %>
    </section>
<%--</div>--%>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
    alert('<%=e.getMessage()%>');
    history.back();</script>
<% }%>

