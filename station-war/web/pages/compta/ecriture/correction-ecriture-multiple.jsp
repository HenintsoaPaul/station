<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.ComptaSousEcriture"%>
<%@page import="affichage.Liste"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.UserEJB"%>
<%@page import="affichage.PageRechercheUpdate"%>

<%
try{
        UserEJB u = (UserEJB) session.getAttribute("u");
        
        ComptaSousEcriture a = new ComptaSousEcriture();
        String listeCrt[] = {"id","journal","daty","compte"};
        String listeInt[] = {"daty","compte"};

        String libEntete[] = {"id","journal","folio","compte","remarque","libellePiece","source","analytique","debit","credit"};

        PageRechercheUpdate pr = new PageRechercheUpdate(a, request, listeCrt, listeInt, 3, libEntete, "id");

        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("compta/ecriture/correction-ecriture-multiple.jsp");
        pr.setAWhere(" AND etat=1");
        pr.getFormu().getChamp("daty1").setLibelle("Date Min");
        pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("daty2").setLibelle("Date Max");
        pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
        pr.getFormu().getChamp("compte1").setLibelle("Compte debut");
        pr.getFormu().getChamp("compte2").setLibelle("Compte fin");
        pr.getFormu().getChamp("journal").setLibelle("ID Journal");
        
        String[] colSomme = null;
        
        pr.creerObjetPage(libEntete, colSomme);

        int nombreLigne = pr.getTableau().getData().length;
%>
<div class="content-wrapper">
    <section class="content-header">
        <h1>Correction des ecritures</h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=compta/ecriture/correction-ecriture-multiple.jsp" method="post" name="incident" id="incident">
            <%
                // pr.getFormu().makeHtmlNew();
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
           
        </form>

        <form action="<%=pr.getLien()%>?but=apresMultiple.jsp" id='modif-form' method="post" data-parsley-validate>
            <input name="acte" type="hidden" id="acte" value="updateMultiple">
            <input name="bute" type="hidden" id="bute" value="compta/ecriture/correction-ecriture-multiple.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.compta.ComptaSousEcritureModif">
            <input name="nombreLigne" type="hidden" id="nomtable" value="<%=nombreLigne%>">
            <div class="result mt-5 table-result">
            <%
                String libEnteteAffiche[] = {"Id","Journal","Folio","Compte","Remarque","Libelle","Source","Analytique","Debit","Credit"};
                pr.getTableau().setLibelleAffiche(libEnteteAffiche);
                pr.getTableau().setNameBoutton("Corriger");
                pr.getTableau().setNameActe("updateMultiple");
                out.println(pr.getTableau().getHtmlWithCheckboxUpdateMultiple());
//                out.println(pr.getBasPage());
            %>
            </div>
        </form>
    </section>
</div>
<%}catch(Exception e){
    e.printStackTrace();
}%>
