<%--
    Document   : produit-fiche
    Created on : 21 mars 2024, 09:44:57
    Author     : Angela
--%>


<%@page import="annexe.Unite"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Produit"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Produit t = new Produit();

    String  mapping = "annexe.Produit",
          nomtable = "Produit",
          apres = "station-ejb/src/java/annexe/produit/produit-fiche.jsp",
          titre = "Modification produit";


    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre("Modification Produit");
    pu.getFormu().getChamp("id").setAutre("readonly");
    pu.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pu.getFormu().getChamp("desce").setLibelle("Description");
    pu.getFormu().getChamp("idTypeProduit").setLibelle("Type produit");
    affichage.Champ[] liste = new affichage.Champ[1];
    Unite uni= new Unite();
    liste[0] = new Liste("idUnite", uni, "VAL", "id");
    pu.getFormu().changerEnChamp(liste);
    pu.getFormu().getChamp("idTypeProduit").setAutre("readonly");
    pu.getFormu().getChamp("idCategorie").setPageAppel("choix/categorie/categorie-choix.jsp","idCategorie;idCategorielibelle;idTypeProduit");
    pu.getFormu().getChamp("idCategorie").setLibelle("Categorie");
    pu.getFormu().getChamp("idUnite").setLibelle("Unite");
    pu.getFormu().getChamp("puVente").setLibelle("Prix de vente");
    pu.getFormu().getChamp("puAchat").setLibelle("Prix Achat MGA");
    pu.getFormu().getChamp("puAchatUsd").setLibelle("Prix Achat USD");
    pu.getFormu().getChamp("puAchatEuro").setLibelle("Prix Achat Euro");
    pu.getFormu().getChamp("puAchatAutreDevise").setLibelle("Prix Achat Autre");
    pu.getFormu().getChamp("puVente").setLibelle("Prix de vente MGA");
    pu.getFormu().getChamp("puVenteUsd").setLibelle("Prix de vente USD");
    pu.getFormu().getChamp("puVenteEuro").setLibelle("Prix de vente Euro");
    pu.getFormu().getChamp("puVenteAutreDevise").setLibelle("Prix de vente Autre");
    String lien = (String) session.getValue("lien");
    String id=pu.getBase().getTuppleID();
    pu.preparerDataFormu();
%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1 class="box-title"><a href=<%= lien + "?but=annexe/produit/produit-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
                    </div>
                    <form action="<%= lien %>?but=apresTarif.jsp&id=<%out.print(request.getParameter("id"));%>" method="post">
                        <%
                            out.println(pu.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br>
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%=apres%>">
                        <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%out.print(request.getParameter("id"));%>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
