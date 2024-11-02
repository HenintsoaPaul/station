<%@page import="prevision.Prevision" %>
<%@page import="caisse.Caisse" %>
<%@page import="affichage.*" %>
<%@page import="user.*" %>
<%@page import="utils.*" %>

<%
    try{

        UserEJB user = (UserEJB) session.getValue("u");
        String lien = (String) session.getValue("lien");
        Prevision prevision = new Prevision();
        PageInsert pageInsert = new PageInsert(prevision, request, user);
        pageInsert.setLien(lien);
                affichage.Champ[] liste = new affichage.Champ[1];
            liste[0] = new Liste("idDevise",new caisse.Devise(),"val","id");
            Caisse c = new Caisse();
            c.setIdPoint(ConstanteStation.getFichierCentre());

            pageInsert.getFormu().changerEnChamp(liste);
            pageInsert.getFormu().getChamp("designation").setDefaut("Prevision du "+utilitaire.Utilitaire.dateDuJour());
            pageInsert.getFormu().getChamp("idDevise").setLibelle("Devise");
            pageInsert.getFormu().getChamp("debit").setLibelle( "station-ejb/src/java/depense" );
            pageInsert.getFormu().getChamp("credit").setLibelle("recette");
            pageInsert.getFormu().getChamp("idDevise").setDefaut("AR");
            pageInsert.getFormu().getChamp("taux").setDefaut("1");
            pageInsert.getFormu().getChamp("compte").setLibelle("Compte de regroupement");
            pageInsert.getFormu().getChamp("debit").setVisible(true);
            pageInsert.getFormu().getChamp("idCaisse").setVisible(false);
            pageInsert.getFormu().getChamp("idVirement").setVisible(false);
            pageInsert.getFormu().getChamp("idVenteDetail").setVisible(false);
            pageInsert.getFormu().getChamp("idOp").setVisible(false);
            pageInsert.getFormu().getChamp("etat").setVisible(false);
            pageInsert.getFormu().getChamp("idOrigine").setVisible(false);
            pageInsert.getFormu().getChamp("daty").setLibelle("Date");
            pageInsert.getFormu().getChamp("idTiers").setPageAppelComplete("pertegain.Tiers","id","tiers");
            pageInsert.getFormu().getChamp("idTiers").setLibelle("Tiers");
            pageInsert.getFormu().getChamp("idFacture").setVisible(false);

            String classe = "prevision.Prevision";
            String nomTable = "PREVISION";
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
