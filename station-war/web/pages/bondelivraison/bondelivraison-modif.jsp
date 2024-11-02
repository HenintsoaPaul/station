<%--
    Document   : classe-saisie.jsp
    Created on : 17 juin 2024, 15:32:16
    Author     : Mirado
--%>

<%@page import="annexe.Unite"%>
<%@page import="magasin.Magasin"%>
<%@page import="faturefournisseur.*"%>
<%@page import="user.*"%>
<%@page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try{
    String numbl = request.getParameter("id");
    UserEJB u = null;
    u = (UserEJB) session.getValue("u");
    As_BonDeLivraison mere = new As_BonDeLivraison();
    As_BonDeLivraison_Fille_Cpl fille = new As_BonDeLivraison_Fille_Cpl();
    fille.setNumbl(numbl);
    fille.setNomTable("AS_BONDELIVRAISON_LIBCPL");
    int nombreLigne = 10;
    As_BonDeLivraison_Fille_Cpl[] details = (As_BonDeLivraison_Fille_Cpl[]) CGenUtil.rechercher(fille,null,null," and numbl='"+numbl+"' ");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, details, request, u, 2);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("idbc").setAutre("readonly");
    pi.getFormu().getChamp( "station-ejb/src/java/magasin" ).setAutre("readonly");
    pi.getFormu().getChamp("idbc").setLibelle("Bon de commande");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idFournisseur").setLibelle("Fournisseur");
    pi.getFormu().getChamp("idFournisseur").setPageAppelComplete("faturefournisseur.Fournisseur","id","fournisseur");
    pi.getFormu().getChamp("etat").setVisible(false);
    affichage.Liste[] liste = new Liste[1];
    Magasin mg = new Magasin();
    liste[0] = new Liste( "station-ejb/src/java/magasin",mg,"val","id");
    pi.getFormu().changerEnChamp(liste);

    for (int idx = 0; idx < details.length; idx++) {
             pi.getFormufle().getChamp("id_"+idx).setDefaut(details[idx].getId());
             pi.getFormufle().getChamp("produit_"+idx).setDefaut(details[idx].getProduit());
             pi.getFormufle().getChamp("numbl_"+idx).setDefaut(details[idx].getProduit());
             pi.getFormufle().getChamp("quantite_"+idx).setDefaut(""+details[idx].getQuantite());
             pi.getFormufle().getChamp("iddetailsfacturefournisseur_"+idx).setDefaut(""+details[idx].getIddetailsfacturefournisseur());
             pi.getFormufle().getChamp("unite_"+idx).setDefaut(""+details[idx].getUnite());
             pi.getFormufle().getChamp("unitelib_"+idx).setAutre("readonly");
             pi.getFormufle().getChamp("produitlib_"+idx).setDefaut(""+details[idx].getProduitlib());
             pi.getFormufle().getChamp("produitlib_"+idx).setAutre("readonly");
             pi.getFormufle().getChamp("iddetailsfacturefournisseur_"+idx).setAutre("readonly");
             pi.getFormufle().getChamp("idbc_fille_"+idx).setDefaut(""+details[idx].getIdbc_fille());
    }

/*
    affichage.Liste[] listef = new Liste[1];
    Unite unitf=new Unite();
    listef[0]=new Liste("unite",unitf,"val","id");
    pi.getFormufle().changerEnChamp(listef);
*/
    pi.getFormufle().getChamp("produitlib_0").setLibelle("Produit");
    pi.getFormufle().getChamp("unitelib_0").setLibelle("Unite");
    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("iddetailsfacturefournisseur_0").setLibelle("detail facture fournisseur");
    pi.getFormufle().getChamp("iddetailsfacturefournisseur_0").setAutre("readonly");

    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("numbl"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("produit"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("etat"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("iddetailsfacturefournisseur"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("unite"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbc_fille"),false);
    affichage.Champ.setAutre(pi.getFormufle().getChampFille("unitelib"),"readonly");
    affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("produitlib"),"annexe.ProduitLib","id" , "Produit_LIB", "id;idUnite;idUniteLib", "produit;unite;unitelib");
    pi.preparerDataFormu();

    //Variables de navigation
    String classeMere = "faturefournisseur.As_BonDeLivraison";
    String classeFille = "faturefournisseur.As_BonDeLivraison_Fille";
    String butApresPost = "bondelivraison/bondelivraison-fiche.jsp";
    String colonneMere = "numbl";
    //Preparer les affichages
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();

%>
<div class="content-wrapper">
    <!-- A modifier -->
    <h1>Modification bon de livraison</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%= request.getParameter("id") %>" method="post" >
        <%

            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= pi.getNombreLigne() %>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
    </form>

</div>

<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>


