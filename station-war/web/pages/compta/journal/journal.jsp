<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="affichage.PageRecherche" %>
<%@page import="mg.cnaps.compta.Journal" %>
<%@page import="affichage.PageInsert" %>
<%
    try {
        String autreparsley = "data-parsley-range='[8, 40]' required";
        Journal a = new Journal();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        pi.getFormu().getChamp("val").setLibelle("Numero");
        pi.getFormu().getChamp("desce").setLibelle("Description");
        pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <section class="content-header">
        <div class="col-12">
            <h1 class="title">Saisie Journal</h1>
        </div>
    </section>
    <section class="content">
        <form class="col-12" action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="contrainte"
              id="contrainte"
              data-parsley-validate>
            <%
                pi.getFormu().makeHtmlInsertTabIndex();
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="compta/journal/journal.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.compta.Journal">
        </form>
            <br/><br/>

    <%
        Journal e = new Journal();
        String listeCrt[] = {"id", "val", "desce"};
        String listeInt[] = null;
        String libEntete[] = {"id", "val", "desce"};

        PageRecherche pr = new PageRecherche(e, request, listeCrt, listeInt, 3, libEntete, 3);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("compta/journal/journal.jsp");
        String[] colSomme = null;
        pr.creerObjetPage(libEntete, colSomme);
    %>
    <%
        String libEnteteAffiche[] = {"Id", "Numero", "Description"};

        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        out.println(pr.getTableau().getHtml());
        out.println(pr.getBasPage());
    %>
    </section>
    
</div>

<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
history.back();</script>

<% } %>
