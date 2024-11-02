<%--
    Document   : prevision-duplication
    Created on : 29 août 2024, 12:34:20
    Author     : Mendrika
--%>

<%@page import="affichage.Liste"%>
<%@page import="affichage.PageInsert"%>
<%@page import="prevision.MultiplicationPrevision"%>
<%@page import="user.UserEJB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try{

        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        MultiplicationPrevision duplication = new MultiplicationPrevision();
        PageInsert pageInsert = new PageInsert(duplication, request, user);
        pageInsert.setLien(lien);
        affichage.Champ[] liste = new affichage.Champ[1];
        String[] frequence = {"Jour", "Semaine", "Mois"};
        liste[0] = new Liste("frequenceUnite", frequence, frequence);

        pageInsert.getFormu().changerEnChamp(liste);

        pageInsert.getFormu().getChamp("idPrevision").setLibelle("Prevision");
        pageInsert.getFormu().getChamp("idPrevision").setAutre("readonly");
        pageInsert.getFormu().getChamp("idPrevision").setDefaut(request.getParameter("idPrevision"));
        pageInsert.getFormu().getChamp("frequence").setLibelle("Fr&eacute;quence");
        pageInsert.getFormu().getChamp("frequence").setDefaut("1");
        pageInsert.getFormu().getChamp("frequenceUnite").setLibelle("Unit&eacute; de fr&eacute;quence");
        pageInsert.getFormu().getChamp("daty").setLibelle("Date de duplication");
        pageInsert.getFormu().getChamp("daty").setDefaut("utilitaire.Utilitaire.dateDuJour()");

            String classe = "prevision.MultiplicationPrevision";
            String nomTable = "MULTIPLICATION_PREVISION";
            String butApresPost = "station-ejb/src/java/prevision/prevision-fiche.jsp";

            pageInsert.preparerDataFormu();
            pageInsert.getFormu().makeHtmlInsertTabIndex();


%>



    <div class="content-wrapper">
        <h1 align="center">Saisie duplication prevision</h1>
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
