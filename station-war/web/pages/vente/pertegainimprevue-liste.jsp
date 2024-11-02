<%--
    Document   : perteventeimprevue-details
    Created on : 29 juil. 2024, 16:19:06
    Author     : bruel
--%>

<%@page import="pertegain.PerteGainImprevueLib"%>
<%@page import="pertegain.PerteGainImprevue"%>
<%@page import="caisse.MvtCaisseCpl"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>


<%
    try {
        PerteGainImprevueLib t = new PerteGainImprevueLib();
            String[] etatAff = {"Tous","Cr&eacute;e(s)" ,"Vis&eacute;e(s)","Pay&eacute;","Annul&eacute;e"};
            String[] etatVal = {"pertegainimprevuelib","pertegainimprevuelib_C","pertegainimprevuelib_NP", "pertegainimprevuelib_P","pertegainimprevuelib_A"};


        t.setNomTable(etatVal[0]);
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            t.setNomTable(request.getParameter("etat"));
        }

         String listeCrt[] = {"id", "designation", "type", "compte", "perte", "gain", "daty"};
        String listeInt[] = {};
        String libEntete[] = {"id", "designation", "type", "compte", "perte", "gain", "daty"};
        PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
        pr.setUtilisateur((user.UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        if (request.getParameter("id") != null) {
            pr.setAWhere(" and idorigine='" + request.getParameter("id") + "'");
        }
        pr.setTitre("Liste des pertes et gains");
        pr.setApres( "station-ejb/src/java/vente/pertegainimprevue-liste.jsp" );
        String[] colSomme = null;
        pr.setNpp(10);
        pr.creerObjetPage(libEntete, colSomme);
        String lienTableau[] = {pr.getLien() + "?but=pertegain/pertegainimprevue-fiche.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);

%>
<script>
     function changerDesignation() {
        document.pertegain.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
      <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="pertegain" id="depense">

    <%  String libEnteteAffiche[] = {"id", "Designation", "Type", "Compte", "Perte", "Gain", "Date"};
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
        pr.getTableau().getData();
        %>
       <% if (pr.getTableau().getHtml() != null) {
            out.println(pr.getFormu().getHtmlEnsemble());
        } else {
    %>
    <center><h4>Aucune donne trouvee</h4></center><%
        } %>
         <div class="row col-md-12">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="row">
                    Etat :
                    <select name="etat" class="champ form-control" id="etat" onchange="changerDesignation()">
                        <%
                            for( int i = 0; i < etatAff.length; i++ ){ %>
                                <% if(request.getParameter("etat") !=null && request.getParameter("etat").compareToIgnoreCase(etatVal[i]) == 0) {%>
                                <option value="<%= etatVal[i] %>" selected> <%= etatAff[i] %> </option>
                                <% } else { %>
                                <option value="<%= etatVal[i] %>"> <%= etatAff[i] %> </option>
                                <% } %>
                        <%    }
                        %>
                    </select>
                </div>
            </div>
         </div>
      </form>

        <br>


<%
            out.println(pr.getTableauRecap().getHtml());%>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>

    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>
