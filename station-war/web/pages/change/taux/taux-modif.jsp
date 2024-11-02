<%@page import="affichage.*" %>
<%@page import="change.*" %>
<%@page import="caisse.Devise" %>

<%
    TauxDeChange taux = new TauxDeChange();
    String  mapping = "change.TauxDeChange",
          nomtable = "tauxdechange",
          apres = "station-ejb/src/java/change/taux/taux-fiche.jsp",
          titre = "Modification Taux de Change";


    PageUpdate pu = new PageUpdate(taux, request, (user.UserEJB) session.getValue("u"));
    pu.setLien((String) session.getValue("lien"));
    pu.setTitre(titre);
    Liste[] listes = new Liste[1];
    listes[0] = new Liste("idDevise", new Devise(), "val", "id");
    pu.getFormu().changerEnChamp(listes);
    pu.getFormu().getChamp("id").setAutre("readonly");
    pu.getFormu().getChamp("idDevise").setLibelle("Devise");
    pu.getFormu().getChamp("taux").setLibelle("Taux de Change");
    pu.getFormu().getChamp("daty").setLibelle("Date de change");
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
                        <h1 class="box-title"><a href=<%= lien + "?but=change/taux/taux-fiche.jsp&id="+id%> <i class="fa fa-arrow-circle-left"></i></a><%=pu.getTitre()%></h1>
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
