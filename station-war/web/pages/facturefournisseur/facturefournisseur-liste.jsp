<%-- 
    Document   : vente-liste
    Created on : 25 mars 2024, 09:57:03
    Author     : Angela
--%>

<%@page import="faturefournisseur.FactureFournisseurCpl"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    FactureFournisseurCpl bc = new FactureFournisseurCpl();
    String[] etatVal = {"","1","11", "0"};
    String[] etatAff = {"Tous","Cr&eacute;e(s)", "Vis&eacute;e(s)", "Annul&eacute;e"};
    bc.setNomTable("FACTUREFOURNISSEURCPL_TOUS");
    if (request.getParameter("devise") != null && request.getParameter("devise").compareToIgnoreCase("") != 0) {
        bc.setNomTable(request.getParameter("devise"));
    } else {
        bc.setNomTable("FACTUREFOURNISSEURCPL_TOUS");
    }
    String listeCrt[] = {"id", "designation","idFournisseurLib","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "designation","idFournisseurLib","idDevise","daty","montantttc","montantpaye", "montantreste","etatlib"};
    String libEnteteAffiche[] = {"id", "D&eacute;signation","Fournisseur","devise","Date","Montant TTC","Montant Pay&eacute;","Montant Reste","Etat"};
    PageRecherche pr = new PageRecherche(bc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    if(request.getParameter("etat")!=null && request.getParameter("etat").compareToIgnoreCase("")!=0) {
        pr.setAWhere(" and etat=" + request.getParameter("etat"));
    } 
    pr.setTitre("Liste des factures fournisseurs");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("facturefournisseur/facturefournisseur-liste.jsp");
    String[] colSomme = { "montantttc", "montantpaye", "montantreste" };
    pr.creerObjetPage(libEntete, colSomme);
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("idFournisseurLib").setLibelle("Fournisseur");
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
   
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=facturefournisseur/facturefournisseur-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<script>
     function changerDesignation() {
        document.vente.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="vente" id="vente">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-6">
                        Devises : 
                        <select name="devise" class="champ form-control" id="devise" onchange="changerDesignation()" >
                            <% if (request.getParameter("devise") != null && request.getParameter("devise").compareToIgnoreCase("vente_cpl_avec_montant") == 0) {%>
                            <option value="FACTUREFOURNISSEURCPL_TOUS" selected>Tous</option>
                            <% } else { %>
                            <option value="FACTUREFOURNISSEURCPL_TOUS">Tous</option>
                            <% } %>
                            <% if (request.getParameter("devise") != null && request.getParameter("devise").compareToIgnoreCase("vente_cpl_avec_montant_mga") == 0) {%>
                            <option value="FACTUREFOURNISSEURCPL_MGA" selected>AR</option>
                            <% } else { %>
                            <option value="FACTUREFOURNISSEURCPL_MGA">AR</option>
                            <% } %>
                            <% if (request.getParameter("devise") != null && request.getParameter("devise").compareToIgnoreCase("vente_cpl_avec_montant_eur") == 0) {%>
                            <option value="FACTUREFOURNISSEURCPL_EUR" selected>EUR</option>
                            <% } else { %>
                            <option value="FACTUREFOURNISSEURCPL_EUR">EUR</option>
                            <% } %>
                            <% if (request.getParameter("devise") != null && request.getParameter("devise").compareToIgnoreCase("vente_cpl_avec_montant_usd") == 0) {%>
                            <option value="FACTUREFOURNISSEURCPL_USD" selected>USD</option>
                            <% } else { %>
                            <option value="FACTUREFOURNISSEURCPL_USD">USD</option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-6">
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
                </br>
            </div>
            <div class="col-md-2"></div>
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




