<%-- 
    Document   : as-commande-analyse
    Created on : 30 d�c. 2016, 04:57:15
    Author     : Joe
--%>
<%@page import="faturefournisseur.*"%>
<%@page import="utilitaire.*"%>
<%@page import="affichage.*"%>


<%
try{    
    FactureFournisseurDetailsCpl mvt = new FactureFournisseurDetailsCpl();
    String nomTable = "FFFILLECPL_MONTANT";
    mvt.setNomTable(nomTable);
    
    String listeCrt[] = {"id","daty","idcategorielib","idpointlib"};
    String listeInt[] = {"daty"};
    String[] pourcentage = {};
    String[] colGr = {"idproduitlib"};
    String[] colGrCol = {"idpointlib"};
    //String somDefaut[] = {"qte", "montanttotal"};
    String somDefaut[] = {"qte", "montanttotal"};
    
    PageRechercheGroupe pr = new PageRechercheGroupe(mvt, request, listeCrt, listeInt, 3, colGr, somDefaut, pourcentage, colGr.length , somDefaut.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    String apreswhere = "";
    if(request.getParameter("daty1") == null || request.getParameter("daty2") == null){
        apreswhere = "and daty = '"+utilitaire.Utilitaire.dateDuJour()+"'";
    }
    pr.setAWhere(apreswhere);
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    pr.getFormu().getChamp("idcategorielib").setLibelle("Categorie");
    pr.getFormu().getChamp("idpointlib").setLibelle("Point");
    pr.setNpp(500);
    pr.setApres("facturefournisseur/achat-analyse.jsp");
    pr.creerObjetPageCroise(colGrCol,pr.getLien()+"?but=facturefournisseur/facturefournisseur-liste.java");
%>
<script>
    function changerDesignation() {
        document.analyse.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Analyse Achat</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=facturefournisseur/achat-analyse.jsp" method="post" name="analyse" id="analyse">
            <%out.println(pr.getFormu().getHtmlEnsemble());%>
        </form>
        <ul>
            <li>La premiere ligne correspond au quantite</li>
            <li>La 2e ligne correspond au montant total</li>
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