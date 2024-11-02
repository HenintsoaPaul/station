<%@page import="bean.CGenUtil"%>
<%@page import="affichage.PageUpdateMultiple"%>
<%@page import="faturefournisseur.*"%>
<%@page import="bean.UnionIntraTable"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageInsertMultiple"%>
<%@page import="java.util.Calendar"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.PageInsert"%>
<%@page import="utilitaire.Utilitaire"%>
<%    
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = null;
    String idUser= "";
    u = (UserEJB) session.getValue("u");
    idUser = ""+u.getUser().getTuppleID();
    As_BonDeCommande mere = new As_BonDeCommande();
    As_BonDeCommande_Fille fille = new As_BonDeCommande_Fille();
    fille.setNomTable("AS_BONDECOMMANDE_FILLE");
    fille.setIdbc(request.getParameter("id"));
    As_BonDeCommande_Fille[] listef = (As_BonDeCommande_Fille[])CGenUtil.rechercher(fille, null, null, "");
    PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, listef, request, u, 2);
    pi.setLien((String) session.getValue("lien"));
    Liste[] liste = new Liste[1];
    ModePaiement mp = new ModePaiement();
    liste[0] = new Liste("modepaiement",mp,"val","id");

    pi.getFormu().changerEnChamp(liste);
    //pi.getFormu().getChamp("fournisseur").setPageAppel("choix/fournisseur/fournisseur-choix.jsp","fournisseur;fournisseurlibelle");
    pi.getFormu().getChamp("fournisseur").setPageAppelComplete("faturefournisseur.Fournisseur","id","FOURNISSEUR");
    pi.getFormu().getChamp("fournisseur").setAutre("readonly");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("etat").setVisible(false);



    affichage.Liste[] listed = new affichage.Liste[pi.getNombreLigne()];
    for (int i = 0; i < pi.getNombreLigne(); i++) {

        pi.getFormufle().getChamp("id_"+i).setAutre("readonly");
    }
       affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("produit"),"annexe.ProduitLib","id","PRODUIT_LIB","idUniteLib;puVente","unite;pu");

    pi.getFormufle().getChamp("id_0").setLibelle("composante");
    pi.getFormufle().getChamp("id_0").setAutre("readonly");
    pi.getFormufle().getChamp("produit_0").setLibelle("Produit");

    pi.getFormufle().getChamp("quantite_0").setLibelle("Quantite");
    pi.getFormufle().getChamp("pu_0").setLibelle("pu");
    pi.getFormufle().getChamp("montant_0").setLibelle("Montant");
    pi.getFormufle().getChamp("tva_0").setLibelle("TVA");
    pi.getFormufle().getChamp("unite_0").setLibelle("Unite");
    pi.getFormufle().getChamp("remise_0").setLibelle("Remise");
    // affichage.Champ.setVisible(pi.getFormufle().getChampFille("id2"), false);
    // affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    
    
    mere = (As_BonDeCommande) pi.getBase();
    pi.preparerDataFormu();

    
%>
<div class="content-wrapper">
    
    <div class="box-title with-border">
        <h1 class="box-title"> <a href="<%=pi.getLien()%>?but=bondecommande/bondecommande-liste.jsp"><i class='fa fa-arrow-circle-left'></i></a> Modification bon de commande</h1>
    </div>
    
    <form action="<%=pi.getLien()%>?but=apresMultiple.jsp&id=<%out.print(request.getParameter("id"));%>" method="post" name="sortie" id="sortie" data-parsley-validate>
        <%
            pi.getFormu().makeHtmlInsertTabIndex();
            pi.getFormufle().makeHtmlInsertTableauIndex();
            out.println(pi.getFormu().getHtmlInsert());
        %>
                <div class="row">
                    <div class="col-md-10 col-md-offset-1">
                        <%
                            out.println(pi.getFormufle().getHtmlTableauInsert());
                        %>
                    </div>
                </div>
        <input name="acte" type="hidden" id="acte" value="updateInsert">
        <input name="bute" type="hidden" id="bute" value="bondecommande/bondecommande-fiche.jsp?id=<%=request.getParameter("id")%>">
        <input name="classe" type="hidden" id="classe" value="faturefournisseur.As_BonDeCommande">
        <input name="classefille" type="hidden" id="classefille" value="faturefournisseur.As_BonDeCommande_Fille">
        <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=pi.getNombreLigne()%>">
        <input name="colonneMere" type="hidden" id="colonneMere" value="idbc">
    </form>
</div>
<script>
    function add_line() {
        var indexMultiple = document.getElementById('indexMultiple').value;
        var nbrLigne = document.getElementById('nbrLigne').value;

        var html = "<tr id='ligne-multiple-"+nbrLigne+"'><td align=center><input type='checkbox' value='"+nbrLigne+"' name='id' id='checkbox"+nbrLigne+"'/></td>";
        html += "<input name='id_"+nbrLigne+"' type='hidden' class='form-control' id='id_"+nbrLigne+"' value>";
        html+="<td style='display: flex;'><input name=id1libelle_"+nbrLigne+" type=textbox class='form-control' id=id1libelle_"+nbrLigne+" value readonly=><input type=hidden value name=id1_"+nbrLigne+" id=id1_"+nbrLigne+"><input name=choix type=button class=submit onclick=pagePopUp('choix/idvaldesceChoix.jsp?champReturn=id1_"+nbrLigne+";id1libelle_"+nbrLigne+"&amp;nomTable=composante&amp;ik=_"+nbrLigne+"&amp;apresLienPageAppel=') value=...></td>";
        html+="<input name='id2_"+nbrLigne+"' type='hidden' class='form-control' id='id2_"+nbrLigne+"' value>"
        html +="<td><a href='#'><span class='glyphicon glyphicon-remove'></span></a></td></tr>";
        
        $('#ajout_multiple_ligne').append(html);
        document.getElementById('indexMultiple').value = parseInt(indexMultiple) + 1;
        document.getElementById('nbrLigne').value = parseInt(nbrLigne) + 1;
        document.getElementById('nombreLigne').value = parseInt(nbrLigne) + 1;
    }
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
}%>
