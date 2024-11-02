<%--
    Document   : pertegainimprevue-fiche
    Created on : 29 juil. 2024, 13:53:11
    Author     : bruel
--%>

<%@page import="pertegain.PerteGainImprevueLib"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="pertegain.PerteGainImprevue"%>
<%@page import="mg.spat.AttacherFichier"%>
<%@page import="service.UploadService"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>
<%
    try {
        String lien = (String) session.getValue("lien");
        String pageActuel = "station-ejb/src/java/pertegain/pertegainimprevue-fiche.jsp";

        PerteGainImprevueLib pertegainimprevue = new PerteGainImprevueLib();
        PageConsulte pc = new PageConsulte(pertegainimprevue, request, (user.UserEJB) session.getValue("u"));//ou avec argument liste Libelle si besoin
        pertegainimprevue = (PerteGainImprevueLib) pc.getBase();
        String id = pertegainimprevue.getId();

        pc.getChampByName("idorigine").setLibelle("Origine");

        pc.getChampByName("daty").setLibelle("Date");
        pc.getChampByName("designation").setLibelle("Designation");
        pc.getChampByName("type").setLibelle("Type");
        pc.getChampByName("compte").setLibelle("Compte");
        pc.getChampByName("montantht").setLibelle("Montnat HT");
        pc.getChampByName("montanttva").setLibelle("Montant TVA");
        pc.getChampByName("montantttc").setLibelle("Montant TTC");
        pc.getChampByName("tierslib").setLibelle("Tiers");
        pc.getChampByName("tierscompte").setLibelle("Compte Tiers");
        pc.getChampByName("idtypegainperte").setVisible(false);
        pc.getChampByName("tiers").setVisible(false);

        if(pertegainimprevue.getGain()>0){
            pc.getChampByName("gain").setLibelle("Gain");
            pc.getChampByName("perte").setVisible(false);
        } else if (pertegainimprevue.getPerte() > 0){
            pc.getChampByName("perte").setLibelle("Perte");
            pc.getChampByName("gain").setVisible(false);
        }

        if(pertegainimprevue.getIdorigine().contains("VNT")){
            pc.getChampByName("idorigine").setLien((String) session.getValue("lien") + "?but=vente/vente-fiche.jsp", "id=");
        } else if(pertegainimprevue.getIdorigine().contains("FCF")) {
            pc.getChampByName("idorigine").setLien((String) session.getValue("lien") + "?but=facturefournisseur/facturefournisseur-fiche.jsp", "id=");
        }


//        pc.getChampByName("nomfournisseur").setLien("module.jsp?but=travaux/tiers-fiche.jsp&id=" + a.getIdFournisseur(), "nom=");
        pc.setTitre("Fiche Perte ou Gain imprevue");
        AttacherFichier[] fichiers = UploadService.getUploadFile(request.getParameter("id"));
        configuration.CynthiaConf.load();
        String cdn = configuration.CynthiaConf.properties.getProperty("cdnReadUri");
        String dossier = "op";

        Onglet onglet = new Onglet("page1");
        onglet.setDossier("inc");
        Map<String, String> map = new HashMap<String, String>();
        map.put("ecriture-details", "");
        if(pertegainimprevue.getEtat() >= ConstanteEtat.getEtatValider()) {
            map.put("mvtcaisse-details", "");
        }
        String tab = request.getParameter("tab");
        if (tab == null) {
            tab = "ecriture-details";
        }
        map.put(tab, "active");
        tab = "inc/" + tab + ".jsp";
%>
<style>
    .col-md-center .box-fiche{
        min-width:100%;
    }
</style>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="box" id="fiche">
                <div class="box-title with-border">

                    <% if(pertegainimprevue.getIdorigine().contains("VNT")){ %>
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=vente/vente-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    <% } else if(pertegainimprevue.getIdorigine().contains("FCF")) { %>
                        <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=facturefournisseur/facturefournisseur-liste.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%></h1>
                    <% } %>

                </div>
                <div class="box-body">
                    <%   out.println(pc.getHtml());%>
                </div>
                <div class="box-footer">
                    <div>
                        <a class="btn btn-success pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=valider&classe=pertegain.PerteGainImprevue&bute=pertegain/pertegainimprevue-fiche.jsp&id=" + id%>"  style="margin-right: 10px">Viser</a>
                        <a class="btn btn-warning pull-left"  href="<%=(String) session.getValue("lien") + "?but=pertegain/pertegainimprevue-modif.jsp&id=" + id%>"  style="margin-right: 10px">Modifier</a>
                        <a class="btn btn-danger pull-left"  href="<%=(String) session.getValue("lien") + "?but=apresTarif.jsp&acte=annulerVisa&classe=pertegain.PerteGainImprevue&bute=pertegain/pertegainimprevue-fiche.jsp&id=" + id%>"  style="margin-right: 10px">Annuler visa</a>

                    </div>
                    <div>
                         <% if(pertegainimprevue.getGain()>0){%>
                            <a class="btn btn-success pull-primary"  href="<%=(String) session.getValue("lien") + "?but=pertegain/pertegain-mvtcaisse-saisie.jsp&id=" + id+"&perteougain=1&montant="+pertegainimprevue.getMontantttc()%>"  style="margin-right: 10px">Entre caisse</a>
                        <%} else if(pertegainimprevue.getPerte()>0){%>
                                <a class="btn btn-primary pull-primary"  href="<%=(String) session.getValue("lien") + "?but=pertegain/pertegain-mvtcaisse-saisie.jsp&id=" + id+"&perteougain=-1&montant="+pertegainimprevue.getMontantttc()%>"  style="margin-right: 10px">sortie caisse</a>
                            <% } %>
                    </div>
                    <div>
                        <a class="btn btn-info pull-right"  href="<%=(String) session.getValue("lien") + "?but=pageupload.jsp&id=" + id + "&dossier=" + dossier + "&nomtable=ATTACHER_FICHIER&procedure=GETSEQ_ATTACHER_FICHIER&bute=pertegain/pertegainimprevue-fiche.jsp&id=" + id%>" style="margin-right: 10px">Attacher Fichier</a>
                    </div>

                     <div class="tab-content">

                </div>
                </div>

            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="nav-tabs-custom">
                <ul class="nav nav-tabs">
                    <!-- a modifier -->
                    <% if (pertegainimprevue.getEtat() >= ConstanteEtat.getEtatValider()) {%>
                    <li class="<%=map.get("ecriture-detail")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=ecriture-details">Ecriture</a></li>
                    <li class="<%=map.get("mvtcaisse-details")%>"><a href="<%= lien%>?but=<%= pageActuel%>&id=<%= id%>&tab=mvtcaisse-details">Mouvement Caisse</a></li>
                    <% }%>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= tab%>" >
                        <jsp:param name="idmere" value="<%= id%>" />
                    </jsp:include>
                </div>
            </div>

        </div>
    </div>

    <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
            <div class="">
                <h2 class="box-title" style="margin-left: 10px;">Les fichiers attach&eacute;s</h2>
            </div>
            <div class="box-body">
                <table class="table table-striped table-bordered table-condensed table-responsive tree">
                    <thead>
                        <tr>
                            <th style="background-color:#bed1dd;"></th>
                            <th style="background-color:#bed1dd;">Libell&eacute;</th>
                            <th style="background-color:#bed1dd;">Fichier</th>
                            <th style="background-color:#bed1dd;">Voir</th>
                            <th style="background-color:#bed1dd;">#</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%if (fichiers == null || fichiers.length == 0) {%>
                        <tr>
                            <td colspan="5" style="text-align: center;"><strong>Aucun fichier</strong></td>
                        </tr>
                        <%} else {
                            for (AttacherFichier fichier : fichiers) {%>
                        <tr class="treegrid-1 treegrid-expanded">
                            <td><span class="treegrid-expander glyphicon glyphicon-minus"></span></td>
                            <td><%=fichier.getChemin()%></td>
                            <td><%=Utilitaire.champNull(fichier.getLibelle())%></td>
                            <td><a href="#" class="btn btn-primary" onclick="javascript:pagePopUp('<%=cdn + dossier + "/" + fichier.getChemin()%>')">Voir</a></td>
                            <td></td>
                        </tr>
                        <%}
                            }%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $('#fiche .row .col-md-6').removeClass('col-md-6').removeClass('col-md-center').addClass('col-md-8').addClass('col-md-offset-2');
</script>
<%} catch (Exception e) {
       e.printStackTrace();
    }%>

