<%@page import="affichage.*"%>
<%@page import="bean.*"%>
<%@page import="user.*"%>
<%@page import="caisse.Caisse" %>
<%@page import="caisse.MvtCaisse" %>

<%
    try{

        /**
         * Data for mapping
         *
        **/
        String nomTable = "MOUVEMENTCAISSE";
        String id = request.getParameter("id");
        String bute = "station-ejb/src/java/caisse/mvt/mvtCaisse-fiche.jsp";
        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        String classe = "caisse.MvtCaisse";



        String autreparsley = "data-parsley-range='[8, 40]' required";
        MvtCaisse mouvement = new MvtCaisse();

        PageUpdate pageUpdate = new PageUpdate( mouvement, request, user );

        Liste[] listes = new Liste[1];
        listes[0] = new Liste("idCaisse", new Caisse(), "val", "id");
        pageUpdate.getFormu().changerEnChamp(listes);

        pageUpdate.setLien(lien);
        pageUpdate.getFormu().getChamp("idCaisse").setLibelle("Caisse");
        pageUpdate.getFormu().getChamp("etat").setVisible(false);
        pageUpdate.getFormu().getChamp("idVenteDetail").setVisible(false);
        pageUpdate.getFormu().getChamp("idVirement").setVisible(false);
        pageUpdate.getFormu().getChamp("idOp").setVisible(false);
        pageUpdate.getFormu().getChamp("idOrigine").setVisible(false);
        pageUpdate.preparerDataFormu();
%>

<div class="content-wrapper">
    <div class="row">
    <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                    <h1>Modification Mouvement Caisse</h1>
                    <form action="<%= lien %>?but=apresTarif.jsp&id=<%= id %>" method="post">
                        <%
                            out.println(pageUpdate.getFormu().getHtmlInsert());
                        %>
                        <div class="row">
                            <div class="col-md-11">
                                <button class="btn btn-primary pull-right" name="Submit2" type="submit">Valider</button>
                            </div>
                            <br><br>
                        </div>
                        <input name="acte" type="hidden" id="acte" value="update">
                        <input name="bute" type="hidden" id="bute" value="<%= bute %>">
                        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
                        <input name="rajoutLien" type="hidden" id="rajoutLien" value="id-<%= id %>" >
                        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<%    }catch(Exception e){
        e.printStackTrace();
    }


%>
