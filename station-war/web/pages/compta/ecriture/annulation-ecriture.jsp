<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.ComptaSousEcritureLib"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRecherche"%>

<%
try{
        UserEJB u = (UserEJB) session.getAttribute("u");
        
        ComptaSousEcritureLib a = new ComptaSousEcritureLib();
        a.setNomTable("COMPTA_SOUSECRITURE_VISEE");
        String listeCrt[] = {"id","journal","daty","compte"};
        String listeInt[] = {"daty","compte"};
        String libEntete[] = {"id","daty","journal","compte","analytique","remarque","libellePiece","debit","credit"};

        PageRecherche pr = new PageRecherche(a, request, listeCrt, listeInt, 3, libEntete, libEntete.length);

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("compta/ecriture/annulation-ecriture.jsp");

        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
//        pr.getFormu().getChamp("dateComptable1").setLibelle("Date Comptable Min");
//        pr.getFormu().getChamp("dateComptable2").setLibelle("Date Comptable Max");
        pr.getFormu().getChamp("compte1").setLibelle("Compte debut");
        pr.getFormu().getChamp("compte2").setLibelle("Compte fin");
        pr.getFormu().getChamp("journal").setLibelle("ID Journal");
        
        String[] colSomme = null;

        pr.setNpp(300);
        
        pr.creerObjetPage(libEntete, colSomme);

        int nombreLigne = pr.getTableau().getData().length;
        String nomtable = "COMPTA_SOUS_ECRITURE";
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Annulation visa des ecritures</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/ecriture/annulation-ecriture.jsp" method="post" name="incident" id="incident">
            <%
                // pr.getFormu().makeHtmlNew();
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
           
        </form>

        <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" id='modif-form' method="post" data-parsley-validate>
            <input name="acte" type="hidden" id="acte" value="annulerVisaMultiple">
            <input name="bute" type="hidden" id="bute" value="compta/ecriture/annulation-ecriture.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.compta.ComptaSousEcriture">
            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%=nombreLigne%>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
            <div class="result mt-5 table-result">
            <%
                String libEnteteAffiche[] = {"Id","Date","Journal","Compte","Analytique","Remarque","Libelle Piece","Debit","Credit"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameBoutton("Annuler");
                pr.getTableau().setNameActe("annulerVisaMultiple");
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
            </div>
        </form>
    </section>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>
