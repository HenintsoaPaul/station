<%--
    Document   : etatcaisse-liste
    Created on : 2 avr. 2024, 10:11:22
    Author     : 26134
--%>

<%@page import="caisse.EtatCaisse"%>
<%@page import="caisse.PageRechercheEtatCaisse"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    EtatCaisse t = new EtatCaisse();
    t.setNomTable("V_ETATCAISSE");
    String listeCrt[] = {"id","idCaisselib","idPointlib","idTypeCaisselib","dateDernierReport"};
    String listeInt[] = {"dateDernierReport"};
    String libEntete[] = {"idCaisselib","idPointlib","idTypeCaisselib","dateDernierReport","montantDernierReport","credit","debit", "reste"};
    PageRechercheEtatCaisse pr = new PageRechercheEtatCaisse(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Etat de Caisse");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/caisse/etatcaisse/etatcaisse-liste.jsp" );
    pr.getFormu().getChamp("idCaisselib").setLibelle("Caisse");
    pr.getFormu().getChamp("idPointlib").setLibelle("Point");
    pr.getFormu().getChamp("idTypeCaisselib").setLibelle("Type Caisse");
    pr.getFormu().getChamp("dateDernierReport1").setLibelle("Date min");
    pr.getFormu().getChamp("dateDernierReport1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("dateDernierReport2").setLibelle("Date max");
    pr.getFormu().getChamp("dateDernierReport2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
/*    String lienTableau[] = {pr.getLien() + "?but=fiche/template-fiche-simple.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);*/
    //Definition des libelles à afficher
    String libEnteteAffiche[] = {"Caisse","Point","Type Caisse","date Dernier Report","Solde Initiale","Entr&eacute;e","D&eacute;pense", "Solde Finale"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>


<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
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
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>



