<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@page import="mg.cnaps.compta.ClasseCompte"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try{
        ClasseCompte a = new ClasseCompte();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        //Modification des affichages
        pi.getFormu().getChamp("val").setLibelle("Nom");
        pi.getFormu().getChamp("desce").setLibelle("Description");
        //Variables de navigation
        String classe = "mg.cnaps.compta.ClasseCompte";
        String butApresPost = "compta/configuration/classecompte-liste.jsp";
        String nomTable = "compta_classe_compte";
        //Generer les affichages
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <div class="simple-block">
        <div class="col-12">
            <h1 class="title">Saisie classe compte</h1>
        </div>
        <form class="col-12" action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" data-parsley-validate>
            <%
                out.println(pi.getFormu().getHtmlInsert());
            %>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= classe %>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        </form>
    </div>
</div>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } %>

