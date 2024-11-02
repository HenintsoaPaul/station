<%@page import="user.*"%> 
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="mg.cnaps.compta.ComptaSousEcriture" %>
<%@page import="mg.cnaps.compta.ComptaEcriture" %>
<script type="text/javascript">

    window.onload = function() {
        var selectElement = document.getElementById("journal");
        if (selectElement) {
            selectElement.addEventListener("change", handleSelectChange);
        }
    };

    function handleSelectChange(event) {
        // Récupérer la valeur sélectionnée
        var selectedValue = event.target.value;
        console.log("Valeur sélectionnée : " + selectedValue);
        var hiddenInputs = document.querySelectorAll('input[type="hidden"][id^="journal_"]');;
        hiddenInputs.forEach(function(input) {
            input.value = selectedValue;  // Met à jour la valeur de chaque input
        });
    }
</script>
    
<%
    try{
    UserEJB u = null;
    u = (UserEJB) session.getValue("u");
    ComptaEcriture  mere = new ComptaEcriture();   
    ComptaSousEcriture fille = new ComptaSousEcriture();
    int nombreLigne = 10;
    PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);
     pi.setLien((String) session.getValue("lien"));
    affichage.Liste[] liste = new affichage.Liste[1];
    TypeObjet journal = new TypeObjet();
    journal.setNomTable("COMPTA_JOURNAL_ECRITURE_VIEW");
    liste[0] = new Liste("journal", journal, "desce", "id");
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("exercice").setDefaut(String.valueOf(Utilitaire.getAnneeEnCours()));
    pi.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pi.getFormu().getChamp("daty").setLibelle("Date");
    pi.getFormu().getChamp("dateComptable").setLibelle("Date Comptable");
    pi.getFormu().getChamp("horsExercice").setLibelle("Hors Exercice");
    pi.getFormu().getChamp("etat").setVisible(false);
    pi.getFormu().getChamp("od").setVisible(false);
    pi.getFormu().getChamp("credit").setVisible(false);
    pi.getFormu().getChamp("debit").setVisible(false);
    pi.getFormu().getChamp("od").setVisible(false);
    pi.getFormu().getChamp("periode").setVisible(false);
    pi.getFormu().getChamp("trimestre").setVisible(false);
     pi.getFormu().getChamp("trimestre").setDefaut("0");
    //  pi.getFormu().getChamp("journal").setDefaut("");
    pi.getFormu().getChamp("annee").setVisible(false);
    pi.getFormu().getChamp("origine").setVisible(false);
    pi.getFormu().getChamp("origine").setDefaut("VNT");
    pi.getFormu().getChamp("idobjet").setVisible(false);
    pi.getFormufle().getChamp("Compte_0").setLibelle("Compte");
    pi.getFormufle().getChamp("Folio_0").setLibelle("Folio");
    pi.getFormufle().getChamp("remarque_0").setLibelle("Remarque");
    pi.getFormufle().getChamp("analytique_0").setLibelle("Analytique");
    pi.getFormufle().getChamp("Folio_0").setLibelle("Folio");
    pi.getFormufle().getChamp("libellePiece_0").setLibelle("Libelle");
    pi.getFormufle().getChamp("debit_0").setLibelle("Debit");
    pi.getFormufle().getChamp("credit_0").setLibelle("Credit");
    pi.getFormufle().getChamp("daty_0").setLibelle("date");

   // affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("compte"),"mg.cnaps.compta.ComptaCompte","compte","compta_compte","","");
     affichage.Champ.setAutocomplete(pi.getFormufle().getChampFille("compte"),"libelle","compte","compta_compte"," AND typecompte='1'");
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("debit"),"0");
    affichage.Champ.setDefaut(pi.getFormufle().getChampFille("credit"),"0");
     affichage.Champ.setDefaut(pi.getFormufle().getChampFille("exercice"),String.valueOf(Utilitaire.getAnneeEnCours()));
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("idMere"), false);

    affichage.Champ.setVisible(pi.getFormufle().getChampFille("reference_engagement"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("compte_aux"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("lettrage"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("journal"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("exercice"), false);
    affichage.Champ.setVisible(pi.getFormufle().getChampFille("etat"), false);
    // affichage.Champ.setVisible(pi.getFormufle().getChampFille("daty"), false);

    affichage.Champ.setVisible(pi.getFormufle().getChampFille("source"), false);

    pi.preparerDataFormu();

    //Variables de navigation
    String classeMere = "mg.cnaps.compta.ComptaEcriture";
    String classeFille = "mg.cnaps.compta.ComptaSousEcriture";
    String butApresPost = "compta/ecriture/ecriture-fiche.jsp";
    String colonneMere = "idMere";
    //Preparer les affichages
    pi.getFormu().makeHtmlInsertTabIndex();
    pi.getFormufle().makeHtmlInsertTableauIndex();
       
%>
<div class="content-wrapper">
    <!-- A modifier -->
    <h1>Insertion Multiple</h1>
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