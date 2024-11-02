<%-- 
    Document   : avoir-details
    Created on : 6 août 2024, 10:37:34
    Author     : Valiah Karen
--%>

<%-- 
    Document   : avoirFC-fiche
    Created on : 2 août 2024, 15:56:27
    Author     : randr
--%>


<%@page import="avoir.AvoirFCLib"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%
//		 try{
    UserEJB u = (user.UserEJB)session.getValue("u");
    
%>
<%
   /*
    AvoirFCLib caisse = new AvoirFCLib();
    PageConsulte pc = new PageConsulte(caisse, request, u);
    pc.setTitre("Fiche AvoirFC");
    pc.getBase();
    String id=pc.getBase().getTuppleID();
    pc.getChampByName("id").setLibelle("Id");
    pc.getChampByName("idMagasinLib").setLibelle("Magasin");
    pc.getChampByName("idVenteLib").setLibelle("Vente");
    pc.getChampByName("idCategorieLib").setLibelle("Categorie");
    pc.getChampByName("idMotifLib").setLibelle("Motif");
    pc.getChampByName("montantHT").setLibelle("Montant HT");
    pc.getChampByName("montantTVA").setLibelle("Montant TVA"); 
    pc.getChampByName("montantTTC").setLibelle("Montant TTC"); 
    pc.getChampByName("montantHTAr").setLibelle("Montant HT Ar"); 
    pc.getChampByName("montantTVAAr").setLibelle("Montant TVA Ar"); 
    pc.getChampByName("montantTTCAr").setLibelle("Montant TTC Ar"); 
    pc.getChampByName("designation").setLibelle("D&eacute;signation");
    pc.getChampByName("daty").setLibelle("Date");
    pc.getChampByName("etat").setLibelle("Etat");
    pc.getChampByName("idMagasin").setVisible(false);
    pc.getChampByName("idOrigine").setVisible(false);
    pc.getChampByName("idClient").setVisible(false);
    pc.getChampByName("idVente").setVisible(false);
    pc.getChampByName("idMotif").setVisible(false);
    pc.getChampByName("idCategorie").setVisible(false);
    String lien = (String) session.getValue("lien");
    String pageModif = "avoir/avoirFC-modif.jsp";
    String classe = "avoir.AvoirFC";
*/
    try{
    AvoirFCLib t = new AvoirFCLib();
    t.setNomTable("avoirfclib");
    String listeCrt[] = {};
    String listeInt[] = {};
    String libEntete[] = {"id", "idMagasinLib","idVenteLib", "idCategorieLib","idMotifLib","montantHT","montantTVA","montantTTC","montantHTAr","montantTVAAr","montantTTCAr","designation"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    if(request.getParameter("id") != null){
        pr.setAWhere(" and idVente='"+request.getParameter("id")+"'");
    }
    String[] colSomme = null;
    pr.setNpp(10);
    pr.creerObjetPage(libEntete, colSomme);
    int nombreLigne = pr.getTableau().getData().length;
%>

<div class="box-body">
    <%
        String libEnteteAffiche[] =  {"id", "Magasin","Vente","Categorie","Motif","Montant HT","Montant TVA","Montant TTC","Montant HT Ar","Montant TVA Ar","Montant TTC Ar","Designation"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        AvoirFCLib[] liste=(AvoirFCLib[]) pr.getTableau().getData();
        if(pr.getTableau().getHtml() != null){
            out.println(pr.getTableau().getHtml());
    %>   
    <%  }if(pr.getTableau().getHtml() == null)
         {
               %><center><h4>Aucune donne trouvee</h4></center><%
         }

        
    %>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>


