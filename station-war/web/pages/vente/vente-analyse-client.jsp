<%--
    Document   : as-commande-analyse
    Created on : 30 d�c. 2016, 04:57:15
    Author     : Joe
--%>
<%@page import="java.util.Calendar"%>
<%@page import="vente.VenteLib"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.*"%>


<%
try{
    VenteLib mvt = new VenteLib();
    String nomTable = "VENTE_CPL";
    mvt.setNomTable(nomTable);

    String listeCrt[] = {"id","daty"};
    String listeInt[] = {"daty"};
    String[] pourcentage = {};
    String[] colGr = {"idClientLib"};
    String[] colGrCol = {"iddevise"};
    //String somDefaut[] = {"qte", "puTotal", "puRevient"};
    String somDefaut[] = {"montantttc","montantpaye", "montantreste"};

    PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colGr, somDefaut, pourcentage, colGr.length , somDefaut.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String apreswhere = "";
    Calendar calendar = Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH) + 1; // January is 0
        int year = calendar.get(Calendar.YEAR);

    if(request.getParameter("daty1") == null || request.getParameter("daty2") == null){
        apreswhere = " and daty <= '"+utilitaire.Utilitaire.dateDuJour()+"' and daty >= '"+String.format("01/%02d/%04d", month, year)+"'";
    }
    pr.setAWhere(apreswhere);


    pr.getFormu().getChamp("daty1").setDefaut(String.format("01/%02d/%04d", month, year));
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");

    pr.setNpp(500);
    pr.setApres( "station-ejb/src/java/vente/vente-analyse-client.jsp" );
    pr.creerObjetPageCroise(colGrCol,pr.getLien()+"?but=");
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
    $(document).ready(function() {
        $('.box table tr').each(function() {
            $(this).find('td:last, th:last').hide();
        });
    });
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Vente Par Client</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=vente/vente-analyse-client.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <ul>
            <li><strong>La premiere ligne represente la somme de la facture.</strong> </li>
            <li><strong>La deuxieme ligne represente la somme des montant payes.</strong></li>
            <li><strong>La troisieme ligne represente la somme des restants de aux clients.</strong></li>
        </ul>
           <%
            String lienTableau[] = {};
            pr.getTableau().setLien(lienTableau);
            pr.getTableau().setColonneLien(somDefaut);%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>
<%
    }catch(Exception e){
        e.printStackTrace();
    }
%>
