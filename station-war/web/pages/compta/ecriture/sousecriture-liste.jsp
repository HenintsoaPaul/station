<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="mg.cnaps.compta.*"%>
<%@page import="affichage.PageRecherche"%>

<% try{
    ComptaSousEcritureLib compta = new ComptaSousEcritureLib();
    compta.setNomTable("COMPTA_SOUSECRITURE_VISEE");
    String[] etatVal = {"COMPTA_SOUSECRITURE_LIB","COMPTA_SOUSECRITURE_VISEE","COMPTA_SOUSECRITURE_CREE2"};
    String[] etatAff = {"TOUS","VISEE", "CREE"};
    compta.setNomTable(etatVal[0]);
    String nomTable=request.getParameter("etat_table");
    if (nomTable != null && nomTable.compareToIgnoreCase("") != 0) {
        out.println("Hahahahahaha  " + nomTable);
        compta.setNomTable(nomTable);
    }
    String listeCrt[] = {"id","compte","journal","daty","exercice","folio"};
    String listeInt[] = {"daty","compte"};
    String libEntete[] = {"id", "journal", "folio", "compte","daty","remarque","libellePiece", "source", "analytique", "debit", "credit"};
    PageRecherche pr = new PageRecherche(compta, request, listeCrt, listeInt, 3, libEntete, libEntete.length);
    pr.setTitre("Consultation des ecritures");
    pr.setUtilisateur((user.UserEJB) session.getValue("u"));
    pr.setLien((String) session.getValue("lien"));
    pr.setApres("compta/ecriture/sousecriture-liste.jsp");
    pr.setOrdre(" order by daty desc");
    String[] colSomme = null;
    pr.creerObjetPage(libEntete, colSomme);

    String lienTableau[] = {pr.getLien() + "?but=compta/ecriture/sousecriture-fiche.jsp"};
    String colonneLien[] = {"id"};
    pr.getTableau().setLien(lienTableau);
    pr.getTableau().setColonneLien(colonneLien);

    pr.getFormu().getChamp("daty1").setLibelle("Date Min");
    pr.getFormu().getChamp("daty1").setDefaut(utilitaire.Utilitaire.dateDuJour());
    pr.getFormu().getChamp("daty2").setLibelle("Date Max");
    pr.getFormu().getChamp("daty2").setDefaut(utilitaire.Utilitaire.dateDuJour());

    pr.getFormu().getChamp("compte1").setLibelle("Compte debut");
    pr.getFormu().getChamp("compte2").setLibelle("Compte fin");
    pr.getFormu().getChamp("journal").setLibelle("ID Journal");
    pr.getFormu().setEtatVal(etatVal);
    pr.getFormu().setEtatAff(etatAff);
    String libEnteteAffiche[] = {"ID", "Journal", "Folio", "Compte","Date","Remarque","Libelle", "Source", "Analytique", "Debit", "Credit"};
    pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>
<script>
    function changeEtat(vals){
        document.getElementById("etat_tables").value = vals;
        document.liste.submit();
    }
</script>
<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="liste" id="liste">
            
            <%
                // pr.getFormu().makeHtmlNew();
                // out.println(pr.getFormu().getFiltreEtat());
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
            <div class="row my-3 col-md-12">
                <div class="box-solid box">
                    <div class="box-body">
                        <label for="" class="form-label">
                        Voir pour etat : 
                        </label>
                        <select name="etat_table" class="form-control" id="etat_tables" >
                            <%
                                for( int i = 0; i < etatAff.length; i++ ){ %>
                                    <option value="<%= etatVal[i] %>" <%= (etatVal[i].equalsIgnoreCase(nomTable)) ? "selected" : "" %> onClick="changeEtat('<%= etatVal[i] %>')">
                                        <%= etatAff[i] %>
                                    </option>
                            <%    }
                            %>
                        </select>
                    </div>
                </div>
                
            </div>
        </form>
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



