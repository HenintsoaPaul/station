<%@page import="venteLubrifiant.VenteLubrifiantLib"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    VenteLubrifiantLib t = new VenteLubrifiantLib();
        String[] etatVal = {"venteLubrifiantLib", "venteLubrifiantLibCree", "venteLubrifiantLibVisee","venteLubrifiantLibAnnule"};
        String[] etatAff = {"Tous", "Cr�e", "Valid�","Annul�"};
    t.setNomTable(etatVal[0]);
	if (request.getParameter("etat") != null && !request.getParameter("etat").isEmpty()) {
            t.setNomTable(request.getParameter("etat"));
        }
    String listeCrt[] = {"id", "idProduitLib","qte","pu","tauxRemise"};
    String listeInt[] = {};
    String libEntete[] = {"id", "idProduitLib","qte","pu","tauxRemise", "etatLib"};
    PageRecherche pr = new PageRecherche(t, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("liste vente lubrifiant");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres( "station-ejb/src/java/venteLubrifiant/venteLubrifiant-liste.jsp" );
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);
    pr.getFormu().getChamp("id").setLibelle("Identifiant");
    pr.getFormu().getChamp("idProduitLib").setLibelle("Produit");

    //Definition des lienTableau et des colonnes de lien
    String lienTableau[] = {pr.getLien() + "?but=venteLubrifiant/venteLubrifiant-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);
    //Definition des libelles � afficher
    String libEnteteAffiche[] = {"id", "Produit", "Quantite", "Prix", "Remise","Etat"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>


<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row col-md-12">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    Etat :
                    <select name="etat" class="champ" id="etat" onchange="changerDesignation()" >
                        <%for(int i=0; i<etatVal.length; i++){
                            String selected = etatVal[i].equalsIgnoreCase(request.getParameter("etat")) ? "selected" : "";
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
