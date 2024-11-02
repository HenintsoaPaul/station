<%--
    Document   : avoirFC-modif
    Created on : 2 ao�t 2024, 16:10:51
    Author     : randr
--%>


<%@page import="vente.Vente"%>
<%@page import="avoir.AvoirFC"%>
<%@page import="avoir.AvoirFCFille"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    try {
        UserEJB u = null;
        u = (UserEJB) session.getValue("u");
        String idAvoicFC = request.getParameter("id");

        AvoirFC mere = new AvoirFC();
        AvoirFCFille fille = new AvoirFCFille();
        int nombreLigne = 10;
        AvoirFCFille[] filles = (AvoirFCFille[])CGenUtil.rechercher(fille,null,null, " and idAvoirFC ='"+idAvoicFC+"'");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, filles, request, u,filles.length);
        pi.setLien((String) session.getValue("lien"));
//        Liste[] liste = new Liste[1];
//        liste[0] = new Liste("idMagasin",new magasin.Magasin(),"val","id");
//        liste[1] = new Liste("idDevise",new caisse.Devise(),"val","id");
//        liste[1].setDefaut("AR");
//        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("remarque").setLibelle("Remarque");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        pi.getFormu().getChamp("idClient").setLibelle("Client");
        pi.getFormu().getChamp("idClient").setAutre("readonly");
        //pi.getFormu().getChamp("idClient").setPageAppelComplete("client.Client","id","Client");
        //pi.getFormu().getChamp("idClient").setPageAppelInsert("client/client-saisie.jsp","idClient;idClientlibelle","id;nom");
        pi.getFormu().getChamp("idVente").setAutre("readonly");
        pi.getFormu().getChamp("idVente").setLibelle("Vente");

        pi.getFormu().getChamp("idMagasin").setVisible(false);
        pi.getFormu().getChamp("etat").setDefaut("1");
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idOrigine").setVisible(false);

        //fille
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idProduit"),"annexe.ProduitLib","id","PRODUIT_LIB_MGA","puVente;puAchat;taux;val","pu;puAchat;tauxDeChange;designation");
        affichage.Champ.setPageAppelInsert(pi.getFormufle().getChampFille("idProduit"), "station-ejb/src/java/annexe/produit/produit-saisie.jsp","id;val");
        pi.getFormufle().getChamp("idProduit_0").setLibelle("Produit");
        pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
        pi.getFormufle().getChamp("designation_0").setLibelle("Designation");
//        pi.getFormufle().getChamp("remise_0").setLibelle("remise");
        pi.getFormufle().getChamp("idOrigine_0").setLibelle("Origine");
        pi.getFormufle().getChamp("pu_0").setLibelle("Montant");
        pi.getFormufle().getChamp("tauxDeChange_0").setLibelle("Taux de change");
        pi.getFormufle().getChampMulitple("tauxDeChange").setAutre("readonly");
        pi.preparerDataFormu();
//        for(int i=0;i<nombreLigne;i++){
           // pi.getFormufle().getChamp("pu_"+i).setAutre("readonly");
            //pi.getFormufle().getChamp("qte_"+i).setDefaut("1");
            //pi.getFormufle().getChamp("tva_"+i).setDefaut("0");
            //pi.getFormufle().getChamp("idDevise_"+i).setDefaut("AR");
//        }
        pi.getFormufle().getChampMulitple("id").setVisible(false);
        pi.getFormufle().getChampMulitple("idAvoirFC").setVisible(false);
        pi.getFormufle().getChampMulitple("remise").setVisible(false);
        pi.getFormufle().getChampMulitple("idVenteDetails").setVisible(false);
        pi.getFormufle().getChampMulitple("IdOrigine").setVisible(false);
        pi.getFormufle().getChampMulitple("puAchat").setVisible(false);
        pi.getFormufle().getChampMulitple("puVente").setVisible(false);
        pi.getFormufle().getChampMulitple("idDevise").setVisible(false);
        pi.getFormufle().getChampMulitple("qte").setVisible(false);

        //Variables de navigation
        String classeMere = "avoir.AvoirFC";
        String classeFille = "avoir.AvoirFCFille";
        String butApresPost = "station-ejb/src/java/avoir/avoirFC-fiche.jsp";
        String colonneMere = "idAvoirFC";
        //Preparer les affichages
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();

%>
<div class="content-wrapper">
   <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1>Nouvel avoir FC</h1>
                    </div>
                    <div class="box-body">
                        <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%=idAvoicFC%>" method="post" >
                            <%

                                out.println(pi.getFormu().getHtmlInsert());
                            %>
                            <h3>Total  : <span id="montanttotal">0</span><span id="deviseLibelle">Ar</span></h3>
                            <%
                                out.println(pi.getFormufle().getHtmlTableauInsert());
                            %>

                            <input name="acte" type="hidden" id="nature" value="updateInsert">
                            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                            <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
                            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
