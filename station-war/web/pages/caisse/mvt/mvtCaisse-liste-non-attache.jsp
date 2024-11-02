<%--
    Document   : mvtCaisse-liste-non-attache
    Created on : 16 ao�t 2024, 16:07:46
    Author     : ASUS
--%>

<%@page import="caisse.MvtCaisseCpl"%>
<%@page import="caisse.MvtCaisse"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    MvtCaisseCpl t = new MvtCaisseCpl();
    t.setNomTable("MOUVEMENTCAISSECPL_NATTACH");
    String etat = request.getParameter("etat");
    if(etat == null) etat = "%";
    String listeCrt[] = {"id", "designation", "daty"};
    String listeInt[] = {"daty"};
    String libEntete[] = {"id", "designation","idCaisseLib","idVenteDetail" , "idVirement","credit","debit", "etatLib"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    if(etat!=null) pr.setAWhere(" and etatlib LIKE '"+etat+"'");
    System.out.println("PR=="+pr.getAWhere());
    pr.setTitre("Liste mouvement caisse non attach&eacute;");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/caisse/mvt/mvtCaisse-liste-non-attache.jsp" );
    pr.getFormu().getChamp("daty1").setLibelle("Date min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date max");

    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=caisse/mvt/mvtCaisse-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    String libEnteteAffiche[] = {"id", "d&eacute;signation","Caisse","Vente d&eacute;tail" , "Virement","Cr&eacute;dit","D&eacute;bit", "&Eacute;tat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
    String[] etatAffiche = {"Tous","Annul&eacute;","Cr&eacute;e","Valid&eacute;e"};
    String[] etatPasse = {"%","ANNULEE","CREE","VALIDEE"};
%>

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <input type="hidden" value="<%=request.getParameter("idPrevision")%>" name="idPrevision">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-lg-6">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="" style="background:#103a8e; color:white;" class="box-header with-border">
                                    Voir l'etat
                                </label>
                                <select name="etat" class="form-control mb-2">
                                    <%
                                        for( int i = 0; i < etatAffiche.length; i++ ){ %>
                                            <option value="<%= etatPasse[i] %>"> <%= etatAffiche[i] %> </option>
                                    <%    }
                                    %>
                                </select>
                                <input type="submit" value="Consultez" class="btn btn-primary my-2" />
                            </div>

                        </div>
                </div>
                <div class="col-lg-6">

            <%
                out.println(pr.getTableauRecap().getHtml());%>
                </div>

            </div>
        </form>

        <br>
        <form action="<%= pr.getLien()%>?but=caisse/mvt/apres-attacher-prevision.jsp" method="post">
            <input type="hidden" value="<%=request.getParameter("idPrevision")%>" name="idPrevision">
            <input type="hidden" value="<%=pr.getLien()%>" name="lien">
            <%
                pr.getTableau().setNameBoutton("Attacher");
                out.println(pr.getTableau().getHtmlWithCheckbox());
                out.println(pr.getBasPage());
            %>
        </form>>
    </section>
</div>
    <%
    }catch(Exception e){

        e.printStackTrace();
    }
%>




