<%--
    Document   : classe-saisie.jsp
    Created on : 17 juin 2024, 15:32:16
    Author     : Mirado
--%>

<%@page import="annexe.Unite"%>
<%@page import="magasin.Magasin"%>
<%@page import="vente.*"%>
<%@page import="user.*"%>
<%@page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>

<%
    try{
    String idbc = request.getParameter("id");
    UserEJB u = null;
    u = (UserEJB) session.getValue("u");
    PageInsertMultiple pi=null;
    As_BondeLivraisonClient mere = new As_BondeLivraisonClient();
    As_BondeLivraisonClientFilleInsertion fille = new As_BondeLivraisonClientFilleInsertion();
    int nombreLigne = 10;
    pi = new PageInsertMultiple(mere,fille,request, nombreLigne,u);

    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("idbc").setAutre("readonly");
    pi.getFormu().getChamp("remarque").setLibelle("Remarque");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("idVente").setLibelle("Reference Vente");
    pi.getFormu().getChamp("idbc").setLibelle("Reference Bon de commande");
    pi.getFormu().getChamp("idVente").setAutre("readonly");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("idorigine").setVisible(false);
    pi.getFormu().getChamp("idClient").setLibelle("Client");
    pi.getFormu().getChamp("idClient").setPageAppelComplete("client.Client","id","Client");
    pi.getFormu().getChamp("idClient").setPageAppelInsert( "station-ejb/src/java/client/client-saisie.jsp","idClient;idClientlibelle","id;nom");
    affichage.Liste[] liste = new Liste[1];
    Magasin mg = new Magasin();
    liste[0] = new Liste( "station-ejb/src/java/magasin",mg,"val","id");
    pi.getFormu().changerEnChamp(liste);
    affichage.Liste[] listed = new affichage.Liste[pi.getNombreLigne()];
    for (int i = 0; i < pi.getNombreLigne(); i++) {

        pi.getFormufle().getChamp("id_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("uniteLib_"+i).setAutre("readonly");
        pi.getFormufle().getChamp("produitLib_0").setLibelle("Produit");
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("produitlib"),"annexe.ProduitLib","id","PRODUIT_LIB","id;idUniteLib;idUnite","produit;uniteLib;unite");

        pi.getFormufle().getChamp("unitelib_0").setLibelle("Unite");
        pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
//        pi.getFormufle().getChamp("idventedetail_0").setLibelle("Vente");
    }



    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("numbl"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("produit"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("unite"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idbc_fille"),false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idventedetail"),false);

    pi.preparerDataFormu();

    //Variables de navigation
    String classeMere = "vente.As_BondeLivraisonClient";
    String classeFille = "vente.As_BondeLivraisonClientFille";
    String butApresPost = "bondelivraison-client/bondelivraison-client-fiche.jsp";
    String colonneMere = "numbl";
    //Preparer les affichages
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();

%>
<div class="content-wrapper">
    <!-- A modifier -->
    <h1>Saisie bon de livraison</h1>
    <!--  -->
    <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" >
        <%

            out.println(pi.getFormu().getHtmlInsert());
            out.println(pi.getFormufle().getHtmlTableauInsert());
        %>

        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
        <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
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


