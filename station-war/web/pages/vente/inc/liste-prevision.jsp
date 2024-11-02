<%--
    Document   : liste-prevision
    Created on : 26 août 2024, 14:27:39
    Author     : Mendrika
--%>

<%@page import="user.UserEJB"%>
<%@page import="vente.Vente"%>
<%@page import="prevision.PrevisionComplet"%>
<%@page import="affichage.PageRecherche"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try{
        Vente v = (Vente) request.getAttribute( "station-ejb/src/java/vente" );
        PrevisionComplet[] previsions = v.getPrevisions("PREVISION_COMPLET_CPLPositif",null);
        String[] intervalles = {};
        String[] criteres = {};
        String[] libEntete = {"id","daty", "ecart"};
        PageRecherche pr = new PageRecherche(new PrevisionComplet(), request, criteres, intervalles, 3, libEntete, libEntete.length);
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        String[] colSomme = null;
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =  {"ID", "Date", "Montant Reste"};
        pr.creerObjetPage(libEntete,colSomme);
        pr.getTableau().setData(previsions);
        pr.getTableau().transformerDataString();
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        String lienTableau[] = {pr.getLien() + "?but=prevision/prevision-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
         }else
         {
               %><center><h4>Aucune donne trouvee</h4></center><%
         }
    %>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>
