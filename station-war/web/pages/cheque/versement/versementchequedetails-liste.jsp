<%@page import="cheque.VersementChequeDetailsCpl"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    VersementChequeDetailsCpl t = new VersementChequeDetailsCpl();
    t.setNomTable("VersementChequeDetailsCpl");
    /*
    private String id,idVersementCheque,idCheque,remarque;
    String idChequeLib,idCaisse,idVersementChequeLib;
    double montant;
    */
    String listeCrt[] = {"id", "idVersementCheque", "idVersementChequeLib","montant"};
    String listeInt[] = {};
    String libEntete[] = {"id", "idVersementCheque", "idVersementChequeLib","montant"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste versement details");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/cheque/versement/versementchequedetails-liste.jsp" );
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=cheque/versement/versementchequedetails-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles � afficher
    String libEnteteAffiche[] = {"id", "designation", "idCaisse","montant"};
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



