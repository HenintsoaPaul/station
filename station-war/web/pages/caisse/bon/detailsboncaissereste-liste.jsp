<%--
    Document   : detailsboncaisse-listes
    Created on : 9 avr. 2024, 11:48:03
    Author     : 26134
--%>



<%@page import="caisse.DetailsBonCaisseClientReste"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    DetailsBonCaisseClientReste t = new DetailsBonCaisseClientReste();
    t.setNomTable("V_DetailsBonCaisseClientReste ");
    String listeCrt[] = {"id", "idCaisseLib","idPointLib","idClientLib"};
    String listeInt[] = {};
    String libEntete[] = {"id","idClientLib","idCaisse","idCaisseLib","idPoint","idPointLib","debit","credit","reste"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste bon");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/caisse/bon/detailsboncaissereste-liste.jsp" );
    pr.getFormu().getChamp("id").setLibelle("Id");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {};
    String colonneLien[] = {};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"id","idClientLib","idCaisse","idCaisseLib","idPoint","idPointLib","debit","credit","reste"};
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



