<%--
    Document   : jauge-liste
    Created on : 26 mars 2024, 14:32:30
    Author     : Angela
--%>

<%@page import="jauge.JaugeLib"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="magasin.MagasinLib"%>
<%@page import="affichage.Liste"%>

<% try{
    JaugeLib bc = new JaugeLib();
    String[] etatVal = {"JAUGELIB", "JAUGE_LIB_CREE", "JAUGE_LIB_VISEE", "JAUGE_LIB_ANNULEE"};
    String[] etatAff = {"Tous", "Cr��e(s)", "Vis�e(s)", "Annul�e"};

        bc.setNomTable(etatVal[0]);
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            bc.setNomTable(request.getParameter("etat"));
        }
    String listeCrt[] = {"id","idMagasinLib"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","idMagasinLib","daty","qte","etatLib"};
    String libEnteteAffiche[] = {"id","Magasin","Date","Quantite","Etat"};
    PageRecherche pr = new PageRecherche(bc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des jauges ");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/jauge/jauge-liste.jsp" );
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("idMagasinLib").setLibelle("Magasin");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=jauge/jauge-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<script>
     function changerDesignation() {
        document.jauge.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="jauge" id="jauge">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat :
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(bc.getNomTable()) ? "selected" : "";
                        %>
                        <option value="<%=etatVal[i]%>" <%=selected%>><%=etatAff[i]%></option>
                        <%}%>
                    </select>
                </div>
                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
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




