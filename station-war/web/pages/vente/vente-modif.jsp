<%--
    Document   : vente-saisie
    Created on : 22 mars 2024, 14:37:44
    Author     : Angela
--%>


<%@page import="caisse.Caisse"%>
<%@page import="vente.InsertionVente"%>
<%@page import="vente.VenteDetails"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="vente.*"%>
<%
    try {
        UserEJB u = null;
        u = (UserEJB) session.getValue("u");
        UpdateVente mere = new UpdateVente();
        UpdateVenteDetails fille = new UpdateVenteDetails();
        fille.setNomTable("UPDATEVENTEDETAILS");
        int nombreLigne = 10;
        UpdateVenteDetails[] filles = (UpdateVenteDetails[])CGenUtil.rechercher(fille,null,null, " and idVente ='"+request.getParameter("id")+"'");
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, filles, request, u,filles.length);
        pi.setLien((String) session.getValue("lien"));
        Liste[] liste = new Liste[3];
        liste[0] = new Liste("idDevise",new caisse.Devise(),"val","id");
        liste[1] = new Liste("idMagasin",new magasin.Magasin(),"val","id");
        liste[2] = new Liste("estPrevu");
        liste[2].makeListeOuiNon();
        pi.getFormu().changerEnChamp(liste);
        pi.getFormu().getChamp("etat").setVisible(false);
        pi.getFormu().getChamp("idOrigine").setVisible(false);
        pi.getFormu().getChamp("idMagasin").setLibelle("Point de vente");
        pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
        pi.getFormu().getChamp("designation").setDefaut("Vente particulier du "+utilitaire.Utilitaire.dateDuJour());
        pi.getFormu().getChamp("estPrevu").setLibelle("Est Prevu");
        pi.getFormu().getChamp("datyPrevu").setLibelle("Date encaissement");
        pi.getFormu().getChamp("remarque").setLibelle("Remarque");
        pi.getFormu().getChamp("daty").setLibelle("Date");
        // pi.getFormu().getChamp("idClient").setVisible(false);
        pi.getFormu().getChamp("idClient").setPageAppelComplete("client.Client","id","Client","id","idClient");
        pi.getFormu().getChamp("idClient").setLibelle("Client");
        pi.getFormu().getChamp("idClient").setPageAppelInsert( "station-ejb/src/java/client/client-saisie.jsp","idClient;idClientLibLibelle","id;nom");
        pi.getFormu().getChamp("idDevise").setLibelle("Devise");
        String table = "PRODUIT_LIB_MGA";
        for(int i=0; i<filles.length; i++) {
            if(filles[i].getIdDevise().compareToIgnoreCase("EUR")==0) {
                System.out.println("devise ====> " + filles[i].getIdDevise());
                table = "PRODUIT_LIB_EUR";
            } else if(filles[i].getIdDevise().compareToIgnoreCase("USD")==0) {
                System.out.println("devise ====> " + filles[i].getIdDevise());
                table = "PRODUIT_LIB_USD";
            } else if(filles[i].getIdDevise().compareToIgnoreCase("AR")==0){
                System.out.println("devise ====> " + filles[i].getIdDevise());
                table = "PRODUIT_LIB_MGA";
            }
        }
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idProduitLib"),"annexe.ProduitLib","id",table,"puVente;puAchat;taux;val;id;compte","pu;puAchat;tauxDeChange;designation;idProduit;comptelibelle");
        pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
        pi.getFormufle().getChamp("remise_0").setLibelle("remise");
        pi.getFormufle().getChamp("idOrigine_0").setLibelle("Origine");
        pi.getFormufle().getChamp("qte_0").setLibelle("Quantite");
        pi.getFormufle().getChamp("pu_0").setLibelle("PU");
        pi.getFormufle().getChamp("idDevise_0").setLibelle("Devise");
        pi.getFormufle().getChamp("designation_0").setLibelle("Designation");
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("compte"),"mg.cnaps.compta.ComptaCompte","compte","compta_compte","","");
        pi.getFormufle().getChamp("compte_0").setLibelle("Compte");
        pi.getFormufle().getChamp("tauxDeChange_0").setLibelle("Taux de change");
        pi.getFormufle().getChamp("idProduitLib_0").setLibelle("Produit");
        pi.getFormufle().getChampMulitple("idVente").setVisible(false);
        pi.getFormufle().getChampMulitple("id").setVisible(false);
        pi.getFormufle().getChampMulitple("IdOrigine").setVisible(false);
        pi.getFormufle().getChampMulitple("idProduit").setVisible(false);
        pi.getFormufle().getChampMulitple("puAchat").setVisible(false);
        pi.getFormufle().getChampMulitple("puVente").setVisible(false);
        pi.preparerDataFormu();
        for(int i=0;i<pi.getNombreLigne();i++){
            //pi.getFormufle().getChamp("pu_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("qte_"+i).setAutre("onChange='calculerMontant("+i+")'");
            pi.getFormufle().getChamp("qte_"+i).setDefaut("0");
            pi.getFormufle().getChamp("idDevise_"+i).setAutre("readonly");
            pi.getFormufle().getChamp("tauxDeChange_"+i).setAutre("readonly");
        }
        //Variables de navigation
        String classeMere = "vente.UpdateVente";
        String classeFille = "vente.UpdateVenteDetails";
        String butApresPost = "station-ejb/src/java/vente/vente-fiche.jsp";
        String colonneMere = "idVente";
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
                        <h1>Modification commande</h1>
                    </div>
                    <div class="box-body">
                        <form class='container' action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" >
                            <%

                                out.println(pi.getFormu().getHtmlInsert());
                            %>
                            <h3>Total a payer : <span id="montanttotal">0</span>Ar</h3>
                            <%
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
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page='taux.jsp'/>
<script>

    function calculerMontant(indice) {
        var val = 0;
            $('input[id^="qte_"]').each(function() {
                var quantite =  parseFloat($("#"+$(this).attr('id').replace("qte","pu")).val());
                var montant = parseFloat($(this).val());
                if(!isNaN(quantite) && !isNaN(montant)){
                    var value =quantite * montant;
                    val += value;
                }
            });
            $("#montanttotal").html(val.toFixed(2));
    }
    function deviseModification() {
        var nombreLigne = parseInt($("#nombreLigne").val());
        for(let iL=0;iL<nombreLigne;iL++){
            $(function(){
                var mapping = {
                    "AR": {
                        "table": "produit_lib_mga",
                    },
                    "USD": {
                        "table": "produit_lib_usd"
                    },
                    "EUR": {
                        "table": "produit_lib_euro"
                    }
                };
                $("#deviseLibelle").html($('#idDevise').val());
                var idDevise = $('#idDevise').val();
                $("#idDevise_"+iL).val(idDevise);
                let autocompleteTriggered = false;
                $("#idProduit_"+iL+"libelle").autocomplete('destroy');
                $("#tauxDeChange_"+iL).val('');
                $("#pu_"+iL).val('');
                $("#idProduit_"+iL+"libelle").autocomplete({
                    source: function(request, response) {
                        $("#idProduit_"+iL).val('');
                        if (autocompleteTriggered) {
                            fetchAutocomplete(request, response, "null", "id", "null", mapping[idDevise].table, "annexe.ProduitLib", "true","puVente;puAchat;taux");
                        }
                    },
                    select: function(event, ui) {
                        $("#idProduit_"+iL+"libelle").val(ui.item.label);
                        $("#idProduit_"+iL).val(ui.item.value);
                        $("#idProduit_"+iL).trigger('change');
                        $(this).autocomplete('disable');
                        var champsDependant = ['pu_'+iL,'puAchat_'+iL,'tauxDeChange_'+iL];
                        for(let i=0;i<champsDependant.length;i++){
                            $('#'+champsDependant[i]).val(ui.item.retour.split(';')[i]);
                        }
                        autocompleteTriggered = false;
                        return false;
                    }
                }).autocomplete('disable');
                $("#idProduit_"+iL+"libelle").off('keydown');
                $("#idProduit_"+iL+"libelle").keydown(function(event) {
                    if (event.key === 'Tab') {
                        event.preventDefault();
                        autocompleteTriggered = true;
                        $(this).autocomplete('enable').autocomplete('search', $(this).val());
                    }
                });
                $("#idProduit_"+iL+"libelle").off('input');
                $("#idProduit_"+iL+"libelle").on('input', function() {
                    $("#idProduit_"+iL).val('');
                    autocompleteTriggered = false;
                    $(this).autocomplete('disable');
                });
                $("#idProduit_"+iL+"searchBtn").off('click');
                $("#idProduit_"+iL+"searchBtn").click(function() {
                    autocompleteTriggered = true;
                    $("#idProduit_"+iL+"libelle").autocomplete('enable').autocomplete('search', $("#idProduit_"+iL+"libelle").val());
                });
            });
        }
    }
    deviseModification();
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>

