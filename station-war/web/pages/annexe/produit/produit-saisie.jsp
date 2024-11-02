
<%--
    Document   : produit-fiche
    Created on : 21 mars 2024, 09:44:57
    Author     : Angela
--%>
<%@page import="annexe.Categorie"%>
<%@page import="annexe.SousCategorie"%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Produit"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.*"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "annexe.Produit",
            nomtable = "Produit",
            apres = "station-ejb/src/java/annexe/produit/produit-fiche.jsp",
            titre = "Nouveau produit";

    Produit  objet  = new Produit();
    objet.setNomTable("Produit");
    PageInsert pi = new PageInsert(objet, request, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("puAchat").setLibelle("Prix Achat initiale MGA");
    pi.getFormu().getChamp("puAchatUsd").setLibelle("Prix Achat initiale USD");
    pi.getFormu().getChamp("puAchatEuro").setLibelle("Prix Achat initiale Euro");
    pi.getFormu().getChamp("puVente").setLibelle("Prix de vente MGA");
    pi.getFormu().getChamp("puVenteUsd").setLibelle("Prix de vente USD");
    pi.getFormu().getChamp("puVenteEuro").setLibelle("Prix de vente Euro");
    pi.getFormu().getChamp("puAchatAutreDevise").setVisible(false);
    pi.getFormu().getChamp("puVenteAutreDevise").setVisible(false);
    pi.getFormu().getChamp("idSousCategorie").setVisible(false);

    affichage.Champ[] liste = new affichage.Champ[5];
    TypeProduit tp= new TypeProduit();
    Unite uni= new Unite();
    Categorie cat= new Categorie();
    SousCategorie sc = new SousCategorie();
    liste[0] = new Liste("idTypeProduit", tp, "VAL", "id");
    liste[1] = new Liste("idUnite", uni, "VAL", "id");
    liste[2] = new Liste("idCategorie", cat, "VAL", "id");
    Liste isAchat=new Liste("isAchat");
    isAchat.makeListeOuiNon();
    liste[3] = isAchat;
    Liste isVente=new Liste("isVente");
    isVente.makeListeOuiNon();
    liste[4] = isVente;
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idTypeProduit").setLibelle("Type produit");
    pi.getFormu().getChamp("isVente").setLibelle("est vente");
    pi.getFormu().getChamp("isAchat").setLibelle("est achat");
    pi.getFormu().getChamp("idCategorie").setLibelle("Categorie");
		pi.getFormu().getChamp("idUnite").setLibelle("Unite");

    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
				out.println(pi.getHtmlAddOnPopup());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="<%=apres%>">
    <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
    <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>

<%

} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();

</script>


<% }%>
