<%-- 
    Document   : vente-liste
    Created on : 25 mars 2024, 09:57:03
    Author     : Angela
--%>

<%@page import="faturefournisseur.As_BonDeLivraison_Lib"%>
<%@page import="utilitaire.Utilitaire"%>
<%@page import="affichage.PageRecherche"%>

<% try{ 
    As_BonDeLivraison_Lib blc = new As_BonDeLivraison_Lib();
    blc.setNomTable("BL_NONFACTURE");
    String listeCrt[] = {"id", "remarque","magasinlib","daty","idFournisseurLib"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "remarque","magasinlib","daty", "idFournisseurLib"};
    String libEnteteAffiche[] = {"id", "Remarque","Magasin","Date","Fournisseur"};
    PageRecherche pr = new PageRecherche(blc, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Liste des bons de livraison non factur&eacute;s");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("bondelivraison/facturer-livraison.jsp");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    pr.getFormu().getChamp("id").setLibelle("ID");
    pr.getFormu().getChamp("magasinlib").setLibelle("Magasin");
    pr.getFormu().getChamp("idFournisseurLib").setLibelle("Fournisseur");
    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    //pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    //pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
   
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=bondelivraison/bondelivraison-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    pr.getTableau().setAfficheBouttondevalider(false);
    pr.getTableau().setNameBoutton("Attacher BL");
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
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="facture" id="facture">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            
        </form>
        <%
            out.println(pr.getTableauRecap().getHtml());%>
        <br>
        <form action="<%= pr.getLien() + "?but=bondelivraison/apresFacturerLivraison.jsp"%>" method="post" >
            <% if(request.getParameter("idFactureFournisseur") != null)  { %>
                <input type="hidden" name="idFactureFournisseur" value="<%= request.getParameter("idFactureFournisseur") %>">
            <% } %>
            <input type="hidden" name="acte">
            <input type="hidden" name="bute" value="<%= pr.getLien() + "?but=bondelivraison/facturer-livraison.jsp" %>">
            <%
                out.println(pr.getTableau().getHtmlWithCheckbox());
            %>
        </form>
        <%
            out.println(pr.getBasPage());
        %>
    </section>
</div>
    <%
    }catch(Exception e){
        e.printStackTrace();
    }
%>




