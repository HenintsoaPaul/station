<%@ page import="user.*" %>
<%@ page import="affichage.*" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="mg.cnaps.compta.ClotureMoisAnnee" %>

<%
    try{

        UserEJB user = (UserEJB) session.getValue("u");

        //Information sur les navigations via la page
        String lien = (String) session.getValue("lien");
        String pageModif = "personne/inscription-modif.jsp";
        String classe = "mg.cnaps.compta.ClotureMoisAnnee";
        String classeAnnul = "mg.cnaps.compta.ClotureMoisAnnee";
        String pageListe = "compta/exercice/ouvertureCloture.jsp";
        String pageActuel = "compta/exercice/fiche-cloture.jsp";

        //Information sur la fiche
        ClotureMoisAnnee clotureMoisAnnee=new ClotureMoisAnnee();
        PageConsulte pc = new PageConsulte(clotureMoisAnnee, request, user);
        clotureMoisAnnee = (ClotureMoisAnnee) pc.getBase();
        String id=request.getParameter(clotureMoisAnnee.getAttributIDName());
        pc.setTitre("Fiche cloture mois ann&eacute;e");

        //Initialisation de l'objet onglet
        Onglet onglet =  new Onglet("liste-journaux");
        onglet.setDossier("inc");
        Map<String, String> listePage = new HashMap<String, String>();
        Map<String, String> listeNumero = new HashMap<String,String>();
        listePage.put("liste-journaux","liste-journaux");
        listeNumero.put("1","liste-journaux");
        onglet.setListePage(listePage);
        onglet.setListeNumero(listeNumero);
        String tab = request.getParameter("tab");
        String currentTab = onglet.getCurrentPage(tab);

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="box-fiche">
                <div class="box">
                <div class="box-title with-border">
                    <h1 class="box-title"><a href="<%=(String) session.getValue("lien")%>?but=compta/exercice/ouvertureCloture.jsp"><i class="fa fa-arrow-circle-left"></i></a><%=pc.getTitre()%>
                    </h1>
                </div>
                <div class="box-body">
                    <%
                        out.println(pc.getHtml());
                    %>
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
                    <li class="<%= listePage.get("page1")%>"><a href="<%= lien %>?but=<%= pageActuel %>&id=<%= id %>&tab=liste-journaux">Liste des journaux</a></li>
                </ul>
                <div class="tab-content">
                    <jsp:include page="<%= currentTab %>" >
                        <jsp:param name="dateComptable1" value="<%= ((ClotureMoisAnnee)pc.getBase()).getDateDebut() %>" />
                        <jsp:param name="dateComptable2" value="<%= ((ClotureMoisAnnee)pc.getBase()).getDateFin() %>" />
                    </jsp:include>
                </div>
            </div>
        </div>
    </div>
</div>
    

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
