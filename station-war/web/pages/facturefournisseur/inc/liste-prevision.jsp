<%-- 
    Document   : liste-prevision
    Created on : 26 août 2024, 14:55:36
    Author     : Mendrika
--%>

<%@page import="prevision.PrevisionComplet"%>
<%@page import="user.UserEJB"%>
<%@page import="faturefournisseur.FactureFournisseur"%>
<%@page import="vente.Vente"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="prevision.Prevision"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try{
        FactureFournisseur ff = (FactureFournisseur) request.getAttribute("factureFournisseur");
        PrevisionComplet[] previsions = ff.getPrevisions("PREVISION_COMPLET_CPLPositif",null);
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
        String libEnteteAffiche[] =  {"ID", "Date", "Montant reste"};
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