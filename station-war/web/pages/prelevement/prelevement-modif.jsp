<%--
    Document   : prelevement-modif
    Created on : 27 mars 2024, 11:30:59
    Author     : SAFIDY
--%>

<%@page import="prelevement.Prelevement"%>
<%@page import="pompe.PompisteLib"%>
<%@page import="pompe.Pompe"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>

<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    Prelevement t = new Prelevement();

    String  mapping = "prelevement.Prelevement",
          nomtable = "PRELEVEMENT",
          apres = "station-ejb/src/java/prelevement/prelevement-fiche.jsp",
          titre = "Modification Prelevement;";


    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre("Modification prelevement");
    pu.getFormu().getChamp("id").setAutre("readonly");
    pu.getFormu().getChamp("idPrelevementAnterieur").setPageAppel("choix/pompe/prelevement/prelevement-choix.jsp");
    pu.getFormu().getChamp("idPrelevementAnterieur").setLibelle("Prelevement anterieur");
    pu.getFormu().getChamp("compteur").setLibelle("Compteur");
    pu.getFormu().getChamp("daty").setLibelle("Date");
    pu.getFormu().getChamp("heure").setLibelle("Heure");
    pu.getFormu().getChamp("idPompiste").setLibelle("Pompiste");
    pu.getFormu().getChamp("idPompe").setLibelle("Pompe");
    pu.getFormu().getChamp("etat").setVisible(false);
    pu.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    affichage.Champ[] liste = new affichage.Champ[2];

    PompisteLib us = new PompisteLib();
    us.setNomTable("POMPISTELIB");
    liste[0] = new Liste("idPompiste",us,"NOMUSER","REFUSER");
    Pompe pompe = new Pompe();
    pompe.setNomTable("POMPE");
    liste[1] = new Liste("idPompe",pompe,"val","id");

    pu.getFormu().changerEnChamp(liste);
    pu.getFormu().getChamp("idPompiste").setLibelle("Pompiste");
    pu.getFormu().getChamp("idPompe").setLibelle("Pompe");

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
                        <h1 class="box-title"><a href=<%= lien + "?but=prelevement/prelevement-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
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

