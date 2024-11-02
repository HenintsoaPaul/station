
<%@page import="annexe.Categorie"%>
<%--
    Document   : produit-fiche
    Created on : 21 mars 2024, 09:44:57
    Author     : Angela
--%>
<%@page import="annexe.Unite"%>
<%@page import="annexe.TypeProduit"%>
<%@page import="annexe.Produit"%>
<%@page import="affichage.PageInsert"%>
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>

<%
    try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "annexe.Produit",
            nomtable = "Produit",
            apres = "station-ejb/src/java/annexe/produit/produit-fiche.jsp",
            titre = "Insertion Produit";

    Produit  objet  = new Produit();
    objet.setNomTable("Produit");
    PageInsert pi = new PageInsert(objet, request, u);
    affichage.Champ[] liste = new affichage.Champ[3];
    Unite uni= new Unite();
    liste[0] = new Liste("idUnite", uni, "VAL", "id");
		Categorie cat= new Categorie();
    liste[1] = new Liste("idCategorie", cat, "VAL", "id");
		TypeProduit typ= new TypeProduit();
    liste[2] = new Liste("idTypeProduit", typ, "VAL", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("val").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("desce").setLibelle("Description");
    pi.getFormu().getChamp("idTypeProduit").setLibelle("Type produit");
    pi.getFormu().getChamp("idCategorie").setLibelle("Categorie");
    pi.getFormu().getChamp("idUnite").setLibelle("Unite");
    pi.getFormu().getChamp("puAchat").setVisible(false);
    pi.getFormu().getChamp("puVente").setLibelle("Prix de vente");



    pi.preparerDataFormu();
%>
<div class="content-wrapper">
    <h1> <%=titre%></h1>

    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="<%=apres%>">
    <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
    <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
		<div>
		<canvas id="salesChart"></canvas>
	</div>
</div>
<script>
window.onload = function() {
            const ctx = document.getElementById('salesChart').getContext('2d');

            const monthlySalesData = {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Ventes mensuelles',
                    data: [1200, 1900, 3000, 5000, 2000, 3000, 4000, 5000, 7000, 8000, 10000, 12000],
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderWidth: 0 // D�finir la largeur de la bordure � 0
                }]
            };

            new Chart(ctx, {
                type: 'bar',
                data: monthlySalesData,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        };
</script>
<%

} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();

</script>


<% }%>
