<%--
    Document   : prelevement-liste
    Created on : 27 mars 2024, 11:30:49
    Author     : SAFIDY
--%>


<%@page import="prelevement.PrelevementLib"%>
<%@page import="affichage.PageRecherche"%>

<% try{
   PrelevementLib t = new PrelevementLib();
    String[] etatVal = {"PRELEVEMENTLIB", "PRELEVEMENTLIB_CREE", "PRELEVEMENTLIB_VISEE", "PRELEVEMENTLIB_ANNULEE","PRELEVEMENTLIB_ENCAISSEE"};
    String[] etatAff = {"Tous", "Cr��e(s)", "Vis�e(s)", "Annul�e","Encaiss�e"};

        t.setNomTable(etatVal[0]);
        if (request.getParameter("etat") != null && request.getParameter("etat").compareToIgnoreCase("") != 0) {
            t.setNomTable(request.getParameter("etat"));
        }
    String listeCrt[] = {"id","designation", "idPrelevementAnterieur","compteur","daty","heure","nomUser","idPompe"};
    String listeInt[] = {};
    String libEntete[] = {"id","designation", "idPrelevementAnterieur","compteur","daty","heure","nomUser","idPompe","etatLib"};
    String libEnteteAffiche[] = {"id","Designation", "idPrelevementAnterieur","compteur","daty","heure","Pompiste","idPompe","etat"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);

    pr.setTitre("Liste des prelevements ");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/prelevement/prelevement-liste.jsp" );

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    pr.getFormu().getChamp("idPrelevementAnterieur").setLibelle("Prelevement anterieur");
    pr.getFormu().getChamp("compteur").setLibelle("Compteur");
    pr.getFormu().getChamp("daty").setLibelle("Date");
    pr.getFormu().getChamp("heure").setLibelle("Heure");
    pr.getFormu().getChamp("nomUser").setLibelle("Pompiste");
    pr.getFormu().getChamp("idPompe").setLibelle("Pompe");
    pr.getFormu().getChamp("designation").setLibelle("Designation");


    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=prelevement/prelevement-fiche.jsp"};
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
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat :
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(t.getNomTable()) ? "selected" : "";
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





