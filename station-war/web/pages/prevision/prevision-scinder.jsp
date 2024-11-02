<%--
    Document   : prevision-scinder
    Created on : 2 sept. 2024, 16:30:58
    Author     : Mendrika
--%>

<%@page import="affichage.PageInsert"%>
<%@page import="prevision.ScinderPrevision"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    try{

        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        ScinderPrevision prev = new ScinderPrevision();
        prev.setNomTable("SCINDERPREVISION");
        PageInsert pageInsert = new PageInsert(prev, request, user);
        pageInsert.setLien(lien);

        pageInsert.getFormu().getChamp("idPrevision").setLibelle("Prevision");
        pageInsert.getFormu().getChamp("idPrevision").setDefaut(request.getParameter("idPrevision"));
        pageInsert.getFormu().getChamp("idPrevision").setAutre("readonly");
        pageInsert.getFormu().getChamp("nombre").setLibelle("Nombre");

        String classe = "prevision.ScinderPrevision";
        String nomTable = "SCINDERPREVISION";
        String butApresPost = "station-ejb/src/java/prevision/prevision-fiche.jsp";

        pageInsert.preparerDataFormu();
        pageInsert.getFormu().makeHtmlInsertTabIndex();
%>

    <div class="content-wrapper">
        <h1 align="center">Saisie Prevision </h1>
        <form action="<%=pageInsert.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
            <%
                out.println(pageInsert.getFormu().getHtmlInsert());
            %>
            <input name="acte" type="hidden" id="nature" value="insert">
            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
            <input name="classe" type="hidden" id="classe" value="<%= classe %>">
            <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        </form>
    </div>

<%
    }catch(Exception e){
        e.printStackTrace();
    }

%>
