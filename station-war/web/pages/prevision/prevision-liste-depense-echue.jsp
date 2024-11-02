<%--
    Document   : prevision-liste-depense
    Created on : 28 ao�t 2024, 16:55:05
    Author     : Estcepoire
--%>

<%@page import="affichage.*"%>
<%@page import="prevision.*"%>
<%@page import="user.*"%>

<%

    try {
        PrevisionComplet prev = new PrevisionComplet();
        prev.setNomTable("PREVISION_COMPLET_CPL_DEP");
        String[] intervalles = {"daty"};
        String[] criteres = {"id", "designation", "daty"};
        String[] libEntete = {"id", "daty", "designation", "debit", "effectifDebit", "depenseEcart"};
        String[] libEnteteAffiche = {"id", "Date", "D&eacute;signation", "Prevision", "Effectif", "Ecart"};
        PageRecherche pr = new PageRecherche(prev, request, criteres, intervalles, 3, libEntete, libEntete.length);

        if(request.getParameter("dateechue")!= null){
            String where = String.format(" and daty <= '"+request.getParameter("dateechue")+"'");
            pr.setAWhere(where);
        }
        pr.setTitre("Liste des Previsions de Depenses");
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres( "station-ejb/src/java/prevision/prevision-liste-depense-echue.jsp" );
        String[] colSomme = {"debit", "effectifDebit"};
        pr.creerObjetPage(libEntete, colSomme);

        pr.getFormu().getChamp("id").setLibelle("ID");
        pr.getFormu().getChamp("daty1").setLibelle("Date Debut");
        pr.getFormu().getChamp("daty2").setLibelle("Date Fin");
        pr.getFormu().getChamp("designation").setLibelle("D&eacute;signation");

        //Definition des lienTableau et des colonnes de lien
        String lienTableau[] = {pr.getLien() + "?but=prevision/prevision-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>


<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre()%></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres()%>" method="post" name="vente" id="vente">
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


<% } catch (Exception e) {
        e.printStackTrace();
    }
%>

<script>
var lastItem = document.querySelector('.col-md-4:last-of-type');

    if (lastItem) {
        var newItem = lastItem.cloneNode(true);

        var label = newItem.querySelector('label');
        if (label) {
            label.setAttribute('for', 'dateechue');
            label.textContent = 'Date Echeance';
        }

        var input = newItem.querySelector('input');
        if (input) {
            input.setAttribute('name', 'dateechue');
            input.setAttribute('id', 'dateechue');
            input.value = '';
            input.setAttribute('tabindex', '6');
        }

        lastItem.parentNode.insertBefore(newItem, lastItem.nextSibling);
        }

</script>



