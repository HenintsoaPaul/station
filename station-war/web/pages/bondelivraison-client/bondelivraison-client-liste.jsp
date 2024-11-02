<%-- 
    Document   : bondelivraison-client-liste
    Created on : 30 juil. 2024, 21:36:16
    Author     : bruel
--%>

<%@page import="vente.As_BondeLivraisonClient_Cpl"%>
<%@page import="vente.BonDeCommandeCpl"%>
<%@page import="affichage.PageRecherche"%>
<%@page import="magasin.Magasin"%>
<%@page import="affichage.Liste"%>
<%@page import="faturefournisseur.ModePaiement"%>
<% try{ 
    As_BondeLivraisonClient_Cpl bdlc = new As_BondeLivraisonClient_Cpl();
    String nomTable = "AS_BONDELIVRAISONCLIENT_LIBCPL";
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            nomTable = request.getParameter("etat");
        }

       bdlc.setNomTable(nomTable);
    String listeCrt[] = {"id","remarque","idmagasinlib","idclientlib","daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id","remarque","idmagasinlib","idclientlib","daty","etatlib"};
    PageRecherche pr = new PageRecherche(bdlc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des Bons de livraison client");
     
    // Changer en Liste
    // Initialisation Liste

    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("bondelivraison-client/bondelivraison-client-liste.jsp");
   
    pr.getFormu().getChamp("id").setLibelle("Id");
    pr.getFormu().getChamp("remarque").setLibelle("Remarque");
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date max");
    
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    //  pr.getFormu().getChamp("daty").setLibelle("daty");

   
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=bondelivraison-client/bondelivraison-client-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    String libEnteteAffiche[] = {"Id","Remarque","Magasin","Client","Date","etat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    String[] etatVal = {"AS_BONDELIVRAISONCLIENT_LIBCPL","AS_BONDELIVRAISONC_LIBCPL_c", "AS_BONDELIVRAISONC_LIBCPL_v", "AS_BONDELIVRAISONC_LIBCPL_a"};
    String[] etatAff = {"Tous","Cr&eacute;e","Valid&eacute;e","Annul&eacute;"};
%>
<script>
    function changerDesignation() {
        document.getElementById("bdlc-liste--form").submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" id="bdlc-liste--form" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
              <div class="col-md-offset-5">
                <div class="form-group">
                    <select name="etat" class="champ-select" id="etat" onchange="changerDesignation()" >
                        <% for (int i = 0; i < etatVal.length; i++) {%>
                        <option value="<%=etatVal[i]%>" <%= etatVal[i].equalsIgnoreCase(bdlc.getNomTable()) ? "selected " : ""%>>
                            <%=etatAff[i]%>
                        </option>
                        <%}%>
                    </select>
                </div>
            </div>

                <div class="col-md-4"></div>
            </div>
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <%
            out.println(pr.getTableau().getHtml());
        %>
    </section>
    
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>
