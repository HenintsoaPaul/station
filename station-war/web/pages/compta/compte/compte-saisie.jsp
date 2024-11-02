<%-- 
    Document   : comptaCompte-saisie
    Created on : 11 sept. 2015, 14:16:24
    Author     : user
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.ComptaCompte"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
try{

    UserEJB u = null;
    u = (UserEJB) session.getAttribute("u");
    String user = u.getUser().getLoginuser();

    String autreparsley = "data-parsley-range='[8, 40]' required";
    ComptaCompte da = new ComptaCompte();
    da.setNomTable("compta_compte");
    PageInsert pi = new PageInsert(da, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));

    affichage.Champ[] liste = new affichage.Champ[2];
    TypeObjet c = new TypeObjet();
    c.setNomTable("COMPTA_JOURNAL_VIEW");
    liste[0] = new Liste("idjournal", c, "desce", "id");

    TypeObjet typecompte = new TypeObjet();
    typecompte.setNomTable("COMPTA_TYPE_COMPTE");
    liste[1] = new Liste("typeCompte",typecompte,"val","id");

    pi.getFormu().getChamp("compte").setLibelle("Compte");
    pi.getFormu().getChamp("libelle").setLibelle("Libelle");
    //pi.getFormu().getChamp("classy").setVisible(false);
    pi.getFormu().changerEnChamp(liste);
    pi.getFormu().getChamp("idjournal").setLibelle("Journal");
    pi.getFormu().getChamp("analytique_obli").setVisible(false);
    pi.getFormu().getChamp("typeCompte").setLibelle("Type de compte");
    pi.preparerDataFormu();

    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">

    <div class="simple-block mt-5">
        <div class="col-12">
            <h1 class="title">Creation de compte </h1>
        </div>
        <form class="col-12" action="<%= pi.getLien() %>?but=apresTarif.jsp" method="post" name="compte" id="compte" data-parsley-validate>
            <%
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="compta/compte/compte-liste.jsp">
            <input name="classe" type="hidden" id="classe" value="mg.cnaps.compta.ComptaCompte">
        </form>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }

%>