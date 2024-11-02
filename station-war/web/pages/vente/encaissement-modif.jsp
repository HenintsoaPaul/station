<%--
    Created on : 12 avr. 2024, 08:38:57
    Author     : Angela
--%>

<%@page import="encaissement.EncaissementDetails"%>
<%@page import="caisse.CategorieCaisse"%>
<%@page import="encaissement.EncaissementCpl"%>
<%@page import="bean.TypeObjet"%>
<%@page import="user.*"%>
<%@ page import="bean.*" %>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%
    String autreparsley = "data-parsley-range='[8, 40]' required";
    EncaissementCpl  t = new EncaissementCpl();

    System.out.println("anaty page modif");

      String  mapping = "encaissement.Encaissement",
            nomtable = "Encaissement",
            apres = "station-ejb/src/java/encaissement/encaissement-fiche.jsp",
            titre = "Modification Encaissement";


    PageUpdate pu = new PageUpdate(t, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre(titre);
    pu.getFormu().getChamp("id").setAutre("readonly");
    pu.getFormu().getChamp("designation").setLibelle("D&eacute;signation");
    pu.getFormu().getChamp("idCaisseLib").setLibelle("ID Caisse");
    pu.getFormu().getChamp("idCaisse").setVisible(false);
    pu.getFormu().getChamp("etatLib").setAutre("readonly");
    pu.getFormu().getChamp("etat").setVisible(false);
    pu.getFormu().getChamp("daty").setLibelle("Date");
    pu.getFormu().getChamp("idOrigine").setLibelle("Id Origine");
    pu.getFormu().getChamp("idTypeEncaissementlib").setLibelle("Type Encaissement");
    pu.getFormu().getChamp("idTypeEncaissement").setVisible(false);
    pu.getFormu().getChamp("montant").setLibelle("Montant");
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
                        <h1 class="box-title"><a href=<%= lien + "?but=vente/encaissement-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
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

