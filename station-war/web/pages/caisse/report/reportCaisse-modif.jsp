

<%@page import="caisse.ReportCaisse"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>


<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    ReportCaisse t = new ReportCaisse();

    String  mapping = "caisse.ReportCaisse",
          nomtable = "REPORTCAISSE",
          apres = "station-ejb/src/java/caisse/report/reportCaisse-fiche.jsp",
          titre = "Modification caisse";

    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre("Modification report caisse");
    Liste[] liste = new Liste[1];
    liste[0] = new Liste("idCaisse",new caisse.CaisseCpl(),"val","id");
    pu.getFormu().changerEnChamp(liste);
    // pu.getFormu().getChamp("idCaisse").setPageAppel("caisse/report/choix/caisse-liste-choix.jsp");
    pu.getFormu().getChamp("idCaisse").setLibelle("Caisse");
    pu.getFormu().getChamp("montant").setLibelle("Montant");
    pu.getFormu().getChamp("montantTheorique").setVisible(false);
    pu.getFormu().getChamp("Etat").setVisible(false);
    pu.getFormu().getChamp("daty").setLibelle("Date");
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
                        <h1 class="box-title"><a href=<%= lien + "?but=annexe/unite/unite-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
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
