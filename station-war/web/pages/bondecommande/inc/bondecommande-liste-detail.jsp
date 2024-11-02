<%@page import="faturefournisseur.As_BonDeCommande_Fille_CPL"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8;" %>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    As_BonDeCommande_Fille_CPL t = new As_BonDeCommande_Fille_CPL();
    t.setNomTable("AS_BONDECOMMANDE_CPL");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id","produitlib","quantite","pu","tva","unitelib"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idbc='"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =   {"id","produit","quantite","pu","tva","unite"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
    %>
    <div class="w-100" style="display: flex; flex-direction: row-reverse;">
        <table style="width: 20%"class="table">
            <tr>
                <td><b>Montant HT:</b></td>
                <td><b><%= AdminGen.calculSommeDouble(pr.getListe(),"montantHT") %> <%= ((As_BonDeCommande_Fille_CPL)pr.getListe()[0]).getIdDevise() %></b></td>
            </tr>
            <tr>
                <td><b>Montant TVA:</b></td>
                <td><b><%= AdminGen.calculSommeDouble(pr.getListe(),"montantTVA") %> <%= ((As_BonDeCommande_Fille_CPL)pr.getListe()[0]).getIdDevise() %></b></td>
            </tr>
            <tr>
                <td><b>Montant TTC:</b></td>
                <td><b><%= AdminGen.calculSommeDouble(pr.getListe(),"montantTTC") %> <%= ((As_BonDeCommande_Fille_CPL)pr.getListe()[0]).getIdDevise() %></b></td>
            </tr>
        </table>
    </div>
    <% }if(pr.getTableau().getHtml() == null){
                %><div style="text-align: center;"><h4>Aucune donnée trouvée</h4></div><%
    }
    %>  
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>