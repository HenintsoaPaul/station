<%@page import="caisse.Caisse"%>

<%@page import="bean.*"%>
<%@page import="user.*"%>
<%@page import="affichage.*"%>
<%@page import="utilitaire.*"%>
<%@page import="vente.*"%>
<%@page import="prevision.Prevision" %>
<%@page import="java.sql.Date"%>
<%@page import="java.time.LocalDate"%>


<%
    try {
        UserEJB u = null;
        u = (UserEJB) session.getValue("u");
        String id = request.getParameter("id");
         String classe = request.getParameter("classe");
        // String classe = request.getParameter("classe");
        FactureCF mere = (FactureCF) (Class.forName(classe).newInstance());
        Prevision fille = new Prevision();
        fille.setNomTable("PREVISION");
        fille.setIdFacture(id);
        int nombreLigne = 10;
        Prevision[] filles = (Prevision[])CGenUtil.rechercher(fille,null,null, "");
        if(filles.length == 0){
            System.out.println("etooooo");
            filles = new  Prevision[1];
            LocalDate localDate = LocalDate.now();
            Date dateDuJours = Date.valueOf(localDate);
            filles[0] = new Prevision();
            filles[0].setDesignation("");
            filles[0].setCredit(0);
            filles[0].setDebit(0);
            filles[0].setDaty(dateDuJours);

            filles[0].setTaux(1);
            filles[0].setCompte("");

            filles[0].setNomTable( "station-ejb/src/java/prevision" );
        }
        PageUpdateMultiple pi = new PageUpdateMultiple(mere, fille, filles, request, u,filles.length);
        FactureCF vente =(FactureCF) pi.getBase();
        pi.setLien((String) session.getValue("lien"));


        pi.getFormufle().getChamp("designation_0").setLibelle("D&eacute;signation");
        pi.getFormufle().getChamp("idCaisse_0").setLibelle("Caisse");
        pi.getFormufle().getChamp("credit_0").setLibelle("Credit");
        pi.getFormufle().getChamp("debit_0").setLibelle("Debit");
        pi.getFormufle().getChamp("daty_0").setLibelle("Date");
        affichage.Champ.setPageAppelComplete(pi.getFormufle().getChampFille("idTiers"),"pertegain.Tiers","id","tiers","","");
        pi.getFormufle().getChampMulitple("id").setVisible(false);
        pi.getFormufle().getChampMulitple("idVenteDetail").setVisible(false);
        pi.getFormufle().getChampMulitple("idVirement").setVisible(false);
        pi.getFormufle().getChampMulitple("etat").setVisible(false);
        pi.getFormufle().getChampMulitple("idOp").setVisible(false);
        pi.getFormufle().getChampMulitple("idOrigine").setVisible(false);

        pi.getFormufle().getChampMulitple("taux").setVisible(false);
        pi.getFormufle().getChampMulitple("compte").setVisible(false);
        pi.getFormufle().getChampMulitple("idFacture").setVisible(false);
        pi.getFormufle().getChampMulitple("idTiers").setVisible(false);
        pi.getFormufle().getChampMulitple("idCaisse").setVisible(false);
        // pi.getFormufle().getChamp("designation_0").setVisible(false);

        pi.getFormufle().getChampMulitple("idDevise").setVisible(false);
        for(int i=0;i<pi.getNombreLigne();i++){
            pi.getFormufle().getChamp("idTiers_"+i).setDefaut(vente.getTiers());
            pi.getFormufle().getChamp("idCaisse_"+i).setDefaut(filles[0].getIdCaisse());
            //   pi.getFormufle().getChampMulitple("debit_"+i).setAutre("readonly");
        }
        //Variables de navigation
        String classeMere ="prevision.MereFictif";
        String classeFille = "prevision.Prevision";
        String butApresPost = request.getParameter("bute");
        String colonneMere = "idFacture";

        String table = request.getParameter("table");

        //Preparer les affichages
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().setApres( "station-ejb/src/java/vente/planPaiement-saisie.jsp" );
        pi.getFormufle().makeHtmlInsertTableauIndex();

%>
<div class="content-wrapper">
   <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1>Saisie Plan de Paiement</h1>
                    </div>
                    <div class="box-body">
                        <form class='container' action="<%=pi.getLien()%>?but=apresPlanPaiement.jsp&id=<%=id%>" method="post" >

                            <%

                                out.println(pi.getFormufle().getHtmlTableauInsert());
                            %>

                            <input name="acte" type="hidden" id="nature" value="insertFille">
                            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                            <input name="classeMere" type="hidden" id="classeMere" value="<%= classeMere %>">
                            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= pi.getNombreLigne() %>">
                            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
                            <input name="idmere" type="hidden" id="idmere" value="<%= id %>">
                            <input name="classe" type="hidden" id="table" value="<%= classe %>">
                            <input name="table" type="hidden" id="table" value="<%= table %>">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    document.querySelectorAll('input[id^="daty_"]').forEach(function(input) {
        input.setAttribute('type', 'daty');
        let actualDate = input.value;
        let newDate = actualDate.split("-").reverse().join("/");
        input.value = newDate;
    });
</script>
<%
	} catch (Exception e) {
		e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>
