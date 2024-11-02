<%--
    Document   : jauge-modif
    Created on : 26 mars 2024, 14:32:41
    Author     : Angela
--%>

<%@page import="magasin.Magasin"%>
<%@page import="jauge.Jauge"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Jauge t = new Jauge();

    String  mapping = "jauge.Jauge",
          nomtable = "JAUGE",
          apres = "station-ejb/src/java/jauge/jauge-fiche.jsp",
          titre = "Modification Jauge";


    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre("Modification Jauge");
    pu.getFormu().getChamp("etat").setVisible(false);
    pu.getFormu().getChamp("idMagasin").setPageAppel("choix/choix-magasin.jsp","idMagasin;idMagasinlibelle");
    pu.getFormu().getChamp("idMagasin").setLibelle("Magasin");
    pu.getFormu().getChamp("qte").setLibelle("Quantit&eacute;");
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
                        <h1 class="box-title"><a href=<%= lien + "?but=jauge/jauge-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
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
